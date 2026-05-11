@echo off
echo Offline Computrace Kill Script v1.0 by billypurdue
echo based on
echo Computrace Kill Script V1.0 - Kippykip
echo:
echo This will permanently kill Computrace from this current Windows install using many methods.
echo There will probably be a lot of errors on missing files / services, 
echo but that's normal as this script accounts for almost everything Computrace related.
echo:
echo: This script is intended to be run from sergei strelec's winpe
echo If you are, then press any key to continue!
pause > NUL
echo Disabling Computrace Services...

Reg.exe add "HKLM\_C_comp_system\ControlSet001\services\CscService" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\_C_comp_system\ControlSet001\services\Ctes Manager" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\_C_comp_system\ControlSet001\services\CtesHostSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\_C_comp_system\ControlSet001\services\rpchdp" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\_C_comp_system\ControlSet001\services\rpcnet" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\_C_comp_system\ControlSet001\services\rpcnetp" /v "Start" /t REG_DWORD /d "4" /f

Reg.exe add "HKLM\_C_comp_system\ControlSet002\services\CscService" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\_C_comp_system\ControlSet002\services\Ctes Manager" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\_C_comp_system\ControlSet002\services\CtesHostSvc" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\_C_comp_system\ControlSet002\services\rpchdp" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\_C_comp_system\ControlSet002\services\rpcnet" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKLM\_C_comp_system\ControlSet002\services\rpcnetp" /v "Start" /t REG_DWORD /d "4" /f


echo Deleting Computrace Files...
DEL /F /Q /A C:\Windows\SysWOW64\cshost.dll
DEL /F /Q /A C:\Windows\SysWOW64\CTLojack.dll
DEL /F /Q /A C:\Windows\SysWOW64\DIAGDLL64.DLL
DEL /F /Q /A C:\Windows\SysWOW64\identprv.dll
DEL /F /Q /A C:\Windows\SysWOW64\pkgmgr.dll
DEL /F /Q /A C:\Windows\SysWOW64\pcnet.dll
DEL /F /Q /A C:\Windows\SysWOW64\wceprv.dll
DEL /F /Q /A C:\Windows\SysWOW64\instw64.exe
DEL /F /Q /A C:\Windows\SysWOW64\pkgslv.exe
DEL /F /Q /A C:\Windows\SysWOW64\rpcnet.exe
DEL /F /Q /A C:\Windows\SysWOW64\rpcnetp.exe
DEL /F /Q /A C:\Windows\SysWOW64\Upgrd.exe
DEL /F /Q /A C:\Windows\System32\cshost.dll
DEL /F /Q /A C:\Windows\System32\CTLojack.dll
DEL /F /Q /A C:\Windows\System32\DIAGDLL64.DLL
DEL /F /Q /A C:\Windows\System32\identprv.dll
DEL /F /Q /A C:\Windows\System32\pkgmgr.dll
DEL /F /Q /A C:\Windows\System32\pcnet.dll
DEL /F /Q /A C:\Windows\System32\wceprv.dll
DEL /F /Q /A C:\Windows\System32\instw64.exe
DEL /F /Q /A C:\Windows\System32\pkgslv.exe
DEL /F /Q /A C:\Windows\System32\rpcnet.exe
DEL /F /Q /A C:\Windows\System32\rpcnetp.exe
DEL /F /Q /A C:\Windows\System32\Upgrd.exe

echo Deleting Computrace Directories...
RD /S /Q C:\ProgramData\CTES
RD /S /Q C:\ProgramData\Rpcnet
echo Disabling Windows WPBT Table...
reg.exe add "HKLM\_C_comp_system\ControlSet001\Control\Session Manager" /v DisableWpbtExecution /t REG_DWORD /d "1" /f
reg.exe add "HKLM\_C_comp_system\ControlSet002\Control\Session Manager" /v DisableWpbtExecution /t REG_DWORD /d "1" /f

echo Blocking Computrace executables via Image File Execution options...
reg.exe add "HKLM\_C_comp_software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\rpcnetp.exe" /v Debugger /t REG_SZ /d "cmd.exe /c echo Blocked Computrace" /f
reg.exe add "HKLM\_C_comp_software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\rpcnet.exe" /v Debugger /t REG_SZ /d "cmd.exe /c echo Blocked Computrace" /f
reg.exe add "HKLM\_C_comp_software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Upgrd.exe" /v Debugger /t REG_SZ /d "cmd.exe /c echo Blocked Computrace" /f
reg.exe add "HKLM\_C_comp_software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\instw64.exe" /v Debugger /t REG_SZ /d "cmd.exe /c echo Blocked Computrace" /f
reg.exe add "HKLM\_C_comp_software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\pkgslv.exe" /v Debugger /t REG_SZ /d "cmd.exe /c echo Blocked Computrace" /f

echo Blocking computrace server communication via hosts file...
echo 0.0.0.0 websitename.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 search.namequery.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 search2.namequery.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 search64.namequery.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 eol.absolute.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 si.namequery.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 d.namequery.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 a.fc.namequery.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 fo.fc.namequery.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 resources.namequery.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 cdta.namequery.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 eum.absolute.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 api.absolute.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 ps.namequery.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 amp.namequery.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 ps.absolute.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 ctm.server.absolute.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 gcm-http.googleapis.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 bh.namequery.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 sv.symcb.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 s.symcb.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 s1.symcb.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 s2.symcb.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 crl.thawte.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 cdp.thawte.com >> C:\Windows\System32\Drivers\Etc\Hosts
echo 127.0.0.1 cacerts.thawte.com >> C:\Windows\System32\Drivers\Etc\Hosts

echo Creating fake directories...
md C:\Windows\SysWOW64\cshost.dll
md C:\Windows\SysWOW64\CTLojack.dll
md C:\Windows\SysWOW64\DIAGDLL64.DLL
md C:\Windows\SysWOW64\identprv.dll
md C:\Windows\SysWOW64\pkgmgr.dll
md C:\Windows\SysWOW64\pcnet.dll
md C:\Windows\SysWOW64\wceprv.dll
md C:\Windows\SysWOW64\instw64.exe
md C:\Windows\SysWOW64\pkgslv.exe
md C:\Windows\SysWOW64\rpcnet.exe
md C:\Windows\SysWOW64\rpcnetp.exe
md C:\Windows\SysWOW64\Upgrd.exe
md C:\Windows\System32\cshost.dll
md C:\Windows\System32\CTLojack.dll
md C:\Windows\System32\DIAGDLL64.DLL
md C:\Windows\System32\identprv.dll
md C:\Windows\System32\pkgmgr.dll
md C:\Windows\System32\pcnet.dll
md C:\Windows\System32\wceprv.dll
md C:\Windows\System32\instw64.exe
md C:\Windows\System32\pkgslv.exe
md C:\Windows\System32\rpcnet.exe
md C:\Windows\System32\rpcnetp.exe
md C:\Windows\System32\Upgrd.exe
echo All done! Computrace should never show its face again unless you clean install Windows again!
pause
