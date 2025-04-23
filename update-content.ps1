# Create backup folder if it doesn't exist
$backupDir = "./backups"
$htmlFile = "./html/index.html"

if (-Not (Test-Path $backupDir)) {
    New-Item -ItemType Directory -Path $backupDir | Out-Null
}

# Generate timestamp
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$backupFile = "$backupDir/index_$timestamp.html"

# Backup current HTML
Copy-Item $htmlFile $backupFile
Write-Output "Backup created at $backupFile"

# Update HTML content
@"
<!DOCTYPE html>
<html>
<head>
  <title>Updated Page</title>
</head>
<body>
  <h1>hlo  </h1>
  <p>This is a live update via Docker volume (from PowerShell).</p>
</body>
</html>
"@ | Set-Content $htmlFile -Encoding UTF8

Write-Output "Content updated successfully."
