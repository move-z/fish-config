function sss -d "SSH connection through cyberark"
    if test (count $argv) -lt 1
        echo "Use: sss [--sys] [args] <dest>" >/dev/stderr
        return 1
    end

    set _CYBERARK_HOST cyberark.intranet.previmedical.it
    set -q CYBERARK_USERNAME && set _USERNAME "$CYBERARK_USERNAME" || set _USERNAME "$USER"

    argparse -i sys -- $argv
    or return 1
    if set -ql _flag_sys
        set _DEST_USER sistemisti
    else
        set _DEST_USER root
    end

    set _DEST $argv[-1]
    if not string match '*.previmedical.it' $_DEST
        set _DEST $_DEST.intranet.previmedical.it
    end
    set _ARGS $argv[1..-2]

    set _CMD "ssh $_ARGS $_USERNAME@$_DEST_USER@$_DEST@$_CYBERARK_HOST"
    echo Running $_CMD
    eval $_CMD
end
