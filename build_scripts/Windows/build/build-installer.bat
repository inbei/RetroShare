@echo off

setlocal

:: Initialize environment
call "%~dp0..\env.bat"
if errorlevel 1 goto error_env
call "%EnvPath%\env.bat"
if errorlevel 1 goto error_env

:: Initialize environment
call "%~dp0env.bat" standard
if errorlevel 2 exit /B 2
if errorlevel 1 goto error_env

:: Check external libraries
if not exist "%BuildLibsPath%\libs" %cecho% error "Please build external libraries first." & exit /B 1

:: Check gcc version of external libraries
if not exist "%BuildLibsPath%\libs\gcc-version" %cecho% error "Cannot get gcc version of external libraries." & exit /B 1
set /P LibsGCCVersion=<"%BuildLibsPath%\libs\gcc-version"
if "%LibsGCCVersion%" NEQ "%GCCVersion%" %cecho% error "Please use correct version of external libraries. (gcc %GCCVersion% ^<^> libs %LibsGCCVersion%)." & exit /B 1

:: Build defines for script
set NSIS_PARAM=

set NSIS_PARAM=%NSIS_PARAM% /DRELEASEDIR="%RsBuildPath%"
set NSIS_PARAM=%NSIS_PARAM% /DQTDIR="%QtPath%\.."
set NSIS_PARAM=%NSIS_PARAM% /DMINGWDIR="%MinGWPath%\.."
set NSIS_PARAM=%NSIS_PARAM% /DOUTDIR="%RsPackPath%"
set NSIS_PARAM=%NSIS_PARAM% /DINSTALLERADD="%RsArchiveAdd%"

:: Scan version from source
set RsRevision=
set RsBuildAdd=
call "%ToolsPath%\get-rs-version.bat" RS_REVISION_STRING RsRevision
if "%RsRevision%"=="" echo Revision not found.& exit /B 1
call "%ToolsPath%\get-rs-version.bat" RS_BUILD_NUMBER_ADD RsBuildAdd
if errorlevel 1 exit /B 1

set NSIS_PARAM=%NSIS_PARAM% /DREVISION=%RsRevision% /DBUILDADD=%RsBuildAdd%

set QtMainVersion=%QtVersion:~0,1%

:: Create installer
"%EnvMakeNSISExe%" %NSIS_PARAM% "%SourcePath%\build_scripts\Windows\installer\retroshare-Qt%QtMainVersion%.nsi"

exit /B %ERRORLEVEL%

:error_env
echo Failed to initialize environment.
endlocal
exit /B 1
