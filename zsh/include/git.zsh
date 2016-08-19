# Basic functions
alias gs='git status'
alias gpl='git pull'
alias gpu='git push'
alias gd='git diff'
alias gpr='git pull --rebase'

# Adding helpers
alias gadd='git add .'
alias gca='git add . && git commit'

# Logging helpers
alias gls='git log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate'
alias gll='git log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'
alias gdate='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=relative'
alias gdatelong='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'

# File searching
search_top_level() {
    A=$(pwd)
    TOPLEVEL=$(git rev-parse --show-toplevel)
    cd $TOPLEVEL
    MY_RESULT="$(git grep --full-name -In $1)"
    py_script="
import sys
bash = sys.argv[1]
bash_split = ['File Name:#:Result'] + bash.split('\n')
name_len = 0
line_len = 0
for line in bash_split:
    this_line = line.split(':')
    temp_name = this_line[0]
    temp_line = this_line[1]
    name_len = max(len(temp_name), name_len)
    line_len = max(len(temp_line), line_len)

to_print = '{0:<%d} | {1:>%d} | {2}' % (name_len, line_len)
for line in bash_split:
    this_line = line.split(':')
    temp_name = this_line[0]
    temp_line = this_line[1]
    print(to_print.format(temp_name, temp_line, ' '.join(this_line[2:])))
"
python3 -c "$py_script" $MY_RESULT
cd $A
}

alias gsearch=search_top_level
alias gfind='git ls-files | grep -i'
