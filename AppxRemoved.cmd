:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
::
::       ██████   ██████   ██    ██ ████ ████████  ██████  ████████  ████████ ██    ██ ██    ██  ██████
::      ██    ██ ██    ██  ███   ██  ██     ██    ██    ██ ██     ██ ██       ███   ██ ██   ██  ██    █
::      ██    ██ ██        ████  ██  ██     ██    ██    ██ ██     ██ ██       ████  ██ ██  ██   ██     
::      ██    ██ ██   ████ ██ ██ ██  ██     ██    ██    ██ ████████  ██████   ██ ██ ██ █████      ██████
::      ██    ██ ██    ██  ██  ████  ██     ██    ██    ██ ██   ██   ██       ██  ████ ██  ██         ██
::      ██    ██ ██    ██  ██   ███  ██     ██    ██    ██ ██    ██  ██       ██   ███ ██   ██  ██    ██
::       ██████   ██████   ██    ██ ████    ██     ██████  ██     ██ ████████ ██    ██ ██    ██  ██████ 
::
::  ► Hazırlayan: Hüseyin UZUNYAYLA / OgnitorenKs
::
::  ► İletişim - Contact;
::  --------------------------------------
::  • Discord: ognitorenks
::  •    Mail: ognitorenks@gmail.com
::  •    Site: https://ognitorenks.blogspot.com
::
:: ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
echo off
chcp 65001
setlocal enabledelayedexpansion
cls
title AppxRemoved │ OgnitorenKs

REM -------------------------------------------------------------
REM Renklendirme
FOR /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E#&for %%b in (1) do rem"') do (set R=%%b)

REM -------------------------------------------------------------
REM Yönetici yetkisi
reg query "HKU\S-1-5-19" > NUL 2>&1
	if !errorlevel! NEQ 0 (Call :Powershell "Start-Process '%~f0' -Verb Runas"&exit)

REM -------------------------------------------------------------
REM Konum bilgisi
cd /d "%~dp0"
FOR /F "tokens=*" %%a in ('cd') do (set Konum=%%a)

REM -------------------------------------------------------------
REM Oluşturulacak klasörler
MD "%Konum%\Log" > NUL 2>&1

REM -------------------------------------------------------------
REM Değişkenler
set NSudo="%Konum%\Bin\NSudo.exe" -U:T -P:E -Wait -ShowWindowMode:hide cmd /c

REM -------------------------------------------------------------
REM Kullanıcı SID bilgisi
Call :Powershell "Get-CimInstance -ClassName Win32_UserAccount | Select-Object -Property Name,SID" > %Konum%\Log\UserSID.txt
FOR /F "tokens=2" %%a in ('Find "%username%" %Konum%\Log\UserSID.txt') do (set CUS=%%a)
DEL /F /Q /A "%Konum%\Log\UserSID.txt" > NUL 2>&1

REM -------------------------------------------------------------
REM Sahiplik
Call :Sahip "%ProgramFiles%\WindowsApps\*"
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /f "OgnitorenKs_AppxRemoved" > NUL 2>&1
	if "!errorlevel!" NEQ "0" (Call :Print)

REM -------------------------------------------------------------
REM Sistem varsayılan dil bilgisini öğrenir
FOR /F "tokens=6" %%a in ('Dism /online /Get-intl ^| Find /I "Default system UI language"') do (set DefaultLang=%%a)

REM -------------------------------------------------------------
REM Settings.ini dosyası içine dil bilgisi kayıtlı ise onu alır. Yok ise sistem varsayılan diline göre atama yapar.
Findstr /i "Language_Pack" %Konum%\Settings.ini > NUL 2>&1
    if !errorlevel! NEQ 0 (if "!DefaultLang!" EQU "tr-TR" (echo ► Language_Pack^= Turkish >> %Konum%\Settings.ini
                                                           set Dil=%Konum%\Bin\Language\Turkish.ini
                                                          )
                           if "!DefaultLang!" NEQ "tr-TR" (echo ► Language_Pack= English >> %Konum%\Settings.ini
                                                           set Dil=%Konum%\Bin\Language\English.ini
                                                          ) 
                          )
    if !errorlevel! EQU 0 (FOR /F "tokens=3" %%a in ('Findstr /i "Language_Pack" %Konum%\Settings.ini') do (set Dil=%Konum%\Bin\Language\%%a.ini))

