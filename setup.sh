#!/bin/bash

# Variables
DNF_CMD=$(type dnf 2> /dev/null)
APT_CMD=$(type apt-get 2> /dev/null)
TOOLS="vim nano git htop zsh"
VIM_CONFIG="set ts=2 ai expandtab"
VIM_RC=$HOME/.vimrc

if [[ ! -z $DNF_CMD ]]; then
  echo "Installing tools..."
  sudo dnf install $TOOLS
  INSTALL_COMPLETE=$?
elif [[ ! -z $APT_CMD ]]; then
  echo "Updating repositories..."
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
    echo -n "Configuring VIM... "
    echo $VIM_CONFIG >> $VIM_RC
    if [[ $? -eq 0 ]]; then
      echo "Done."
    else
      echo "Failed."
    fi
  fi

  if [[ $SHELL == "/usr/bin/zsh" ]]; then
    echo "ZSH already set to default Shell!"
  else
    echo "Changing shell to ZSH... "
    chsh -s /usr/bin/zsh
    sudo chsh -s /usr/bin/zsh
  fi
else
  echo "Error: Installation failed!"
  exit 1;
fi
