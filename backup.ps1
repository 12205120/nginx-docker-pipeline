# Define the backup directory and the HTML file
$backupDir = "./backups"
$htmlFile = "./html/index.html"

# Create the backup directory if it doesn't exist
if (-Not (Test-Path $backupDir)) {
    New-Item -ItemType Directory -Path $backupDir | Out-Null
}

# Generate a timestamp for the backup filename
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$backupFile = "$backupDir/index_$timestamp.html"

# Copy the current HTML file to the backup folder with timestamped name
Copy-Item $htmlFile $backupFile

Write-Output "Backup created at $backupFile"
