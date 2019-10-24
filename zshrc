. $(brew --prefix)/etc/profile.d/z.sh
alias j='z'

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

fpath+=~/.zfunc
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="crunch"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git docker docker-compose)

source $ZSH/oh-my-zsh.sh

# alias
alias p="cd ~/projects"
alias la="ls -la"
alias bubu="brew update && brew upgrade"
alias cp="rsync -ahP --inplace"

# edit common stuff
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"
alias resource="source ~/.zshrc"
alias scratch='vim $(echo $TMPDIR)/scratch'

# git slow fix
__git_files () { 
    _wanted files expl 'local files' _files     
}

# set neovim as standard
alias vim='nvim'
alias vi='nvim'

# set Editor
export EDITOR='nvim'

# Go
export GOPATH="$HOME/projects/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOBIN"

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

eval "$(pyenv virtualenv-init -)"
source "$(pyenv root)/completions/pyenv.zsh"

# Rust
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
export RUSTC_WRAPPER=sccache
export PATH="$PATH:~/.cargo/bin/racer" # explicitly add racer to the path

# fzf 
export FZF_DEFAULT_OPTS='--height 40% --border'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

