function sss -d "SSH connection through cyberark"
    if test (count $argv) -lt 1
        echo "Hostname required" >/dev/stderr
        return 1
    end

    set CYBERARK_HOST plcarkpsmp01.intranet.previmedical.it
    set -q USERNAME || set USERNAME $USER
    set DEST_HOST $argv[(count $argv)]
    set DEST_HOST (string replace .intranet.previmedical.it '' $DEST_HOST).intranet.previmedical.it
    set ARGS $argv[1..-2]

    set CMD "ssh $ARGS $USERNAME@root@$DEST_HOST@$CYBERARK_HOST"
    echo Running $CMD
    eval $CMD
end
