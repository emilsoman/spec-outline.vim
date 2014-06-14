" recognize spec files
if has("autocmd")
  autocmd BufNewFile,BufRead *[s|S]pec* set filetype+=.foo
endif
