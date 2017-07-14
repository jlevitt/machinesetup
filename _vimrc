set nocompatible              " be iMproved, required
filetype off                  " required

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'flazz/vim-colorschemes'
Plugin 'txt.vim'
"Plugin 'Syntastic'
"Plugin 'justinmk/vim-gtfo'
Plugin 'scrooloose/nerdtree'
"Plugin 'b4winckler/vim-angry'
"Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'jnurmine/Zenburn'
"Plugin 'vim-scripts/indentpython.vim'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'nvie/vim-flake8'
"Plugin 'tpope/vim-commentary'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Aliases/Helpers
:command! Reload so %

" Keymaps
nnoremap J :tabprevious<CR>
nnoremap K :tabnext<CR>
nnoremap <C-j> :join<CR>
nnoremap <C-f> :let @/ = @"<CR>|  " Find yanked text
set pastetoggle=<F2>

" Vim Settings
set clipboard=unnamed
set number
set guifont=Consolas:h11:cANSI| " Fix molokai italics/gui only
colorscheme molokai

" Spacing and tabbing
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=100
set nowrap
   
" Filetypes
autocmd BufRead,BufNewFile * setfiletype txt

" NerdTree Settings
autocmd VimEnter * nmap <F3> :NERDTreeToggle<CR>
autocmd VimEnter * imap <F3> <Esc>:NERDTreeToggle<CR>a
let NERDTreeQuitOnOpen=1
let NERDTreeWinSize=50

" Autocmd utilities
autocmd BufEnter * silent! lcd %:p:h|                           " cd to opened file location
autocmd FocusLost,TabLeave * call feedkeys("\<C-\>\<C-n>")|     " Normal mode on focus lost
"
"Start Ctrl P in MRU mode
"let g:ctrlp_map='<c-p>'
"let g:ctrlp_cmd = 'CtrlPMRU'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python settings https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/ "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix encoding=utf-8
"let g:ycm_autoclose_preview_window_after_completion=1
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"    project_base_dir = os.environ['VIRTUAL_ENV']
"    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"    execfile(activate_this, dict(__file__=activate_this))
"EOF

"let python_highlight_all=1
"syntax on
