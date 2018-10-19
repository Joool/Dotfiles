" installs plug if not available
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" remember to set init file, see :h nvim-from-vim
call plug#begin('~/.vim/plugged')
  " better search
  Plug 'haya14busa/incsearch.vim'

  " Statusline
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " numbertoggle
  Plug 'jeffkreeftmeijer/vim-numbertoggle'

  " show git diff
  Plug 'mhinz/vim-signify'

  " fuzzy finder
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'

  " tabcompletion
  Plug 'ervandew/supertab'

  " async linter
  Plug 'w0rp/ale'

  " ctags 
  Plug 'craigemery/vim-autotag'
  Plug 'majutsushi/tagbar'

  " Autocomplete
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif

  " Syntax themes
  Plug 'flazz/vim-colorschemes'

  " Rust
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  Plug 'racer-rust/vim-racer', { 'for': 'rust' }

  " Python
  Plug 'zchee/deoplete-jedi', { 'for': 'python' }

  " Solidity
  Plug 'tomlion/vim-solidity' 

  " toml
  Plug 'cespare/vim-toml'

call plug#end()

"=====================================================
"===================== SETTINGS ======================
set nocompatible
filetype off
filetype plugin indent on

set ttyfast

set laststatus=2
set encoding=utf-8              " Set default encoding to UTF-8
set autoread                    " Automatically reread changed files without asking me anything
set autoindent                  
set backspace=indent,eol,start  " Makes backspace key more powerful.
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set mouse=a                     "Enable mouse mode

set noerrorbells             " No beeps
set number                   " Show line numbers
set showcmd                  " Show me what I'm typing
set noswapfile               " Don't use swapfile
set nobackup                 " Don't create annoying backup files
set splitright               " Split vertical windows right to the current windows
set splitbelow               " Split horizontal windows below to the current windows
set autowrite                " Automatically save before :next, :make etc.
set hidden
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats
set noshowmatch              " Do not show matching brackets by flickering
set noshowmode               " We show the mode with airline or lightline
set ignorecase               " Search case insensitive...
set smartcase                " ... but not it begins with upper case 
set completeopt=menu,menuone
set nocursorcolumn           " speed up syntax highlighting
set nocursorline
set updatetime=300

set pumheight=10             " Completion window max size

set expandtab
set shiftwidth=4
set tabstop=4


"http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
set clipboard^=unnamed
set clipboard^=unnamedplus

" ~/.viminfo needs to be writable and readable
set viminfo='200

set lazyredraw          " Wait to redraw

if has('persistent_undo')
  set undofile
  set undodir=~/.cache/vim
endif

" open help vertically
command! -nargs=* -complete=help Help vertical belowright help <args>
autocmd FileType help wincmd L

" filetypes
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 
autocmd BufNewFile,BufRead *.ino setlocal noet ts=4 sw=4 sts=4
autocmd BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
autocmd BufNewFile,BufRead *.md setlocal noet ts=4 sw=4
autocmd BufNewFile,BufRead *.vim setlocal expandtab shiftwidth=2 tabstop=2
autocmd BufNewFile,BufRead *.py
    \ setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix

autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2

set hidden

" colorscheme 
colorscheme hybrid_material

"=====================================================
"===================== Mappings ======================
let mapleader = ","

" rebind escape to ctrl-c
inoremap <C-c> <Esc><Esc>

" Stay in visual mode when shifting indentation
xnoremap < <gv
xnoremap > >gv

" Some useful quickfix shortcuts for quickfix
map <C-a> :cn<CR>
map <C-s> :cp<CR>
nnoremap <leader>a :cw<CR>
nnoremap <leader>A :cclose<CR>

" put quickfix window always to the bottom
autocmd FileType qf wincmd J
augroup quickfix
    autocmd!
    autocmd FileType qf setlocal wrap
augroup END

" Fast saving
nnoremap <leader>w :w!<cr>
nnoremap <silent> <leader>q :q!<CR>

" Center the screen
nnoremap <space> zz

" Remove search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Close all but the current one
nnoremap <leader>o :only<CR>

" Switch to last buffer
nnoremap <leader>b :b#<CR>

" Better split switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Visual linewise up and down by default (and use gj gk to go quicker)
noremap <Up> gk
noremap <Down> gj
noremap j gj
noremap k gk

" Fast jumping up/down
noremap J 5gj
noremap K 5gk

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when moving up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

" bindings for quickly cycling the change list
noremap <C-n> g,
noremap <C-m> g;

" Remap H and L (top, bottom of screen to left and right end of line)
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

" Do not show stupid q: window
map q: :q

" Terminal mode
nnoremap <leader>L :term <return>
nnoremap <leader>l :vsplit term://zsh <return>
tnoremap <leader>c <C-\><C-n>

" Move line up down with A-j A-k, on mac we use the symbols created by
" pressing A-j...
nnoremap º :m .+1<CR>==
nnoremap ∆ :m .-2<CR>==
inoremap º <Esc>:m .+1<CR>==gi
inoremap ∆ <Esc>:m .-2<CR>==gi
vnoremap º :m '>+1<CR>gv=gv
vnoremap ∆ :m '<-2<CR>gv=gv

"=====================================================
"===================== Plugins =======================

"===================== incsearch =====================
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)


" ==================== tcomment ======================
let g:tcomment_maps = 0
nnoremap <silent> t :TComment<CR>j
vnoremap <silent> t :TComment<CR>

" ==================== vimairline ====================
let g:airline#extensions#tabline#enabled = 1

" ==================== Ale ===========================
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
hi link ALEError Default
hi link ALEWarning Default

" Write this in your vimrc file
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

let g:airline#extensions#ale#enabled = 1

" ==================== Deoplete ======================
let g:deoplete#enable_at_startup = 1

" ==================== SIGNIFY =======================
let g:signify_vcs_list=['git']

" ==================== Supertab ======================
let g:SuperTabDefaultCompletionType = "<c-n>"

" ==================== FZF ===========================
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_history_dir = '~/.local/share/fzf-history'

" disable statusline in fzf terminal mode
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'window': '10split enew' }

" keybindings
nnoremap ü :FZF<CR>
nnoremap Ü :FZF 
nnoremap <silent> <leader>B :Buffers<CR>
nnoremap <silent> <leader>g :GFiles<CR>
nnoremap <silent> <leader>R :Rg<CR>
nnoremap <silent> <leader>H :History:<CR>
nnoremap <silent> <leader>h :History/<CR>

"===================== Tags ==========================
let g:autotagTagsFile=".tags"
nnoremap <silent> <leader>t :TagbarToggle<CR>

"===================== Rust ==========================
" rustup component add rustfmt-preview --toolchain=nightly
let g:racer_experimental_completer = 1
let g:racer_cmd = "$HOME/.cargo/bin/racer"

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

let g:rustfmt_autosave = 1
let g:autofmt_autosave = 1 

"===================== Python ========================
