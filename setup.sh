#!/bin/bash

# Variables
DNF_CMD=$(type dnf 2> /dev/null)
APT_CMD=$(type apt 2> /dev/null)

TOOLS="vim nano git fish"
VIM_CONFIG="set ts=2 ai expandtab"
VIM_RC=$HOME/.vimrc

# Install Tools
echo "Updating system..."

if [[ ! -z $DNF_CMD ]]; then    
  sudo dnf -y update
  INSTALL_COMPLETE=$(sudo dnf install $TOOLS)
elif [[ ! -z $APT_CMD ]]; then
  sudo apt update
  INSTALL_COMPLETE=$(sudo apt install $TOOLS)
else
  echo "Error: No package manager found!"
  exit 1;
fi

if [[ ! -z $INSTALL_COMPLETE ]]; then
  if grep -wq "$VIM_CONFIG" $VIM_RC; then
    echo "VIM already configured!"
  else
    echo "Configuring VIM..."
    echo $VIM_CONFIG >> $VIM_RC
  fi

  if [[ $SHELL == "/usr/bin/fish" ]]; then
    echo "Fish already configured!"
  else
    echo "Changing shell to fish..."
    chsh -s /usr/bin/fish
    sudo chsh -s /usr/bin/fish
  fi
else
  echo "Error: Installation failed!"
  exit 1;
fi
