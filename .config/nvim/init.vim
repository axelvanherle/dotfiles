" - xel's nvim config -

" General Settings
let mapleader=","                  " Change leader key to ,
set number relativenumber         " Show line numbers and relative numbers
set wrap linebreak nolist         " Wrap lines neatly
set ttyfast                       " Optimize for fast terminal connections

" Use system clipboard
if has("unnamedplus")
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

" Plugin Management
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()

" Window Navigation
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" NERDTree Configuration
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1      " Auto-close NERDTree when a file is opened

" CoC Configuration
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
" Manual and auto formatting with CoC
nmap <leader>ff :call CocAction('format')<CR>
