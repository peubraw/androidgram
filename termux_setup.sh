#!/bin/bash

# Update packages
echo "Updating packages..."
pkg update && pkg upgrade -y

# Install dependencies
echo "Installing dependencies..."
pkg install python git clang libxml2 libxslt libjpeg-turbo zlib freetype android-tools -y

# Create virtual environment
echo "Creating virtual environment..."
python -m venv .venv
source .venv/bin/activate

# Install requirements
echo "Installing requirements..."
pip install --upgrade pip
pip install setuptools wheel
pip install -r requirements.txt

echo "################################################"
echo "Setup Complete!"
echo "1. Create your account configuration:"
echo "   cp -r config-examples accounts/YOUR_USERNAME"
echo "2. Edit the config.yml in that folder."
echo "3. Run the bot:"
echo "   source .venv/bin/activate"
echo "   python run.py --config accounts/YOUR_USERNAME/config.yml"
echo "################################################"
