@ECHO OFF
setlocal

cd "%~dp0"

msbuild DansWinUi3SelfContainedDemo\DansWinUi3SelfContainedDemo\DansWinUi3SelfContainedDemo.csproj -t:restore /t:Build;Publish /p:Configuration=Release /p:Platform=x64 /p:PublishProfile=x64Profile /p:OutputPath=.\..\..\PusblishBin

endlocal
pause
