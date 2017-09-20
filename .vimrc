" ================================================================================
" 自定义函数
" ================================================================================
" 控制菜单的显示与隐藏
func! SwitchMenu()
    if &guioptions =~# 'm'
        set guioptions-=m
    else
        set guioptions+=m
    endif
endfunc

" 随机选择主题
func! PickColorScheme()
    let rand=localtime() % 3
    if rand == 0
        colorscheme molokai            " 设置背景颜色
    elseif rand == 1
        colorscheme jellybeans         " 设置背景颜色
    else
        colorscheme peaksea            " 设置背景颜色
    endif
endfunc

" 编译源文件
func! CompileCode()
    exec "w"
    if &filetype == "c"
        exec "!gcc -Wall -std=c99 %<.c -o %<"
    elseif &filetype == "cpp"
        exec "!g++ -Wall -std=c++11 %<.cpp -o %<"
    elseif &filetype == "lua"
        exec "!luac %<.lua"
    elseif &filetype == "python"
        exec "!python3 -m %<.py"
    endif
endfunc

" 运行可执行文件
func! RunCode()
    exec "w"
    if &filetype == "vim"
        exec "source %<.vim"
    elseif &filetype == "c" || &filetype == "cpp"
        exec "!./%<"
    elseif &filetype == "lua"
        exec "!lua %<.lua"
    elseif &filetype == "sh"
        exec "!bash %<.sh"
    elseif &filetype == "python"
        exec "!python3 %<.py"
    elseif &filetype == "perl"
        exec "!perl %<.pl"
    elseif &filetype == "php"
        exec "!php %<.php"
    endif
endfunc

" 处理终端Alt无法映射问题
func! EscaltConsole()
    " ASCII('/') = 47
    for i in range(65, 90) + range(97, 122) + range(47,47)
        exe "set <M-".nr2char(i).">=\<Esc>".nr2char(i)
    endfor
    set ttimeoutlen=50
    if &term =~ 'xterm'
        set <F1>=OP
        set <F2>=OQ
        set <F3>=OR
        set <F4>=OS
        set <HOME>=OH
        set <END>=OF
    endif
endfunc

" ================================================================================
" 界面显示设置
" ================================================================================
" 修改配置文件重新加载后不改变当前窗口位置
if !exists("is_running")
    " 判断是终端还是Gvim
    if has("gui_running")
        winpos 330 0                   " 窗体起始位置
        set lines=50 columns=100       " 行列，窗口大小
        " F2显示菜单栏
        noremap <silent> <F2> :call SwitchMenu() <CR>
    else
        set t_Co=256
        call EscaltConsole()
    endif
    call PickColorScheme()
endif

let is_running=1

set guioptions-=r                      " 去掉右边滚动条
set guioptions-=m                      " 去掉菜单栏
set guioptions-=T                      " 去除工具栏
set completeopt-=preview               " 补全内容不以分割子窗口形式出现

set nu                                 " 显示行号
set ruler                              " 在编辑过程中,在右下角显示光标位置的状态行
set cmdheight=1                        " 命令行(在状态行下)的高度,默认为1

set langmenu=zh_CN.UTF-8               " 菜单语言设置
set helplang=cn                        " 中文帮助

set laststatus=2                       " 总是显示状态行
set t_Co=256                           " 显示提示终端支持256色,以便正常显示状态栏
set background=dark                    " 设置背景为暗色


" ================================================================================
" 字体编码设置
"
" encoding:      Vim内部使用的字符编码方式，包括Vim的buffer、菜单文本、消息文本等。
" fileencoding:  Vim中当前编辑的文件的字符编码方式，Vim保存文件时也会将文件保存为
"                这种字符编码方式(不管是否新文件都如此)。
" fileencodings: Vim启动时会按照它所列出的字符编码方式逐一探测即将打开的文件的字符
"                编码方式，并且将fileencoding设置为最终探测到的字符编码方式。因此
"                最好将 Unicode 编码方式放到这个列表的最前面，将拉丁语系编码方式
"                latin1放到最后面。
" termencoding:  Vim所工作的终端(或者Windows的Console窗口)的字符编码方式。这个选项
"                在Windows下对我们常用的GUI模式的gVim无效，而对Console模式的Vim而
"                言就是Windows控制台的代码页，并且通常我们不需要改变它。
" ================================================================================
" 设置字符集编码，默认使用utf-8
set encoding=utf-8                     " 状态栏乱码
set fileencodings=utf-8,ucs-bom,chinese,gb18030,gbk,gb2312,cp936,shift-jis
" set guifont=Ubuntu\ Mono\ 12           " Ubuntu下设置字体及大小
set guifont=Monaco:h14

