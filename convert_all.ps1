<#
Exel's bulk converter/copier for SC Ships

Open the game's .p4k archive and unpack the objects folder
Peter Dolkens makes a good tool for this called unp4k-suite (https://github.com/dolkensp/unp4k)

Slap this script in the same directory you unpacked to and let it do what it do, homie
Requires cgf-converter.exe to exist in the same directory (https://github.com/Markemp/Cryengine-Converter)

NOTE: there are tens of thousands of files to convert and move. Dis gon' take time, yo.

#>

Clear-Host

# Ask where the files are at
$location = Read-Host -Prompt "Where is your unpacked 'objects' folder located? I.E. C:\SC_Unpacked\"

# People don't pay attention to detail, add a backslash if missing
if ($location -match '\\$') {
}
else {
  $location = $location + "\"
}

# This is what we expect to find. We need this file to be able to do our thing
$converterExe = $location + "cgf-converter.exe"
Write-Output "Checking in:" $location "`r"
if(Test-Path $converterExe -PathType Leaf)
{
    Write-Output "CGF Converter found. Continuing..."
}
else {
    Write-Output "CGF Converter not found! Make sure it is in the directory you specified! Aborting...`r`n"
    exit
}

# Build lists of all .cga and .cgf files in folder, recursively
Write-Output "Building list of files, please wait...`r`n"
$files = Get-ChildItem -path $location -Recurse | Where-Object {$_.extension -eq ".cga"}
$files2 = Get-ChildItem -path $location -Recurse | Where-Object {$_.extension -eq ".cgf"}

# What file type do you want?
$format = Read-Host -Prompt "What format do you want the files converted to? [-dae, -obj]"

# For each .cga file, capture file pathing to build run parameters for converter, and convert
foreach ($file in $files) {
$params = $file.FullName + " " + $format + " -objectdir " + $file.DirectoryName
$name = $file.Basename
    if ($format -eq "-obj") {
		Start-Process -FilePath $converterExe $params -WindowStyle Hidden
    Start-Sleep -Milliseconds 300
		Write-Output $file.FullName
    }
    else {
		Start-Process -FilePath $converterExe $params -WindowStyle Hidden
    Start-Sleep -Milliseconds 300
		Write-Output $file.FullName
    }
}

# For each .cgf file, capture file pathing to build run parameters for converter, and convert
foreach ($file2 in $files2) {
$params = "$file2 $format -objectdir $file2.DirectoryName"
$name = $file2.Basename
    if ($format -eq "-obj") {
		Start-Process -FilePath E:\SC_Ships\cgf-converter.exe $params -WindowStyle Hidden
    Start-Sleep -Milliseconds 300
		Write-Output $file2.FullName
    }
    else {
		Start-Process -FilePath E:\SC_Ships\cgf-converter.exe $params -WindowStyle Hidden
    Start-Sleep -Milliseconds 300
		Write-Output $file2.FullName
    }
}
