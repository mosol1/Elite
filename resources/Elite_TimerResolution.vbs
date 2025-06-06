Set WshShell = CreateObject("WScript.Shell") 
WshShell.Run Chr(34) & "C:\SetTimerResolution.exe" & Chr(34) & " --resolution 5120 --no-console", 7, False 
WshShell.Run "wmic process where name='TextInputHost.exe' CALL setpriority 'normal'", 0, False
