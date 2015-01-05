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
autocmd BufEnter * lcd %:p:h
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
nnoremap <silent> <F3> :exe "vimgrep " . expand("<cword>") . " *.cpp *.c"<CR>
nnoremap <silent> <C-F3> :exe "vimgrep " . @" . " *.cpp *.c"<CR>
nnoremap <silent> <F2> :cn<CR>
nnoremap <silent> <C-F2> :cp<CR>



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
Plugin 'vim-neatstatus'
Plugin 'ctrlp.vim'
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

" ��Ҫ�˵����͹�����
set go=egrL

" �Զ��л�Ŀ¼
" set autochdir ʹ��autocmdʵ��

" ��������
colo desert

" �����﷨����
syn on
" Ĭ��ʹ��clipboard�Ĵ���*
set clipboard=unnamed

" set for ctrlp
" ���õ���������ʽ,�·����������ϵ�������
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:15,results:15'
" �س� ���� ^t ѡ��
let g:ctrlp_switch_buffer = 'Et'
" ������netrw,help,quickfix����ʱ�����ظ���������
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
" �ڵ�ǰtabҳ���洴����tabҳ
let g:ctrlp_tabpage_position = 'ac'
" �Ե�ǰĿ¼
let g:ctrlp_working_path_mode = 'c'
" ����
let g:ctrlp_use_caching = 1
" ���˳�vimʱ��ɾ������
let g:ctrlp_clear_cache_on_exit = 1
" ����Ŀ¼
let g:ctrlp_cache_dir = $home . '/.cache/ctrlp'
" ctrlpɨ�������ļ�
let g:ctrlp_show_hidden = 1
" ������������
let ctrlp_custom_ignore={
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ }
" ���ɨ���ļ���
let g:ctrlp_max_files = 200
" ���ɨ���ļ����
let g:ctrlp_max_depth = 6
" ����svnɨ���ļ�
" let g:ctrlp_user_command = {
"     \ 'types': {
"       \ 1: ['.git', 'cd %s && git ls-files'],
"       \ 2: ['.svn', 'cd %s && svn ls'],
"       \ }
"     \ }
" ctrlp�����¼��
let g:ctrlp_max_history = &history

let g:ctrlp_extensions = ['tag', 'buffertag']
" ���Դ�Сд��ѯ
set ic

" ����ctags��cscope 
map <F12> :call Do_CsTag()<CR>
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR>
function! Do_CsTag()
    let dir = getcwd()
    let proj_dir = strpart(dir, 0, 2) . finddir("uep", ".;")
    let tags_path = strpart(dir, 0, 2) . findfile("tags", ".;")
    let cscope_path = strpart(dir, 0, 2) . findfile("cscope.out", ".;")
    let cscope_files_path = strpart(dir, 0, 2) . findfile("cscope.files", ".;")

    let s:all_projects = ["uep", "sipphone", "vim74"]
    
    for prj in s:all_projects
        if finddir(prj, ".;")
            let s:project = prj
        endif
    endfor

    if len(proj_dir) <= len(strpart(dir, 0, 2))
        let proj_dir = dir
    endif
    if len(tags_path) == 0
        let tags_path = proj_dir . "/tags"
        if g:iswindows
            let tags_path = proj_dir . "\tags"
        endif
    endif
    if len(cscope_path) == 0
        if g:iswindows
            let cscope_path = proj_dir . "\cscope.out"
            let cscope_files_path = proj_dir . "\cscope.files"
        else
            let cscope_path = proj_dir . "/cscope.out"
            let cscope_files_path = proj_dir . "/cscope.files"
        endif
    endif

    echom "project " . s:project . "dir ". dir .";proj_dir: ". proj_dir ." ;tags_path: ". tags_path ." cscope_path: ". cscope_path ." cscope_files_path: ". cscope_files_path

    if filereadable(tags_path)
        if(g:iswindows==1)
            let tagsdeleted=delete(tags_path)
        else
            let tagsdeleted=delete(tags_path)
        endif
        if(tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if has("cscope")
        silent! execute "cs kill -1"
    endif
    if filereadable(cscope_files_path)
        let csfilesdeleted=delete(cscope_files_path)
        if(csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            return
        endif
    endif
    if filereadable(cscope_path)
        let csoutdeleted=delete(cscope_path)
        if(csoutdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
            return
        endif
    endif
    if(executable('ctags'))
        "silent! execute "!ctags -R --c-types=+p --fields=+S *"
        silent! execute "lcd ". proj_dir ."|!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q " . proj_dir ." -f " . tags_path
    endif
    if(executable('cscope') && has("cscope") )
        if(g:iswindows!=1)
            silent! execute "!find ". proj_dir ." -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > ". proj_dir ."/cscope.files"
        else
            silent! execute "!dir ". proj_dir ." /s/b *.c,*.cpp,*.h,*.java,*.cs >> ". proj_dir ."\\cscope.files"
        endif
        silent! execute "lcd ". proj_dir ."|!cscope -b -R "
        execute "normal :"
        if filereadable(cscope_path)
            execute "cs add ". cscope_path
        endif
    endif

endfunction
