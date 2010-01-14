" Plugin: apt-complete.vim
" Description: provide deb package name completion.
" Version: 0.14
" Author:  Cornelius
let g:apt_cmd = 'apt-cache -n search '
fun! AptComplete(findstart, base) "{{{
  if a:findstart
    let start = col('.') - 1
    let line = getline('.')
    while start > 0 && line[start - 1] =~ '[0-9a-zA-Z-]' 
      let start -= 1
    endwhile
    return start
  else
    let list = system(printf('%s "^%s" | cut -d" " -f1 ',g:apt_cmd,a:base))
    return sort(split(list,"\n"))
  endif
endf "}}}

fun! s:Enable()
  let s:old = &omnifunc
  setlocal completefunc=AptComplete
endf

fun! s:Disable()
  exec 'setlocal completefunc='.s:old
endf

fun! s:Toggle()
  if &completefunc == 'AptComplete'
    cal s:Disable()
  else
    cal s:Enable()
  endif
endf

fun! s:defopt(name,value)
  if ! exists('a:name')
    let {a:name} = a:value
  endif
endf
cal s:defopt('g:EnableAptComplete',0)

com! AptCompleteOn     :cal s:Enable()
com! AptCompleteOff    :cal s:Disable()
com! AptCompleteToggle :cal s:Toggle()
