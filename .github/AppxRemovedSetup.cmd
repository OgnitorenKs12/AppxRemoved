echo off
chcp 65001 > NUL
setlocal enabledelayedexpansion
title AppxRemoved Setup
mode con cols=80 lines=30
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set R=%%b)
cd /d "%~dp0"
for /f %%a in ('"cd"') do set Konum=%%a

:: -------------------------------------------------------------
MD "C:\AppxRemoved" > NUL 2>&1

:: =============================================================
:: Güncelleme dosyası indirilir
cls&Call :Panel "[■■■■■■■■■■■■                                    ]" "%R%[92m         Installing AppxRemoved...%R%[0m"
Call :Powershell "& { iwr https://raw.githubusercontent.com/OgnitorenKs12/AppxRemoved/main/.github/AppxRemoved.zip -OutFile %temp%\AppxRemoved.zip }"

:: İndirilen güncelleme zip dosyası klasörü çıkarılır.
cls&Call :Panel "[■■■■■■■■■■■■■■■■■■■■■■■■                        ]" "%R%[92m         Installing AppxRemoved...%R%[0m"
Call :Powershell "Expand-Archive -Force '%temp%\AppxRemoved.zip' 'C:\AppxRemoved'"

:: Güncelleme zip dosyası silinir.
cls&Call :Panel "[■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■            ]" "%R%[92m         Installing AppxRemoved...%R%[0m"
DEL /F /Q /A "%temp%\AppxRemoved.zip" > NUL 2>&1

(
echo Set oWS = WScript.CreateObject^("WScript.Shell"^)
echo sLinkFile = "C:\Users\%username%\Desktop\AppxRemoved.lnk"
echo Set oLink = oWS.CreateShortcut^(sLinkFile^)
echo oLink.TargetPath = "C:\AppxRemoved\AppxRemoved.cmd"
echo oLink.WorkingDirectory = "C:\AppxRemoved"
echo oLink.Description = "AppxRemoved"
echo oLink.IconLocation = "C:\AppxRemoved\Bin\Icon\Ogni.ico"
echo oLink.Save
) > %Temp%\OgnitorenKs.Shortcut.vbs
cscript "%Temp%\OgnitorenKs.Shortcut.vbs" > NUL 2>&1
DEL /F /Q /A "%Temp%\OgnitorenKs.Shortcut.vbs" > NUL 2>&1
cls&Call :Panel "[■■■■■■■■■■■■■■■■■■■■COMPLETE■■■■■■■■■■■■■■■■■■■■]" "%R%[92m         Installing AppxRemoved...%R%[0m"
Call :Powershell "Start-Process 'C:\AppxRemoved\AppxRemoved.cmd' -Verb Runas"
exit
:: =============================================================
:: ██████████████████████████████████████████████████████████████████████████████████████████████████
:: ██████████████████████████████████████████████████████████████████████████████████████████████████
:: ██████████████████████████████████████████████████████████████████████████████████████████████████
:Panel
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                     %~2
echo.            
echo               %~1
echo.
echo             %R%[33m████ ████ █   █ █ █████ ████ ████ ███ █   █ █  █ ████%R%[0m
echo             %R%[33m█  █ █    ██  █ █   █   █  █ █  █ █   ██  █ █ █  █   %R%[0m
echo             %R%[33m█  █ █ ██ █ █ █ █   █   █  █ ████ ██  █ █ █ ██   ████%R%[0m
echo             %R%[33m█  █ █  █ █  ██ █   █   █  █ █ █  █   █  ██ █ █     █%R%[0m
echo             %R%[33m████ ████ █   █ █   █   ████ █  █ ███ █   █ █  █ ████%R%[0m
goto :eof

:: -------------------------------------------------------------
:Powershell
chcp 437 > NUL 2>&1
Powershell -command %*
chcp 65001 > NUL 2>&1
goto :eof

