Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File C:\Program Files\EliteOptimizer\resources\XHCI.ps1", 0, True
Set objShell = Nothing
