# Dan's WinUI 3 Self-Contained .exe Guide

## About

This repository contains:

* A guide on how to set up a WinUI 3 project to build to a self-contained .exe file
  * This means that it does not have to be installed, it can just be run
* Example workflows for when the main branch is updated and when a release is made
* A simple MVVM & DI / IOC Example

## Demo

The simple demo exe can be downloaded from the releases page. It can be run without installing any pre-requisites

## Guide

### Preparing Your Computer

*Note: Eventually this will come to the built in versions for visual studio. I will update the guide around when that happens*

1) Setup Visual Studio. Open Visual Studio Installer and select:

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

6)

### Making The exe
