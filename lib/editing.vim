""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Keyboard shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ; as :
nnoremap ; :

inoremap jj <esc>
nnoremap Y y$
nnoremap gUiw mzgUiw`z
nnoremap guiw mzguiw`z

" Ctrl+c and Ctrl+j as Esc
inoremap <C-j> <Esc>
vnoremap <C-j> <Esc>
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Move by line
nnoremap j gj
nnoremap k gk

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" <leader>, shows/hides hidden characters
nnoremap <leader>, :set invlist<cr>

" Keymap for replacing up to next _ or -
"noremap <leader>m ct_   " choosing over lsp ctx menu
"noremap <leader>n ct-

" M to make
noremap M :!make -k -j4<cr>

" I can type :help on my own, thanks.
map <F1> <Esc>
imap <F1> <Esc>

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Quick-save
nmap <leader>w :StripWhitespace<CR>:w<CR>
nmap <leader>wq :wq<CR>
nnoremap <leader>q :q!<CR>
nnoremap <leader>qq :q!<Esc>:q!<CR>
command! W w
command! Wq wq
command! WQ wq

" detele things shortcut
nnoremap <C-i> C
"inoremap <C-i> C
"vnoremap <C-i> C
nnoremap <leader>i C
"inoremap <leader>i C
"vnoremap <leader>i C

" F3 to insert a logical clock
nmap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>
inoremap <special> <F3> <c-r>=strftime('%c')<CR>

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" Replaced gundo with UndoTree, pure vimscript instead of dependencies
nnoremap <leader>u :UndotreeToggle<CR>

