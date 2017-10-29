all:
	[ -f ~/.vimrc ] || ln -s $(PWD)/.vimrc ~/.vimrc
	[ -f ~/.Brewfile ] || ln -s $(PWD)/Brewfile ~/Brewfile
	[ -f ~/.zshrc ] || ln -s $(PWD)/.zshrc ~/.zshrc
	[ -f ~/.gitconfig ] || ln -s $(PWD)/.gitconfig ~/.gitconfig
	[ -f ~/.global_gitignore ] || ln -s $(PWD)/.global_gitignore ~/.global_gitignore

clean:
	[ -f ~/.vimrc ] || rm ~/.vimrc 

.PHONY: all
