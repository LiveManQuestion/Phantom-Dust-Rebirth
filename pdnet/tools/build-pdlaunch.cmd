@echo off
rem Builds tools\out\pdlaunch.exe (loads pdnet into an unmodified game, see pdlaunch.cpp). A windows program, not a console one:
rem it stays running in the background while the game is open, and a console program would show a window all that time.
setlocal
set OUT=%~dp0out
set VSWHERE="%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
rem -products * so the standalone "Build Tools for Visual Studio" is found too.
for /f "usebackq delims=" %%i in (`%VSWHERE% -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do set VSDIR=%%i
if not defined VSDIR (
    echo Visual Studio C++ tools not found. See BUILDING.md.
    exit /b 1
)
call "%VSDIR%\VC\Auxiliary\Build\vcvarsall.bat" x64 10.0.22000.0 >nul || exit /b 1
rem SDL3 headers (pdlaunch loads SDL3.dll at run time, it doesn't link to it); make-testkit.ps1 ships the DLL.
rem Without SDL3 set, the official SDL3 3.4.18 VC package is downloaded once into deps\ at the repository root.
set DEPS=%~dp0..\..\deps
if not defined SDL3 if exist "C:\Users\ryhol\tools\downloads\sdl3\x\SDL3-3.4.18\include" set SDL3=C:\Users\ryhol\tools\downloads\sdl3\x\SDL3-3.4.18
if not defined SDL3 set SDL3=%DEPS%\SDL3-3.4.18
if not exist "%SDL3%\include\SDL3\SDL.h" (
    echo Downloading SDL3 3.4.18 from github.com/libsdl-org/SDL...
    if not exist "%DEPS%" mkdir "%DEPS%"
    "%SystemRoot%\System32\curl.exe" -fsSL -o "%DEPS%\sdl3.zip" https://github.com/libsdl-org/SDL/releases/download/release-3.4.18/SDL3-devel-3.4.18-VC.zip || goto :sdlfailed
    rem Windows' own tar (bsdtar) unzips; a GNU tar earlier on PATH (Git Bash) would read "C:" as a remote host.
    "%SystemRoot%\System32\tar.exe" -xf "%DEPS%\sdl3.zip" -C "%DEPS%" || goto :sdlfailed
    del "%DEPS%\sdl3.zip"
)
if not exist "%SDL3%\include\SDL3\SDL.h" goto :sdlfailed
if not exist "%OUT%\obj" mkdir "%OUT%\obj"
pushd "%OUT%"
cl /nologo /std:c++20 /EHsc /MT /O2 /W3 /permissive- /utf-8 /DUNICODE /D_UNICODE /I"%~dp0..\src" /I"%SDL3%\include" /Fo"obj\\" /Fe"pdlaunch.exe" "%~dp0pdlaunch.cpp" /link /SUBSYSTEM:WINDOWS /ENTRY:wmainCRTStartup kernel32.lib psapi.lib ole32.lib user32.lib || (popd & echo BUILD FAILED & exit /b 1)
popd
copy /y "%SDL3%\lib\x64\SDL3.dll" "%OUT%" >nul
echo Built %OUT%\pdlaunch.exe
exit /b 0

:sdlfailed
echo SDL3 headers not available at %SDL3% (download or unzip failed). Set SDL3 to an unzipped SDL3-devel-*-VC folder.
exit /b 1
