" To make sure plugin is loaded only once,
" and to allow users to disable the plugin
" with a global conf.
if exists("g:do_not_load_spec_outline")
  finish
endif
let g:do_not_load_spec_outline = 1

" If this command doesn't exist, create one.
" This is the only interface for users.
if !exists(":SpecOutlineToggle")
  command SpecOutlineToggle  :call s:SpecOutlineToggle()
endif

" Default mapping is <Leader>?
map <unique> <silent> <Leader>? :SpecOutlineToggle<CR>

" Toggles SpecOutline window
function! s:SpecOutlineToggle()
  if !exists('b:quickfix_window_open')
    let b:quickfix_window_open = 0
  endif
  if b:quickfix_window_open
    call s:SpecOutlineHide()
  else
    call s:SpecOutlineShow()
  endif
endfunction

function! s:SpecOutlineShow()
  let specLines = []
  let index = 0

  " Get Current filename
  let fileName = expand('%:p')
  " Read all lines of current file and collect lines
  " which have 'it' or 'describe' or 'context'
  for line in readfile(fileName)
    let index += 1
    " Match lines starting with 'it,describe or context' followed by either of
    " (,",' or whitespace
    " and followed by a non whitespace character
    if line =~ '^\s*\(specify\|it_behaves_like\|it\|describe\|context\)\s*[("'' ]\D'
      let newLine = "\"" . fileName . "\" " .index . ": |" .line
      call add(specLines, newLine)
    endif
  endfor
  " We need a reference to the current buffer
  " because once we open the quickfix window,
  " we will be in a different buffer.
  let originalBuffer = bufname("%")

  " Push all spec outline lines to quickfix buffer
  cgetexpr specLines

  let orientation = get(g:, 'spec_outline_orientation', 'right')
  let orientation_prefix = ''

  if orientation == 'right'
    let orientation_prefix = 'vertical botright '
  elseif orientation == 'left'
    let orientation_prefix = 'vertical topleft '
  elseif orientation == 'top'
    let orientation_prefix = 'topleft '
  elseif orientation == 'bottom'
    let orientation_prefix = 'botright '
  endif

  execute orientation_prefix . "copen"
  " Distribute space equally
  wincmd =

  call s:SpecOutlineSyntax()
  call setbufvar(originalBuffer, 'quickfix_window_open', 1)
endfunction

" Just close the quickfix window
function! s:SpecOutlineHide()
  cclose
  let b:quickfix_window_open = 0
endfunction

" Beautify text in SpecOutline window
function! s:SpecOutlineSyntax()
  " Hide what's concealed.
  setlocal conceallevel=3
  " Apply conceal rules on line with cursor as well.
  setlocal concealcursor=ncv
  " Hide Filename and line no used by quickfix
  syn match HideFileNameAndLineNo "^.*|" conceal
  " Hide 'do' which appears at the end of rspec blocks
  syn match HideRubyBlock " do\s*$" conceal
  " Hide ', ->' which appears at end of jasmine blocks in coffeescript
  syn match HideCoffeeBlock ",\s*->\s*$" conceal
  " Highlight 'it', 'describe' and 'context'
  syn keyword SpecOutlineKeyword it describe context
  hi def link SpecOutlineKeyword Keyword
endfunction
