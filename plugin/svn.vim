" made by Michael Scherer ( misc@mandrake.org )
" $Id: svn.vim 282 2005-01-31 21:24:55Z misc $
" 
" 2004-09-13 : Lukas Ruf ( lukas.ruf@lpr.ch )
"   - re-ordered windows
"   - set focus on svn-commit.tmp (that's where one has to write)
"   - set buffer type of new window to 'nofile' to fix 'TODO'
"
" 2005-01-31 : 
"   - autoclose on exit, thanks to Gintautas Miliauskas ( gintas@akl.lt )
"     and tips from Marius Gedminas ( mgedmin@b4net.lt )
"     
" 2005-02-08 :
"   - rewrite in pure vim function, from Kyosuke Takayama ( support@mc.neweb.ne.jp )
"   - simplified installation instruction, from Marius Gedminas ( mgedmin@b4net.lt )   
"
" 2005-02-11 : 
"   - reindent with space, asked by Marius Gedminas ( mgedmin@b4net.lt )   
"   - do not preview if no file are diffed, patch from Marius Gedminas.
"  
" to use it, place it in ~/.vim/ftplugins ( create the directory if it doesn't exist ) 
let s:fileline = 1
function! SvnDirStatus()
    exec ":tabnew! svn.status"
    silent! setlocal previewwindow bufhidden=delete nobackup noswf nobuflisted nowrap buftype=nofile 

    set modifiable
    exec ":1,$d" 
    call setline(1, getcwd())
    call setline(2, repeat('-', 80))
    call setline(3, "=: diff, <Space>: select, <leader>v: commit, <leader>u: revert")
    call setline(4, "<leader>h: hide unversion")
    call setline(5, repeat('-', 80))
    let s:fileline = 7

    exec ":$;r !svn status ."
    setlocal nomodifiable
    map <buffer> = :call SvnDiffWindows()<CR>
    map <buffer> <Space> :call SvnActive()<CR>
    map <buffer> <leader>v :call SvnCommit()<CR>
    map <buffer> <leader>u :call SvnRevert()<CR>
    map <buffer> <leader>h :call SvnHideUnVersion()<CR>
endfunction

function! SvnRevert()
    let list_of_files = SvnGetListFiles('^*M ')

    if list_of_files == ""
        echo "Please select a file"
        return 
    endif
    exec ":!svn revert " . list_of_files . "\n"
    echo ":!svn revert " . list_of_files

    let i = s:fileline
    
    set modifiable
    while i <= line('$')
        let line = getline(i)
        " echo "line: " . line . " pattern: " . a:ptn . " called: " . matchstr(line, a:ptn) 
        if line !~ "^* "
            let newline = substitute(line, '\v^*M (.*)$', '= \1', '')
            call setline(i, newline)
        endif

        let i = i + 1
    endwhile

    setlocal nomodifiable
endfunction

function! SvnHideUnVersion()
    let i = s:fileline " for read
    let j = s:fileline " for write

    setlocal modifiable

    while i <= line('$')
        let line = getline(i)
        " echo "line: " . line . " pattern: " . a:ptn . " called: " . matchstr(line, a:ptn) 
        if line !~ "^[?D ] "
            call setline(j, line)
            let j = j + 1
        endif

        let i = i + 1
    endwhile

    while j < i
        call setline(j, "")
        let j += 1
    endwhile

    setlocal nomodifiable
endfunction

function! SvnCommit()
    let list_of_files = SvnGetListFiles('^*M ')

    if list_of_files == ""
        echo "Please select a file"
        return 
    endif

    let desc = inputdialog("Commit Summary:")
    if desc == ""
        echo "Please input a messge for commit"
        return
    endif

    exec ":!svn commit -m " . desc . " " . list_of_files . "\n"
    echo ":!svn commit -m " .desc . " " . list_of_files
    call SvnDirStatus()
endfunction

function! SvnActive()
    let line = getline('.')
    if line =~ '^M'
        let newline = substitute(line, '\v^M (.*)$', '*M\1', '')
    else 
        if line =~ '^*M'
            echo "1"
            let newline = substitute(line, '\v*M(.*)$', 'M \1', '')
        else
            echo "2"
            let newline = line
        endif
    endif
    setlocal modifiable
    call setline('.', newline)
    setlocal nomodifiable

endfunction

function! SvnGetListFiles(ptn)
    let i = 0
    let list_of_files = ''

    while i <= line('$')
        let line = getline(i)
        " echo "line: " . line . " pattern: " . a:ptn . " called: " . matchstr(line, a:ptn) 
        if line =~ a:ptn
            let file = substitute(line, '\v' . a:ptn . '\s*(.*)\s*$', '\1', '')
            let list_of_files = list_of_files . ' '.file
            " echo "get file: " . file
        endif

        let i = i + 1
    endwhile
    return list_of_files
endfunction


function! SvnDiffWindows()
    let list_of_files = SvnGetListFiles("^*M ")

    if list_of_files == ""
        return 
    endif
    
    only!
    vnew
    silent! setlocal ft=diff previewwindow bufhidden=delete nobackup noswf nobuflisted nowrap buftype=nofile
    call setline(1, 'normal :r!svn diff ' . list_of_files . "\n")
    exe 'normal :$;r!svn diff ' . list_of_files . "\n"
    setlocal nomodifiable
    goto 1
    redraw!
    wincmd R
    wincmd p
    redraw!
endfunction

map <leader>vv :!svn ci -m "" %<left><left><left>
map <leader>vs :call SvnDirStatus()<cr>
