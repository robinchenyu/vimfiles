" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

if has('autocmd')
  " Remove ALL autocommands for the current group
  au!
endif

" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

if v:version < 700
  echoerr 'This _vimrc requires Vim 7 or later.'
  quit
endif

if has('multi_byte')
  " Legacy encoding is the system default encoding
  let legacy_encoding=&encoding
endif

" 快捷键设置
inoremap jk <ESC>
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>
map gf :Grep<CR>
nnoremap <silent> <F3> :Grep<CR>


" 设置bundle
" execute pathogen#infect()
syntax on
filetype plugin indent on


set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=$home/vimfiles/bundle/Vundle.vim/
" call vundle#begin()
   " alternatively, pass a path where Vundle should install plugins
   "call vundle#begin('~/some/path/here')

call vundle#begin($home . "/vimfiles/bundle")

" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'

" My bundles here:
"
" original repos on GitHub
Plugin 'c.vim'
Plugin 'taglist.vim'
"

call vundle#end()            " required
filetype plugin indent on     " required!

" # vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
set modeline

: " 设置编程间隔
" tab长度
set tabstop=4
set shiftwidth=4
set softtabstop=4
" 以空格代替tab
set expandtab

" 自动切换目录
set autochdir

" 设置主题
colo desert

" 开启语法高亮
syn on
" 默认使用clipboard寄存器*
set clipboard=unnamed

" set for ctrlp
" 设置弹出窗口样式,下方弹出，重上到下排序，
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:15,results:15'
" 回车 或者 ^t 选择
let g:ctrlp_switch_buffer = 'Et'
" 在已有netrw,help,quickfix窗口时，不重复创建窗口
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
" 在当前tab页后面创建新tab页
let g:ctrlp_tabpage_position = 'ac'
" 以当前目录和.svn目录为根目录
let b:ctrlp_working_path_mode = 'ra'
" 缓存
let g:ctrlp_use_caching = 1
" 当退出vim时，删除缓存
let g:ctrlp_clear_cache_on_exit = 1
" 缓存目录
let g:ctrlp_cache_dir = $home . '/.cache/ctrlp'
" ctrlp扫描隐藏文件
let g:ctrlp_show_hidden = 1
" 设置搜索忽略
let ctrlp_custom_ignore={
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ }
" 最多扫描文件数
let g:ctrlp_max_files = 200
" 最多扫描文件深度
let g:ctrlp_max_depth = 6
" 根据svn扫描文件
let g:ctrlp_user_command = {
    \ 'types': {
      \ 1: ['.git', 'cd %s && git ls-files'],
      \ 2: ['.svn', 'cd %s && svn ls'],
      \ }
    \ }
" ctrlp输入记录数
let g:ctrlp_max_history = &history
" 当输入<c-y>时，vertical开新文件
let g:ctrlp_open_new_file = 'v'
