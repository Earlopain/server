[[ $- != *i* ]] && return

[[ "$(whoami)" = "root" ]] && return

# limits recursive functions, see 'man bash'
[[ -z "$FUNCNEST" ]] && export FUNCNEST=100

# Use the up and down arrow keys for finding a command in history
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

alias ls='ls --color=auto'
alias grep='grep --colour=auto'
# Ask before overwriting
alias cp='cp -i'

alias ifconfig='ip addr'
alias grub-update='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias mine='sudo chown $USER:$USER'
alias unlock-key='echo "test" | gpg --clearsign > /dev/null'

alias dcr='docker compose run --rm'
alias dcb='docker compose build'
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dcl='docker compose logs --tail 10 --follow'

export GPG_TTY=$(tty)
