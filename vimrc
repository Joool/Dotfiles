" install neovim python package
" remember to set init file, see :h nvim-from-vim
call plug#begin('~/.vim/plugged')
  " Statusline
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

  " numbertoggle
  Plug 'jeffkreeftmeijer/vim-numbertoggle'

  " show git diff
  Plug 'mhinz/vim-signify'

  " fuzzy finder
  Plug '/usr/local/opt/fzf'

  " TODO: group programming stuff into groups and laod
  " linter/autocomplete/snippets on demand
  " Linter
  Plug 'vim-syntastic/syntastic'

  " Autocomplete
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif

  " Snippets
  Plug 'SirVer/ultisnips'

  " Syntax themes
  Plug 'flazz/vim-colorschemes'

  " Rust
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  Plug 'racer-rust/vim-racer', { 'for': 'rust' }
  Plug 'wagnerf42/vim-clippy', { 'for': 'rust' }

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

autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2

" rebind escape to ctrl-c
inoremap <C-c> <Esc><Esc>

" colorscheme
colorscheme hybrid_material

"=====================================================
"===================== Mappings ======================
let mapleader = ","

" Some useful quickfix shortcuts for quickfix
map <C-n> :cn<CR>
map <C-m> :cp<CR>
nnoremap <leader>a :cclose<CR>

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

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when moving up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

" Remap H and L (top, bottom of screen to left and right end of line)
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_

" Do not show stupid q: window
map q: :q

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h


" Terminal mode
nnoremap <leader>t :vsplit term://zsh <return>
tnoremap <leader>c <C-\><C-n>

"=====================================================
"===================== Plugins =======================

"===================== Syntastic =====================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ==================== UltiSnips ====================
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

" ==================== Deoplete ======================
let g:deoplete#enable_at_startup = 1

" ==================== NerdTree ======================
" For toggling
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>

let NERDTreeShowHidden=1


" ==================== SIGNIFY =======================
let g:signify_vcs_list=['git']

"=====================================================
"===================== Language Specific =============

"===================== Rust ==========================
" rustup component add rustfmt-preview --toolchain=nightly
let g:autofmt_autosave = 1
let g:rustfmt_autosave = 1

" use cargo as rust linter
let g:syntastic_rust_checkers = ['cargo']

" racer config
" https://github.com/racer-rust/racer
set hidden
let g:racer_cmd = "/Users/joelfrank/.cargo/bin/racer"
let g:racer_experimental_completer = 1

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)


"===================== Tex ==========================
" LaTeX (rubber) macro for compiling
au FileType tex nmap <leader>c :w<CR>:!rubber --pdf all %<CR>

" View PDF macro; '%:r' is current file's root (base) name.
au FileType tex nmap <leader>v :!open %:r.pdf &<CR><CR>
