bass source /etc/profile

set -x EDITOR nvim
set -x BROWSER firefox
set -x STARSHIP_CONFIG ~/.config/fish/starship.toml

fish_add_path -P ~/.local/bin

bass source "$HOME/.cargo/env"
#bass source "$HOME/.sdkman/bin/sdkman-init.sh"
set -x JAVA_HOME $HOME/.sdkman/candidates/java/current

for candidate in $HOME/.sdkman/candidates/* ;
  fish_add_path -P $candidate/current/bin
end

if status is-interactive
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

    # must run before initializing mcfly
    fzf_configure_bindings --directory=\cf --history=\e\cr
    mcfly init fish | source
    mcfly-fzf init fish | source

    # Commands to run in interactive sessions can go here
    alias nv nvim
    alias vim nvim

    zoxide init fish | source
    alias cd z
    alias cdi zi

    alias cat "bat -pP"
    # alias diff difft
    alias du dust
    # alias find fd
    # alias grep rg
    alias ls "exa --header --icons"
    # alias ps procs
    # alias sed sd
    alias top btm

    bind -k nul forward-char
    bind -k right forward-single-char
    bind \e\[C forward-single-char
end

