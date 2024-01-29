$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$desktopDir = [Environment]::GetFolderPath("Desktop")
$programFiles = [Environment]::GetFolderPath("ProgramFiles")
$url = 'https://www.ppsspp.org/files/1_17/PPSSPPSetup.exe'
$checksum = '4dd1c87721c15c1f521c7b43712a2e47cd124314c82f7716a17d873fc17488bc'
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
