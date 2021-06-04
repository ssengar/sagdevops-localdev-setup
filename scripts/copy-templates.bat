@echo off

set myDIR=DevOps
IF not exist %myDIR% (mkdir %myDIR%)

cd %myDIR%

goto comment
...skip this...


echo Clone the sagdevops-cc-server GIT repo
git clone --recursive -b release/105oct2019 https://github.com/SoftwareAG/sagdevops-cc-server 
IF %errorlevel% NEQ 0 (
	echo Non-zero exit code %errorlevel% was returned. Exit the process.
	rem endlocal	
	EXIT /B %errorlevel%
)

echo Clone the sagdevops-cc-server GIT repo
git clone https://github.com/saigandi/sagdevops-ci-cd-local-env-setup.git 
IF %errorlevel% NEQ 0 (
	echo Non-zero exit code %errorlevel% was returned. Exit the process.
	rem endlocal	
	EXIT /B %errorlevel%
)

:comment

set cce_home=%~dp0/../sagdevops-cc-server
echo %cce_home%

REM set srcpath=%~dp0 
REM echo %srcpath%

rem COPYIT.BAT transfers all files in all subdirectories of
rem the source drive or directory (%1) to the destination rem drive or directory (%2)



rem set /p Arg1=Please enter the source folder of your custom templates?:%1
rem set /p Arg2=Please enter the target folder of your CCE library templates?:%2

rem xcopy %Arg1% %Arg2% /s /e



REM set /p Arg3=Please enter the environment file of your custom templates?:%3
REM set /p Arg4=Please enter the environment file of your CCE templates?: %4
 
REM xcopy %Arg3% %Arg4% /s /e
