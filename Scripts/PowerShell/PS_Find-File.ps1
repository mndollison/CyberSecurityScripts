# This script is used to find a file in Windows. It accepts two parameters of filename and filepath. Filename is mandatory while filepath is optional.
# If you don't specify a filepath, it will default to C:\
# To use in a Meterpreter session, follow the steps below:
#     1. Run command "load powershell"
#     2. Run command "powershell_import /media/sf_CyberSecurity/PS_Find-File.ps1" (This will load the script to the Meterpreter session.)
#     3. Run command "powershell_execute "Find-File -filename 'sample.txt' -filepath 'C:\\Users'"
#
# Examples on how to call the function:
# Find-File -filename "example.txt"
# Find-File -filename "example.txt" -filepath "C:\\Users"

function Find-File {
    param (
        [Parameter(Mandatory=$true)]
        [string]$filename,

        [Parameter(Mandatory=$false)]
        [string]$filepath = "C:\\"
    )

    # Search for the file 
    $files = Get-ChildItem -Path $filepath -Recurse -Force -Include $filename -ErrorAction SilentlyContinue

    # Check if any files were found
    if ($files) {
        # Select desired properties including CreationTime and LastWriteTime
        $files | Select-Object -Property FullName, Name, Length, @{
            Name = "IsHidden"
            Expression = { ($_.Attributes -band [System.IO.FileAttributes]::Hidden) -ne 0 }
        }, CreationTime, LastWriteTime | Format-Table -AutoSize
    } else {
        Write-Output "File '$filename' not found in '$filepath'."
    }
}
