$env:GOOGLE_API_KEY = "AIzaSyBzRh0RJk2PfXFByISi80NxS2CMGIgnGtM"
$env:GEMINI_API_KEY = "AIzaSyBzRh0RJk2PfXFByISi80NxS2CMGIgnGtM"
$env:NODE_TLS_REJECT_UNAUTHORIZED = "0"

# สร้าง config directory ถ้ายังไม่มี
$configDir = "$env:USERPROFILE\.openclaw"
if (-not (Test-Path $configDir)) {
    New-Item -ItemType Directory -Path $configDir | Out-Null
}

# เขียน openclaw.json
$config = @{
    gateway = @{
        auth = @{ mode = "token"; token = "398157b165c9ef2b33ec01922c560bca113a8b46f1834713" }
        mode = "local"
    }
    agents = @{
        defaults = @{
            model = @{ primary = "google/gemini-3-flash-preview" }
        }
    }
    plugins = @{
        entries = @{ google = @{ enabled = $true } }
    }
    meta = @{ lastTouchedVersion = "2026.4.5" }
}

$config | ConvertTo-Json -Depth 10 | Set-Content "$configDir\openclaw.json" -Encoding UTF8
Write-Host "[openclaw] Config OK: $configDir\openclaw.json" -ForegroundColor Green

# Start gateway
Write-Host "[openclaw] Starting gateway on port 18789 (Google Gemini)..." -ForegroundColor Cyan
Write-Host "[openclaw] Press Ctrl+C to stop" -ForegroundColor Yellow
Write-Host ""

Set-Location $PSScriptRoot
& "C:\Program Files\nodejs\node.exe" openclaw.mjs gateway --port 18789
