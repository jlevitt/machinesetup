set number
set clipboard=unnamed
set backspace=indent,eol,start
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
nnoremap <C-j> :tabprevious<CR>
nnoremap <C-k> :tabnext<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
