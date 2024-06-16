" Author: John Kurkowski <john.kurkowski@gmail.com>
" Description: Glint Language Server integration for ALE

call ale#Set('handlebars_glint_executable', 'glint-language-server')
call ale#Set('handlebars_glint_use_global', get(g:, 'ale_use_global_executables', 0))

function! ale_linters#handlebars#glint#GetProjectRoot(buffer) abort
    let l:package_path = ale#path#FindNearestFile(a:buffer, 'package.json')

    return !empty(l:package_path) ? fnamemodify(l:package_path, ':h') : ''
endfunction

call ale#linter#Define('handlebars', {
\   'name': 'glint',
\   'lsp': 'stdio',
\   'executable': {b -> ale#path#FindExecutable(b, 'handlebars_glint', [
\       'node_modules/.bin/glint-language-server',
\   ])},
\   'command': '%e --stdio',
\   'project_root': function('ale_linters#handlebars#glint#GetProjectRoot'),
\})