set fileformat=unix
set fileencoding=utf-8

" ================================================================================
" 基本功能设置
" ================================================================================
set nocompatible                       " 不要使用vi的键盘模式，而是vim自己的
set autoread                           " 文件变化后自动读取
set noeb                               " 去掉输入错误的提示声音
set lz                                 " 当运行宏时,在命令执行完成之前不重新绘制屏幕
set shortmess=atI                      " 启动时不显示援助索马里儿童的提示(必须放在nocompatible后面)
set hid                                " 可以在没有保存的情况下切换buffer
" 设定文件浏览器目录为当前目录
set bsdir=buffer
set autochdir

set confirm                            " 在处理未保存或只读文件的时候，弹出确认

" 自动缩进
set autoindent
set smartindent

set cindent                            " 编辑C/C++时,使用C语言缩进方式

" 设置显示tab
" set list                             " 设置显示TAB,默认为^I
" set listchars=tab:>-,trail:+         " 设置显示TAB以及行尾空格的标志

" et   expandtab,将tab展开成空格,而不是制表符
" sts  softabstop,使用tab或bs自动插入或者删除相应的空格数
" sw   shiftwidth,自动缩进插入的空格数
set et sts=4 sw=4

set history=50                         " 历史记录数
set nobackup                           " 禁止生成临时文件
set noswapfile                         " 禁止生成交换文件
set ignorecase smartcase               " 搜索忽略大小写,内容包含大写字母时,不忽略大小写,否则忽略
set hlsearch incsearch                 " 高亮,搜索逐字符高亮

set gdefault                           " 行内替换
set viminfo+=!                         " 保存全局变量
set iskeyword+=$,%,#,-                 " 带有如下符号的单词不要被换行分割
set linespace=0                        " 字符间插入的像素行数目
set wildmenu                           " 增强模式中的命令行自动完成操作
set backspace=2                        " 使回格键(backspace)正常处理indent, eol, start等
set whichwrap+=<,>,h,l                 " 允许backspace和光标键跨越行边界
set winaltkeys=no                      " Alt组合键不映射到菜单上
set mousemodel=popup                   " 设置鼠标右键弹出

" 可以在buffer的任何地方使用鼠标(类似office中在工作区双击鼠标定位)
set mouse=a
set selection=exclusive
set selectmode=mouse,key

set report=0                           " 通过使用:commands命令,告诉我们文件的哪一行被改变过
set showmatch                          " 高亮显示匹配的括号
set matchtime=5                        " 匹配括号高亮的时间(单位是十分之一秒)
set scrolloff=1                        " 光标移动到buffer的顶部和底部时保持1行距离

set foldenable                         " 设置为可折叠
set foldmethod=manual                  " 设置折叠方式

set wmw=0 wmh=0                        " 设置最小窗口为0以便可以最大化其他窗口(水平/垂直方向)
set fillchars=vert:\ ,stl:\ ,stlnc:\   " 在被分割的窗口间显示空白，便于阅读
set sessionoptions+=resize,unix,slash  " 恢复session时恢复窗口大小,兼容Windows与*nix

syntax on                              " 语法高亮
filetype plugin indent on              " 类型检测、特定类型插件、类型缩进都开启


" ================================================================================
" 键映射设置
" ================================================================================
let mapleader=";"
let maplocalleader=";"

" 一键保存、编译
nnoremap <silent> <M-c> :call CompileCode()<CR>
" 一键保存、运行
nnoremap <silent> <M-r> :call RunCode()<CR>
" 清除高亮显示
nnoremap <silent> <M-n> :silent noh<CR>
" 读取配置文件
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
" 重新读取配置文件
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>

" 分屏
nnoremap <silent> <leader>- :split<CR>
nnoremap <silent> <leader>\ :vsplit<CR>

