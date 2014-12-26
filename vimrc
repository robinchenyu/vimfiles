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
execute pathogen#infect()
syntax on
filetype plugin indent on


set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=$home/vimfiles/bundle/Vundle.vim/
call vundle#rc($home . "/vimfiles/bundle")

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My bundles here:
"
" original repos on GitHub
Bundle 'c.vim'
Bundle 'taglist.vim'
"

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

" 设置主题
colo desert

" 开启语法高亮
syn on
" 默认使用clipboard寄存器*
set clipboard=unnamed
