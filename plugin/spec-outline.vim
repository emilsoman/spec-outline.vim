" To make sure plugin is loaded only once,
" and to allow users to disable the plugin
" with a global conf.
if exists("g:do_not_load_spec_outline")
  finish
endif
let g:do_not_load_spec_outline = 1

if !exists(":SpecOutlineToggle")
  command Correct  :call s:SpecOutlineToggle
endif

map <unique> <Leader>?  SpecOutlineToggle

" recognize spec files
"if has("autocmd")
  "autocmd BufNewFile,BufRead *[s|S]pec* set filetype+=.foo
"endif

function! s:SpecOutlineToggle()
  if b:quickfix_window_open
    s:SpecOutlineHide()
  else
    s:SpecOutlineShow()
  endif
endfunction

function! s:SpecOutlineShow()
  for line in readfile(expand('%:p'))
    if line =~ '^\s*[it|describe]' | echo line | endif
  endfor
  let b:quickfix_window_open = 1
endfunction

function! s:SpecOutlineHide()
  let b:quickfix_window_open = 0
endfunction
