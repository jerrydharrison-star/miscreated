@echo off
:start
tasklist /FI "IMAGENAME eq MiscreatedServer.exe" 2>NUL | find /I /N "MiscreatedServer.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo MiscreatedServer.exe is already running. Exiting script.
    exit /b
)

echo Starting Miscreated Server with Refined Steam Identity...
start /affinity F /wait MiscreatedServer.exe -dedicated -sv_port 64090 -sv_steamaccount 1E9ED7374DBA410275E4D921079B91A8 +map islands
echo Server has stopped.
exit
