source ~/vimfiles/dwiw-loader.vim
Plugin 'flazz/vim-colorschemes'
colorscheme hybrid

Plugin 'Syntastic'
Plugin 'justinmk/vim-gtfo'
Plugin 'Persistent13/vim-ps1'

" enable powershell syntax plug
autocmd BufNewFile,BufReadPost *.ps1 set filetype=ps1

set number
set clipboard=unnamed
set backspace=indent,eol,start
nnoremap J :tabprevious<CR>
nnoremap K :tabnext<CR>
nnoremap <C-j> :join<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
nnoremap <F5> ":let @/ = @"<CR>
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4   
au FocusLost,TabLeave * call feedkeys("\<C-\>\<C-n>")

"Start Ctrl P in MRU mode
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd = 'CtrlPMRU'
