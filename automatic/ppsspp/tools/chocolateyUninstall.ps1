$desktopDir = [Environment]::GetFolderPath("Desktop")

Remove-Item ($desktopDir + '\PPSSPP (32-Bit).lnk')
Remove-Item ($desktopDir + '\PPSSPP (64-Bit).lnk')