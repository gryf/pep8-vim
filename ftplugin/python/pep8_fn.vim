" File: pep8_fn.vim
" Author: Roman 'gryf' Dobosz (gryf73 at gmail.com)
" Version: 1.2
" Last Modified: 2016-12-10
" Description: {{{
"
" Overview
" --------
" This plugin provides functionality to static checks for python files
" regarding PEP8 guidance[1] as ":Pep8" command.
"
" This function does not use pep8[2] command line utility, but relies on pep8
" module.
"
" This script uses python, therefore VIm should be compiled with python
" support. You can check it by issuing ":version" command, and search for
" "+python" or "+python3" inside features list.
"
" Couple of ideas was taken from pyflakes.vim[3] plugin.
"
" Installation
" ------------
" 1. Copy the pep8_fn.vim file to the $HOME/.vim/ftplugin/python or
"    $HOME/vimfiles/ftplugin/python or $VIM/vimfiles/ftplugin/python
"    directory. If python directory doesn't exists, it should be created.
"    Refer to the following Vim help topics for more information about Vim
"    plugins:
"       :help add-plugin
"       :help add-global-plugin
"       :help runtimepath
" 2. It should be possible to import pep8 from python interpreter (it should
"    report no error):
"    >>> import pep8
"    >>>
"    If there are errors, install pep8 first. Simplest way to do it, is to
"    use easy_install[4] shell command as a root:
"    # easy_install pep8
" 3. Restart Vim.
" 4. You can now use the ":Pep8" which will examine current python buffer
"    and open quickfix buffer with errors if any.
"
" [1] http://www.python.org/dev/peps/pep-0008/
" [2] http://pypi.python.org/pypi/pep8
" [3] http://www.vim.org/scripts/script.php?script_id=2441
" [4] http://pypi.python.org/pypi/setuptools
"
" }}}

let s:plugin_path = expand('<sfile>:p:h', 1)

if exists(":Pep8")
    finish " only load once
endif

if !exists("g:pep8_exclude")
    let g:pep8_exclude = []
endif


function! s:SetPython(msg)
    if !exists('g:_python')
        if has('python')
            let g:_python = {'exec': 'python', 'file': 'pyfile'}
        elseif has('python3')
            let g:_python = {'exec': 'python3', 'file': 'py3file'}
        else
            echohl WarningMsg|echomsg a:msg|echohl None
            finish
        endif
    endif
endfunction


function! s:LoadPep8()
    if !exists('g:pep8_fn_initialized ')
        call s:SetPython("Pep8 command cannot be initialized - no python "
                    \ . "support compiled in vim.")
        execute g:_python['file'] . ' ' . s:plugin_path . '/pep8_fn.py'
        let g:pep8_fn_initialized = 1
    endif
endfunction

call s:LoadPep8()

function s:Pep8()
    execute g:_python['exec'] . ' VImPep8().run()'
endfunction
command Pep8 call s:Pep8()
