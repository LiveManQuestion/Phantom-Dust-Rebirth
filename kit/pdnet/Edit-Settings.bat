@echo off
rem Opens the in-game Settings file (settings.ini) in Notepad. Double-click to run.
rem What you save there overrides pdnet.ini, e.g. exact nametag colours. Edit it with the game closed.
set "settings=%LOCALAPPDATA%\Packages\Microsoft.MSEsper_8wekyb3d8bbwe\LocalState\pdnet\settings.ini"
if not exist "%settings%" (
    echo settings.ini doesn't exist yet. Start the game once and save something in Multiplayer ^> Settings.
    pause
    exit /b 1
)
tasklist /fi "imagename eq PDUWP.exe" | find /i "PDUWP.exe" >nul && echo Phantom Dust is running: close it before saving, or the game may overwrite your changes. && pause
start "" notepad "%settings%"
