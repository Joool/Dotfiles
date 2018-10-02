all:
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	[ -f ~/.ctags ] || ln -s $(PWD)/ctags ~/.ctags
	[ -f ~/.Brewfile ] || ln -s $(PWD)/Brewfile ~/Brewfile
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	[ -f ~/.global_gitignore ] || ln -s $(PWD)/global_gitignore ~/.global_gitignore

clean:
	[ -f ~/.vimrc ] || rm ~/.vimrc 
	[ -f ~/.ctags ] || rm ~/.ctags 
	[ -f ~/.Brewfile ] || rm ~/Brewfile
	[ -f ~/.zshrc ] || rm ~/.zshrc 
	[ -f ~/.gitconfig ] || rm ~/.gitconfig 
	[ -f ~/.global_gitignore ] || rm ~/.global_gitignore 

.PHONY: all
