let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

" List your plugins here
Plug 'preservim/nerdtree'
Plug 'tomlion/vim-solidity'
Plug 'https://github.com/ervandew/supertab.git'

call plug#end()

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
set so=15 " keep cursor centered by setting a large scroll offset
set ruler

" File explorer
autocmd VimEnter * NERDTree

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

let g:NERDTreeWinSize=50
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
map <C-W>f :NERDTreeToggle<CR>

set foldmethod=marker foldmarker={,}
set foldlevel=99

colorscheme evening
hi NonText ctermbg=NONE
hi Normal guibg=NONE ctermbg=NONE

set splitright
