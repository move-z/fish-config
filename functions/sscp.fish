function sscp -d "SCP through cyberark"
    if test (count $argv) -lt 2
        echo "Use: sscp [args] <source> <dest>" >/dev/stderr
        return 1
    end

    set _CYBERARK_HOST plcarkpsmp01.intranet.previmedical.it
    set -q _USERNAME || set _USERNAME "$USER"

    function _sscp_build_arg -V _CYBERARK_HOST -V _USERNAME
        set _PATH $argv[1]

        if test (count $_PATH) -gt 1
            set _DEST_HOST $_PATH[1]
            set _PATH "$_PATH[2..]"
            set _DEST_HOST (string replace .intranet.previmedical.it '' $_DEST_HOST).intranet.previmedical.it
            set _PATH "$_USERNAME@root@$_DEST_HOST@$_CYBERARK_HOST:$_PATH"
        end

        echo "$_PATH"
    end

    set _SOURCE (_sscp_build_arg "$argv[-2]")
    set _DEST (_sscp_build_arg "$argv[-1]")
    functions -e _sscp_build_arg

    set _ARGS $argv[1..-3]

    set _CMD "scp $_ARGS $_SOURCE $_DEST"
    echo Running "$_CMD"
    eval $_CMD
end
