#!/bin/bash

# Run line before executing this script
# chmod +x GoProBatchConverts.sh

# This script exists to run updater.ps1 without hassle
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check for updater script location
if [ -f "${SCRIPT_DIR}/installer/updater.ps1" ]; then
    UPDATER_SCRIPT="${SCRIPT_DIR}/installer/updater.ps1"
else
    UPDATER_SCRIPT="${SCRIPT_DIR}/updater.ps1"
fi

# Check if pwsh (PowerShell Core) is installed
if command -v pwsh >/dev/null 2>&1; then
    # pwsh is available, use PowerShell Core
    pwsh -NoProfile -NoLogo -ExecutionPolicy Bypass -File "${UPDATER_SCRIPT}"
else
    # Check if standard powershell is available as fallback
    if command -v powershell >/dev/null 2>&1; then
        # Use standard PowerShell
        powershell -NoProfile -NoLogo -ExecutionPolicy Bypass -File "${UPDATER_SCRIPT}"
    else
        echo "Error: Neither PowerShell Core (pwsh) nor PowerShell is installed"
        exit 1
    fi
fi

# Clean up duplicate updater script if it exists
if [ -f "${SCRIPT_DIR}/installer/updater.ps1" ] && [ -f "${SCRIPT_DIR}/updater.ps1" ]; then
    rm "${SCRIPT_DIR}/updater.ps1"
fi

# Wait for 5 seconds
sleep 5