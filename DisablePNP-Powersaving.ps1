# Define the MessageBox class
Add-Type -TypeDefinition @"
using System;
using System.Windows.Forms;
public class MessageBoxExample {
    public static void ShowMessage() {
        MessageBox.Show("Hello", "Message Box");
    }
}
"@

# Call the ShowMessage method to display the message box
[MessageBoxExample]::ShowMessage()
