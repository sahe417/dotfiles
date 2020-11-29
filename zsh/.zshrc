# ---- add ---- #
autoload -U compinit && compinit -u
autoload -Uz colors
colors

PROMPT="%{$fg[green]%}%m%(!.#.$) %{$reset_color%}"
PROMPT2="%{$fg[green]%}%_> %{$reset_color%}"
RPROMPT="%{$fg[cyan]%}[%~]%{$reset_color%}"

setopt print_eight_bit
setopt auto_cd
setopt no_beep
setopt nolistbeep
setopt auto_pushd

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups

alias ls='ls -AFG'

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Add OpenJDK11 for Salesforce Extends Pack
#export JAVA_HOME=/Users/tsunao/Library/Java/JavaVirtualMachines/jdk-11.jdk/Contents/Home

