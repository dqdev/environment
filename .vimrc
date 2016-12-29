set nocompatible 
" ---------------Package Manager-------------------
" Required:
set runtimepath+=$HOME/.vim/package_manager/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin($HOME.'/.vim/package_manager/')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/neocomplete.vim')
call dein#add('davidhalter/jedi-vim')
call dein#add('SirVer/ultisnips')
call dein#add('honza/vim-snippets')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('scrooloose/nerdcommenter')
call dein#add('tpope/vim-fugitive')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('edkolev/tmuxline.vim')
call dein#add('christoomey/vim-tmux-navigator')
" You can specify revision/branch/tag.
"call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif
" ---------------Package Manager-------------------

inoremap <F10> <Esc>
set nocompatible
set term=xterm

scriptencoding utf-8 
set encoding=utf-8
set fileencoding=utf-8

set expandtab
set tabstop=4
set ruler
set backspace=indent,eol,start
set shiftwidth=4                        "this is the level of autoindent, adjust to taste
set showmode
set number
set showmatch  "shows matching braces
set whichwrap+=h,l,<,>,[,]
set so=12  "Start scrolling before cursor reaches bottom

set cursorline
set autoindent
set mouse=a

"Make vim yank and paste sync with system clipboard
set clipboard=unnamedplus

"Without this, vim has a delay in Tmux when going
"from insert mode to normal mode
set ttimeoutlen=0

filetype on 
au Filetype make setlocal noexpandtab

set shortmess=atI

"Searching
set incsearch
set ignorecase
set smartcase

set textwidth=115

set nobackup
"set backupdir=~/.vim/backup

