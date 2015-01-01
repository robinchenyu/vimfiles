" -----------------------------------------------------------------------------
"  < ÅĞ¶Ï²Ù×÷ÏµÍ³ÊÇ·ñÊÇ Windows »¹ÊÇ Linux >
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
"  < ÅĞ¶ÏÊÇÖÕ¶Ë»¹ÊÇ Gvim >
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

" ¿ì½İ¼üÉèÖÃ
inoremap jk <ESC>
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>
nnoremap <silent> <F3> :exe "vimgrep " . @" . " *.cpp *.c"<CR>
nnoremap <silent> <F2> :cn<CR>
nnoremap <silent> <C-F2> :cp<CR>



" ÉèÖÃbundle
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
"

call vundle#end()            " required
filetype plugin indent on     " required!

" # vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
set modeline

: " ÉèÖÃ±à³Ì¼ä¸ô
" tab³¤¶È
set tabstop=4
set shiftwidth=4
set softtabstop=4
" ÒÔ¿Õ¸ñ´úÌætab
set expandtab

" ÉèÖÃÖ÷Ìâ
colo desert

" ¿ªÆôÓï·¨¸ßÁÁ
syn on
" Ä¬ÈÏÊ¹ÓÃclipboard¼Ä´æÆ÷*
set clipboard=unnamed

" set for ctrlp
" ÉèÖÃµ¯³ö´°¿ÚÑùÊ½,ÏÂ·½µ¯³ö£¬ÖØÉÏµ½ÏÂÅÅĞò£¬
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:15,results:15'
" »Ø³µ »òÕß ^t Ñ¡Ôñ
let g:ctrlp_switch_buffer = 'Et'
" ÔÚÒÑÓĞnetrw,help,quickfix´°¿ÚÊ±£¬²»ÖØ¸´´´½¨´°¿Ú
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
" ÔÚµ±Ç°tabÒ³ºóÃæ´´½¨ĞÂtabÒ³
let g:ctrlp_tabpage_position = 'ac'
" ÒÔµ±Ç°Ä¿Â¼ºÍ.svnÄ¿Â¼Îª¸ùÄ¿Â¼
let b:ctrlp_working_path_mode = 'ra'
" »º´æ
let g:ctrlp_use_caching = 1
" µ±ÍË³övimÊ±£¬É¾³ı»º´æ
let g:ctrlp_clear_cache_on_exit = 1
" »º´æÄ¿Â¼
let g:ctrlp_cache_dir = $home . '/.cache/ctrlp'
" ctrlpÉ¨ÃèÒş²ØÎÄ¼ş
let g:ctrlp_show_hidden = 1
" ÉèÖÃËÑË÷ºöÂÔ
let ctrlp_custom_ignore={
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ }
" ×î¶àÉ¨ÃèÎÄ¼şÊı
let g:ctrlp_max_files = 200
" ×î¶àÉ¨ÃèÎÄ¼şÉî¶È
let g:ctrlp_max_depth = 6
" ¸ù¾İsvnÉ¨ÃèÎÄ¼ş
let g:ctrlp_user_command = {
    \ 'types': {
      \ 1: ['.git', 'cd %s && git ls-files'],
      \ 2: ['.svn', 'cd %s && svn ls'],
      \ }
    \ }
" ctrlpÊäÈë¼ÇÂ¼Êı
let g:ctrlp_max_history = &history

" ºöÂÔ´óĞ¡Ğ´²éÑ¯
set ic

=======
" -----------------------------------------------------------------------------
" < åˆ¤æ–­æ“ä½œç³»ç»Ÿæ˜¯å¦æ˜¯ Windows è¿˜æ˜¯ Linux >
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
" < åˆ¤æ–­æ˜¯ç»ˆç«¯è¿˜æ˜¯ Gvim >
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
" å¿«æ·é”®è®¾ç½®
inoremap jk <ESC>
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>
nnoremap <silent> <F3> :exe "vimgrep " . @" . " *.cpp *.c"<CR>
nnoremap <silent> <F2> :cn<CR>
nnoremap <silent> <C-F2> :cp<CR>
" è®¾ç½®bundle
" execute pathogen#infect()
syntax on
filetype plugin indent on
set nocompatible " be iMproved
filetype off " required!
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
call vundle#end() " required
filetype plugin indent on " required!
" # vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
set modeline
: " è®¾ç½®ç¼–ç¨‹é—´éš”
" tabé•¿åº¦
set tabstop=4
set shiftwidth=4
set softtabstop=4
" ä»¥ç©ºæ ¼ä»£æ›¿tab
set expandtab
" è®¾ç½®ä¸»é¢˜
colo desert
" å¼€å¯è¯­æ³•é«˜äº®
syn on
" é»˜è®¤ä½¿ç”¨clipboardå¯„å­˜å™¨*
set clipboard=unnamed
" set for ctrlp
" è®¾ç½®å¼¹å‡ºçª—å£æ ·å¼,ä¸‹æ–¹å¼¹å‡ºï¼Œé‡ä¸Šåˆ°ä¸‹æ’åºï¼Œ
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:15,results:15'
" å›è½¦ æˆ–è€… ^t é€‰æ‹©
let g:ctrlp_switch_buffer = 'Et'
" åœ¨å·²æœ‰netrw,help,quickfixçª—å£æ—¶ï¼Œä¸é‡å¤åˆ›å»ºçª—å£
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
" åœ¨å½“å‰tabé¡µåé¢åˆ›å»ºæ–°tabé¡µ
let g:ctrlp_tabpage_position = 'ac'
" ä»¥å½“å‰ç›®å½•å’Œ.svnç›®å½•ä¸ºæ ¹ç›®å½•
let b:ctrlp_working_path_mode = 'ra'
" ç¼“å­˜
let g:ctrlp_use_caching = 1
" å½“é€€å‡ºvimæ—¶ï¼Œåˆ é™¤ç¼“å­˜
let g:ctrlp_clear_cache_on_exit = 1
" ç¼“å­˜ç›®å½•
let g:ctrlp_cache_dir = $home . '/.cache/ctrlp'
" ctrlpæ‰«æéšè—æ–‡ä»¶
let g:ctrlp_show_hidden = 1
" è®¾ç½®æœç´¢å¿½ç•¥
let ctrlp_custom_ignore={
\ 'dir': '\v[\/]\.(git|hg|svn)$',
\ 'file': '\v\.(exe|so|dll)$',
\ }
" æœ€å¤šæ‰«ææ–‡ä»¶æ•°
let g:ctrlp_max_files = 200
" æœ€å¤šæ‰«ææ–‡ä»¶æ·±åº¦
let g:ctrlp_max_depth = 6
" æ ¹æ®svnæ‰«ææ–‡ä»¶
let g:ctrlp_user_command = {
\ 'types': {
\ 1: ['.git', 'cd %s && git ls-files'],
\ 2: ['.svn', 'cd %s && svn ls'],
\ }
\ }
" ctrlpè¾“å…¥è®°å½•æ•°
let g:ctrlp_max_history = &history
" å¿½ç•¥å¤§å°å†™æŸ¥è¯¢
set ic