REM -------------------------------------------------------------
REM Bilgi bölümü [DİL VERİLERİNİ EKLE UNUTMA]
echo.
Call :Dil A 2 T0006&echo  •%R%[92m !LA2! %R%[0m
echo.
Call :Dil A 2 T0001&echo  •%R%[33m !LA2! %R%[0m
Call :Dil A 2 T0002&echo  •%R%[33m !LA2! %R%[0m
Call :Dil A 2 T0003&echo  •%R%[33m !LA2! %R%[0m
Call :Dil A 2 T0004&echo  •%R%[33m !LA2! %R%[0m
echo.
Call :Dil A 2 T0005&echo  •%R%[32m !LA2! %R%[0m
pause > NUL
REM -------------------------------------------------------------
REM Menüde kullanıcığı tanımları dil dosyasından çekiyoruz
Call :Dil Z 2 P0001
Call :Dil Y 2 P0002
Call :Dil X 2 P0003
Call :Dil W 2 P0004
Call :Dil V 2 P0005
Call :Dil U 2 P0006
REM -------------------------------------------------------------
:AppxRemoved
cls
Call :Dil A 2 B0001&echo.&echo  •%R%[33m !LA2! %R%[0m
REM Kalıntıları temizliyorum
DEL /F /Q /A "%Konum%\Log\AppxList.txt" > NUL 2>&1
DEL /F /Q /A "%Konum%\Log\MenuList.txt" > NUL 2>&1
REM Uygulamalar hakkında bilgi topluyorum
Call :AppxList Name A
Call :AppxList PackageFamilyName B
Call :AppxList PackageFullName C
Call :AppxList NonRemovable
Call :AppxList Architecture
Call :AppxList Version
REM Verileri katalogluyorum
set Count=0
set New=0
REM Kırmızı - Kaldırılamaz uygulamaları ayırıyorum
FOR /L %%a in (1,1,!N!) do (
	FOR /F "tokens=3" %%b in ('Findstr /i "NameA_%%a_" %Konum%\Log\AppxList.txt') do (
		FOR /F "tokens=3" %%c in ('Findstr /i "PackageFamilyNameB_%%a_" %Konum%\Log\AppxList.txt') do (
			FOR /F "tokens=3" %%d in ('Findstr /i "PackageFullNameC_%%a_" %Konum%\Log\AppxList.txt') do (
				FOR /F "tokens=3" %%e in ('Findstr /i "NonRemovable_%%a_" %Konum%\Log\AppxList.txt') do (
					FOR /F "tokens=3" %%f in ('Findstr /i "Architecture_%%a_" %Konum%\Log\AppxList.txt') do (
						FOR /F "tokens=3" %%g in ('Findstr /i "Version_%%a_" %Konum%\Log\AppxList.txt') do (
							if "%%e" EQU "True" (set /a Count+=1
												 echo Appxx_!Count!_◄3►%%b►%%c►%%d►%%f►%%g► >> %Konum%\Log\MenuList.txt
												)
							if "%%e" NEQ "True" (set /a New+=1
							                     echo Appxx_!New!_◄%%b►%%c►%%d►%%f►%%g► >> %Konum%\Log\AppxList1.txt
												)
)))))))
DEL /F /Q /A "%Konum%\Log\AppxList.txt" > NUL 2>&1
RENAME "%Konum%\Log\AppxList1.txt" "AppxList.txt" > NUL 2>&1
REM Mor - Sürücü ve dil uygulamalarını ayırıyorum
FOR %%g in (NVIDIAControl RealtekAudioControl LanguageExperiencePack) do (Call :List_Search %%g 2)
REM Mavi - Market uygulamalarını ayırıyorum
FOR %%g in (Xaml VCLibs NET.Native StorePurchaseApp Services.Store.Engagement WindowsStore WindowsAppRuntime MicrosoftEdge WebExperience Winget) do (Call :List_Search %%g 1)
REM Mavi - Kodek uygulamalarını ayırıyorum
FOR %%g in (Extension) do (Call :List_Search %%g 1)
REM Mavi - Kodek uygulamalarını ayırıyorum
FOR %%g in (Xbox GamingApp) do (Call :List_Search %%g 1)
REM Sarı - Standart olarak yüklü veya kullanıcı tarafından yüklenmiş uygulamaları ayırıyorum
FOR /F "delims=◄ tokens=2" %%a in ('Findstr /i "Appxx_" %Konum%\Log\AppxList.txt') do (
	set /a Count+=1
	echo Appxx_!Count!_◄0►%%a >> %Konum%\Log\MenuList.txt
)
REM Katalogladığım uygulamaların sayısını N değişkenine tanımlıyorum.
set N=!Count!
REM Fazlalık log dosyalarını siliyorum.
DEL /F /Q /A "%Konum%\Log\AppxList.txt" > NUL 2>&1
:Menu
cls
REM Uygulama menu ekranı
REM Renk kodları hakkında bilgi veriyorum
echo %R%[90m-------------------------------------------------------------%R%[0m
Call :Dil A 2 T0007&echo %R%[31m █ %R%[90m=%R%[37m !LA2! %R%[0m
Call :Dil A 2 T0008&echo %R%[35m █ %R%[90m=%R%[37m !LA2! %R%[0m
Call :Dil A 2 T0009&echo %R%[36m █ %R%[90m=%R%[37m !LA2! %R%[0m
Call :Dil A 2 T0010&echo %R%[33m █ %R%[90m=%R%[37m !LA2! %R%[0m
echo %R%[90m-------------------------------------------------------------%R%[0m
REM Mavi renkli uygulamaları listelemek istediğim bölümde boş değişken hatası oluşmaması için Next değişkenin içini rastgele ifade ile doldurdum.
set Next=NT
REM Uygulamaları renklerine göre listeliyorum
FOR /L %%a in (1,1,!N!) do (
	FOR /F "delims=► tokens=2" %%b in ('Findstr /i "Appxx_%%a_" %Konum%\Log\MenuList.txt') do (
		FOR /F "delims=► tokens=5" %%c in ('Findstr /i "Appxx_%%a_" %Konum%\Log\MenuList.txt') do (
			FOR /F "delims=► tokens=6" %%d in ('Findstr /i "Appxx_%%a_" %Konum%\Log\MenuList.txt') do (
				FOR /F "delims=◄► tokens=2" %%e in ('Findstr /i "Appxx_%%a_" %Konum%\Log\MenuList.txt') do (
					set Empty=NT
					Call :Empty %%a
					if %%e EQU 3 (if !Empty! EQU NT (echo  %R%[32m%%a-%R%[31m %%b%R%[90m [%%c]%R%[90m %%d │ [%R%[90m!LZ2!%R%[90m]%R%[0m))
					if %%e NEQ 3 (if !Empty! EQU NT (Call :Catalog_Appx "%%a" "%%b" "%%c" "%%d"))
				)
			)
		)
	)
)
echo.
Call :Dil A 2 M0001
set /p Menu=►%R%[92m !LA2! %R%[90m[%R%[90mx,y%R%[90m]= %R%[0m
Call :Upper !Menu! Menu
echo !Menu! | Findstr /i "x" > NUL 2>&1
	if "!errorlevel!" EQU "0" (goto Search)
REM seçilen numaralara göre
Call :Dil A 2 T0011&echo ►%R%[96m !LA2!... %R%[0m 
FOR %%a in (!Menu!) do (Call :NonRemoved %%a)
set Menu2=!Menu2!,!Menu!
goto Menu

:: -------------------------------------------------------------
:Empty
FOR %%z in (!Menu2!) do (
	if %%z EQU %%a (set Empty=1)
)
goto :eof

:: -------------------------------------------------------------
:List_Search
REM Mavi, Mor, Sarı uygulamaları kataloglama bölümü, verileri buraya yönlendiriyorum.
FOR /F "tokens=*" %%a in ('Findstr /i "%~1" %Konum%\Log\AppxList.txt') do (
	FOR /F "delims=◄ tokens=1" %%b in ('echo %%a') do (
		FOR /F "delims=◄ tokens=2" %%c in ('echo %%a') do (
			set /a Count+=1
			echo Appxx_!Count!_◄%~2►%%c >> %Konum%\Log\MenuList.txt
			Call :Powershell "(Get-Content %Konum%\Log\AppxList.txt) | ForEach-Object { $_ -replace '%%b', 'NNN' } | Set-Content '%Konum%\Log\AppxList.txt'"
		)
	)
)
goto :eof

:: -------------------------------------------------------------
:Dil
REM Dil verilerini buradan alıyorum. Call komutu ile buraya uygun değerleri gönderiyorum.
REM %~1= Harf │ %~2= tokens değeri │ %~3= Find değeri
set L%~1%~2=
FOR /F "delims=> tokens=%~2" %%z in ('Findstr /i "%~3" !Dil! 2^>NUL') do (set L%~1%~2=%%z)
goto :eof

:: -------------------------------------------------------------
:Powershell
:: chcp 65001 kullanıldığında Powershell komutları ekranı kompakt görünüme sokuyor. Bunu önlemek için bu bölümde uygun geçişi sağlıyorum.
chcp 437 > NUL 2>&1
Powershell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -C %*
chcp 65001 > NUL 2>&1
goto :eof

:: -------------------------------------------------------------
:Upper
REM Gönderilen kelime, cümle veya herhangi bir tanımın içerisindeki tüm harfler büyük olarak değiştirilir.
chcp 437 > NUL 2>&1
FOR /F %%g in ('Powershell -command "'%~1'.ToUpper()"') do (set %~2=%%g)
chcp 65001 > NUL 2>&1
goto :eof

:: -------------------------------------------------------------
:Catalog_Appx
REM Mor, Mavi, Sarı uygulamaları menu ekranında listeliyip bilgi notları ekliyorum
set Next=0
REM Microsoft Store
FOR %%z in (Xaml VCLibs NET.Native StorePurchaseApp Services.Store.Engagement WindowsStore WindowsAppRuntime MicrosoftEdge WebExperience Winget) do (
	echo %~2 | Findstr /i "%%z" > NUL 2>&1
		if !errorlevel! EQU 0 (echo  %R%[32m%~1-%R%[36m %~2%R%[90m [%~3]%R%[90m %~4 │ [%R%[90m!LY2!%R%[90m]%R%[0m&set Next=1)
)
if "!Next!" EQU "1" (goto :eof)
REM Kodekler
FOR %%z in (Extension) do (
	echo %~2 | Findstr /i "%%z" > NUL 2>&1
		if !errorlevel! EQU 0 (echo  %R%[32m%~1-%R%[36m %~2%R%[90m [%~3]%R%[90m %~4 │ [%R%[90m!LX2!%R%[90m]%R%[0m&set Next=1)
)
if "!Next!" EQU "1" (goto :eof)
REM Xbox
FOR %%z in (Xbox GamingApp) do (
	echo %~2 | Findstr /i "%%z" > NUL 2>&1
		if !errorlevel! EQU 0 (echo  %R%[32m%~1-%R%[36m %~2%R%[90m [%~3]%R%[90m %~4 │ [%R%[90m!LW2!%R%[90m]%R%[0m&set Next=1)
)
if "!Next!" EQU "1" (goto :eof)
REM Sürücü
FOR %%z in (NVIDIAControl RealtekAudioControl) do (
	echo %~2 | Findstr /i "%%z" > NUL 2>&1
		if !errorlevel! EQU 0 (echo  %R%[32m%~1-%R%[35m %~2%R%[90m [%~3]%R%[90m %~4 │ [%R%[90m!LV2!%R%[90m]%R%[0m&set Next=1)
)
if "!Next!" EQU "1" (goto :eof)
REM Dil
FOR %%z in (LanguageExperiencePack) do (
	echo %~2 | Findstr /i "%%z" > NUL 2>&1
		if !errorlevel! EQU 0 (echo  %R%[32m%~1-%R%[35m %~2%R%[90m [%~3]%R%[90m %~4 │ [%R%[90m!LU2!%R%[90m]%R%[0m&set Next=1)
)
if "!Next!" EQU "1" (goto :eof)
if !Next! EQU 0 (echo  %R%[32m%~1-%R%[33m %~2%R%[90m [%~3]%R%[90m %~4%R%[0m)
goto :eof

:: -------------------------------------------------------------
:AppxReader
set Count=0
chcp 437 > NUL 2>&1
FOR /F "skip=3 tokens=*" %%g in ('Powershell -C "Get-AppxPackage -AllUsers | Select-Object %~1"') do (
	set /a Count+=1
	echo %~1_!Count!_ = %%g >> %Konum%\Log\AppxList.txt
)
chcp 65001 > NUL 2>&1
set N=!Count!
goto :eof

:: -------------------------------------------------------------
:AppxList
REM Uygulama verilerini çektiğim bölüm, bu bölüme yönlendirme yapıyorum
set Count=0
chcp 437 > NUL 2>&1
FOR /F "skip=3 tokens=*" %%g in ('Powershell -C "Get-AppxPackage -AllUsers | Select-Object %~1"') do (
	set /a Count+=1
	echo %~1%~2_!Count!_ = %%g >> %Konum%\Log\AppxList.txt
)
chcp 65001 > NUL 2>&1
set N=!Count!
goto :eof

:: -------------------------------------------------------------
:NonRemoved
REM Uygulamları kaldırma bölümü
FOR /F "delims=► tokens=4" %%g in ('Findstr /i "Appxx_%~1_" %Konum%\Log\MenuList.txt') do (set Choice=%%g)
FOR /F "delims=► tokens=3" %%g in ('Findstr /i "Appxx_%~1_" %Konum%\Log\MenuList.txt') do (set Choice2=%%g)
FOR /F "delims=► tokens=2" %%g in ('Findstr /i "Appxx_%~1_" %Konum%\Log\MenuList.txt') do (set Choice3=%%g)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\EndOfLife\!CUS!\!Choice!" /f > NUL 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\!Choice2!" /f > NUL 2>&1
Dism /Online /Set-NonRemovableapppolicy /Packagefamily:!Choice! /nonremovable:0 > NUL 2>&1
"%Konum%\Bin\NSudo.exe" -U:T -P:E -Wait -ShowWindowMode:hide Powershell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -C "Remove-AppxPackage -Package '!Choice!' -allusers"
FOR /F "tokens=*" %%g in ('dir /b "%Windir%\SystemApps\*!Choice3!*" 2^>NUL') do (
    echo Call :RD_Direct "%%Windir%%\SystemApps\%%g" >> %Konum%\Log\ResetAppxRemoved.cmd
    %NSudo% RD /S /Q "%Windir%\SystemApps\%%g"
)
FOR /F "tokens=*" %%g in ('dir /b "%ProgramFiles%\WindowsApps\*!Choice3!*" 2^>NUL') do (
    echo Call :RD_Direct "%%ProgramFiles%%\WindowsApps\%%g" >> %Konum%\Log\ResetAppxRemoved.cmd
    %NSudo% RD /S /Q "%ProgramFiles%\WindowsApps\%%g"
)
FOR /F "tokens=*" %%g in ('dir /b "%Windir%\SystemApps\*!Choice3!*" 2^>NUL') do (
    echo Call :RD_Direct "%%Windir%%\SystemApps\%%g" >> %Konum%\Log\ResetAppxRemoved.cmd
    %NSudo% RD /S /Q "%Windir%\SystemApps\%%g"
)
FOR /F "tokens=*" %%g in ('dir /b "%ProgramData%\Microsoft\Windows\AppRepository\Packages\*!Choice3!*" 2^>NUL') do (
    echo Call :RD_Direct "%%ProgramData%%\Microsoft\Windows\AppRepository\Packages\%%g" >> %Konum%\Log\ResetAppxRemoved.cmd
    %NSudo% RD /S /Q "%ProgramData%\Microsoft\Windows\AppRepository\Packages\%%g"
)
FOR /F "tokens=*" %%g in ('dir /b "C:\Users\All Users\Microsoft\Windows\AppRepository\Packages\*!Choice3!*" 2^>NUL') do (
    echo Call :RD_Direct "C:\Users\All Users\Microsoft\Windows\AppRepository\Packages\%%g" >> %Konum%\Log\ResetAppxRemoved.cmd
    %NSudo% RD /S /Q "C:\Users\All Users\Microsoft\Windows\AppRepository\Packages\%%g"
)
FOR /F "tokens=*" %%g in ('dir /b "%LocalAppData%\Packages\*!Choice3!*" 2^>NUL') do (
    echo Call :RD_Direct "%LocalAppData%\Packages\%%g" >> %Konum%\Log\ResetAppxRemoved.cmd
    %NSudo% RD /S /Q "%LocalAppData%\Packages\%%g"
)
FOR /L %%g in (1,1,3) do (set Choice%%g=)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /f /v "OgnitorenKs_AppxRemoved" /t REG_SZ /d "%Konum%\Log\ResetAppxRemoved.cmd" > NUL 2>&1
goto :eof

:: -------------------------------------------------------------
:Sahip
REM Klasör veya dosya sahipliği alma
takeown /f "%~1" > NUL 2>&1
icacls "%~1" /grant administrators:F > NUL 2>&1
goto :eof

:: -------------------------------------------------------------
:Print
REM Kaldırma işleminden sonra ilk açılışta kalıntıları temizlemesi için ekleme yapıyorum
(
echo echo off
echo chcp 65001
echo setlocal enabledelayedexpansion
echo cls
echo title Temizlik işlemi yapılıyor. Lütfen bekleyin │ Cleaning is in progress. Please wait
echo.
echo reg query "HKU\S-1-5-19" ^> NUL 2^>^&1
echo    if %%errorlevel%% NEQ 0 ^(Call :Powershell "Start-Process '%%~f0' -Verb Runas"^&exit^)
echo.
echo set NSudo="%Konum%\Bin\NSudo.exe" -U:T -P:E -Wait -ShowWindowMode:hide cmd /c
echo.
echo reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OgnitorenKs_AppxRemoved" /f ^> NUL 2^>^&1
echo goto Delete
echo.
echo :RD_Direct
echo echo [RD_Direct]-[%%~1]
echo %%NSudo%% RD /S /Q "%%~1"
echo goto :eof
echo.
echo :RD_Search
echo echo [RD_Search]-[%%~dp1%%%%g]
echo FOR /F "tokens=*" %%%%g in ^('Dir /AD /B "%%~1" 2^^^>NUL'^) do ^(
echo    echo [RD_Search]-[%%~dp1%%%%g]
echo    %%NSudo%% RD /S /Q "%%~dp1%%%%g"
echo ^)
echo goto :eof
echo.
echo :RD_Deep_Search
echo FOR /F "tokens=*" %%%%g in ^('Dir /AD /B /S "%%~1" 2^^^>NUL'^) do ^(
echo    echo [RD_Deep_Search]-[%%%%g]
echo    %%NSudo%% RD /S /Q "%%%%g"
echo ^)
echo goto :eof
echo.
echo :DEL_Direct
echo echo [DEL_Direct]-[%%~1]
echo %%NSudo%% DEL /F /Q /A "%%~1"
echo goto :eof
echo.
echo :DEL_Search
echo FOR /F "tokens=*" %%%%g in ^('Dir /A-D /B "%%~1" 2^^^>NUL'^) do ^(
echo    echo [DEL_Search]-[%%~dp1%%%%g]
echo    %%NSudo%% DEL /F /Q /A "%%~dp1%%%%g"
echo ^)
echo goto :eof
echo.
echo :DEL_Deep_Search
echo FOR /F "tokens=*" %%%%g in ^('Dir /A-D /B /S "%%~1" 2^^^>NUL'^) do ^(
echo    echo [DEL_Deep_Search]-[%%%%g]
echo    %%NSudo%% DEL /F /Q /A "%%%%g"
echo ^)
echo goto :eof
echo.
echo :Powershell
echo chcp 437 ^> NUL 2^>^&1
echo Powershell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -C %%*
echo chcp 65001 ^> NUL 2^>^&1
echo goto :eof
echo.
echo :Delete
) > %Konum%\Log\ResetAppxRemoved.cmd
goto :eof


:Search
Call :Dil A 2 M0002
set /p Search=►%R%[92m !LA2!%R%[90m= %R%[0m
FOR /F 


goto :eof