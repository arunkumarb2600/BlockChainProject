# SCM Project Startup Script
Write-Host "Starting SCM Blockchain Project..." -ForegroundColor Green

# Set Node.js legacy OpenSSL provider for compatibility
$env:NODE_OPTIONS = "--openssl-legacy-provider"

# Start Ganache in background
Write-Host "Starting Ganache..." -ForegroundColor Yellow
Start-Process powershell -ArgumentList "-Command", "ganache-cli -p 8545 -h 127.0.0.1 -l 10000000 -g 20000000000" -WindowStyle Normal

# Wait for Ganache to start
Start-Sleep -Seconds 5

# Deploy contracts
Write-Host "Deploying contracts..." -ForegroundColor Yellow
truffle migrate --reset --network ganache

# Start React app
Write-Host "Starting React frontend..." -ForegroundColor Yellow
Set-Location client
Start-Process powershell -ArgumentList "-Command", "`$env:NODE_OPTIONS='--openssl-legacy-provider'; npm start" -WindowStyle Normal

Write-Host "Setup complete!" -ForegroundColor Green
Write-Host "- Ganache: http://127.0.0.1:8545" -ForegroundColor Cyan
Write-Host "- React App: http://localhost:3000" -ForegroundColor Cyan