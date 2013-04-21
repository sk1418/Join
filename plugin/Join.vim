" Join    : a better (hopefully) :Join command in Vim
" Author  : Kai Yuan <kent.yuan@gmail.com>
" Version : 1.0.0
" License: {{{
"Copyright (c) 2013 Kai Yuan
"Permission is hereby granted, free of charge, to any person obtaining a copy of
"this software and associated documentation files (the "Software"), to deal in
"the Software without restriction, including without limitation the rights to
"use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
"the Software, and to permit persons to whom the Software is furnished to do so,
"subject to the following conditions:
"
"The above copyright notice and this permission notice shall be included in all
"copies or substantial portions of the Software.
"
"THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
"IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
"FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
"COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
"IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
"CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
if exists("g:loaded_Join") || &cp
  finish
endif

let g:loaded_Join                = 1
let s:FLAGS                      = ['k','r'] "available flags
let g:Join_debug                 = 0

"message dictionary
let s:errMsgsDict                = {'err_arg_sep': '[JoinErr:ARG] Invalid Separator'}
let s:errMsgsDict['err_arg_num'] = '[JoinErr:ARG] Invalid number of arguments'
let s:errMsgsDict['err_arg_cf']  = '[JoinErr:ARG] Argument Count or Flags is invalid'

"------------------------------------
" Do the join logic here
"------------------------------------
fun! <SID>DoJoin(sep, bang, count, flag, first, last)
    if g:Join_debug"{{{
        echom '---------------------'
        echom 'parsed sep:'   . a:sep
        echom 'bang:'        . a:bang
        echom 'input count:' . a:count
        echom 'input flags'  . a:flag
        echom '---------------------'
    endif"}}}
    let cnt = a:count	
    
    "flags
    let joinRev  = stridx(a:flag, 'r') >= 0
    let joinKeep = stridx(a:flag, 'k') >= 0

    if a:first == a:last
        let cnt = cnt == 0 ? 1 : cnt
        "a:first and a:last are same
        let jbegin = cnt > 0 ? a:first : a:first + ((cnt + 1)<0?cnt+1:cnt)
        let jend   = cnt > 0 ? (cnt > 1 ? a:first + cnt - 1:a:first + cnt): a:first
    else " user inputed a range > 1 line
        if cnt == 0 "without count 
            let jbegin = a:first
            let jend   = a:last
        elseif cnt > 0 "with positive count
            let jbegin = a:last
            let jend   = jbegin + (cnt==1?1:cnt -1)
        else " negative count !! could be confusing, need explain in doc 
            let jend   = a:first
            let jbegin = (a:first + ((cnt+1)<0?cnt+1:cnt) )
        endif
    endif
    "
    if g:Join_debug"{{{
        echom '---------------------'
        echom 'calculated firstline:'.jbegin
        echom 'calculated lastline:' . jend
        echom 'join keep :' . joinKeep
        echom 'join rev :' . joinRev
        echom '---------------------'
    endif"}}}
    
    
    let jbegin = jbegin < 0 ? 0 : jbegin
    let jend = jend >= line('$') ? line('$') : jend
    
    "now load lines
    let lines = getline(jbegin, jend)

    if !a:bang  "without bang, trim lines
        call map(lines, "substitute(v:val, '^\\s\\+\\|\\s\\$','','g')")
    endif
    
    if !joinKeep
        "remove lines
        execute jbegin . ',' . jend . 'd'
        call append(jbegin>0 ? jbegin-1 : 0, join(joinRev?reverse(lines):lines, a:sep))	
    else
        if cnt>=0
            call setline(jbegin, join(joinRev?reverse(lines):lines, a:sep))
        else
            call setline(jend, join(joinRev?reverse(lines):lines, a:sep))
        endif

    endif
    
endf

"------------------------------------
"check if an input is Count argument
"------------------------------------
fun! <SID>IsCount(inputCount)
    return a:inputCount =~ '^-\?[1-9]\d*$'
endf

"------------------------------------
"check if an input string is flags argument
"------------------------------------
fun! <SID>IsFlag(inputFlags)
    let flagReg = '['. join(s:FLAGS,'') .']'
    if empty(a:inputFlags) || len(a:inputFlags) > len(s:FLAGS)
        return 0
    else
        return empty(substitute(a:inputFlags,flagReg, '','g'))
    endif
endf



"------------------------------------
" this function is responsible to parse user inputs, and return parted
" arguments in a dictionary. If parsing error occured, exception will be thrown
" argstr should follow format [sep] [count] [flags]
" for example 'I am sep' 20 kr
"------------------------------------
fun! <SID>ParseArgs(argstr)
    let rest  = a:argstr
    let c     = 0
    let sep   = " "
    let flags = ""

    "first check sep 
    if a:argstr[0] =~ "['\"]"
        let sepRegex = "\\v^(['\"]).*(\\\\)@<!\\1( |$)@="
        try
            let sepInput = matchstr(a:argstr,sepRegex,0)
        catch /.*/
            throw 'err_arg-sep'
        endtry

        if empty(sepInput)
            throw 'err_arg_sep'
        else
            let rest = strpart(rest, len(sepInput))
            let sep  = eval(sepInput)
        endif
    endif

    let rest   = substitute(rest,' \+', " ","g")
    let cfList = split(rest, " ") "count flag list
    let ln     = len(cfList)
    if ln > 2
        throw 'err_arg_num'
    elseif ln == 1
        if s:IsCount(cfList[0])
            let c     = cfList[0]
        elseif s:IsFlag(cfList[0])
            let flags = cfList[0]
        else
            throw 'err_arg_cf'
        endif
    elseif  ln == 2 
        if s:IsCount(cfList[0]) && s:IsFlag(cfList[1])
            let c     = cfList[0]
            let flags = cfList[1]
        elseif s:IsCount(cfList[1]) && s:IsFlag(cfList[0])
            let c     = cfList[1]
            let flags = cfList[0]
        else
            throw 'err_arg_cf'
        endif
    endif

    return {'sep':sep, 'count':c, 'flags':flags}
endf


fun! <SID>Join(argstr, bang) range
    try
        let args = s:ParseArgs(a:argstr)
    catch /^err/
        call s:ShowErrMsg(v:exception)
        return
    endtry	

    let args['first'] = a:firstline
    let args['last']  = a:lastline
    let args['bang']  = a:bang
    call s:DoJoin( args['sep'], args['bang'], args['count'], args['flags'], args['first'], args['last'])
endf


fun! <SID>ShowErrMsg(errKey)
    echohl Error
    echon  s:errMsgsDict[a:errKey]
    echohl None
endf
command! -nargs=* -range -bang -bar  Join <line1>,<line2>call <SID>Join(<q-args>, <bang>0)

" vim: ts=4:sw=4:ft=vim:expandtab:fdm=marker
