set nocp " 非vi

let mapleader = "\\"
lef g:mapleader = "\\"
set t_Co=256
set path=.,/usr/include,**

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

"-------------------------------语法
syntax enable
syntax enable " 开启
syntax on " 语法高亮
"---------------------------------------

"----------------------------------------显示
colorscheme solarized " 设置主题
set background=dark
set cursorcolumn
set cursorline
set hls " 匹配高亮
set incsearch " 增量搜索（实时匹配）
set laststatus=2 " 状态栏
set number " 行号
set number " 行号
"set relativenumber
set ruler " 标尺
set showcmd " 显示当前输入命令
" set scrolloff=8 " 屏幕上下保留
" 清屏同时清除高亮
nnoremap <silent> <C-l>  :<C-u>nohlsearch<Cr><C-l>
"------------------------------------

"----------------------------------------缩进
filetype plugin indent on
set sw=4 " 缩进4个空格
set ts=4 " tab为4个字符
set et " tab替换为空格
set smarttab " 删除tab的4个空格
set nospell " 拼写检查
set wrap
set nolbr
" set tw=78 " 设置光标超过78的时候折行
" set lbr " 不在单词中间折断
" set fo+=mB " 汉字断行处理
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
"---------------------------------------


"---------------------------------------map
" 用空格来当mapleader
map <Space> <Leader>
" quick switch background color between dark and light
map  <silent> <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
" 使 <C-p> <C-n> 支持历史过滤
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" ex命令中%%转换为当前缓存文件目录路径
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
nnoremap  <leader>cn  :<C-u>cnext<Cr> " quicklist next
nnoremap  <leader>cp  :<C-u>cprevious<Cr> " quicklist previous
"---------------------------


"-------------------------------实用
set pastetoggle=<F5>
set ignorecase " 忽略忽略大小写
set smartcase " 和 ignorecase 一起智能
set history=200
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.py[oc]     " MacOSX/Linux
"-------------------------------------

"-------------------autocmd
" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
"-------------------------------------

"------------------------来自《Vim 实用技巧》
"runtime macros/matchit.vim
set hidden " 缓存切换位保存不提醒
if has("autocmd")
    autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
endif
" :Qargs 将quickfix 列表中的文件加入 args 列表中
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let bufnr = quickfix_item['bufnr']
    " Lines without files will appear as bufnr=0
    if bufnr > 0
      let buffer_numbers[bufnr] = bufname(bufnr)
    endif
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" makes * and # work on visual mode too.
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" recursively vimgrep for word under cursor or selection if you hit leader-star
nmap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
vmap <leader>* :<C-u>call <SID>VSetSearch('/')<CR>:execute 'noautocmd vimgrep /' . @/ . '/ **'<CR>

"-------------------------------------
