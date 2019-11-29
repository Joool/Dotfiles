#!/bin/bash
exists() 
{
    eval command -v $1 1>/dev/null 2>&1
}

create_symlink_if_not_exist() {
    if [[ ! -f $1 ]]; then
        ln -s $2 $1
    fi
}

delete_symlink_if_exist() {
    if [[ -f $1 ]]; then
        rm $1
    fi
}

setup_symlinks()
{

    create_symlink_if_not_exist ~/.vimrc $(pwd)/vimrc
    create_symlink_if_not_exist ~/.zshrc $(pwd)/zshrc
    create_symlink_if_not_exist ~/.gitconfig $(pwd)/gitconfig
    create_symlink_if_not_exist ~/.global_gitignore $(pwd)/global_gitignore
}

clean_symlinks()
{
    delete_symlink_if_exist ~/.vimrc 
    delete_symlink_if_exist ~/.zshrc
    delete_symlink_if_exist ~/.gitconfig 
    delete_symlink_if_exist ~/.global_gitignore 
}

setup_linx() 
{
    apt update && apt install zsh -y
    if ! exists nvm; then
        curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
        chmod u+x nvim.appimage
        ./nvim.appimage
        rm ./nvim.appimage
    fi
}

setup_maxos()
{
    if ! exists brew; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    if ! exists nvim; then
        brew install neovim
    fi

    if ! exists zsh; then
		brew install zsh
    fi
}

create_directory() 
{
    if [[ ! -d $1 ]]; then
        mkdir -p $1 
    fi
}

install() {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        setup_linx
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        setup_maxos
    fi

    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    NVIM_CONFIG_PATH="$HOME/.config/nvim/"
    create_directory $NVIM_CONFIG_PATH

    if [[ ! -f "$NVIM_CONFIG_PATH/init.vim" ]]; then
        touch "$NVIM_CONFIG_PATH/init.vim"
        echo "source ~/.vimrc" >> "$NVIM_CONFIG_PATH/init.vim"
    fi


    setup_symlinks
}

if [[ $1 == "" ]]; then
    echo "No argument provided!"
    exit
fi

if [[ $1 == "install" ]]; then
    install
elif [[ $1 == "clean" ]]; then
    clean_symlinks
else 
    echo "Command not recognized!"
fi

