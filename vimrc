" Indentation & Tabs
set noautoindent
set nosmartindent
set noexpandtab
set tabstop=8
set shiftwidth=8

" General
set encoding=utf8
set nocompatible
set number
set relativenumber
set ignorecase
set smartcase
set hlsearch
set incsearch
set tabstop=4 shiftwidth=4 softtabstop=4
set expandtab
set autoindent
set smartindent
syntax on
set termguicolors
set so=30

" Sudo write
cmap w!! w !sudo tee > /dev/null %

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
Plug 'yegappan/lsp'
Plug 'joshdick/onedark.vim'
call plug#end()

" Theme
set background=dark
colorscheme onedark

" LSP Setup
let lspOpts = {'autoHighlightDiag': 1}
autocmd User LspSetup call LspOptionsSet(lspOpts)

let lspServers = [
      \ {'name': 'clang',
      \  'filetype': ['c', 'cpp'],
      \  'path': '/usr/bin/clangd',
      \  'args': ['--background-index']}
      \ ]
autocmd User LspSetup call LspAddServer(lspServers)

" LSP Keymaps
nnoremap <silent> gd :call LspGotoDefinition()<CR>
nnoremap <silent> gr :call LspReferences()<CR>
nnoremap <silent> K  :call LspHover()<CR>
nnoremap <silent> <leader>rn :call LspRename()<CR>
nnoremap <silent> <leader>ca :call LspCodeAction()<CR>

" Completion
inoremap <expr> <CR>   pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Tab>  pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

" NERDTree & Airline
nnoremap <leader>n :NERDTreeToggle<CR>
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:NERDTreeFileLines = 1
let g:NERDTreeIgnore = ['^node_modules$', '^__pycache__$']
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_statusline_ontop = 0
let g:airline_theme='deus'
let g:airline#extensions#tabline#formatter = 'default'

" Cursor shape
if &term =~ 'xterm\|rxvt\|alacritty'
  let &t_SI = "\e[6 q"
  let &t_EI = "\e[2 q"
endif
