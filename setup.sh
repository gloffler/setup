#!/bin/bash

# Variables
DNF_CMD=$(type dnf 2> /dev/null)
APT_CMD=$(type apt-get 2> /dev/null)
TOOLS="neovim curl nano git htop zsh"
ZSH_RC=$HOME/.zshrc

# Install tools
if [[ ! -z $DNF_CMD ]]; then
  sudo dnf update --refresh
  echo "Installing tools..."
  # epel-release is needed for additional tools like htop
  sudo dnf install -y epel-release
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
  exit 1
fi

# Install zinit
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

BLOCK='ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"'

if ! grep -Fq 'zinit.git' "$ZSH_RC"; then
  echo "$BLOCK" >> "$ZSH_RC"
  echo "Zinit added to $ZSH_RC"
else
  echo "Zinit already exists in $ZSH_RC"
fi

# Install oh my posh
curl -s https://ohmyposh.dev/install.sh | bash -s
