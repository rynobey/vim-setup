# vim-setup
Simple vim environment setup and plugin management

# Getting Started
Do the following:
```
  cd ~
  git clone https://github.com/rynobey/vim-setup.git
  cd vim-setup
  chmod +x vim-setup.sh
```
```
  ./vim-setup.sh init
```
```
  ./vim-setup.sh install
```
# Instructions
Running ```./vim-setup.sh --help``` gives you the following:
```
  usage: vim-setup [--help]
                   <command> [<args>]

  These commands are available:
  
  Initialize environment
	  init          Install pathogen and intialize the ~/.vim/bundle folder and plugins.vim file
	  install       Downloads all plugins listed in plugins.vim and replaces ~/.vimrc

  Manage plugins
	  update        Pulls latest commits from all master branches of plugins
	  add <p1> <p2>	Adds a plugin (p1 = git folder name) to the plugin list and clones its repo (p2 = git repo URL)
	  remove <p1>   Removes a plugin (p1 = git folder name) from the plugin list and deletes its repo
```
