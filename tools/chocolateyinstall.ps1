$ErrorActionPreference = 'Stop'  
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"


$url        = 'https://aplicacoes.autenticacao.gov.pt/apps/Autenticacao.gov_Win_x86_signed.msi' # download url, HTTPS preferred
$url64      = 'https://aplicacoes.autenticacao.gov.pt/apps/Autenticacao.gov_Win_x64_signed.msi' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  url64bit      = $url64


  softwareName  = 'Autenticação.gov*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique

  checksum      = '3DC1C4EADE14DFC44E1259B801135792929E1222972F432A8CA77F02827C0279'
  checksumType  = 'sha256'
  checksum64    = '5BA02666281065EECEA9F2F6F9F3AB73FDDE0CAD07FAD1334EEA823F7AEEBEEA'
  checksumType64= 'sha256'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  validExitCodes= @(0, 3010, 1641)
 
}

Install-ChocolateyPackage @packageArgs 
