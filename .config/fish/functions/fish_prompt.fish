function fish_prompt --description 'Informative prompt'
    #Save the return status of the previous command
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.

    if functions -q fish_is_root_user; and fish_is_root_user
        printf '%s@%s %s%s%s# ' $USER (prompt_hostname) (set -q fish_color_cwd_root
                                                         and set_color $fish_color_cwd_root
                                                         or set_color $fish_color_cwd) \
            (prompt_pwd) (set_color normal)
    else
        set_color red --bold
        printf "["
        set_color yellow
        printf "%s" "$USER"
        set_color green
        printf "@"
        set_color blue
        printf "%s" "$hostname"
        set_color magenta
        printf " %s" "$PWD"
        set_color red
        printf "]"
        set_color normal
        printf "\n" 
    printf '$'
    printf ' '
    end
end
