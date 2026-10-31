# Building Phantom Dust Rebirth (pdnet) on Windows

You do **not** need a decrypted copy of the game to build. Everything comes from free, public downloads.
Players who only want to play don't need any of this: they use a kit (`Setup.bat`).

## 1. Install the tools (once)

Open PowerShell and run these. Windows asks for permission (UAC) for the first two.

```powershell
winget install --id Microsoft.VisualStudio.2022.BuildTools --exact --override "--wait --passive --norestart --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64"
winget install --id Microsoft.WindowsSDK.10.0.22000 --exact
winget install --id Python.Python.3.12 --exact --scope user
winget install --id Git.Git --exact
```

- **Build Tools for Visual Studio 2022** is enough (a full Visual Studio 2022 with "Desktop development with C++" works too).
- **Windows SDK 10.0.22000** exactly: the scripts and `cppwinrt.exe` are pinned to it. The current Visual Studio
  installer no longer offers it as a component, so install it with winget as above.
- Close and reopen the terminal afterwards so `py` is on PATH.

## 2. Get the source

```powershell
git clone -c core.longpaths=true https://github.com/SnowRyze/Phantom-Dust-Rebirth
```

`core.longpaths=true` is needed: some generated XSAPI stub file names are longer than Windows' default path limit.

## 3. EOS SDK (for online play)

pdnet's online lobbies use Epic Online Services. Epic's SDK can only be downloaded with a (free) Epic developer account:

1. Sign in at <https://dev.epicgames.com/portal>, open **SDK & Release Notes**, download the **C SDK** (1.19.x).
2. Unzip it so this file exists: `deps\eos-sdk\SDK\Include\eos_sdk.h` (`deps\` at the top of the repository; git ignores it).
   Or set `EOS_SDK` to the SDK's `SDK` folder anywhere else.

Without it, `build.cmd` prints a warning and builds **without EOS** (single player and local testing still work, online lobbies don't).

## 4. Build

```bat
pdnet\build.cmd                    :: -> pdnet\build\Microsoft.Xbox.Services.dll  (pdnet; kits rename it pdnet.dll)
pdnet\tools\build-pdlaunch.cmd     :: -> pdnet\tools\out\pdlaunch.exe + SDL3.dll   (loads pdnet into the Store game)
```

What happens automatically the first time:

- `build.cmd` runs `pdnet\xsapi\generate.py`, which downloads Microsoft's Xbox Live SDK **2017.4.20170428.2** from
  nuget.org (~80 MB, cached in `pdnet\xsapi\winmd-cache\`, SHA-256 checked) and takes `Microsoft.Xbox.Services.winmd` from it.
  That winmd is the one Phantom Dust 1.3.25854.2 ships (same size; same for the x64 Release DLL), and the stubs generated
  from it are identical to the ones in git. To use the game's own file instead: `py -I pdnet\xsapi\generate.py <path>`.
- `build-pdlaunch.cmd` downloads SDL3 3.4.18 (VC package) from GitHub into `deps\` unless `SDL3` points somewhere else.

## 5. Make a kit (optional)

```powershell
.\make-testkit.ps1 -Stage Store -Build build -KitDir .\dist
```

Kits go to `-KitDir` (default: `D:\` if it exists, otherwise `dist\`). The EOS DLL is taken from `EOS_SDK` / `deps\eos-sdk`.
`eos.ini` (EOS client credentials) is never in git; the project owner provides it.

## Troubleshooting

| Message | Fix |
|---|---|
| `Visual Studio C++ tools not found` | Step 1, Build Tools line. |
| `Windows SDK 10.0.22000 not found` | Step 1, SDK line. |
| `Python 3 not found` | Step 1, Python line; reopen the terminal. |
| `Filename too long` during clone | Clone again with `-c core.longpaths=true`. |
| `WARNING: EOS SDK headers not found` | Step 3 (or ignore for an offline-only build). |
