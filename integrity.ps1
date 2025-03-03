$folderPath = "C:\Users\pande\Desktop\TestFile\Files"
$hashFile = "$folderPath\hashedfile.txt"

# Function to get file hash
function Get-FileHashValue {
    param ([string]$filePath)
    return (Get-FileHash -Path $filePath -Algorithm SHA256).Hash
}

# Function to hash all files and save to hashedfile.txt
function Save-Hashes {
    if (Test-Path $hashFile) {
        Remove-Item $hashFile -Force
    }
    Get-ChildItem -Path $folderPath -File | ForEach-Object {
        "$($_.Name): $(Get-FileHashValue $_.FullName)" | Out-File -Append -FilePath $hashFile
    }
    Write-Host "Hashes saved to $hashFile"
}

# Function to monitor file integrity
function Monitor-Files {
    $originalHashes = @{}
    if (Test-Path $hashFile) {
        Get-Content $hashFile | ForEach-Object {
            $parts = $_ -split ": "
            if ($parts.Length -eq 2) {
                $originalHashes[$parts[0]] = $parts[1]
            }
        }
    }
    
    Write-Host "Monitoring file integrity... Press Ctrl+C to stop."
    while ($true) {
        $currentHashes = @{}
        Get-ChildItem -Path $folderPath -File | ForEach-Object {
            $currentHash = Get-FileHashValue $_.FullName
            $currentHashes[$_.Name] = $currentHash
            
            if ($originalHashes.ContainsKey($_.Name)) {
                if ($originalHashes[$_.Name] -ne $currentHash) {
                    Write-Host "ALERT: File $($_.Name) has been modified!" -ForegroundColor Red
                }
            } else {
                Write-Host "ALERT: New file detected - $($_.Name)!" -ForegroundColor Yellow
            }
        }
        
        # Check for deleted files
        foreach ($fileName in $originalHashes.Keys) {
            if (-not $currentHashes.ContainsKey($fileName)) {
                Write-Host "ALERT: File $fileName has been deleted!" -ForegroundColor Magenta
            }
        }
        
        Start-Sleep -Seconds 5
    }
}

# User choice menu
Write-Host "What would you like to do?" -ForegroundColor Cyan
Write-Host "[A] Start monitoring files" -ForegroundColor Green
Write-Host "[B] Generate hashes for the files" -ForegroundColor Yellow
$choice = Read-Host "Enter your choice (A/B)"

if ($choice -eq "A") {
    Monitor-Files
} elseif ($choice -eq "B") {
    Save-Hashes
} else {
    Write-Host "Invalid selection. Please restart the program and choose A or B." -ForegroundColor Red
}