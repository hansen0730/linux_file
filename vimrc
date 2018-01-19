" Hansen Fang
" fhz0730@gmail.com

"set helplang=cn

let g:winManagerWindowLayout='TagList|FileExplorer'
let g:winManagerWidth=20
nmap wm :WMToggle<CR>

set completeopt=longest,menu

set cursorline

nmap hd :call TitleDet()<CR>
function AddTitle()
    call append(0,"/*")
    call append(1," *  File name: ".expand("%:t"))
    call append(2," *")
    call append(3," *  Create date: ".strftime("%Y-%m-%d %H:%M"))
    call append(4," *  Modified date: ".strftime("%Y-%m-%d %H:%M"))
    call append(5," *  Author: Hansen (fhz0730@gmail.com)")
    call append(6," *  Comment: ")
    call append(7," */")
    call append(8,"  ")
endf

" Update Modify time and file name
function UpdateTitle()
    call setline(2," *  File name: ".expand("%:t")) 
    call setline(5," *  Modified date: ".strftime("%Y-%m-%d %H:%M"))
endf

function TitleDet()
    let n=1
    while n < 10
        let line = getline(n)
        if line =~ '^ \*  Modified date:*'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddTitle()
endfunction
"au BufWritePost *.c :call UpdateTitle()

set fenc=utf-8
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936

" Not use vi type
set nocompatible

set history=100

" Warning for not save or read only file
set confirm

" Share with windows
set clipboard+=unnamed

filetype on
filetype plugin on
filetype indent on

" Save global vars
set viminfo+=!

" Not wrap split on these char
set iskeyword+=_,$,@,%,#,-

syntax on

:highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
:match OverLength '\%101v.*'

" Status line color
highlight StatusLine guifg=SlateBlue guibg=Yellow
highlight StatusLineNC guifg=Gray guibg=White

" Not save back file
set nobackup

" Not use swap fie
setlocal noswapfile
set bufhidden=hide

set linespace=0

set wildmenu

" Show line and col num on status bar
set ruler
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)

" Command bar high
set cmdheight=1

set backspace=2

set whichwrap+=<,>,h,l

" can use mouse in vim env
set mouse=a
set selection=exclusive
set selectmode=mouse,key

" For Tmux env
set mouse+=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" can use 'command' tell me which line changed in file
set report=0

set fillchars=vert:\ ,stl:\ ,stlnc:\

set showmatch
" show time in match, such { < (
set matchtime=6

" Ignore case in search, But is you search string include one or more Uppercase
set ignorecase smartcase
" use high light
set hlsearch
" realtime high light while search
set incsearch
" Inhibit wrap search
set nowrapscan

" What string you want to show after 'set list'
"set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol

" Move cursor keep 3 line to button and top
set scrolloff=2

" Not flicker
set novisualbell

