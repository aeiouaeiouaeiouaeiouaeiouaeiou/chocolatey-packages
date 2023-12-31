import-module au

$releases = 'https://www.ppsspp.org/download/'

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
     }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    #http://www.ppsspp.org/files/{VERSION}/PPSSPPSetup.exe
    $re  = "files/.+/PPSSPPSetup.exe"
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version = $url -split '/' | select -Last 1 -Skip 1
    $version = $version.replace('_', '.')
    $url = 'https://www.ppsspp.org/' + $url

    $Latest = @{ URL32 = $url; Version = $version }
    return $Latest
}

update
