$ErrorActionPreference = 'Stop';
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$desktopDir = [Environment]::GetFolderPath("Desktop")
$programFiles = [Environment]::GetFolderPath("ProgramFiles")
$url = 'https://www.ppsspp.org/files/1_20_3/PPSSPPSetup.exe'
$checksum = '1315fd1add7b1501a0b0e50d93eb6c46d27376aa23edd942974cbc8b9122d89a'
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
