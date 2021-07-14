" Plug related config
call plug#begin('$HOME/.local/share/nvim/plugged')

Plug 'ciaranm/securemodelines'

" Status bar
Plug 'bling/vim-airline'

" Fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" ALterantive to FzF
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'

" Themes :3
Plug 'morhetz/gruvbox'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'srcery-colors/srcery-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'NLKNguyen/papercolor-theme'

" Tree/directory explorer
Plug 'preservim/nerdtree' 

" Autopairs
Plug 'jiangmiao/auto-pairs'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Track coding time
Plug 'wakatime/vim-wakatime'

" Markdown live preview via browser
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Editorconfig auto detect
" Plug 'editorconfig/editorconfig-vim'

" Comment stuff
Plug 'tpope/vim-commentary' 

" Distraction free editing
Plug 'junegunn/goyo.vim'

" Auto configure indentation
Plug 'tpope/vim-sleuth'

" LaTeX
Plug 'lervag/vimtex'

" Multicursor
" Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Notes related
" Plug 'xolox/vim-misc'
" Plug 'xolox/vim-notes'

" Neovim built in LSP
Plug 'neovim/nvim-lspconfig'
Plug 'tjdevries/lsp_extensions.nvim'

" Custom language related plugins
Plug 'tjdevries/nlua.nvim'          " Lua development
Plug 'nvim-lua/lsp-status.nvim'     " Lua statusline
Plug 'euclidianAce/BetterLua.vim'   " Better lua
Plug 'nvim-lua/completion-nvim'     " Better LSP completition

Plug 'ziglang/zig.vim'              " Zig language support

" C lang based formatting
" By default it uses the Google style, if not .clang-format
" file was given
Plug 'rhysd/vim-clang-format'

" Language check

" Wiki :3
Plug 'vimwiki/vimwiki'

call plug#end()

"█▓▒░ Make pyenv and neovim work nice together

if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
    set guicursor=
    autocmd OptionSet guicursor noautocmd set guicursor=
end

if !has('gui_running')
    set t_Co=256
endif

"█▓▒░ Plugin settings

" Don't confirm .lvimrc
let g:localvimrc_ask = 0

set noswapfile                              " Don't use swapfile

set tags=.git/tags

" Sane splits
set splitright                              " Split vertical windows right to the current windows
set splitbelow                              " Split horizontal windows below to the current windows

" Permanent undo
set undodir=~/.vimdid
set undofile

" Decent wildmenu
set wildmenu
"set wildmode=list:longest
set wildmode=list:full
"set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=migrations                       " Django migrations
set wildignore+=go/pkg                           " Go static files
set wildignore+=go/bin                           " Go bin files
set wildignore+=go/bin-vagrant                   " Go bin-vagrant files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files

" Proper search
set incsearch                               " Shows the match while typing
set ignorecase                              " Search case insensitive...
set smartcase                               " ... but not when search pattern contains upper case characters
set gdefault                                " search/replace "globally" (on a line) by default

" ==========================================================================
"    GUI settings
" ==========================================================================
set guioptions-=T                           " Remove toolbar
set vb t_vb=                                " No more beeps
set backspace=2                             " Backspace over newlines
set cmdheight=2
set tw=79
set cursorline
set cursorcolumn
"set nofoldenable
set foldmethod=marker                       " Only fold on marks
set ruler                                   " Where am I?
set ttyfast
" https://github.com/vim/vim/issues/1735#issuecomment-383353563
set lazyredraw                              " don't update the display while executing macros<Paste>
set synmaxcol=500
set laststatus=2                            " always have a statusline
set relativenumber                          " Relative line numbers
set number                                  " Also show current absolute line
set diffopt+=iwhite	                        " No whitespace in vimdiff
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
    set diffopt+=indent-heuristic
endif
set colorcolumn=80                          " and give me a colored column
set showcmd                                 " Show (partial) command in status line.
set mouse=a                                 " Enable mouse usage (all modes) in terminals
set shortmess+=c                            " don't give |ins-completion-menu| messages.

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" LSP related
lua require('init')


" native nvim lsp
setlocal omnifunc=v:lua.vim.lsp.omnifunc

nnoremap <silent> gd            <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD            <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gdd           <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> K             <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <c-k>         <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD           <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr            <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gR            <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> g0            <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW            <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <Leader>[     <cmd>lua vim.lsp.strutures.Diagnostics.buf_move_next_diagnostic()<CR>
nnoremap <silent> <Leader>]     <cmd>lua vim.lsp.strutures.Diagnostics.buf_move_prev_diagnostic()<CR>

augroup NvimLSP
    autocmd!
    autocmd BufWritePre *.py,*.rs,*.ex lua vim.lsp.buf.formatting_sync(nil, 2000)
    autocmd BufEnter,BufWritePost *.rs lua require('lsp_extensions.inlay_hints').request { aligned = true, prefix = " » " }
