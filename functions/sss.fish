function sss -d "SSH connection through cyberark"
    if test (count $argv) -lt 1
        echo "Use: sss [--sys] [args] <dest>" >/dev/stderr
        return 1
    end

    set _CYBERARK_HOST plcarkpsmp01.intranet.previmedical.it
    set -q _USERNAME || set _USERNAME $USER

    argparse sys -- $argv
    or return 1
    if set -ql _flag_sys
        set _DEST_USER sistemisti
    else
        set _DEST_USER root
    end

    set _DEST $argv[-1]
    set _DEST (string replace .intranet.previmedical.it '' $_DEST).intranet.previmedical.it
    set _ARGS $argv[1..-2]

    set _CMD "ssh $_ARGS $_USERNAME@$_DEST_USER@$_DEST@$_CYBERARK_HOST"
    echo Running $_CMD
    eval $_CMD
end
