$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$desktopDir = [Environment]::GetFolderPath("Desktop")
$programFiles = [Environment]::GetFolderPath("ProgramFiles")
$url = 'https://ppsspp.org/files/1_15_4/PPSSPPSetup.exe'
$checksum = 'a2e0de3dbda267746be0a44bfd2299b6d98aea46416682f90ffa1abaf2f62c36'
$pp = Get-PackageParameters

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
if (!$pp['No32bitIcon']) {
  Install-ChocolateyShortcut -ShortcutFilePath ($desktopDir + '\PPSSPP (32-Bit).lnk') -TargetPath ($programFiles + '\PPSSPP\PPSSPPWindows.exe')
}
Install-ChocolateyShortcut -ShortcutFilePath ($desktopDir + '\PPSSPP (64-Bit).lnk') -TargetPath ($programFiles + '\PPSSPP\PPSSPPWindows64.exe')