" vim-dispatch
nnoremap <leader>d :Dispatch<CR>
" special case for netbricks
autocmd BufRead,BufNewFile $HOME/dev/netbricks/** let b:dispatch = './build.sh'
autocmd BufRead,BufNewFile $HOME/dev/netbricks/** nnoremap <leader>d :Dispatch!<CR>
autocmd BufRead,BufNewFile $HOME/dev/projects/netbricks/** let b:dispatch = './build.sh'
autocmd BufRead,BufNewFile $HOME/dev/projects/netbricks/** nnoremap <leader>d :Dispatch!<CR>

" Jump to start and end of line using the home row key
"map H ^
"map L $
nnoremap <C-h> ^
nnoremap <C-l> $
inoremap <C-e> <Esc>A
inoremap <C-a> <Esc>I
nnoremap <C-e> <Esc>A
nnoremap <C-a> <Esc>I

" map wincmd
"
" The right windcmd
nmap <silent>J :wincmd j<CR>
nmap <silent>K :wincmd k<CR>
nmap <silent>H :wincmd h<CR>
nmap <silent>L :wincmd l<CR>

nmap <silent> <A-k> :wincmd k<CR>
nmap <silent> <A-j> :wincmd j<CR>
nmap <silent> <A-h> :wincmd h<CR>
nmap <silent> <A-l> :wincmd l<CR>

" provide hjkl movements in Insert mode via the <Alt> modifier key
"
inoremap <A-h> <C-o>h
inoremap <A-j> <C-o>j
inoremap <A-k> <C-o>k
inoremap <A-l> <C-o>l


" Neat X clipboard integration linux
"
" ,p will paste clipboard into buffer
" ,c will copy entire buffer into clipboard
if has('unix')
  if has('mac')       " osx
    " Paste clipboard content to current line
    nnoremap <silent>P :r !pbpaste<CR>
    vnoremap <silent>y :w !pbcopy<CR>
  else                " linux, bsd, etc
    noremap <leader>p :read !xsel --clipboard --output<cr>
    noremap <leader>c :w !xsel -ib<cr><cr>
  endif
endif

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remap VIM 0 to first non-blank character
map 0 ^

" highlighted yank
if !exists('##textyankpost')
  map y <plug>(highlightedyank)
endif

" fzf !!! {{{
" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
"
let g:fzf_layout = { 'down': '~25%' }
" Keybindings
imap <c-x><c-l> <plug>(fzf-complete-line)
nnoremap <leader>c :Commits<CR>
" Open hotkeys
nnoremap <C-p> :Files<CR>
nnoremap <leader>; :Buffers<CR>
nnoremap <leader>f :GFiles<CR>
nnoremap <leader>g :GFiles?<CR>
" <leader>s for Rg search
noremap <leader>s :Ag<CR>
noremap <leader>/ :Rg<CR>
noremap <leader>rg :Rgg<CR>
" }}}
" fzf helper methods {{{
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

command! -bang -nargs=* Rgg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
      \ 'options': '--tiebreak=index'}, <bang>0)

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep --line-number '.shellescape(<q-args>), 0,
      \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

" Override Colors command. You can safely do this in your .vimrc as fzf.vim
" will not override existing commands.
command! -bang Colors
      \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Bat: https://github.com/sharkdp/bat
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \                 <bang>0 ? fzf#vim#with_preview('up:60%')
      \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
      \                 <bang>0)

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

" Likewise, Files command with preview window
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" TODO(jethros): write a GitFiles method that start fzf in full screen and
" display GFiles
command! -bang -nargs=? GitFiles
      \ call fzf#vim#gitfiles('?',
      \                 <bang>0 ? fzf#vim#with_preview('up:60%')
      \                         : fzf#vim#with_preview('up:60%:hidden', '?'),
      \                 <bang>0)
" }}}

" Mac setting, not important {{{
"
" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif
" }}}
" Delete trailing white space on save, useful for Python and CoffeeScript ;) {{{
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
" }}}

" C++ reference look up  {{{
" https://stackoverflow.com/questions/2272759/looking-up-c-documentation-inside-of-vim?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
command! -nargs=+ Cppman silent! call system("tmux split-window cppman " . expand(<q-args>))
autocmd FileType cpp nnoremap <silent><buffer> K <Esc>:Cppman <cword><CR>
" }}}
" fugitive {{{
"
nnoremap <silent> gd :GDiff<CR>
nnoremap <silent> dg :diffget<CR>
" }}}

" vim-illuminate
hi link illuminatedWord Visual
" Time in milliseconds (default 250)
let g:Illuminate_delay = 1500
"let g:Illuminate_ftHighlightGroups = {
"      \ 'vim': ['vimVar', 'vimString', 'vimLineComment',
"      \         'vimFuncName', 'vimFunction', 'vimUserFunc', 'vimFunc']
"      \ }

" vim-search-pulse
let g:vim_search_pulse_duration = 250

" poppy
au! cursormoved * call PoppyInit()

" notational-fzf-vim
if !empty(glob("~/notes"))
  let g:nv_search_paths = ['~/notes']
  nnoremap NN :NV<CR>
endif

" NnoreF and Preview are only for macOS
if has("mac") || has("macunix")
    " Preview
  let g:livepreview_previewer = 'open -a Preview'
endif

" A second kind of re-wrap {{{
" Reformat lines (getting the spacing correct)
"
" https://tex.stackexchange.com/questions/1548/intelligent-paragraph-reflowing-in-vim
fun! TeX_fmt()
  if (getline(".") != "")
    let save_cursor = getpos(".")
    let op_wrapscan = &wrapscan
    set nowrapscan
    let par_begin = '^\(%D\)\=\s*\($\||\\begin\|\\end\|\\[\|\\]\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\|\\noindent\>\)'
    let par_end   = '^\(%D\)\=\s*\($\||\\begin\|\\end\|\\[\|\\]\|\\place\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\)'
    try
      exe '?'.par_begin.'?+'
    catch /E384/
      1
    endtry
    norm V
    try
      exe '/'.par_end.'/-'
    catch /E385/
      $
    endtry
    norm gq
    let &wrapscan = op_wrapscan
    call setpos('.', save_cursor)
  endif
endfun
" }}}
autocmd Filetype tex nmap Q :call TeX_fmt()<CR>zz
autocmd Filetype markdown nmap Q :call TeX_fmt()<CR>zz

" NERDCommenter
"
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = {
      \ 'c': {'left': '//'},
      \ 'cpp': {'left': '//'},
      \ 'python': {'left': '#'},
      \ 'rust': {'left': '//'},
      \ }
" Nerd commenter keybindings
"map <leader>\ <leader>c<Space>
map <leader>cc <plug>NERDComToggleComment
map <C-\> <leader>c<Space>
