set nocompatible 
" ---------------Package Manager-------------------
call plug#begin()

" Make sure you use single quotes

"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on':  'NERDTreeToggle' }
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'ghifarit53/tokyonight-vim'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()

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

if has('mouse_sgr')
    set ttymouse=sgr
endif

"Make vim yank and paste sync with system clipboard
set clipboard=unnamed

"Without this, vim has a delay in Tmux when going
"from insert mode to normal mode
set ttimeoutlen=0

filetype plugin indent on 
au Filetype make setlocal noexpandtab

set shortmess=atI

"Searching
set incsearch
set ignorecase
set smartcase

set nobackup
"set backupdir=~/.vim/backup

"Awesomesauce
set wildmenu
set wildmode=longest:full,full
set wildignore=*.o,*.a,*.d,*.dd,*.so,*.pyc,*.pyo,*.tsk
set wildignore+=*/tmp/*,*.swp,*.zip 

set hidden

let mapleader = ","

" ---------------FZF---------------------
" - Popup window (anchored to the bottom of the current window)
"let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } }
let g:fzf_layout = { 'down': '40%' }

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --hidden --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
nmap <silent> <C-P> :Files<CR>
nmap <silent> <C-F> :Lines<CR>
nmap <silent> / :BLines<CR>
nmap <silent> <C-G> :RG<CR>
nmap <silent> <NUL> :Buffers<CR>

" ---------------CtrlP-------------------
"let g:ctrlp_follow_symlinks = 1 "Follow symlinks without loops
"let g:ctrlp_clear_cache_on_exit = 0 "Clear cache with <F5>
"let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"  \ 'file': '\v\.(exe|so|dll)$',
"  \ 'link': 'some_bad_symbolic_links',
"  \ }

"nmap <silent> <C-Space> :CtrlPBuffer<CR>

"Get Ctrl-Space to work in vim
"nmap <silent> <NUL> :CtrlPBuffer<CR>

" ---------------NERDTree---------------
"Opens NERDTree
map <silent><leader>f :NERDTreeToggle<CR>

""Bookmark, only works in NERDTree buffer
map <leader>b :Bookmark 

"Open Bookmark, only works in NERDTree buffer
map <leader>o :OpenBookmark 

"If NERDTree is only buffer left open, auto closes vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"let g:NERDTreeFileExtensionHighlightFullName = 1
"let g:NERDTreeExactMatchHighlightFullName = 1
"let g:NERDTreePatternMatchHighlightFullName = 1
let g:NERDTreeHighlightFolders = 1
let g:NERDTreeHighlightFoldersFullName = 1 

"---------------COC-------------------
let g:coc_node_path = '/usr/local/opt/node@14/bin/node'
set signcolumn=number

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

let g:UltiSnipsExpandTrigger="<C-9>"

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> { <Plug>(coc-diagnostic-prev)
nmap <silent> } <Plug>(coc-diagnostic-next)
nmap <silent> <leader>d :CocList --normal diagnostics<CR>

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

"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 13
"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
"set guifont=Hack\ Regular\ 14
"set guifont = Hack\ Nerd\ Font:h11
let g:WebDevIconsOS = 'Darwin'
" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1

set t_Co=256

if (has("termguicolors"))
    set termguicolors
endif

highlight Normal ctermbg=None

map <F5> :colorscheme onedark

"---------Tokyo Night-----------
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 0
let g:tokyonight_disable_italic_comment = 1
colorscheme tokyonight

" Make comments easier to read in tokyonight
highlight Comment guifg=#8088ae

" Make current line show up clearer in tokyonight
highlight CursorLine guibg=#2b2c3f

" Slightly less dark background in tokyonight
highlight Normal guibg=#20232d

"--------------Status Line------------------
set laststatus=2 "show the status line

"Hide default input/normal mode indicator
set noshowmode
let g:airline_powerline_fonts = 1
"let g:airline_theme='jellybeans'
let g:airline_theme='onedark'
"let g:airline_theme = "tokyonight"
let g:airline_extensions = ['branch', 'fzf', 'coc']

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
" Fixes weird issue where Ctrl-S and some other stuff not
" working in a tmux split
silent !stty -ixon > /dev/null 2>/dev/null

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
"inoremap <S-tab> <BS><BS><BS><BS>

nnoremap <silent> <C-_> :Commentary<CR>
xnoremap <silent> <C-_> :Commentary<CR>
inoremap <silent> <C-_> <C-O>:Commentary<CR>
