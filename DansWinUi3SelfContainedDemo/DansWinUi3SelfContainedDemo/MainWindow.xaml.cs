using Microsoft.UI.Xaml;

namespace DansWinUi3SelfContainedDemo;

public partial class MainWindow
{
    public MainWindow()
    {
        InitializeComponent();
    }

    private void myButton_Click(object sender, RoutedEventArgs e)
    {
        myButton.Content = "Clicked";
    }
}
