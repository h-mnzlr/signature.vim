if exists('g:loaded_signature')
    finish
endif
let g:loaded_signature = 1

" let g:name = 'Heiko Menzler'
" let g:email = 'heikogeorg.menzler@stud.uni-goettingen.de'
iabbrev <silent> ssig <C-R>=PersonalSignature()<CR>

function PersonalSignature()
	" sadly this does not work for latex documents, as the '%' character is interpreted as a variable by printf
	let l:signature_lines=4

	" As the letters are passed to the expression register key-wise when
	" inserting, we need to define different behaviours when the
	" formatoption 'r' (add commentstring in new line when insert mode) is set.
	if count(&formatoptions, 'r') == 0
		let l:signature_format=repeat(&commentstring."\n", l:signature_lines - 1).&commentstring
	else
		let l:signature_format=&commentstring."\n".repeat("%s\n", l:signature_lines - 2)."%s"
	end

	let l:datestring='Date: '.strftime('%d.%m.%Y')
	let l:personalsignature=printf(l:signature_format, g:name, g:email, '', l:datestring)
	return l:personalsignature
endfunction

" When opening an empyt buffer automatically add signature
augroup AutomaticSignature
	au!
	au BufNewFile * normal issig
augroup end

" Add a space in each commentstring before the comment
augroup FixCommentstrings
	au!
	au BufEnter * let &commentstring=substitute(&commentstring, '\(\s\)\@<!%s', ' %s', '')
augroup end