" 使用符号包围光标下面的字(中文多字)
nnoremap <leader>" viw<ESC>`<i"<ESC>`>a"<ESC>h
nnoremap <leader>' viw<ESC>`<i'<ESC>`>a'<ESC>h
nnoremap <leader>* viw<ESC>`<i*<ESC>`>a*<ESC>h
nnoremap <leader>< viw<ESC>`<i<<ESC>`>a><ESC>h
nnoremap <leader>( viw<ESC>`<i(<ESC>`>a)<ESC>h
nnoremap <leader>[ viw<ESC>`<i[<ESC>`>a]<ESC>h
nnoremap <leader>{ viw<ESC>`<i{<ESC>`>a}<ESC>h
" 使用符号包围光标下面的单个汉字
nnoremap <leader>;" a"<ESC>hi"<ESC>e
nnoremap <leader>;' a'<ESC>hi'<ESC>e
nnoremap <leader>;* a*<ESC>hi*<ESC>e
nnoremap <leader>;< a><ESC>hi<<ESC>e
nnoremap <leader>;( a)<ESC>hi(<ESC>e
nnoremap <leader>;[ a]<ESC>hi[<ESC>e
nnoremap <leader>;{ a}<ESC>hi{<ESC>e
" 使用符号包围选择的字符
vnoremap <leader>" <ESC>`<i"<ESC>`>a"<ESC>
vnoremap <leader>' <ESC>`<i'<ESC>`>a'<ESC>
vnoremap <leader>* <ESC>`<i*<ESC>`>a*<ESC>
vnoremap <leader>< <ESC>`<i<<ESC>`>a><ESC>
vnoremap <leader>( <ESC>`<i(<ESC>`>a)<ESC>
vnoremap <leader>[ <ESC>`<i[<ESC>`>a]<ESC>
vnoremap <leader>{ <ESC>`<i{<ESC>`>a}<ESC>

" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
" 将查找出来的所有结果显示在单独的窗口中，双击该行就能定位到文件中的相应行
nnoremap <leader>/ :exec 'lvimgrep /' . input('/', expand('<cword>')) . '/j % <bar> lopen'<CR>

" 把JJ映射成退出插入模式
inoremap jj <ESC>

" 命令模式下移动方向
cnoremap <C-a> <home>
cnoremap <C-e> <end>
cnoremap <C-d> <del>

cnoremap <C-b> <left>
cnoremap <C-f> <right>
cnoremap <C-n> <down>
cnoremap <C-p> <up>

" 使用sudo权限保存的文件
cnoremap W<CR> w !sudo tee %<CR>

" 复制系统剪贴板内容到命令行
cnoremap <leader>p <C-R>+

" 复制系统剪贴板内容到编辑器中
nnoremap <leader>p "+p
" normal模式下复制当前行内容到系统剪贴板
nnoremap <leader>y "+yy
" visual模式下复制当前选定内容到系统剪贴板
vnoremap <leader>y "+y

" ================================================================================
" 键简写设置
" ================================================================================
cnoreabbrev wd w ~/Desktop

" ================================================================================
" Vundle配置
" ================================================================================
call plug#begin('~/.vim/plugged')

" >>>>>>>>>> Interface
Plug 'vim-airline/vim-airline', {'as': 'Airline'}
Plug 'vim-airline/vim-airline-themes', {'as': 'AirlineThemes'}
Plug 'scrooloose/nerdtree', {'as': 'NERDTree'}
Plug 'majutsushi/tagbar', {'as': 'TagBar'}
Plug 'jlanzarotta/bufexplorer', {'as': 'BufExplorer'}
Plug 'tpope/vim-fugitive', {'as': 'Fugitive'}
Plug 'airblade/vim-gitgutter', {'as': 'GitGutter'}

" >>>>>>>>>> File
Plug 'rking/ag.vim', {'as': 'Ag'}
Plug 'ctrlpvim/ctrlp.vim', {'as': 'CtrlP'}

" >>>>>>>>>> Text
Plug 'Chiel92/vim-autoformat', {'as': 'AutoFormat'}
Plug 'scrooloose/nerdcommenter', {'as': 'NERDCommenter'}
Plug 'Stormherz/tablify', {'as': 'Tablify'}

Plug 'Lokaltog/vim-easymotion', {'as': 'EasyMotion'}
Plug 'vim-scripts/matchit.zip', {'as': 'MatchIt'}

" >>>>>>>>>> Syntax
" Plug 'vim-syntastic/syntastic', {'as': 'Syntastic'}
Plug 'w0rp/ale', {'as': 'Ale'}
Plug 'Valloric/YouCompleteMe', { 'as': 'YouCompleteMe'}

" >>>>>>>>>> Snippet
Plug 'SirVer/ultisnips', {'as': 'UltiSnips'}
Plug 'jetz/vim-snippets', {'as': 'Snippets'}

" >>>>>>>>>> FileType
Plug 'fatih/vim-go', {'as': 'Go'}
Plug 'vim-scripts/bash-support.vim', {'as': 'Bash'}
Plug 'ekalinin/Dockerfile.vim', {'as': 'Dockerfile'}
Plug 'evanmiller/nginx-vim-syntax', {'as': 'Nginx'}
Plug 'mitsuhiko/vim-jinja', {'as': 'JinJa2'}
Plug 'cespare/vim-toml', {'as': 'Toml'}
Plug 'solarnz/thrift.vim', {'as': 'Thrift'}
Plug 'rodjek/vim-puppet', {'as': 'Puppet'}

call plug#end()

" ================================================================================
" Airline配置
" ================================================================================
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep = '#'
let g:airline_right_alt_sep = '#'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
    " 也可以是Unicode符号, 参见Airline
    let g:airline_symbols.branch = 'BR:'
    let g:airline_symbols.linenr = 'LN'
    let g:airline_symbols.maxlinenr = ''
    let g:airline_symbols.readonly = 'RO'
    let g:airline_symbols.paste = '{p}'
    let g:airline_symbols.whitespace = ''
endif

let g:airline_theme = "simple"
let g:airline_section_warning = ''

let g:airline#extensions#ale#enabled = 1

" ================================================================================
" NERDTree配置
" ================================================================================
nnoremap <silent> <leader>1 :NERDTreeToggle<CR>
let NERDTreeIgnore=['\~$', '\.pyc$', '\.o$', '\.exe$', '^__pycache__$[[dir]]']

" ================================================================================
" Tagbar配置
" ================================================================================
nnoremap <silent> <leader>0 :TagbarToggle<CR>
let g:tagbar_width = 30

" ================================================================================
" BufExplorer配置
" ================================================================================
nnoremap <silent> <M-l> :BufExplorer<CR>

" ================================================================================
" AutoFormat配置
" ================================================================================
nnoremap <silent> <M-q> :Autoformat<CR>

let g:formatters_python = ['autopep8', 'yapf']
let g:formatters_go = ['gofmt_1']
let g:formatters_c = ['clangformat']
let g:formatters_cpp = ['clangformat']
let g:formatters_javascript = ['jsbeautify_javascript', 'standard_javascript']
let g:formatters_html = ['htmlbeautify']
let g:formatters_css = ['cssbeautify']
let g:formatters_json = ['jsbeautify_json']
let g:formatters_markdown = ['remark_markdown']

" ================================================================================
" EasyMotion配置
" ================================================================================
nmap <leader>f <Plug>(easymotion-f)
nmap <leader>F <Plug>(easymotion-F)
nmap <leader>s <Plug>(easymotion-s)

let g:EasyMotion_smartcase = 1

" ================================================================================
" NERDCommenter配置
" ================================================================================
let NERDMapleader = ';c'

" ================================================================================
" YCM配置
" ================================================================================
let g:ycm_complete_in_comments = 1             " 补全功能在注释中同样有效  
let g:ycm_min_num_of_chars_for_completion = 1  " 从第一个键入字符开始罗列匹配项  
let g:ycm_key_invoke_completion = '<M-/>'      " 补全默认Ctrl+Space，改为Alt+/  
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']

" ================================================================================
" Syntastic配置
" ================================================================================
" let g:syntastic_check_on_open = 1                " 载入源文件时检查语法
" let g:syntastic_python_checkers = ['pylama']
" let g:syntastic_c_checkers = ['clang_check']
" let g:syntastic_go_checkers = ['golint']
" let g:syntastic_javascript_checkers = ['jshint']
" let g:syntastic_html_checkers = ['jshint']
" let g:syntastic_css_checkers = ['csslint']
" let g:syntastic_json_checkers = ['jsonlint']
" let g:syntastic_php_checkers = ['php']
" let g:syntastic_sh_checkers = ['sh']
" let g:syntastic_enable_perl_checker = 1
" let g:syntastic_perl_checkers = ['perl']
 
" ================================================================================
" ALE配置
" ================================================================================
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)

" ================================================================================
" UltiSnips配置
" ================================================================================
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-tab>"

" ================================================================================
" Markdown相关配置
" ================================================================================
augroup _FT_MARKDOWN
    " 清除当前group中的autocmd，防止重复包含
    autocmd!
    autocmd BufRead,BufNewFile *.{md,mkd,markdown}   set filetype=markdown
augroup END

" ================================================================================
" Bash相关配置
" ================================================================================
let g:BASH_MapLeader = '\'

" ================================================================================
" Lua相关配置
" ================================================================================
augroup _FT_LUA
    autocmd!
    autocmd FileType lua setlocal sw=4
augroup END

" ================================================================================
" Python相关配置
" ================================================================================
augroup _FT_PYTHON
    autocmd!
    " 行尾添加 #noqa
    autocmd FileType python nnoremap <buffer> <leader>nq :exec "norm! A # noqa"<CR>
augroup END

" ================================================================================
" Go相关配置
" ================================================================================
augroup _FT_GO
    autocmd!
    autocmd FileType go setlocal ts=4
    autocmd FileType go nnoremap <buffer> <M-d> :GoDoc <CR>
    autocmd FileType go nnoremap <buffer> <M-r> :GoRun <CR>
    autocmd FileType go nnoremap <buffer> <M-c> :GoBuild <CR>
augroup END

let g:go_bin_path = '/Users/jetz/Library/GoPath/bin'
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
