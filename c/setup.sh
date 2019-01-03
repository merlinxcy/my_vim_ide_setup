#!/bin/sh
echo "[*]update vim"
apt-get install vim -y
echo "[*]installing vim-plugin"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "[*]setting plugins"
echo "" > ~/.vimrc
echo "call plug#begin('~/.vim/plugged')" >> ~/.vimrc
echo "Plug 'junegunn/vim-easy-align'" >>~/.vimrc
echo "Plug 'skywind3000/quickmenu.vim'" >> ~/.vimrc
echo "Plug 'junegunn/goyo.vim'" >> ~/.vimrc
echo "Plug 'junegunn/limelight.vim'" >> ~/.vimrc
echo "Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }" >> ~/.vimrc
echo "Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }" >> ~/.vimrc
echo "Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }" >> ~/.vimrc
echo "Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }" >> ~/.vimrc
echo "Plug 'w0rp/ale'" >> ~/.vimrc
echo "Plug 'Valloric/YouCompleteMe'" >> ~/.vimrc
echo "call plug#end()" >> ~/.vimrc

cat>>~/.vimrc<<EOF
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

let g:ale_sign_error = "\ue009\ue009"
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! SpellBad gui=undercurl guisp=red
hi! SpellCap gui=undercurl guisp=blue
hi! SpellRare gui=undercurl guisp=magenta

EOF

cat>>~/.vimrc<<EOF
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone

noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
           \ 'cs,lua,javascript': ['re!\w{2}'],
           \ }
EOF

echo "[*]install YCM core"
apt install build-essential cmake3 python3-dev
cd ~/.vim/plugged/YouCompleteMe
python3 install.py --all
vim +PlugInstall +qall
