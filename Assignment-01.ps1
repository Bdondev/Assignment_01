# Define the file paths
$generalOutputFolder = "/Users/ash/Assignment_01/retrieve-output"  # General output folder for filtered files
$archiveFolderPath = "/Users/ash/Assignment_01/archive"  # Folder to archive old folders
$sourceFilePath = "/Users/ash/Assignment_01/data.csv"  # Path to the source CSV file 
 
# Filter Value (set dynamically)
$filterValue = "chocolate"
 
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


# Filter the data based on the dynamic filter value
Write-Host "Filtering data..."
$modifiedData = $importedData | ForEach-Object {
    # Create an empty custom object with all columns set to empty
    $output = @{
        product   = ""
        price     = ""
        aisle     = ""
        available = ""
    }

    # Check if the value matches the filter value in any of the columns
    if ($_.'product' -eq $filterValue) {
        $output['product'] = $_.'product'  # Only populate 'product' if it matches the filter value
    }
    if ($_.'price' -eq $filterValue) {
        $output['price'] = $_.'price'  # Only populate 'price' if it matches the filter value
    }
    if ($_.'aisle' -eq $filterValue) {
        $output['aisle'] = $_.'aisle'  # Only populate 'aisle' if it matches the filter value
    }
    if ($_.'available' -eq $filterValue) {
        $output['available'] = $_.'available'  # Only populate 'available' if it matches the filter value
    }

    # Return the modified object (with only the filtered column populated)
    [PSCustomObject]$output
}

# Debugging: Output modified data after filtering
$modifiedData | Format-Table -AutoSize

# Export the filtered data to a new CSV file in the newly created folder
$newCsvFilePath = Join-Path -Path $newFolderPath -ChildPath "filtered_output.csv"
Write-Host "Exporting filtered data to CSV..."
$modifiedData | Export-Csv -Path $newCsvFilePath -NoTypeInformation

Write-Host "Filtered data has been written to $newCsvFilePath"

