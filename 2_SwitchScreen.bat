@echo off
@REM POWERED BY Kantic- https://github.com/quentinmathieu

set title=SwitchScreen

@REM quit script if it's already running
tasklist /fi "imagename eq cmd.exe" /v | find /i "%title%"
echo %ERRORLEVEL%
  if "%ERRORLEVEL%"=="0" goto :end

TITLE %title%

@REM copy the script in startup windows's programs
set startup="%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
if NOT exist %startup%\2_SwitchScreen.bat (
    copy %~dp0\1_SwitchScreen.vbs %startup%\1_SwitchScreen.vbs
    copy %0 %startup%\%~n0%~x0
    msg * "Installation complete !"
) 

@REM mklink /d %current%  %startup%


set EXE=csgo.exe
:waitingOpen
@REM Waiting csgo to be launched
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %EXE%"') DO IF NOT %%x == %EXE% (
  echo %EXE% waiting for csgo to launch...
  timeout /t 3 >nul
  goto :waitingOpen
)

@REM switch to only 1st screen
DisplaySwitch.exe /internal



SETLOCAL EnableExtensions
:before
@REM While csgo is running display that it's running ; THEN when you quit csgo leave the for loop
FOR /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %EXE%"') DO IF %%x == %EXE% (
  echo %EXE% is Running
  timeout /t 3 >nul
  goto :before
)


@REM that extends screens
DisplaySwitch.exe /extend

goto :waitingOpen

:end




