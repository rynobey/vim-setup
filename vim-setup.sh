#!/bin/bash

download_plugins() {
  plugin_list_file=$1
  while read -r line
  do 
    cd ${HOME}/.vim/bundle
    IFS=";" tokens=($line)
    if [ ! -d "${tokens[0]}" ]; then
      eval "git clone ${tokens[1]}"
    else
      echo "${tokens[0]} already downloaded"
    fi
    cd ${HOME}/vim-setup
  done < $plugin_list_file
}

update_plugins() {
  plugin_list_file=$1
  while read -r line
  do 
    cd ${HOME}/.vim/bundle
    IFS=";" tokens=($line)
    if [ ! -d "${tokens[0]}" ]; then
      echo "${tokens[0]} can't be updated: It does not exist"
    else
      cd ${tokens[0]}
      eval "git pull origin master"
      cd ${HOME}/.vim/bundle
    fi
    cd ${HOME}/vim-setup
  done < $plugin_list_file
}

add_plugin() {
  plugin_list_file=$1
  plugin_folder_name=$2
  plugin_git_address=$3
  already_added=false
  while read -r line
  do 
    cd ${HOME}/.vim/bundle
    IFS=";" tokens=($line)
    if [ "${tokens[0]}" == "$plugin_folder_name" ]; then
      already_added=true
    fi
    cd ${HOME}/vim-setup
  done < $plugin_list_file
  if [ $already_added == true ]; then
    echo "$plugin_folder_name was already in the plugin list"
  else
    echo "$plugin_folder_name;$plugin_git_address" >> $plugin_list_file
    cd ${HOME}/.vim/bundle
    eval "git clone $plugin_git_address"
    cd ${HOME}/vim-setup
    echo "Added $plugin_folder_name to the plugin list"
  fi
}

remove_plugin() {
  plugin_list_file=$1
  plugin_folder_name=$2
  already_added=false
  temp_plugin_list_file="tmp.vim"
  while read -r line
  do 
    IFS=";" tokens=($line)
    if [ "${tokens[0]}" == "$plugin_folder_name" ]; then
      already_added=true
    fi
  done < $plugin_list_file
  if [ $already_added == true ]; then
    while read -r line
    do 
      IFS=";" tokens=($line)
      if [ "${tokens[0]}" != "$plugin_folder_name" ]; then
        echo "${tokens[0]};${tokens[1]}" >> $temp_plugin_list_file
      fi
    done < $plugin_list_file
    eval "mv $temp_plugin_list_file $plugin_list_file"
    eval "rm -rf ${HOME}/.vim/bundle/$plugin_folder_name"
    echo "Deleted $plugin_folder_name folder and removed it from the plugin list"
  else
    echo "$plugin_folder_name not found"
  fi
}

display_help() {
  printf "usage: vim-setup [--help]\n"
  printf "\t\t <command> [<args>]\n\n"
  printf "These commands are available:\n\n"
  printf "Initialize environment\n"
  printf "\tinit\t\tInstall pathogen and intialize the ~/.vim/bundle folder and plugins.vim file\n"
  printf "\tinstall\t\tDownloads all plugins listed in plugins.vim and replaces ~/.vimrc\n\n"
  printf "Manage plugins\n"
  printf "\tupdate\t\tPulls latest commits from all master branches of plugins\n"
  printf "\tadd <p1> <p2>\tAdds a plugin (p1 = git folder name) to the plugin list and clones its repo (p2 = git repo URL)\n"
  printf "\tremove <p1>\tRemoves a plugin (p1 = git folder name) from the plugin list and deletes its repo\n"
}

if [[ $1 == "init" ]]; then
  # install vim-pathogen
  string=`dpkg -l | grep vim-pathogen`
  if [[ $string == *"pathogen"* ]]; then
    echo "vim-pathogen already installed"
  else
    sudo apt-get install vim-pathogen
  fi
  # create .vim directory
  if [ ! -d "${HOME}/.vim" ]; then
    mkdir ${HOME}/.vim
  else
    echo "${HOME}/.vim directory already exists"
  fi
  # create bundle directory
  if [ ! -d "${HOME}/.vim/bundle" ]; then
    mkdir ${HOME}/.vim/bundle
  else
    echo "${HOME}/.vim/bundle directory already exists"
  fi
  # create plugins.vim if not yet existing
  if [ ! -f "plugins.vim" ]; then
    touch plugins.vim
    echo "No plugins.vim found: Empty plugins.vim created"
  else
    echo "Existing plugins.vim found"
  fi
elif [[ $1 == "install" ]]; then
  # download plugins
  download_plugins plugins.vim
  # rename existing .vimrc
  mv ${HOME}/.vimrc ${HOME}/.vimrc_old
  # copy .vimrc to home directory
  cp .vimrc ${HOME}/.
  echo "Copied .vimrc to home directory"
elif [[ $1 == "update" ]]; then
  update_plugins plugins.vim
elif [[ $1 == "add" ]]; then
  add_plugin plugins.vim $2 $3
elif [[ $1 == "remove" ]]; then
  remove_plugin plugins.vim $2
elif [[ $1 == "--help" ]]; then
  display_help
fi
