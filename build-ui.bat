@echo off
:: OpenClaw - Build Control UI (Windows)
:: Double-click to run

cd /d "%~dp0"

echo [openclaw] Installing UI dependencies...
cd ui
pnpm install
if errorlevel 1 (
    echo [ERROR] pnpm install failed
    pause
    exit /b 1
)

echo [openclaw] Building Control UI...
cd ..
pnpm ui:build
if errorlevel 1 (
    echo [ERROR] UI build failed
    pause
    exit /b 1
)

echo.
echo [openclaw] UI build complete!
echo [openclaw] Start gateway then open: http://localhost:18789
pause
