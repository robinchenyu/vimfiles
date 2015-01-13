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
autocmd BufEnter * lcd %:p:h
autocmd BufWritePost *vimrc source vimrc 
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
nnoremap <silent> <F3> :exe "vimgrep " . expand("<cword>") . " *.cpp *.c *.py *.log *.html"<CR>
nnoremap <silent> <C-F3> :exe "vimgrep " . @" . " *.cpp *.c"<CR>
nnoremap <silent> <F2> :cn<CR>
nnoremap <silent> <C-F2> :cp<CR>

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" 设置bundle
" execute pathogen#infect()
syntax on
filetype plugin indent on

set hlsearch
set autoread

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Pos:\ %l:%c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>



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
" Plugin 'vim-neatstatus'
Plugin 'ctrlp.vim'
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

" 不要菜单栏和工具栏
set go=egrL

" 自动切换目录
" set autochdir 使用autocmd实现

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
" 以当前目录
let g:ctrlp_working_path_mode = 'c'
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
" let g:ctrlp_user_command = {
"     \ 'types': {
"       \ 1: ['.git', 'cd %s && git ls-files'],
"       \ 2: ['.svn', 'cd %s && svn ls'],
"       \ }
"     \ }
" ctrlp输入记录数
let g:ctrlp_max_history = &history

let g:ctrlp_extensions = ['tag', 'buffertag']
" 忽略大小写查询
set ic

" 配置ctags和cscope 
map <C-F12> :call Do_CsTag()<CR>
map <F12> :call SwitchProject()<CR>
map <M-p> :CtrlPMRUFiles<CR>
map <M-b> :CtrlPBookmarkDir<CR>
map <M-t> :CtrlPBufTag<CR>
map <C-v>d :call SvnDirStatus()<CR>
map <C-v>= :call SvnDiffWindows()<CR>
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR>

function! FindProjDir()
    let cur_dir = getcwd()
    let myprojects = {"uep07": ".\\+7.\\+uep", "sipdll": ".\\+sipdll.Source", "uep06": ".\\+6.\\+uep", "xercesc": ".\\+src.xercesc"}

    for [key,val] in items(myprojects)
        if cur_dir =~ val
            return [key, matchstr(cur_dir, val)]
        endif
    endfor
    echo "no project"
    return ["unknown", cur_dir]
endfunction

function! SwitchProject()
    let [project_name, project_dir] = FindProjDir()

    set tags&
    execute "cs kill -1"
    if g:iswindows
        let &tags = &tags . "," . project_dir . "\\tags" 
        execute "cs add " . project_dir . "\\cscope.out"
        echo "set tags " . &tags . "cs ". project_dir . "\\cscope.out"
        
    else
        let &tags = &tags . "," . project_dir . "/tags" 
        execute "cs add " . project_dir . "/cscope.out"
    endif


endfunction

function! Do_CsTag()
    let [project_name, project_dir] = FindProjDir()

    if g:iswindows
        let tags_path = project_dir . "\\tags"
        let cscope_path = project_dir . "\\cscope.out"
        let cscope_files_path = project_dir . "\\cscope.files"
    else
        let tags_path = project_dir . "/tags"
        let cscope_path = project_dir . "/cscope.out"
        let cscope_files_path = project_dir . "/cscope.files"
    endif

    echom "project " . project_name . "dir ". project_dir ." ;tags_path: ". tags_path ." cscope_path: ". cscope_path ." cscope_files_path: ". cscope_files_path

    if filereadable(tags_path)
        let tagsdeleted=delete(tags_path)
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
        silent! execute "lcd ". project_dir ."|!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q " . project_dir ." -f " . tags_path
       if &tags !~ project_dir 
          let &tags=&tags . ",". tags_path
          echo "set tags = ". &tags
      endif 
    endif
    if(executable('cscope') && has("cscope") )
        if(g:iswindows!=1)
            silent! execute "!find ". project_dir ." -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > ". project_dir ."/cscope.files"
        else
            silent! execute "!dir ". project_dir ." /s/b *.c,*.cpp,*.h,*.java,*.cs >> ". project_dir ."\\cscope.files"
        endif
        silent! execute "lcd ". project_dir ."|!cscope -b -R "
        execute "normal :"
        if filereadable(cscope_path)
            execute "cs add ". cscope_path
        endif
    endif

endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction
