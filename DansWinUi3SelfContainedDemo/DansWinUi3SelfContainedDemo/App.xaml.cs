﻿using Microsoft.UI.Xaml;

namespace DansWinUi3SelfContainedDemo;

public partial class App
{
    public App()
    {
        InitializeComponent();
    }

    protected override void OnLaunched(LaunchActivatedEventArgs args)
    {
        _window = new MainWindow();
        _window.Activate();
    }

    private Window _window;
}
