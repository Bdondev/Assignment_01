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
# Write sample data to CSV (simulating your original data file)
$data = @(
    [PSCustomObject]@{ product = "chocolate"; price = 4.99; aisle = "bakery"; available = "yes" },
    [PSCustomObject]@{ product = "banana"; price = 0.99; aisle = "produce"; available = "yes" },
    [PSCustomObject]@{ product = "ice cream"; price = 4.50; aisle = "frozen"; available = "no" }
)
 
# Write sample data to the original CSV file (this would be your existing CSV in a real scenario)
$data | Export-Csv -Path $sourceFilePath -NoTypeInformation
 
Write-Host "Data has been written to $sourceFilePath"

# Import data from the original CSV file
Write-Host "Importing data from CSV..."
$importedData = Import-Csv -Path $sourceFilePath
