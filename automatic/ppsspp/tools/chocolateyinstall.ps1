$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$desktopDir = [Environment]::GetFolderPath("Desktop")
$programFiles = [Environment]::GetFolderPath("ProgramFiles")
$url = 'https://www.ppsspp.org/files/1_20_2/PPSSPPSetup.exe'
$checksum = '3530eef34bf1c6883070d9e3fb0860514c76873bc19ab3eb9f81df82094ff6f9'
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
