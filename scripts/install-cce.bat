@echo off
setlocal

rem #############################################
rem #
rem # Batch Script to Install Command Central
rem # 
rem #############################################

rem Read CCE and CICD setup related values from a properties file 
FOR /F "eol=# tokens=1,2 delims==" %%G IN (..\config\cce-setup.properties) DO (set %%G=%%H)  

rem SET cc_cli_home=%sagcce_installdir%/CommandCentral/client
SET log_file=%cicdhome_dir%\logFile.log

SET start_datetime=%date%%time%


IF NOT EXIST %cicdhome_dir% MKDIR %cicdhome_dir%
cd %cicdhome_dir%
echo "============== Start at %start_datetime% ==================" >> %log_file%

echo Clone the sagdevops-cc-server GIT repo

set remote_repo=https://github.com/SoftwareAG/sagdevops-cc-server
rem set local_repo=%cicdhome_dir%\sagdevops-cc-server
git -C %cicdhome_dir%\sagdevops-cc-server pull || git --recursive -b release/105oct2019 clone remote_repo
IF %errorlevel% NEQ 0 (
	echo Non-zero exit code %errorlevel% was returned. Exit the process.
	rem endlocal	
	EXIT /B %errorlevel%
)



rem git clone --recursive -b release/105oct2019 https://github.com/SoftwareAG/sagdevops-cc-server >> %log_file%
rem IF %errorlevel% NEQ 0 (
rem 	echo Non-zero exit code %errorlevel% was returned. Exit the process.
rem 	rem endlocal	
rem 	EXIT /B %errorlevel%
rem )


powershell.exe -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/SoftwareAG/sagdevops-antcc/release/104apr2019/bootstrap/install.ps1'))"


cd %cicdhome_dir%\sagdevops-cc-server

echo Bootstrap CCE
rem ant boot -Daccept.license=true -Dcc.cli.home=%cc_cli_home% -Dinstall.dir=%sagcce_installdir% >> %log_file%
call ant boot -Daccept.license=true >> %log_file%

IF %errorlevel% NEQ 0 (
		echo Non-zero exit code %errorlevel% was returned. Exit the process.
	rem endlocal	
		EXIT /B %errorlevel%
)

call ant -f build.xml up

rem Exit from main script
EXIT /B %errorlevel%