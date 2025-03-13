if exists('g:loaded_continuity')
  finish
endif
let g:loaded_continuity = 1
lua require('continuity').setup()

