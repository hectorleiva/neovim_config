#!/bin/bash

set -e

# ── helpers ───────────────────────────────────────────────────────────────────

command_exists() { command -v "$1" &> /dev/null; }

ask_yes_no() {
    local answer
    read -rp "$1 (y/n) " answer
    [[ "$answer" == "y" || "$answer" == "Y" ]]
}

info() { printf '\n[INFO] %s\n' "$*"; }
warn() { printf '\n[WARN] %s\n' "$*"; }
die()  { printf '\n[ERROR] %s\n' "$*" >&2; exit 1; }

# ── prerequisites ─────────────────────────────────────────────────────────────

check_prerequisites() {
    command_exists git  || die "git is required but not installed."
    command_exists curl || die "curl is required but not installed."
}

# ── config clone ──────────────────────────────────────────────────────────────

clone_nvim_config() {
    local dest="$HOME/.config/nvim"

    if [[ -d "$dest/.nvim_installed" ]]; then
        info "Neovim config already present at $dest — skipping clone."
        return
    fi

    if [[ -d "$dest" && -n "$(ls -A "$dest" 2>/dev/null)" ]]; then
        warn "$dest exists and is non-empty. Skipping clone to avoid overwriting."
        return
    fi

    info "Cloning neovim config into $dest"
    mkdir -p "$HOME/.config"
    git clone --depth 1 git@github.com:hectorleiva/neovim_config.git "$dest"
}

# ── macOS ─────────────────────────────────────────────────────────────────────

install_on_macos() {
    command_exists brew || die "Homebrew must be installed first. See https://brew.sh"

    if command_exists nvim; then
        info "neovim is already installed ($(nvim --version | head -1)) — skipping."
    else
        info "Installing neovim via brew"
        brew install neovim
    fi

    if ask_yes_no "Install nginx-language-server via pip?"; then
        if command_exists nginx-language-server; then
            info "nginx-language-server is already installed — skipping."
        elif command_exists pip3; then
            pip3 install -U nginx-language-server
        elif command_exists pip; then
            pip install -U nginx-language-server
        else
            warn "pip not found. Install nginx-language-server manually after installing Python/pip."
        fi
    fi

    info "Open neovim with 'nvim' and run ':Lazy' to install plugins."
    info "Consider adding:  alias vim=nvim  to your ~/.zshrc or ~/.bashrc"

    touch .nvim_installed
}

# ── Linux ─────────────────────────────────────────────────────────────────────

detect_pkg_manager() {
    if command_exists apt-get; then echo apt
    elif command_exists dnf;   then echo dnf
    elif command_exists yum;   then echo yum
    elif command_exists pacman; then echo pacman
    elif command_exists zypper; then echo zypper
    else echo ""
    fi
}

pkg_install() {
    local pkg="$1"
    case "$(detect_pkg_manager)" in
        apt)    sudo apt-get install -y "$pkg" ;;
        dnf)    sudo dnf install -y "$pkg" ;;
        yum)    sudo yum install -y "$pkg" ;;
        pacman) sudo pacman -S --noconfirm "$pkg" ;;
        zypper) sudo zypper install -y "$pkg" ;;
        *)      die "No supported package manager found. Install '$pkg' manually." ;;
    esac
}

detect_arch() {
    case "$(uname -m)" in
        x86_64)        echo "x86_64" ;;
        aarch64|arm64) echo "arm64" ;;
        *)             die "Unsupported architecture: $(uname -m)" ;;
    esac
}

install_nvim_linux() {
    if command_exists nvim; then
        info "neovim is already installed ($(nvim --version | head -1)) — skipping."
        return
    fi

    local arch
    arch=$(detect_arch)
    local appimage="nvim-linux-${arch}.appimage"
    local tmp
    tmp=$(mktemp -d)

    info "Downloading neovim AppImage ($arch) into $tmp"
    curl -L --progress-bar \
        "https://github.com/neovim/neovim/releases/latest/download/${appimage}" \
        -o "$tmp/nvim.appimage"
    chmod u+x "$tmp/nvim.appimage"

    info "Installing neovim to /opt/nvim/nvim"
    sudo mkdir -p /opt/nvim
    sudo mv "$tmp/nvim.appimage" /opt/nvim/nvim
    rm -rf "$tmp"

    info "Add the following to your ~/.bashrc or ~/.zshrc if not already present:"
    printf '\n    export PATH="$PATH:/opt/nvim/"\n\n'
}

install_lazygit_linux() {
    if command_exists lazygit; then
        info "lazygit is already installed — skipping."
        return
    fi

    local arch
    arch=$(detect_arch)
    local version
    version=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
        | grep -Po '"tag_name": "v\K[^"]*')
    [[ -n "$version" ]] || die "Could not determine the latest lazygit version."

    info "Installing lazygit v${version} (${arch})"
    local tmp
    tmp=$(mktemp -d)
    curl -L --progress-bar \
        "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${version}_Linux_${arch}.tar.gz" \
        -o "$tmp/lazygit.tar.gz"
    tar -C "$tmp" -xf "$tmp/lazygit.tar.gz" lazygit
    sudo install "$tmp/lazygit" /usr/local/bin/lazygit
    rm -rf "$tmp"
}

install_on_linux() {
    install_nvim_linux

    if ask_yes_no "Install ripgrep (needed for Telescope live_grep)?"; then
        if command_exists rg; then
            info "ripgrep is already installed — skipping."
        else
            pkg_install ripgrep
        fi
    fi

    if ask_yes_no "Install lazygit?"; then
        install_lazygit_linux
    fi

    if ask_yes_no "Install xclip (clipboard support in neovim)?"; then
        if command_exists xclip; then
            info "xclip is already installed — skipping."
        else
            pkg_install xclip
        fi
    fi

    info "Open neovim with 'nvim' and run ':Lazy' to install plugins."
    touch .nvim_installed
}

# ── main ──────────────────────────────────────────────────────────────────────

main() {
    check_prerequisites
    clone_nvim_config

    case "$(uname -s)" in
        Darwin) install_on_macos ;;
        Linux)  install_on_linux ;;
        *)      die "Unsupported OS: $(uname -s)" ;;
    esac
}

main "$@"
