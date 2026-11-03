# Rebuilds pdnet\src\rebirth_word.h from rebirth-art.png (the lettering with its own transparency): crops it to what
# is visible and writes it at full size. Writes preview.png (the result over black, 3x) next to this script.
$d = $PSScriptRoot
Add-Type -AssemblyName System.Drawing
Add-Type -Path "$d\Key.cs" -ReferencedAssemblies System.Drawing
$s = [Drawing.Bitmap]::FromFile("$d\rebirth-art.png")
$x0 = $s.Width; $y0 = $s.Height; $x1 = -1; $y1 = -1
for ($y = 0; $y -lt $s.Height; $y++) { for ($x = 0; $x -lt $s.Width; $x++) { if ($s.GetPixel($x, $y).A -gt 0) {
    if ($x -lt $x0) { $x0 = $x }; if ($x -gt $x1) { $x1 = $x }; if ($y -lt $y0) { $y0 = $y }; if ($y -gt $y1) { $y1 = $y } } } }
$word = $s.Clone([Drawing.Rectangle]::FromLTRB($x0, $y0, $x1 + 1, $y1 + 1), [Drawing.Imaging.PixelFormat]::Format32bppArgb)
# The title has room for 88 rows (kLift + kSubH in gamepatches.cpp, 2 spare) under the logo's 549 columns: larger art
# is scaled down to fit, keeping its shape.
$scale = [Math]::Min(1.0, [Math]::Min(88.0 / $word.Height, 549.0 / $word.Width))
if ($scale -lt 1)
{
    $w = [int][Math]::Round($word.Width * $scale); $h = [int][Math]::Round($word.Height * $scale)
    $small = [Drawing.Bitmap]::new($w, $h, [Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [Drawing.Graphics]::FromImage($small)
    $g.InterpolationMode = [Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.PixelOffsetMode = [Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.CompositingMode = [Drawing.Drawing2D.CompositingMode]::SourceCopy
    $attr = [Drawing.Imaging.ImageAttributes]::new(); $attr.SetWrapMode([Drawing.Drawing2D.WrapMode]::TileFlipXY) # no dark edge
    $g.DrawImage($word, [Drawing.Rectangle]::new(0, 0, $w, $h), 0, 0, $word.Width, $word.Height, [Drawing.GraphicsUnit]::Pixel, $attr)
    $g.Dispose(); $word.Dispose(); $word = $small
}
[Key]::Preview("$d\preview.png", $word, [Drawing.Color]::Black, 3)
[Key]::Header("$d\..\..\src\rebirth_word.h", $word)
$s.Dispose()
"rebirth_word.h: {0}x{1}" -f $word.Width, $word.Height