augroup END

" Custom LSP diagnostics signs
" sign define LspDiagnosticsErrorSign text=E linehl=ErrorMsg texthl=LspDiagnosticsError numhl=
" sign define LspDiagnosticsWarningSign text=W linehl=MoreMsg texthl=LspDiagnosticsWarningSign numhl=

" Golang related
" Autoformat
autocmd BufWritePre *.go lua goimports(2000)
" Jump to Test files
autocmd FileType go nnoremap <silent> gts <cmd>lua go_switch()<CR>

" Ziglang related
" Autoformatting
let g:zig_fmt_autosave = 1

" Python related

" C/C++ related
" Enable Clang auto fromatting on C based languages
autocmd FileType c,cpp,objc ClangFormatAutoEnable

" Javascript formatting
" autocmd BufWritePre *.js :normal mpgg=G`p

" General configuration
" ---------------------

" Map Leader to Space
let mapleader = "\<Space>"
let maplocalleader = ","

set nocompatible
syntax on

if (has("termguicolors"))
    set termguicolors
endif

" Am I a joke to you?
set background=dark

" Theme :3
colorscheme gruvbox
" colorscheme nord
" colorscheme srcery
" colorscheme vim-monokai-tasty

" Solarized config
let g:solarized_termcolors=256
" colorscheme solarized

" Airline theme
let g:airline_detect_paste = 0      " I Don't need this. Never did.
let g:airline_detect_crypt = 0      " Useless.
let g:airline_detect_spell = 0      " Another useless thing.
let g:airline_exclude_preview = 1
let g:airline_theme = 'gruvbox'

" Disable startup message
set shortmess+=I

" Number configurations
set relativenumber
set number	

" Line break config
set textwidth=0

" Status line config
set laststatus=2

" Search config
set showmatch	
set hlsearch	
set smartcase	
set ignorecase	
set incsearch	

set cursorline
set ruler	
set undolevels=1000
set backspace=indent,eol,start
set noerrorbells visualbell t_vb=
set belloff=all

" mouse support
set mouse+=a

set noshowmode

set cmdheight=1
set showmatch  
set hidden     

set completeopt-=preview

set noequalalways
set splitright
set splitbelow
set updatetime=1000

set hlsearch

" Make it so there are always ten lines below my cursor
set scrolloff=10 

" Tabs
" Want auto indents automatically
set autoindent
set cindent
set wrap

" Make it so that long lines wrap smartly
set breakindent
let &showbreak=repeat(' ', 3)
set linebreak

" Always use spaces instead of tab characters
set expandtab

" Folding
set foldmethod=marker
set foldlevel=0
set modelines=1

" Set the gutter padding
" so it doesnt blink when errors
" or git gutters
set signcolumn=yes

" Clipboard
" Always have the clipboard be the same as my regular clipboard
" set clipboard+=unnamedplus

set inccommand=split
set list

syntax enable

" Help remap
nnoremap <F1> <esc>
inoremap <F1> <esc>
vnoremap <F1> <esc>

" 0 should be ^
nnoremap 0 ^

" Move lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Disable the search highlig.
nnoremap <esc> :noh<return><esc>

" NERD Tree
map <Leader>a :NERDTreeToggle<CR>

" Fuzzy related
map <Leader>o :GFiles<CR>
map <Leader>O :tabnew<CR>:GFiles<CR>
map <Leader>p :Files<CR>
map <Leader>rg :Rg<SPACE>

" Splits config

" Better window navigation
noremap <A-l> <C-w>l
noremap <A-h> <C-w>h
noremap <A-j> <C-w>j
noremap <A-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" Remap changing tab to Ctrl+n(ext)/p(revious)
noremap <C-n> gt
noremap <C-p> gT

" Vimtex
let g:tex_flavor = 'latex'
let g:vimtex_mappings_enabled = 0

let g:vimtex_latexmk_continuous = 1

" LaTeX bindings
nnoremap <Leader>vc :VimtexCompile<CR>
nnoremap <Leader>vi :VimtexTocToggle<CR>
nnoremap <Leader>vp :VimtexView<CR> 

" Markdown preview related
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_browser = 'brave'
let g:mkdp_echo_preview_url = 1

if empty(v:servername) && exists('*remote_startserver')
    call remote_startserver('VIM')
endif

" Completion plugin config
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <silent><expr> <c-p> completion#trigger_completion()

set completeopt=menuone,noinsert,noselect " Set completeopt to have a better completion experience
set shortmess+=c " Avoid showing message extra message when using completion

" GUI options
" set guifont=MesloLGLDZ_Nerd_Font_Mono:h15
set guifont=Consolas:h16

" Editing setup
source $HOME/.config/nvim/editing.vim

" Syntax support
source $HOME/.config/nvim/syntax.vim

