#!/bin/bash

OS=$(uname -s)

if [[ $OS == "Darwin" ]]; then
    printf "Setting up nvim directory at ~/.config/nvim"
    mkdir -p ~/.config/nvim

    printf "Copying over the neovim_config files/folders from github using git clone"
    git clone --depth 1 git@github.com:hectorleiva/neovim_config.git ~/.config/nvim

    if command -v brew &> /dev/null; then
        printf "Installing neovim using brew"
        brew install neovim

        read -p "Install nginx-language-server via pip? (y/n) " installNginxLanguageServerAnswer
        if [[ $installNginxLanguageServerAnswer == "y" || $installNginxLanguageServerAnswer == "Y" ]]; then
            if command -v pip &> /dev/null; then
                pip install -U nginx-language-server
            else
                printf "You can install nginx-language-server using pip by following the instructions in the README.md"
            fi
        fi

    else
        printf "homebrew needs to be installed prior to installing all the neovim dependencies. Please review the README.md for more information."
    fi

    printf "Open neovim using 'neovim' and run ':Lazy' and install all the packages defined in ~/.config/nvim"
    printf "I recommend to add 'alias vim=neovim' in your '~/.bashrc' or '~/.zshrc' file"
elif [[ $OS == "Linux" ]]; then
    cd /tmp

    printf "Downloading the latest release from https://github.com/neovim/neovim/releases/latest/download/nvim.appimage into /tmp"

    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage

    printf "Changing permissions on nvim.appimage"
    chmod u+x nvim.appimage
    ./nvim.appimage

    printf "Creating the /opt/nvim directory and moving nvim.appimage into it"
    mkdir -p /opt/nvim
    mv nvim.appimage /opt/nvim/nvim

    read -p "Install ripgrep for telescope live_grep to work? (y/n) " installRipGrepAnswer
    if [[ $installRipGrepAnswer == "y" || $installRipGrepAnswer == "Y" ]]; then
        sudo apt install ripgrep
    fi

    read -p "Install lazygit? (y/n) " installLazyGitAnswer
    if [[ $installLazyGitAnswer == "y" || $installLazyGitAnswer == "Y" ]]; then
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

        printf "Installing lazygit at version: $LAZYGIT_VERSION"

        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf lazygit.tar.gz lazygit
        sudo install lazygit /usr/local/bin
    fi

    read -p "Install xclip? (y/n) " installXClipAnswer
    if [[ $installXClipAnswer == "y" || $installXClipAnswer == "Y" ]]; then
        printf "Installing xclip for clipboard support inside neovim"
        sudo apt install xclip
    fi

    printf "
        Insert the following into your ~/.bashrc or ~/.zshrc file if you have not done so already

        export PATH=\"\$PATH:/opt/nvim/\"
    "
else
    printf "Your OS does not support this installation method at this time."
fi

