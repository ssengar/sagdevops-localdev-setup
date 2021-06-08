@echo off
setlocal

rem #############################################
rem #
rem # Batch Script to copy the installation files & custom templates
rem # 
rem #############################################

rem Read CCE and CICD setup related values from a properties file 
FOR /F "eol=# tokens=1,2 delims==" %%G IN (..\config\cce-setup.properties) DO (set %%G=%%H)  

SET src_dir=%src_dir%
SET target_dir=%target_dir%
echo local dev directory:%src_dir%
echo sagdevops CCE directory:%target_dir%
IF NOT EXIST %target_dir% MKDIR %target_dir%
cd %target_dir%
git -C %target_dir%/sagdevops-cc-server pull || git clone --recursive -b release/105oct2019 https://github.com/SoftwareAG/sagdevops-cc-server 
echo Clone the ldev-setup GIT repo
echo.
xcopy /s /e "%src_dir%/sagdevops-localdev-setup/templates" "%target_dir%/sagdevops-cc-server/templates"
IF %errorlevel% NEQ 0 (
	echo Non-zero exit code %errorlevel% was returned. Exit the process.
	rem endlocal	
	EXIT /B %errorlevel%
)
echo custom templates copied successfully
cd %target_dir%/sagdevops-cc-server/antcc
mkdir environments
cd %target_dir%/sagdevops-cc-server/antcc/environments
mkdir default
copy /-y "%src_dir%/sagdevops-localdev-setup/environments/default" "%target_dir%/sagdevops-cc-server/antcc/environments/default"
copy /y "%src_dir%/sagdevops-localdev-setup/config\sagenv.xml" "%target_dir%/sagdevops-cc-server/antcc/lib"
IF %errorlevel% NEQ 0 (
	echo Non-zero exit code %errorlevel% was returned. Exit the process.
	rem endlocal	
	EXIT /B %errorlevel%
)
ENDLOCAL
EXIT /B %errorlevel%