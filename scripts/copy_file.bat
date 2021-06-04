@echo off
setlocal

rem #############################################
rem #
rem # Batch Script to copy the installation files & custom templates
rem # 
rem #############################################

rem Read CCE and CICD setup related values from a properties file 
FOR /F "eol=# tokens=1,2 delims==" %%G IN (../config/ldev-setup.properties) DO (set %%G=%%H)  

SET src_dir=%src_dir%
SET target_dir=%target_dir%
IF NOT EXIST %src_dir% MKDIR %src_dir%
git clone https://github.com/saigandi/sagdevops-localdev-setup.git
echo Clone the sagdevops-cc-server GIT repo
echo.
IF NOT EXIST %target_dir% MKDIR %target_dir%
git clone --recursive -b release/105oct2019 https://github.com/SoftwareAG/sagdevops-cc-server 
echo Clone the ldev-setup GIT repo
echo.
xcopy /s /e "%src_dir%/sagdevops-localdev-setup/templates" "%target_dir%/sagdevops-cc-server/templates"
cd %target_dir%/sagdevops-cc-server/antcc
mkdir environments/default
copy /-y "%src_dir%/sagdevops-localdev-setup/environments/default" "%target_dir%/sagdevops-cc-server/antcc/environments/default"
copy /-y "%src_dir%/sagdevops-localdev-setup/config/sagenv.xml" "%target_dir%/sagdevops-cc-server/antcc/lib"
EN
EXIT /B %errorlevel%