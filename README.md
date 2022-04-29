# Dan's WinUI 3 Self-Contained .exe Guide

## Important Note

This guide should work in the future. However, there is currently a blocking issue [msbuild#7452](https://github.com/dotnet/msbuild/issues/7452) that needs to be resolved before the `dotnet` cli commands can work.

Therefore, the project can be built into an exe, but it can't be shared as self contained. The project also can't currently be run in VS Code. However, I just discovered a work around for the exe. See the end.

Nevermind, another blocking issue. Raised issue. [So close yet so far msbuild#7587](<https://github.com/dotnet/msbuild/issues/7587>)

## Another shocking thing

There is currently no XAML Designer... [microsoft-ui-xaml#5917](https://github.com/microsoft/microsoft-ui-xaml/issues/5917)

## About

This repository contains:

* A guide on how to set up a WinUI 3 project to build to a self-contained .exe file
  * This means that it does not have to be installed, it can just be run
* Example workflows for when the main branch is updated and when a release is made
* A simple MVVM & DI / IOC Example
* The .vscode files required to debug / publish the exe. You will still need Visual Studio installed though unless you want to work out all the files needed. I didn't fancy that

## Demo

The simple demo exe can be downloaded from the releases page. It can be run without installing any pre-requisites

## Guide

### Preparing Your Computer

*Note: Eventually this will come to the built in versions for visual studio. I will update the guide around when that happens*

*Note: Visual Studio 2022 Preview is required so you have .NET 6.0.300 installed. The build / publish command won't run without it. Ironically you don't actually need to use the preivew version, you just need it installed*

1) Setup Visual Studio 2022 Preview. When installing, select:

    * Main Page

        * Universal Windows Platform development

            * C++ (v143) Universal Windows Platform tools

        * .NET Desktop Development

            * Windows App SDK C# Templates

        * Desktop development with C++

    * Individual Components Page

        * Windows 10 SDK (10.0.19041.0)

*Note: A copy of the installers from the links can be found in `.\InstallersForReadme` if you want to get them quickly, otherwise feel free to download from the links*

2) Download and install [Windows App SDK 1.1 Preview 2](https://docs.microsoft.com/en-us/windows/apps/windows-app-sdk/downloads)

3) From the same website, download `C# Visual Studio 2022 extension` for the preview

4) Install this specific version of the [C++ redistributable](https://docs.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170)

### Creating The Project

1) Open Visual Studio and make a new project

2) Select `Blank App, Packaged (WinUI 3 in Desktop)`

3) If storing in git, run `dotnet new gitignore` in command prompt in the folder created.

4) Add `<WindowsPackageType>None</WindowsPackageType>` to the end of the newly created .csproj's main `PropertyGroup`. See `.\DansWinUi3SelfContainedDemo\DansWinUi3SelfContainedDemo\DansWinUi3SelfContainedDemo.csproj` if unsure

5) Change the debug dropdown at the top of Visual Studio from `YouProjectName (Packaged)` to `YouProjectName (Unpackaged)`

*At this point it will build a non-self-contained exe. The next steps are to make it contained when you run `dotnet publish`*

6) Add the code below to the end of the newly created .csproj's main `PropertyGroup`. See `.\DansWinUi3SelfContainedDemo\DansWinUi3SelfContainedDemo\DansWinUi3SelfContainedDemo.csproj` if unsure

        <PublishSingleFile Condition="'$(Configuration)' == 'Release'">true</PublishSingleFile>
        <SelfContained>true</SelfContained>
        <RuntimeIdentifier>win-x64</RuntimeIdentifier>
        <PublishReadyToRun>true</PublishReadyToRun>
        <PublishTrimmed>false</PublishTrimmed>
        <IncludeNativeLibrariesForSelfExtract>true</IncludeNativeLibrariesForSelfExtract>

### Making The exe

To make the exe, simply run the `dotnet publish` command with the following arguments. Make sure to replace `YourProject.csproj` with a path to you project.

    dotnet publish /p:DebugType=None /p:DebugSymbols=false /p:PublishReadyToRun=true /p:PublishSingleFile=true /p:PublishReadyToRunShowWarnings=true /p:PublishTrimmed=false /p:IncludeNativeLibrariesForSelfExtract=true "YourProject.csproj" -o "." -c release

See `DotnetMakeDemo.bat` for an example of the command used for this project.

## Publishing exe workaround till Microsoft fix `dotnet`

1) Add the code below to the end of the newly created .csproj's main `PropertyGroup`. See `.\DansWinUi3SelfContainedDemo\DansWinUi3SelfContainedDemo\DansWinUi3SelfContainedDemo.csproj` if unsure

        <DebugType Condition="'$(Configuration)' == 'Release'">None</DebugType>
        <DebugSymbols Condition="'$(Configuration)' == 'Release'">false</DebugSymbols>
        <PublishReadyToRunShowWarnings Condition="'$(Configuration)' == 'Release'">true</PublishReadyToRunShowWarnings>

2) Add `msbuild` to your path. I found mine in `C:\Program Files\Microsoft Visual Studio\2022\Preview\MSBuild\Current\Bin`

3) Modify your publish command to look like:

        msbuild YourProject.csproj -t:restore /t:Build;Publish /p:Configuration=Release /p:Platform=x64 /p:PublishProfile=x64Profile /p:OutputPath=.\Published

See `MsbuildMakeDemo.bat` for an example of the command used for this project.

*Note: When running, be prepared for a metric ton of output in the console*
