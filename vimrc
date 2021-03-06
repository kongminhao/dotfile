" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim
""""""""""""""""""""
let g:islinux=1
" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
set nocompatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" tab to 4 space
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif


"for vundle
set nocompatible

" auto-install vim-plug

if (g:islinux && empty(glob('~/.vim/autoload/plug.vim')))
	silent !curl -fLso ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" Plug 'VundleVim/Vundle.vim'
"Plug 'tpope/vim-fugitive'
"Plug 'vim-scripts/L9'
"Plug 'git://git.wincent.com/command-t.git'
"Plug 'rstacruz/sparkup', {'rtp':'vim/'}
"Plug 'ascenator/L9', {'rtp':'newL9'}

Plug 'ervandew/supertab'

"Plug 'kien/rainbow_parentheses.vim'
"Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'

" air line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-surround'

"Plug 'scrooloose/syntastic'

"rainbow parentheses
Plug 'luochen1990/rainbow'
" auto close parentheses
Plug 'vim-scripts/AutoClose'

"for vim markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

"for snipmate
"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'tomtom/tlib_vim'
"Plug 'garbas/vim-snipmate'
"vim chat of Tux
"Plug 'wsdjeg/vim-chat'
"Plug 'vim-scripts/taglist.vim'
"Plug 'terryma/vim-multiple-cursors'

Plug 'kongminhao/autoHEADER'
Plug 'easymotion/vim-easymotion'

Plug 'johngrib/vim-game-code-break'
"vim golang"
"Plug 'fatih/vim-go'
"vim git"
"Plug 'tpope/vim-fugitive'

"wakatime"
"Plug 'wakatime/vim-wakatime'
call plug#end() 

"set by ian

imap aa <esc>
imap jk <RIGHT>
set nu
set ci
set fencs=utf-8,gbk,gb2312,cp936

set guifont=Ubuntu\ mono:h14
set autoread
set nobackup
"use \n not \r\n

set fileformat=unix
set cursorline
"set ai
"start roll the screen when it's 7th line"
set so=7

"for nerdtree
map NE :NERDTreeToggle<cr>
autocmd bufenter * if(winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"for rainbow
let g:rainbow_active = 1

"for solarized"
set background=dark

""""""""""""""""""""""""""""""""
"for syntastic
""set statusline+=%#warningmsg#
""set statusline+=%{SyntasticStatuslineFlag()}
""set statusline+=%*

""let g:syntastic_always_populate_loc_list = 1
""let g:syntastic_auto_loc_list = 1
""let g:syntastic_check_on_open = 1
""let g:syntastic_check_on_wq = 0


"""""""""""""""""""""""""""""""""""
"for air line when there is only one window, replace buffer
set laststatus=2


"""""""""""""""""""""""""""""""""""""""""""""
"for vim markdown
let g:vim_markdown_folding_disabled = 1

"for markdown preview plus"
"let g:table_mode_corner="|"
""nmap <Leader>ch :update<Bar>silent ! start %:p<CR>
"
""""""""""""""""""""""""""""""""""""
"for Airline-theme"
let g:airline_theme='bubblegum'

""""""""""""""""""""""""""
"for vim airline"
"let g:airline#extensions#tabline#enabled = 1



""""""""""""""""""""""""""""""""""""""
" for taglist.vim"
"let Tlist_Inc_Winwidth=0
""let Tlis_File_Fold_Auto_Close=1
""let Tlist_Show_One_File=1
""let Tlist_Exit_OnlyWindow=1
""let Tlist_GainFocus_On_ToggleOpen=1
""map TG :TlistToggle<CR>

"""""""""""for win gui"
if has("gui_running")
	set guioptions-=T
	"set guioptions-=m
	"set guioptions-=L
	"set guioptions-=r
endif



" for auto header"
set clipboard=unnamed
let g:autoHEADER_default_author="scukmh"
let g:autoHEADER_default_email="353213666@qq.com"
let g:autoHEADER_auto_enable=1
let g:autoHEADER_fill_char_repeat=70
set re=1
set ttyfast
set lazyredraw
"vim easymotion conf"
let mapleader=" "
map f <leader><leader>s
