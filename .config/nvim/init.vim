" - xel's nvim config -

" General Settings
let mapleader=","                  " Change leader key to ,
set number relativenumber         " Show line numbers and relative numbers
set wrap linebreak nolist         " Wrap lines neatly
set ttyfast                       " Optimize for fast terminal connections
set expandtab
set tabstop=4
set shiftwidth=4

" Window Navigation
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-Up> :resize -5<CR>
nnoremap <C-Down> :resize +5<CR>
nnoremap <C-Left> :vertical resize -5<CR>
nnoremap <C-Right> :vertical resize +5<CR>

" Terminal 
nnoremap <C-t> :rightbelow split +terminal<CR>
tnoremap <C-q> <C-\><C-n>

" Use system clipboard
if has("unnamedplus")
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

" Plugin Management
call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'lervag/vimtex'
call plug#end()

" CoC Configuration
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"
" Manual and auto formatting with CoC
nmap <leader>ff :call CocAction('format')<CR>

" fzf Configuration
nnoremap <leader>fl :Lines<CR>
nnoremap <C-x> :vsplit<CR>:FZF<CR>
nnoremap <C-z> :split<CR>:FZF<CR>
