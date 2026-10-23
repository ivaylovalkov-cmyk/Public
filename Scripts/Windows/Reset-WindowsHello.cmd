@echo off
title Reset Windows Hello for Business
rem ESC character for ANSI bold/underline formatting
for /f %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
echo.
echo This will refresh YOUR Windows Hello for Business (PIN, fingerprint and face sign-in)
echo for user: %USERDOMAIN%\%USERNAME% (no data will be lost)
echo.
echo After it finishes you will be signed out and device will be rebooted automatically. Sign back in with your
echo PASSWORD %ESC%[1m%ESC%[4mWHILE ON THE CORPORATE NETWORK%ESC%[0m, then set up a new PIN.
echo.
choice /c YN /m "Continue"
if errorlevel 2 goto :cancel

certutil -deleteHelloContainer
if errorlevel 1 (
    echo.
    echo Deleting the Hello container failed. Error code: %errorlevel%
    pause
    exit /b 1
)

echo.
echo Hello container deleted.
choice /c YN /m "Sign out now"
if errorlevel 2 goto :done
shutdown -r -t 10
goto :eof

:cancel
echo Cancelled. Nothing was changed.
:done
pause
