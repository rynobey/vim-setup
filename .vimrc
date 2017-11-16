" Pathogen
execute pathogen#infect()

" Colors
syntax enable " enable syntax highlighting
filetype on " recognize filetypes

" Spaces and tabs
set tabstop=2 " number of visual spaces for TAB
set softtabstop=2 " number of spaces for TAB when editing
set shiftwidth=2 " indentation shift width (when using '>' or '<')
set expandtab " replace tabs with spaces

" UI
set number " show absolute line numbers
set relativenumber " show relative line numbers (combined with absolute gives hybrid)
set showmatch " highlight matching braces
set so=999 " keep cursor centered by setting a large scroll offset
