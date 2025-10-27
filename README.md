# Linux Dev Setup

Automates bootstrapping a fresh Linux workstation with a few everyday tools, an opinionated Vim config, and an Oh My Zsh shell setup (including autosuggestions and syntax highlighting).

- ✅ Supports Debian/Ubuntu (`apt-get`) and Fedora/RHEL (`dnf`)
- ✅ Installs common CLI tools: `vim`, `curl`, `nano`, `git`, `htop`, `zsh`
- ✅ Configures `~/.vimrc` with spaces and auto-indentation
- ✅ Installs Oh My Zsh, switches to the `flazz` theme, and enables useful plugins

## Quick Start

Run the installer from a fresh terminal session:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/gloffler/setup/main/setup.sh)"
```

> The script uses `sudo` to install packages; you’ll be prompted for your password.

## Requirements

- Linux distro with either `apt-get` or `dnf`
- Internet access (to download packages and Oh My Zsh)
- A user with `sudo` privileges

## What the Script Does

1. Detects the available package manager (`dnf` or `apt-get`) and installs the toolchain in `TOOLS`.
2. Appends a minimal Vim configuration (`set ts=2 ai expandtab`) to `~/.vimrc` if it isn’t already there.
3. Installs Oh My Zsh (if not present), switches the theme to `flazz`, and adds the `zsh-autosuggestions` and `zsh-syntax-highlighting` plugins.

Already-configured environments are left untouched where possible—the script skips steps if it detects they’re done.

## Customizing

- Update the `TOOLS` variable inside `setup.sh` to install additional packages.
- Modify `VIM_CONFIG` if you prefer a different default Vim style.
- Adjust the Oh My Zsh plugins by editing your `~/.zshrc` after the run.

To test changes locally, clone the repo and execute:

```bash
./setup.sh
```

> If you run it locally, review the script first to ensure it matches your environment’s needs.

## Troubleshooting

- **Package manager not found:** The script exits if neither `dnf` nor `apt-get` exists. Install one of them or update the script for your package manager.
- **Oh My Zsh already installed:** You’ll see a message and the installation will be skipped; existing themes/plugins are left intact.
- **`sed -i` errors on macOS:** This script targets Linux distributions. For macOS, consider adapting the `sed -i` flags or using Homebrew.
