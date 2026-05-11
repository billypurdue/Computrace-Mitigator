@echo off
:: I found this script on github, but it's meant to be run before absolut trips - I modifed it so it can run from Sergei Strelec's WinPE.

setlocal enabledelayedexpansion

echo Offline Computrace Kill Script v1.0 by h0d0r
echo Based on Kippykip's original script

echo Available volumes/drives:

wmic logicaldisk get deviceid, volumename, size


:getdrive
set /p "DRV=Enter the drive letter of the Windows install (e.g., D): "
:: Don't need the colons but sometimes I put them by accident
set "DRV=%DRV::=%"

if not exist "%DRV%:\Windows" (
    echo [ERROR] %DRV%:\Windows was not found. Please pick a valid Windows install that's not the WinPE boot volume.
    goto :getdrive
)

echo:
echo Using Target Drive: %DRV%:\
echo This script is intended to be run from sergei strelec's winpe.
echo Press any key to start the "Kill" process on %DRV%:\...
pause > NUL

echo Disabling Computrace Services by creating and modifying registry keys
echo Note: Errors during this step indicate either the registry keys already exist (if you've run this before for example) or your Windows volume selection wasn't correct.
echo .
Reg.exe add "HKLM\_%DRV%_comp_system\ControlSet001\services\CscService" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\_%DRV%_comp_system\ControlSet001\services\Ctes Manager" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\_%DRV%_comp_system\ControlSet001\services\CtesHostSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\_%DRV%_comp_system\ControlSet001\services\rpchdp" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\_%DRV%_comp_system\ControlSet001\services\rpcnet" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\_%DRV%_comp_system\ControlSet001\services\rpcnetp" /v "Start" /t REG_DWORD /d "4" /f

Reg.exe add "HKLM\_%DRV%_comp_system\ControlSet002\services\CscService" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\_%DRV%_comp_system\ControlSet002\services\Ctes Manager" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\_%DRV%_comp_system\ControlSet002\services\CtesHostSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\_%DRV%_comp_system\ControlSet002\services\rpchdp" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\_%DRV%_comp_system\ControlSet002\services\rpcnet" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\_%DRV%_comp_system\ControlSet002\services\rpcnetp" /v "Start" /t REG_DWORD /d "4" /f

echo Deleting Computrace Files...
echo Note: Errors here either mean you've already deleted the files (or they didn't exist) or your Windows volume selection wasn't correct.
echo .
for %%F in (cshost.dll CTLojack.dll DIAGDLL64.DLL identprv.dll pkgmgr.dll pcnet.dll wceprv.dll instw64.exe pkgslv.exe rpcnet.exe rpcnetp.exe Upgrd.exe) do (
    DEL /F /Q /A %DRV%:\Windows\SysWOW64\%%F
    DEL /F /Q /A %DRV%:\Windows\System32\%%F
)

echo Deleting Computrace Directories...
RD /S /Q %DRV%:\ProgramData\CTES
RD /S /Q %DRV%:\ProgramData\Rpcnet

echo Disabling Windows WPBT Table...
echo Note: Errors during this step indicate either the registry keys already exist (if you've run this before for example) or your Windows volume selection wasn't correct.
echo .
reg.exe add "HKLM\_%DRV%_comp_system\ControlSet001\Control\Session Manager" /v DisableWpbtExecution /t REG_DWORD /d "1" /f
reg.exe add "HKLM\_%DRV%_comp_system\ControlSet002\Control\Session Manager" /v DisableWpbtExecution /t REG_DWORD /d "1" /f

echo Blocking via Image File Execution options...
echo Note: Errors during this step indicate either the registry keys already exist (if you've run this before for example) or your Windows volume selection wasn't correct.
echo .
for %%E in (rpcnetp.exe rpcnet.exe Upgrd.exe instw64.exe pkgslv.exe) do (
    reg.exe add "HKLM\_%DRV%_comp_software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%E" /v Debugger /t REG_SZ /d "cmd.exe /c echo Blocked Computrace" /f
)

echo Blocking computrace server communication via hosts file...
echo Note: Errors here either likely means that your Windows volume selection wasn't correct.
echo .
set "HOSTS=%DRV%:\Windows\System32\Drivers\Etc\Hosts"
echo 0.0.0.0 websitename.com >> "%HOSTS%"
echo 127.0.0.1 search.namequery.com >> "%HOSTS%"
echo 127.0.0.1 search2.namequery.com >> "%HOSTS%"
echo 127.0.0.1 search64.namequery.com >> "%HOSTS%"
echo 127.0.0.1 eol.absolute.com >> "%HOSTS%"
echo 127.0.0.1 si.namequery.com >> "%HOSTS%"
echo 127.0.0.1 d.namequery.com >> "%HOSTS%"
echo 127.0.0.1 a.fc.namequery.com >> "%HOSTS%"
echo 127.0.0.1 fo.fc.namequery.com >> "%HOSTS%"
echo 127.0.0.1 resources.namequery.com >> "%HOSTS%"
echo 127.0.0.1 cdta.namequery.com >> "%HOSTS%"
echo 127.0.0.1 eum.absolute.com >> "%HOSTS%"
echo 127.0.0.1 api.absolute.com >> "%HOSTS%"
echo 127.0.0.1 ps.namequery.com >> "%HOSTS%"
echo 127.0.0.1 amp.namequery.com >> "%HOSTS%"
echo 127.0.0.1 ps.absolute.com >> "%HOSTS%"
echo 127.0.0.1 ctm.server.absolute.com >> "%HOSTS%"
echo 127.0.0.1 gcm-http.googleapis.com >> "%HOSTS%"
echo 127.0.0.1 bh.namequery.com >> "%HOSTS%"
echo 127.0.0.1 sv.symcb.com >> "%HOSTS%"
echo 127.0.0.1 s.symcb.com >> "%HOSTS%"
echo 127.0.0.1 s1.symcb.com >> "%HOSTS%"
echo 127.0.0.1 s2.symcb.com >> "%HOSTS%"
echo 127.0.0.1 crl.thawte.com >> "%HOSTS%"
echo 127.0.0.1 cdp.thawte.com >> "%HOSTS%"
echo 127.0.0.1 cacerts.thawte.com >> "%HOSTS%"

echo Creating fake directories to block file recreation...
echo Note: Errors here either mean you've already run this script, or your Windows volume selection wasn't correct.
echo .
for %%F in (cshost.dll CTLojack.dll DIAGDLL64.DLL identprv.dll pkgmgr.dll pcnet.dll wceprv.dll instw64.exe pkgslv.exe rpcnet.exe rpcnetp.exe Upgrd.exe) do (
    md %DRV%:\Windows\SysWOW64\%%F
    md %DRV%:\Windows\System32\%%F
)

echo:
echo All done! Computrace is neutralized on drive %DRV%.
pause
