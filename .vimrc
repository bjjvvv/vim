set nocp " 非vi

let mapleader = "["
set t_Co=256

"解决编码问题
if has("multi_byte")
    " UTF-8 编码
    set encoding=utf-8
    set termencoding=utf-8
    set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1 " 编码
    if v:lang =~? '^/(zh/)/|/(ja/)/|/(ko/)'
        set ambiwidth=double
    endif
    if has("win32")
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        language messages zh_CN.utf-8
    else
        "Ubuntu 14.04下GVIM的字体间距过宽
        set guifont=Meslo\ LG\ S\ DZ\ for\ Powerline\ 12
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif


"----------------------------------------Voudle
if filereadable(expand("~/.vim/.vimrc.bundles"))
source ~/.vim/.vimrc.bundles
endif
"----------------------------------------Voudle


"----------------------------------------显示
syntax enable
set background=dark
colorscheme solarized " 设置主题
set laststatus=2 " 状态栏
set ruler " 标尺 
set number " 行号
syntax enable " 开启
syntax on " 语法高亮
set hls " 匹配高亮
set showcmd " 显示当前输入命令


"----------------------------------------缩进
filetype plugin indent on
set sw=4 " 缩进4个空格
set ts=4 " tab为4个字符
set et " tab替换为空格
set smarttab " 删除tab的4个空格
set nospell " 拼写检查
set wrap
set tw=78 " 设置光标超过78的时候折行
set lbr " 不在单词中间折断
set fo+=mB " 汉字断行处理
set backspace=start,eol,indent" 删除行尾，回车，缩进
set whichwrap=b,s,h,l,<,>,[,] " 支持左右跨行移动

" set sm " 括号配对
set cin " 打开c/c++自动缩进
" set ai " 自动缩进

" 基于缩进或语法进行代码折叠
set foldmethod=indent
"set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable


"---------------------------------------map



" 来自 Vim 实用技巧
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%' " ex命令中%%转换为当前缓存文件目录路径
" runtime macros/matchit.vim
set pastetoggle=<F5>
set hidden " 缓存切换位保存不提醒
if has("autocmd")
    autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
endif
nnoremap <silent> <C-l>  :<C-u>nohlsearch<Cr><C-l>h " 清屏同时清除高亮
set incsearch " 增量搜索（实时匹配）
