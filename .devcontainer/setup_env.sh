#!/bin/bash

set -e # Stop script execution on any error
set -o pipefail # Catch errors in pipelines

VENV_PATH="/workspaces/hugo-site/venv"

echo "Setting up the Python development environment..."

# Create virtual environment if it doesn't exist
if [ ! -d "$VENV_PATH" ]; then
    python -m venv $VENV_PATH
else
    echo "Virtual environment already exists."
fi

# Activate virtual environment and install dependencies
source $VENV_PATH/bin/activate
sudo apt-get update && sudo apt-get upgrade -y
pip install --upgrade pip 
pip install pip-tools
# Install Homebrew
yes '' | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/vscode/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
sudo apt-get install build-essential nodejs npm -y
brew install gcc
brew install sass/sass/sass
brew install hugo