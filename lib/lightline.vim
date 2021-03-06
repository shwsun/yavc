" Lightline config
"
" Add diagnostic info for https://github.com/itchyny/lightline.vim
function! CocCurrentFunction()
	return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
			\ 'colorscheme': 'jellybeans',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\		    [  'gitbranch', ],
			\		    [ 'readonly', 'filename', 'modified' ],
			\			[ 'coc_error', 'coc_warning', 'coc_hint', 'coc_info' ] ],
			\   'right': [ [ 'lineinfo' ],
			\              [ 'percent' ],
			\              [ 'fileformat', 'fileencoding', 'filetype'] ]
			\ },
			\ 'component_expand': {
			\   'coc_error'        : 'LightlineCocErrors',
			\   'coc_warning'      : 'LightlineCocWarnings',
			\   'coc_info'         : 'LightlineCocInfos',
			\   'coc_hint'         : 'LightlineCocHints',
			\   'coc_fix'          : 'LightlineCocFixes',
			\ },
			\ 'component_function': {
			\   'gitbranch': 'fugitive#head',
			\   'currentfunction': 'CocCurrentFunction',
			\   'filename': 'LightlineFilename',
			\   'fileformat': 'LightlineFileformat',
			\   'filetype': 'LightlineFiletype',
			\ },
			\   'separator': { 'left': '▒', 'right': '▒' },
			\   'subseparator': { 'left': '▒', 'right': '░' }
			\ }


function! LightlineFilename()
	return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

function! LightlineFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
	return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

let g:lightline.component_type = {
			\   'coc_error'        : 'error',
			\   'coc_warning'      : 'warning',
			\   'coc_info'         : 'tabsel',
			\   'coc_hint'         : 'middle',
			\   'coc_fix'          : 'middle',
			\ }

function! s:lightline_coc_diagnostic(kind, sign) abort
	let info = get(b:, 'coc_diagnostic_info', 0)
	if empty(info) || get(info, a:kind, 0) == 0
		return ''
	endif
	try
		let s = g:coc_user_config['diagnostic'][a:sign . 'Sign']
	catch
		let s = ""
		" let s = "•"
	endtry
	return printf('%s %d', s, info[a:kind])
endfunction

function! LightlineCocErrors() abort
	return s:lightline_coc_diagnostic('error', 'error')
endfunction

function! LightlineCocWarnings() abort
	return s:lightline_coc_diagnostic('warning', 'warning')
endfunction

function! LightlineCocInfos() abort
	return s:lightline_coc_diagnostic('information', 'info')
endfunction

function! LightlineCocHints() abort
	return s:lightline_coc_diagnostic('hints', 'hint')
endfunction

function! LightlineGitBranch()
	return "\uE725 " . (exists('*fugitive#head') ? fugitive#head() : '')
endfunction

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()


