:set number relativenumber
:set wrap linebreak nolist
:set ttyfast

" Use system clipboard
if has("unnamedplus")
	set clipboard=unnamedplus
else
	set clipboard=unnamed
endif

"Navigate windows using Vim binds
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" Plugins
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}	

call plug#end()

" NERDTree Config
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

" Auto-close NERDTree when a file is opened
let g:NERDTreeQuitOnOpen = 1

" CoC Config
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
