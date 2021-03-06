param($installPath, $toolsPath, $package, $project)

$pathClass = [System.IO.Path]
$projectPath = $pathClass::GetDirectoryName($project.FileName)
$refFile = "$projectPath\scripts\_references.js"

# for testing
# $srcDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
# $refFile = "$srcDir\_references.js"


if (!(test-path $refFile)) {
    pauseAndThrow "Unable to locate $refFile"
}
Write-Host "Updating $refFile ..."
$input = get-content $refFile
$isUpdated = $input | Select-String "breeze.debug.js" -quiet

if ($isUpdated) {
   Write-Host "Already up to date: $refFile ..."
   return
} 

# seems to insure a linefeed
"" | Out-file $refFile -append
'/// <reference path="breeze.debug.js" />' | Out-File $refFile -append

Write-Host "Updating $refFile completed"