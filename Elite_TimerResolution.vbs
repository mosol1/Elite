Set WshShell = CreateObject("WScript.Shell") 
WshShell.Run Chr(34) & "C:\Program Files (x86)\ElitePremiumUtility\resources\SetTimerResolution.exe" & Chr(34) & " --resolution 5070 --no-console", 7, False 
WshShell.Run "wmic process where name='TextInputHost.exe' CALL setpriority 'normal'", 0, False 
WshShell.Run "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File ""C:\Program Files (x86)\ElitePremiumUtility\resources\dwmMMCSS.ps1""", 0, True 
WshShell.Run "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File ""C:\Program Files (x86)\ElitePremiumUtility\resources\DWMFlushQueue.ps1""", 0, True 
WshShell.Run "taskkill /F /IM dwm.exe", 0, True 
WshShell.Run "cmd /c start """" /b ""C:\Windows\System32\dwm.exe""", 0, True 
