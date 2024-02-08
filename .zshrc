# ---
# Axel's zsh config. Started from Luke Smith's config, but alterted it to my liking.
# ---

export EDITOR=nvim

# - Basic setup - #
precmd() { print -Pn "\e]2;%~\a" }
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# - Load extenal configuration - #
[ -f "$HOME/.config/shell/aliasrc" ] && source "$HOME/.config/shell/aliasrc"

# - History configuration - #
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history
setopt appendhistory

# - Plugins - #
# zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
# autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="$(go env GOPATH)/bin:$PATH"

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
bindkey -v '^?' backward-delete-char
	# Check which clipboard utility is available
if command -v wl-copy > /dev/null 2>&1; then
    copy_to_clipboard() {
        echo "$1" | wl-copy
    }
    paste_from_clipboard() {
        wl-paste
    }
elif command -v xclip > /dev/null 2>&1; then
    copy_to_clipboard() {
        echo "$1" | xclip -selection clipboard
    }
    paste_from_clipboard() {
        xclip -selection clipboard -o
    }
else
    echo "No clipboard utility found! Install xclip if on X11, wl-clipboard if on wayland"
    return
fi
function yank-line-to-clipboard() {
    copy_to_clipboard "$BUFFER"
    zle reset-prompt
}
function paste-from-clipboard() {
    local clipboard_content=$(paste_from_clipboard)
    LBUFFER+=$clipboard_content
}
zle -N yank-line-to-clipboard
zle -N paste-from-clipboard
bindkey -M vicmd 'y' yank-line-to-clipboard
bindkey -M vicmd 'p' paste-from-clipboard

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# - Dir navigation - #
# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        \rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Used to copy files to clipboard
copyfile() {
    if [[ -z "$1" ]]; then
        echo "Usage: copyfile <filename>"
        return 1
    fi
    if [[ "$XDG_SESSION_TYPE" == "wayland" && -x "$(command -v wl-copy)" ]]; then
        wl-copy < "$1"
    elif [[ -x "$(command -v xclip)" ]]; then
        xclip -selection clipboard < "$1"
    else
        echo "No suitable clipboard utility found."
        return 1
    fi
}
