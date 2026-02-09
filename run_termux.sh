#!/bin/bash
# Script to run GramAddict on Termux
cd "$(dirname "$0")"

# Activate virtual environment
source .venv/bin/activate

# Try to connect to local ADB (if not already connected)
# This assumes the device has ADB enabled on port 5555
echo "Attempting to connect to local ADB..."
adb connect 127.0.0.1:5555

# Run the bot with arguments passed to this script
# Example usage: ./run_termux.sh accounts/myuser/config.yml
echo "Starting GramAddict..."
python run.py --config "$@"
