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
        winpos 250 0                   " 窗体起始位置
        set lines=55 columns=105       " 行列，窗口大小
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

set updatetime=300                     " 减少更新时间，提升体验

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
set nowritebackup
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
nnoremap <silent> <Leader>ev :e $MYVIMRC<CR>
" 重新读取配置文件
nnoremap <silent> <Leader>sv :source $MYVIMRC<CR>
" 打开terminal
nnoremap <silent> <Leader>t :terminal<CR>

" 分屏
nnoremap <silent> <Leader>- :split<CR>
nnoremap <silent> <Leader>\ :vsplit<CR>

" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
" 将查找出来的所有结果显示在单独的窗口中，双击该行就能定位到文件中的相应行
nnoremap <Leader>/ :exec 'lvimgrep /' . input('/', expand('<cword>')) . '/j % <bar> lopen'<CR>

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
cnoremap <Leader>p <C-R>+

" 复制系统剪贴板内容到编辑器中
nnoremap <Leader>p "+p
" normal模式下复制当前行内容到系统剪贴板
nnoremap <Leader>y "+yy
" visual模式下复制当前选定内容到系统剪贴板
vnoremap <Leader>y "+y

" ================================================================================
" 键简写设置
" ================================================================================
cnoreabbrev wd w ~/Desktop

" ================================================================================
" Vundle配置
" ================================================================================
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jlanzarotta/bufexplorer'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'preservim/nerdcommenter'
Plug 'stormherz/tablify'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'andymass/vim-matchup'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'dense-analysis/ale'
Plug 'vim-autoformat/vim-autoformat'
Plug 'iberianpig/tig-explorer.vim', {'as': 'tig-explorer'}
Plug 'junegunn/fzf', {'as': 'fzf', 'dir': '~/.vim/plugged/fzf/fzf'}
Plug 'junegunn/fzf.vim', {'as': 'fzf.vim', 'dir': '~/.vim/plugged/fzf/fzf.vim'}
Plug 'neoclide/coc.nvim', {'as': 'coc', 'do': 'yarn install --frozen-lockfile'}

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
nnoremap <silent> <Leader>1 :NERDTreeToggle<CR>
let NERDTreeIgnore=['\~$', '\.pyc$', '\.o$', '\.exe$', '^__pycache__$[[dir]]', '^node_modules$[[dir]]']

" ================================================================================
" Tagbar配置
" ================================================================================
nnoremap <silent> <Leader>0 :TagbarToggle<CR>
let g:tagbar_width = 30

" ================================================================================
" BufExplorer配置
" ================================================================================
nnoremap <silent> <M-l> :BufExplorer<CR>

" ================================================================================
" AutoFormat配置
" ================================================================================
nnoremap <silent> <M-q> :Autoformat<CR>

let g:formatters_python = ['black']
let g:formatters_go = ['gofmt_1', 'goimports']
let g:formatters_c = ['clangformat']
let g:formatters_lua = ['luafmt']
let g:formatters_json = ['fixjson']
let g:formatters_javascript = ['jsbeautify_javascript']
let g:formatters_html = ['htmlbeautify']
let g:formatters_css = ['cssbeautify']
let g:formatters_sql = ['sqlformat']
let g:formatters_markdown = ['remark_markdown']

" ================================================================================
" EasyMotion配置
" ================================================================================
nmap <Leader>f <Plug>(easymotion-f)
nmap <Leader>F <Plug>(easymotion-F)
nmap <Leader>s <Plug>(easymotion-s)

let g:EasyMotion_smartcase = 1

" ================================================================================
" NERDCommenter配置
" ================================================================================
let NERDMapleader = ';c'

" ================================================================================
" Surround配置
" ================================================================================
xmap <Leader>{ S{
xmap <Leader>} S}
xmap <Leader>[ S[
xmap <Leader>] S]
xmap <Leader>( S(
xmap <Leader>) S)
xmap <Leader>< S<
xmap <Leader>> S>
xmap <Leader>" S"
xmap <Leader>' S'
xmap <Leader>` S`
xmap <Leader>* S*
nmap <Leader>{ ysiw{
nmap <Leader>} ysiw}
nmap <Leader>[ ysiw[
nmap <Leader>] ysiw]
nmap <Leader>( ysiw(
nmap <Leader>) ysiw)
nmap <Leader>< ysiw<
nmap <Leader>> ysiw>
nmap <Leader>" ysiw"
nmap <Leader>' ysiw'
nmap <Leader>` ysiw`
nmap <Leader>* ysiw*

" ================================================================================
" Ale配置
" ================================================================================
let g:ale_c_parse_makefile = 1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)

" ================================================================================
" Fzf 配置
" ================================================================================
nnoremap <C-s> :Rg<CR>
nnoremap <C-p> :Files<CR>

" ================================================================================
" Tig 配置
" ================================================================================
nnoremap <Leader>G :TigOpenCurrentFile<CR>
nnoremap <Leader>g :TigOpenProjectRootDir<CR>

" ================================================================================
" UltiSnips配置
" ================================================================================
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-tab>"

" ================================================================================
" Coc配置
" ================================================================================
let g:coc_global_extensions = [
            \ "coc-jedi",
            \ "coc-go",
            \ "coc-tsserver",
            \ "coc-clangd",
            \ "coc-lua",
            \ "coc-vetur",
            \ "coc-html",
            \ "coc-css",
            \ "coc-json",
            \ "coc-yaml",
            \ "coc-vimlsp"]

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <Leader>rn <Plug>(coc-rename)

" ================================================================================
" Markdown相关配置
" ================================================================================
augroup _FT_MARKDOWN
    " 清除当前group中的autocmd，防止重复包含
    autocmd!
    autocmd BufRead,BufNewFile *.{md,mkd,markdown}   set filetype=markdown
augroup END

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
    autocmd FileType python setlocal ts=4
    autocmd FileType python nnoremap <buffer> <Leader>nq :exec "norm! A # noqa"<CR>
augroup END

" ================================================================================
" Go相关配置
" ================================================================================
augroup _FT_GO
    autocmd!
    autocmd FileType go setlocal ts=4
    autocmd FileType go nmap gtj :CocCommand go.tags.add json<CR>
    autocmd FileType go nmap gty :CocCommand go.tags.add yaml<CR>
    autocmd FileType go nmap gtt :CocCommand go.tags.add toml<CR>
    autocmd FileType go nmap gtg :CocCommand go.tags.add gorm<CR>
    autocmd FileType go nmap gtx :CocCommand go.tags.clear<CR>
    autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
augroup END
