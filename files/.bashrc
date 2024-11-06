[[ $- != *i* ]] && return

[[ "$(whoami)" = "root" ]] && return

# limits recursive functions, see 'man bash'
[[ -z "$FUNCNEST" ]] && export FUNCNEST=100

# Use the up and down arrow keys for finding a command in history
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

alias ls='ls --color=auto'
alias ll='ls -lah'
alias grep='grep --colour=auto'
# Ask before overwriting
alias cp='cp -i'

alias ifconfig='ip addr'
alias grub-update='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias mine='sudo chown $USER:$USER'
alias unlock-key='echo "test" | gpg --clearsign > /dev/null'

alias dcr='docker compose run --rm'
alias dcb='docker compose build'
alias dcu='docker compose up --menu=false'
alias dcd='docker compose down'
alias dcl='docker compose logs --tail 10 --follow'
alias dcl='docker compose pull'

git-rebase(){
  git rebase -i --committer-date-is-author-date HEAD~$1
}

export GPG_TTY=$(tty)
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

eval "$(rbenv init - bash)"
