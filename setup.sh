#!/bin/bash

# Variables
DNF_CMD=$(type dnf 2> /dev/null)
APT_CMD=$(type apt-get 2> /dev/null)
TOOLS="vim curl nano git htop zsh"
VIM_CONFIG="set ts=2 ai expandtab"
VIM_RC=$HOME/.vimrc

# Install tools
if [[ ! -z $DNF_CMD ]]; then
  echo "Installing tools..."
  dnf install -y $TOOLS
  INSTALL_COMPLETE=$?
elif [[ ! -z $APT_CMD ]]; then
  echo "Updating repositories..."
  apt-get update
  echo "Installing tools..."
  apt-get install -y $TOOLS
  INSTALL_COMPLETE=$?
else
  echo "Error: No package manager found!"
  exit 1
fi

# VIM configuration
if [[ $INSTALL_COMPLETE -eq 0 ]]; then
  if grep -wq "$VIM_CONFIG" "$VIM_RC" 2> /dev/null; then
    echo "VIM already configured!"
  else
    echo -n "Configuring VIM... "
    echo "$VIM_CONFIG" >> "$VIM_RC"
    if [[ $? -eq 0 ]]; then
      echo "Done."
    else
      echo "Failed."
    fi
  fi

  # Check if Oh My Zsh is already installed (default directory: ~/.oh-my-zsh)
  if [ -d "$HOME/.oh-my-zsh" ]; then
      echo "Oh My Zsh is already installed."
  else
    echo "Oh My Zsh is not installed. Starting installation..."
    RUNZSH=yes KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
fi

