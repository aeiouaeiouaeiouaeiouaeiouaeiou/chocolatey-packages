$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$desktopDir = [Environment]::GetFolderPath("Desktop")
$programFiles = [Environment]::GetFolderPath("ProgramFiles")
$url = 'http://ppsspp.org/files/1_14_1/PPSSPPSetup.exe'
$checksum = '7b527de4b961ad6dd912934456f8e4cd1f84e37fa47e330c779dd59b60474d80'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'exe'
  url            = $url
  softwareName   = 'ppsspp*'
  checksum       = $checksum
  checksumType   = 'sha256'
  silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
Install-ChocolateyShortcut -ShortcutFilePath ($desktopDir + '\PPSSPP (32-Bit).lnk') -TargetPath ($programFiles + '\PPSSPP\PPSSPPWindows.exe')
Install-ChocolateyShortcut -ShortcutFilePath ($desktopDir + '\PPSSPP (64-Bit).lnk') -TargetPath ($programFiles + '\PPSSPP\PPSSPPWindows64.exe')
