<#
Exel's bulk converter/copier for SC Ships

Open the game's .p4k archive and unpack the objects folder
Peter Dolkens makes a good tool for this called unp4k-suite (https://github.com/dolkensp/unp4k)

Slap this script in the same directory you unpacked to and let it do what it do, homie
Requires cgf-converter.exe to exist in the same directory (https://github.com/Markemp/Cryengine-Converter)

NOTE: there are tens of thousands of files to convert and move. Dis gon' take time, yo.

#>

Clear-Host

# Build list of all .cga files in folder, recursively
Write-Output "Building list of files, please wait...`r`n"
$files = Get-ChildItem -path "E:\SC_Ships\3_22\" -Recurse | Where-Object {$_.extension -eq ".cga"}
$files2 = Get-ChildItem -path "E:\SC_Ships\3_22\" -Recurse | Where-Object {$_.extension -eq ".cgf"}

# What file type do you want?
$format = Read-Host -Prompt "What format do you want the files converted to? [-dae, -obj]"

# For each file in the list, check if destination directory exists (make if not), convert, and move converted file to destination directory
foreach ($file in $files) {
$params = $file.FullName + " " + $format + " -objectdir " + $file.DirectoryName
$name = $file.Basename
    if ($format -eq "-obj") {
		Start-Process -FilePath E:\SC_Ships\cgf-converter.exe $params -WindowStyle Hidden
    Start-Sleep -Milliseconds 300
		Write-Output $file
    }
    else {
		Start-Process -FilePath E:\SC_Ships\cgf-converter.exe $params -WindowStyle Hidden
    Start-Sleep -Milliseconds 300
		Write-Output $file
    }
}

foreach ($file2 in $files2) {
$params = "$file2 $format -objectdir $file2.DirectoryName"
$name = $file2.Basename
    if ($format -eq "-obj") {
		Start-Process -FilePath E:\SC_Ships\cgf-converter.exe $params -WindowStyle Hidden
    Start-Sleep -Milliseconds 300
		Write-Output $file2
    }
    else {
		Start-Process -FilePath E:\SC_Ships\cgf-converter.exe $params -WindowStyle Hidden
    Start-Sleep -Milliseconds 300
		Write-Output $file2
    }
}
