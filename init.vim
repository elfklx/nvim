" The Neovim Config
" Maintainer: Luan Santos <https://github.com/luan>
" Version:    2.0

scriptencoding utf-8

" Setup user preferences
if !isdirectory(expand('<sfile>:h') . '/user')
  silent! execute '!cp -a ' . expand('<sfile>:h') . '/user.defaults ' . expand('<sfile>:h') . '/user'
endif

runtime user/before.vim
runtime update.vim " Auto-update
runtime plug.vim
runtime! lang/*.vim
runtime! include/*.vim
runtime keyboard.vim
runtime user/after.vim
runtime colorscheme.vim

" Allow project specific configuration
set exrc
set secure

" Automatically create and restore new sessions in your current working
" directory.  See https://stackoverflow.com/a/6052704
fu! SaveSess()
    execute 'Obsession ' . getcwd() . '/.session.vim'
endfunction

fu! RestoreSess()
if filereadable(getcwd() . '/.session.vim')
    execute 'so ' . getcwd() . '/.session.vim'
    if bufexists(1)
        for l in range(1, bufnr('$'))
            if bufwinnr(l) == -1
                exec 'sbuffer ' . l
            endif
        endfor
    endif
endif
endfunction

autocmd VimLeave * call SaveSess()
autocmd VimEnter * nested call RestoreSess()
