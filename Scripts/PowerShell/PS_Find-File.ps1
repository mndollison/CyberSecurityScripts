#This script is used to find a file in Windows. It accepts two parameters of filename and filepath. Filename is mandatory while filepath is optional.
# If you don't specify a filepath, it will default to C:\:
#Example usage:
#	Find-File -filename "example.txt" 
#	Find-File -filename "example.txt" -filepath "C:\\Users"

function Find-File {
    param (
        [Parameter(Mandatory=$true)]
        [string]$filename,
        
        [Parameter(Mandatory=$false)]
        [string]$filepath = "C:\\"
    )
    
    #Get-ChildItem -Path $filepath -Recurse -ErrorAction SilentlyContinue -Include $filename | ForEach-Object { $_.FullName }
    Get-ChildItem -Path $filepath -Recurse -Force -Include $filename -ErrorAction SilentlyContinue | Format-List -Property *
}