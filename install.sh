#!/bin/bash
# if ubuntu, 先写ubuntu的

function install_for_ubuntu(){
	# install git ,tmux, zsh, vim,htop,nload
	apt-get update && apt-get install git, tmux, zsh, vim, htop, nload，wget
	if [ $? -eq 0 ];then
		# install oh-my-zsh, repalce my favorate Themes
		sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
		sed -i '' 's/robbyrussell/agnoster/g' ~/.zshrc
		# 
		cp .tmux.conf ~/.tmux.conf
		cp basic.vim ~/.vimrc
		tmux source ~/.tmux.conf
	fi
}