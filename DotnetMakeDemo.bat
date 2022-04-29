@ECHO OFF
setlocal

cd "%~dp0"

dotnet publish /p:DebugType=None /p:DebugSymbols=false /p:PublishReadyToRun=true /p:PublishSingleFile=true /p:PublishReadyToRunShowWarnings=true /p:PublishTrimmed=false /p:IncludeNativeLibrariesForSelfExtract=true "DansWinUi3SelfContainedDemo\DansWinUi3SelfContainedDemo\DansWinUi3SelfContainedDemo.csproj" -o "." -c release

endlocal
pause
