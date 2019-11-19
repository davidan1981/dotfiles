" Vim color file
" Maintainer:   David An (rockalizer@gmail.com)
" Last Change:  January 2015 - 0.2
" URL: 

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

"set background=dark "light     "or dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="davidan"

hi Normal       ctermfg=White      ctermbg=none
hi NonText      ctermfg=DarkGray   ctermbg=none
hi Statement    ctermfg=Green      ctermbg=none
hi Comment      ctermfg=Magenta    ctermbg=none         cterm=italic    term=italic
hi Constant     ctermfg=Red        ctermbg=none
hi Identifier   ctermfg=Cyan       ctermbg=none
hi Type         ctermfg=DarkGreen  ctermbg=none
hi Folded       ctermfg=DarkGreen  ctermbg=none         cterm=underline term=none
hi Special      ctermfg=Magenta    ctermbg=none
hi PreProc      ctermfg=Lightgray  ctermbg=none         cterm=bold      term=bold
hi Scrollbar    ctermfg=Blue       ctermbg=none
hi Cursor       ctermfg=white      ctermbg=none
hi ErrorMsg     ctermfg=Red        ctermbg=none         cterm=bold      term=bold
hi WarningMsg   ctermfg=DarkYellow ctermbg=none
hi VertSplit    ctermfg=23         ctermbg=23
hi Directory    ctermfg=Cyan       ctermbg=DarkBlue
hi Visual       ctermfg=White      ctermbg=DarkGray 
hi Title        ctermfg=White      ctermbg=DarkBlue
hi Search       ctermfg=Black      ctermbg=DarkYellow
hi StatusLine   term=bold          cterm=bold,underline ctermfg=Yellow ctermbg=23
hi StatusLineNC term=bold          cterm=bold,underline ctermfg=White ctermbg=23
hi LineNr       term=bold          cterm=bold           ctermfg=23   ctermbg=none
hi TabLineFill  ctermfg=23         ctermbg=23
hi TabLine      ctermfg=Gray       ctermbg=23
hi TabLineSel   ctermfg=White      ctermbg=35
