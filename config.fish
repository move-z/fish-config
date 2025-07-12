# backward compatibility with posix profile file
bass source /etc/profile

set -x EDITOR hx
# set -x EDITOR nvim
set -x BROWSER firefox
set -x GPG_TTY (tty)
set -x STARSHIP_CONFIG ~/.config/fish/starship.toml

#if test "$XDG_SESSION_TYPE" = wayland
#    set -x QT_QPA_PLATFORM wayland
#else
#    set -x QT_QPA_PLATFORM xcb
#end

fish_add_path -P ~/.local/bin
fish_add_path -P ~/.local/share/nvim/mason/bin

direnv hook fish | source

# rust cargo
bass source "$HOME/.cargo/env"

## java sdkman
#for candidate in $HOME/.sdkman/candidates/* ;
#  fish_add_path -P $candidate/current/bin
#end
#set -x JAVA_HOME $HOME/.sdkman/candidates/java/current

set FISH_CONF_DIR "$HOME/.config/fish"
if test -f "$FISH_CONF_DIR/local.fish"
    source "$FISH_CONF_DIR/local.fish"
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    # Leave sharship out because async-prompt requires it in non interactive 
    # mode

    # must run before initializing mcfly
    fzf_configure_bindings --directory=\cf --git_log=\a --git_status=\cs --history= --processes=\cp
    mcfly init fish | source
    mcfly-fzf init fish | source

    jj util completion fish | source
    # makes startup too slow
    # kubectl completion fish | source
    # k3d completion fish | source

    zoxide init fish | source
    alias cd z
    alias cdi zi

    alias cat "bat -pP"
    alias less "bat -p"
    alias ls "eza --header --icons"

    alias nv nvim
    alias vim nvim

    alias k kubectl

    bind -k nul forward-char
    bind -k right forward-single-char
    bind \e\[C forward-single-char

    # transient prompt for starship: prompt definition
    function starship_transient_prompt_func
        starship module directory
        printf " @ "
        starship module time
        starship module character
    end

    starship init fish | source
    # enable transient prompt for starship (this function is defined by starship)
    enable_transience

    zellij setup --generate-completion fish | source
    if not set -q ZELLIJ
        exec zellij attach -c
    end
end
