if exists('g:loaded_hud')
  finish
endif
let g:loaded_hud = 1

let g:hud = extend(get(g:, 'hud', {}), {
      \ 'steps': ['▏', '▎', '▍', '▌', '▋', '▊', '▉', '█'],
      \ 'eof': '▓',
      \ 'blank': ' ',
      \ 'width': 14,
      \}, 'keep')

let s:blank = g:hud.blank
let s:steps = g:hud.steps
let s:width = g:hud.width
let s:eof = g:hud.eof

fu! Hud() abort
  let lcurr = line('.')
  let llast = line('$')

  if lcurr == 1
    return repeat(s:blank, s:width)
  elseif lcurr == llast
    return repeat(s:eof, s:width)
  endif

  let percent =  line('.') * 1.0 / line('$')

  let filled =  float2nr(percent * s:width)
  let step = float2nr(percent * s:width * len(s:steps)) % len(s:steps)
  let padding =  s:width - filled - 1

  return repeat(s:steps[-1], filled) . s:steps[step] . repeat(s:blank, padding)
endfu
