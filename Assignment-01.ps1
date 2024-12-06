# Define the file paths
$generalOutputFolder = "/Users/sarahgisondi/Assignment_01/retrieve-output"  # General output folder for filtered files
$archiveFolderPath = "/Users/sarahgisondi/Assignment_01/archive"  # Folder to archive old folders
$sourceFilePath = "/Users/sarahgisondi/Assignment_01/data.csv"  # Path to the source CSV file 
 
# Filter Value (set dynamically)
$filterValue = "banana"
 
# Find the next available folder name (vs1, vs2, etc.)
$existingFolders = Get-ChildItem -Path $generalOutputFolder -Directory
$nextFolderIndex = 1
 
# Find the next available "vsX" folder name (vs1, vs2, vs3, etc.)
while ($existingFolders.Name -contains "vs$nextFolderIndex") {
    $nextFolderIndex++
}
 
# Generate the new folder name as "vsX"
$newFolderName = "vs$nextFolderIndex"
$newFolderPath = Join-Path -Path $generalOutputFolder -ChildPath $newFolderName
 
# Create the new folder for filtered output
if (-not (Test-Path -Path $newFolderPath)) {
    New-Item -Path $newFolderPath -ItemType Directory
    Write-Host "Created new folder: $newFolderPath"
}