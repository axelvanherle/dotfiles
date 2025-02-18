# ---
# Axel's zsh config. Started from Luke Smith's config, but alterted it to my liking.
# ---

# - Exports - #
export EDITOR=nvim
export PATH="$(go env GOPATH)/bin:$PATH"

# - Basic setup - #
precmd() { print -Pn "\e]2;%~\a" } # Alter the name of the terminal to current dir
autoload -U colors && colors
# Set promt
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# - Load extenal configuration - #
[ -f "$HOME/.config/shell/aliasrc" ] && source "$HOME/.config/shell/aliasrc"
[ -f "$HOME/.config/shell/functionrc" ] && source "$HOME/.config/shell/functionrc"

# - History configuration - #
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history
setopt appendhistory

# - Plugins - #
# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
# autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# - Autocomplete configuration - #
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# - VI Mode configuration - #
bindkey -v
export KEYTIMEOUT=1
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# copy paste in vi mode
zle -N yank-line-to-clipboard
zle -N paste-from-clipboard
bindkey -M vicmd 'y' yank-line-to-clipboard
bindkey -M vicmd 'p' paste-from-clipboard
zle -N zle-keymap-select
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# - Dir navigation - #
bindkey -s '^o' 'lfcd\n'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