"Awesomesauce
set wildmenu
set wildmode=longest:full,full
set wildignore=*.o,*.a,*.d,*.dd,*.so,*.pyc,*.pyo,*.tsk
set wildignore+=*/tmp/*,*.swp,*.zip 

set hidden

let mapleader = ","

" ---------------CtrlP-------------------
let g:ctrlp_follow_symlinks = 1 "Follow symlinks without loops
"let g:ctrlp_clear_cache_on_exit = 0 "Clear cache with <F5>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

nmap <silent> <C-Space> :CtrlPBuffer<CR>

"Get Ctrl-Space to work in vim
nmap <silent> <NUL> :CtrlPBuffer<CR>

" ---------------NERDTree---------------
"Opens NERDTree
map <silent><leader>n :NERDTreeToggle<CR>

""Bookmark, only works in NERDTree buffer
map <leader>b :Bookmark 

"Open Bookmark, only works in NERDTree buffer
map <leader>o :OpenBookmark 

"If NERDTree is only buffer left open, auto closes vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" ---------------Tabline---------------
"set guioptions-=m  "menu bar
"set guioptions-=T  "toolbar
set guioptions-=r  "scrollbar

"let g:airline#extensions#tabline#enabled = 1

" ---------------Buffers----------------
"Switch to next/previous buffers
nnoremap [ :bprev<cr>
nnoremap ] :bnext<cr>
"Using Leader brings up list of buffers
nnoremap <leader>] :buffers<CR>:buffer<SPACE>
nnoremap <leader>[ :buffers<CR>:buffer<SPACE>

" ---------------Splits----------------
"Split current buffer
nmap <silent> <leader>s :vsplit<CR>
nmap <silent> <leader>S :split<CR>

"Arrows Switch cursor to different splits
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>

"hjkl Switch cursor to different splits
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

"Move split left right up down with arrow keys
nmap <silent> <leader><Left> :wincmd H<CR>
nmap <silent> <leader><Right> :wincmd L<CR>
nmap <silent> <leader><Up> :wincmd K<CR>
nmap <silent> <leader><Down> :wincmd J<CR>>

"Move split left right up down with hlkj
nmap <silent> <leader>h :wincmd H<CR>
nmap <silent> <leader>l :wincmd L<CR>
nmap <silent> <leader>k :wincmd K<CR>
nmap <silent> <leader>j :wincmd J<CR>

:au VimResized * wincmd =

" ---------------Color---------------
set hls                             "sets highlight search
nmap <silent> <leader>n :nohlsearch<CR>
syntax on       
syntax enable

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 13
"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set t_Co=256
colorscheme xoria256
"colorscheme molokai
"colorscheme solarized

highlight Normal ctermbg=None

map <F9> :colorscheme desert
map <F10> :colorscheme desert256

map <F7> :colorscheme wombat
map <F8> :colorscheme wombat256

map <F5> :colorscheme molokai
map <F6> :colorscheme xoria256


" -------------AutoComplete-----------
"  This is simple version, deprecated use version below for more features
"function! Tab_Or_Complete()
"  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
"    return "\<C-N>"
"  else
"    return "\<Tab>"
"  endif
"endfunction
":inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
":set dictionary="/usr/dict/words"

" -------------NeoComplete-----------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell': $HOME.'/.vimshell_hist',
    \ 'scheme'  : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" <TAB>: completion.
"inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <BS>: close popup and delete backword char.
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Auto close preview pane upon tab completion
autocmd CompleteDone * pclose

" Enable omni completion.
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Use jedi-vim for python completion
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python ='\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
" alternative pattern: '\h\w*\|[^. \t]\.\w*'


"--------------Snippets------------------
" Get tabs to behave properly with snippets and neocomplete
" From https://github.com/SirVer/ultisnips/issues/519 Hotschke's comments
let g:UltiSnipsJumpForwardTrigger="<NOP>"
let g:ulti_expand_or_jump_res = 0
function! ExpandSnippetOrJumpForwardOrReturnTab()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<TAB>"
    endif
endfunction

inoremap <expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ "<C-R>=ExpandSnippetOrJumpForwardOrReturnTab()<CR>"

" jump to next placeholder otherwise do nothing
snoremap <buffer> <silent> <TAB>
    \ <ESC>:call UltiSnips#JumpForwards()<CR>

" previous menu item, jump to previous placeholder or do nothing
let g:UltiSnipsJumpBackwordTrigger = "<NOP>"
inoremap <expr> <S-TAB>
    \ pumvisible() ? "\<C-p>" :
    \ "<C-R>=UltiSnips#JumpBackwards()<CR>"

" jump to previous placeholder otherwise do nothing
snoremap <buffer> <silent> <S-TAB>
    \ <ESC>:call UltiSnips#JumpBackwards()<CR>

" expand snippet, close menu or insert newline
let g:UltiSnipsExpandTrigger = "<NOP>"
let g:ulti_expand_or_jump_res = 0
inoremap <silent> <CR> <C-r>=<SID>ExpandSnippetOrReturnEmptyString()<CR>
function! s:ExpandSnippetOrReturnEmptyString()
    if pumvisible()
        let snippet = UltiSnips#ExpandSnippetOrJump()
        if g:ulti_expand_or_jump_res > 0
            return snippet
        else
            return "\<C-y>\<CR>"
        endif
    else
        return "\<CR>"
    endif
endfunction


"--------------Status Line------------------
set laststatus=2 "show the status line

"Hide default input/normal mode indicator
set noshowmode
let g:airline_powerline_fonts = 1
let g:airline_theme='jellybeans'

let g:airline_extensions = ['branch', 'ctrlp']

function! AirlineInit()
    let g:airline_section_a = airline#section#create_right(['mode'])
    let g:airline_section_b = airline#section#create_right(['branch'])
    let g:airline_section_c = airline#section#create(['readonly','file'])
    let g:airline_section_x = airline#section#create_left([''])
    let g:airline_section_y = airline#section#create_left(['filetype'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()


"--------------Tmux Line------------------
let g:tmuxline_preset = {
      \'a'    : '#H',
      \'b'    : '#P',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'y'    : '%a, %b %d',
      \'z'    : '#S'}

"--------------Diffing------------
"set statusline=%-10.3n  "buffer number
" ,2 pulls change from buffer 2
map <silent> <leader>2 :diffget 2<CR> :diffupdate<CR>
map <silent> <leader>3 :diffget 3<CR> :diffupdate<CR>
map <silent> <leader>4 :diffget 4<CR> :diffupdate<CR>

" --------------Macros----------------
"Ctrl-S saves
nnoremap <silent> <C-s> :w!<CR>
inoremap <silent> <C-s> <C-O>:w!<CR>

" Next Tab
nnoremap <silent> <S-Right> :tabnext<CR>
      
" Previous Tab
nnoremap <silent> <S-Left> :tabprevious<CR>

" New Tab
nnoremap <silent> <C-t> :tabnew<CR>

" Close Tab
nnoremap <silent> <C-w> :q!<CR>

" Shift-Tab will shift back 1 tab
nnoremap <S-tab> <lt><lt> 
inoremap <S-tab> <BS><BS><BS><BS>

