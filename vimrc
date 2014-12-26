" -----------------------------------------------------------------------------
"  < �жϲ���ϵͳ�Ƿ��� Windows ���� Linux >
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
"  < �ж����ն˻��� Gvim >
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

" ��ݼ�����
inoremap jk <ESC>
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>
map gf :Grep<CR>
nnoremap <silent> <F3> :Grep<CR>


" ����bundle
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

: " ���ñ�̼��
" tab����
set tabstop=4
set shiftwidth=4
set softtabstop=4
" �Կո����tab
set expandtab

" ��������
colo desert

" �����﷨����
syn on
" Ĭ��ʹ��clipboard�Ĵ���*
set clipboard=unnamed
