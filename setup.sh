#!/bin/bash

# Variables
DNF_CMD=$(type dnf 2> /dev/null)
APT_CMD=$(type apt-get 2> /dev/null)
TOOLS="vim nano git fish"
VIM_CONFIG="set ts=2 ai expandtab"
VIM_RC=$HOME/.vimrc

if [[ ! -z $DNF_CMD ]]; then
  echo "Updating system..."
  sudo dnf -y update
  echo "Installing tools..."
  sudo dnf install $TOOLS
  INSTALL_COMPLETE=$?
elif [[ ! -z $APT_CMD ]]; then
  echo "Updating system..."
  sudo apt-get update
  echo "Installing tools..."
  sudo apt-get install $TOOLS
  INSTALL_COMPLETE=$?
else
  echo "Error: No package manager found!"
  exit 1;
fi

if [[ $INSTALL_COMPLETE -eq 0 ]]; then
  if grep -wq "$VIM_CONFIG" $VIM_RC 2> /dev/null; then
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