" Show in status bar
set statusline=%F%m%r%h%w\[POS=%l,%v][%p%%]\%{strftime(\"%d/%m/%y\ -\ %H:%M\")}
" Alway show status bar
set laststatus=2

" Auto format
set formatoptions=tcrqn

" indent like up line
set autoindent
set smartindent
" indent for c lang
set cindent

" indent with 4
set tabstop=4
set softtabstop=4
set shiftwidth=4
" Use space replace tab
set expandtab

set nowrap

" About Ctags
" Sort with name
" let Tlist_Sort_Type = "name"
" Tlist show right
let Tlist_Use_Right_Window = 1
" Compress mode
let Tlist_Compart_Format = 1
" If just Tlist window, then close it
let Tlist_Exist_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 0
" Not show Fold Tree
let Tlist_Enable_Fold_Column = 0
let Tlist_Show_One_File=1

" Auto commands
" Only these file show line num, and etc
if has("autocmd")
    autocmd FileType xml,html,c,cs,java,perl,shell,bash,cpp,python,vim,php,ruby set number
    autocmd FileType xml,html vmap <C-o> <ESC>'<i<!--<ESC>o<ESC>'>o-->
    autocmd FileType java,c,cpp,cs vmap <C-o> <ESC>'<o
    autocmd FileType html,text,php,vim,c,java,xml,bash,shell,perl,python setlocal textwidth=100
    autocmd Filetype html,xml,xsl source $HOME/.vim/plugin/closetag.vim/plugin/closetag.vim
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \ exe " normal g`\"" |
      \ endif
endif "has("autocmd")

" 'F5' compile and run C lang code
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
exec "w"
exec "!gcc % -o %<"
exec "! ./%<"
endfunc
" 'F6' compile and run C++ lang code
map <F6> :call CompileRunGpp()<CR>
func! CompileRunGpp()
exec "w"
exec "!g++ % -o %<"
exec "! ./%<"
endfunc

" Show .NFO file
set encoding=utf-8
function! SetFileEncodings(encodings)
    let b:myfileencodingsbak=&fileencodings
    let &fileencodings=a:encodings
endfunction
function! RestoreFileEncodings()
    let &fileencodings=b:myfileencodingsbak
    unlet b:myfileencodingsbak
endfunction

au BufReadPre *.nfo call SetFileEncodings('cp437')|set ambiwidth=single au BufReadPost *.nfo call RestoreFileEncodings()

" High light show txt file, need txt.vim plugin
au BufRead,BufNewFile * setfiletype txt

" Fold mode {indent manual syntax marker .etc}, use 'space' control
"set foldenable
"set foldmethod=manual
" fold mode use syntax
"set foldmethod=syntax
" Fold area width
"set foldcolumn=0
" Fold level
"set foldlevel=1
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc':'zo')<CR>

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" About cscope
if has("cscope")
    " set csprg=/usr/bin/cscope
    " gtags for 
    set cscopeprg='gtags-cscope'
    set cscopetag
    set csto=1
    set cst
    set nocsverb
    if filereadable("cscope.out")
        cs add cscope.out
    endif

    set csverb
    set cscopeverbose

"   's'   symbol: find all references to the token under cursor
"   'g'   global: find global definition(s) of the token under cursor
"   'c'   calls:  find all calls to the function name under cursor
"   't'   text:   find all instances of the text under cursor
"   'e'   egrep:  egrep search for the word under cursor
"   'f'   file:   open the filename under cursor
"   'i'   includes: find files that include the filename under cursor
"   'd'   called: find functions that function under cursor calls

    set cscopequickfix=c-,d-,i-,t-,e-

    nmap <space>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <space>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <space>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <space>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <space>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <space>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <space>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <space>d :cs find d <C-R>=expand("<cword>")<CR><CR>

endif

" gtags
let GtagsCscope_Auto_Load = 1
let CtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1

" Show line number
set nu

" Use Ctrl+c to copy
nmap <C-c> "+y

" Color scheme
"colorscheme molokai

" Key map
nmap <F8> :qall<CR>
nmap <F9> :wqall<CR>
nmap <F10> :Tlist<CR>

" For Bundle
set nocompatible
" Close file type for Bundle
"filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'vundle'
Bundle 'winmanager'
Bundle 'SuperTab'
Bundle 'The-NERD-tree'
Bundle 'taglist.vim'
Bundle 'txt.vim'
Bundle 'closetag.vim'
Bundle 'javaimp.vim'
"Bundle 'Yggdroot/LeaderF'
Bundle 'gtags.vim'
Bundle 'multilobyte/gtags-cscope'

let g:JavaImpSortPkgSep=1

" Use Ctrl+f to use the Leaderf to find file
"nmap <C-f> :LeaderfFile<CR>

function C_syntax()
    set foldmethod=expr foldexpr=getline(v:lnum)="\v(^\s*//.*\n)+"
    let c_no_comment_fold=1
    ""autocmd FileType c setlocal foldmethod=expr foldexpr=getline(v:lnum)=~'^\s*//'
    inoremap ' ''<ESC>i
    inoremap " ""<ESC>i
    inoremap ( ()<ESC>i
    inoremap < <><ESC>i
    inoremap [ []<ESC>i
    inoremap { {<CR>}<ESC>O
endfunction

" autocmd filetype c,cpp,h,hpp call C_syntax()
"set foldmethod=expr foldexpr=getline(v:lnum)=~'^\s*'.&commentstring[0]

