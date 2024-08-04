Set WshShell = CreateObject("WScript.Shell") 
WshShell.Run Chr(34) & "C:\Program Files\ElitePremiumUtility\resources\SetTimerResolution.exe" & Chr(34) & " --resolution 5000 --no-console", 7, False 
WshShell.Run "wmic process where name='TextInputHost.exe' CALL setpriority 'normal'", 0, False 
WshShell.Run "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File ""C:\Program Files\ElitePremiumUtility\resources\dwmMMCSS.ps1""", 0, True 
WshShell.Run "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File ""C:\Program Files\ElitePremiumUtility\resources\DWMFlushQueue.ps1""", 0, True 
WshShell.Run "taskkill /F /IM dwm.exe", 0, True 
WshShell.Run "cmd /c start """" /b ""C:\Windows\System32\dwm.exe""", 0, True 