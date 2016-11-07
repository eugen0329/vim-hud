if exists('g:loaded_hud')
  finish
endif
let g:loaded_hud = 1

if !exists('g:hud')
  let g:hud = {}
endif

" If {steps} given, assign last step char to {eof} by default
if has_key(g:hud, 'steps')
  let s:steps = g:hud.steps
  let s:eof = get(g:hud, 'eof', s:steps[-1])
elseif has('multi_byte') && (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8')
  let s:steps = ['▏', '▎', '▍', '▌', '▋', '▊', '▉', '█']
  let s:eof = get(g:hud, 'eof', '▓')
else
  let s:steps = ['-', '=', '#']
  let s:eof = get(g:hud, 'eof', '$')
endif

let s:blank = get(g:hud, 'blank', ' ')
let s:width = get(g:hud, 'width', 14)

fu! Hud() abort
  let lcurr = line('.')
  let llast = line('$')

  if lcurr == 1
    return repeat(s:blank, s:width)
  elseif lcurr == llast
    return repeat(s:eof, s:width)
  endif

  let percent =  line('.') * 1.0 / line('$')

  let nfilled =  float2nr(percent * s:width)
  let step = float2nr(percent * s:width * len(s:steps)) % len(s:steps)
  let padding =  s:width - nfilled - 1

  return repeat(s:steps[-1], nfilled) . s:steps[step] . repeat(s:blank, padding)
endfu
