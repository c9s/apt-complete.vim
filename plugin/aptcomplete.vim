" Plugin: apt-complete.vim
" Description: provide deb package name completion.
" Version:  0.1
" Author:  Cornelius

let apt_cmd = 'apt-cache -n search '
fun! AptComplete(findstart, base) "{{{
  if a:findstart
    let start = col('.') - 1
    let line = getline('.')
    while start > 0 && line[start - 1] =~ '[0-9a-zA-Z-]' 
      let start -= 1
    endwhile
    return start
  else
    let names = split(system(printf('%s "^%s" | cut -d" " -f1 ',apt_cmd,a:base)),"\n")
    return names
  endif
endf "}}}
setlocal omnifunc=AptComplete
