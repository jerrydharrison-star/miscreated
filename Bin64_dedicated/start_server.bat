@echo off
:start
tasklist /FI "IMAGENAME eq MiscreatedServer.exe" 2>NUL | find /I /N "MiscreatedServer.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo MiscreatedServer.exe is already running. Exiting script.
    exit /b
)

echo Starting Miscreated Server with Refined Steam Identity...
start /affinity F /wait MiscreatedServer.exe -dedicated -sv_port 64090 -sv_steamaccount <YOUR_STEAM_ACCOUNT_TOKEN> +map islands
echo Server has stopped.
exit
