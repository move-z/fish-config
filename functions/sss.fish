function sss -d "SSH connection through cyberark"
    if test (count $argv) -lt 1
        echo "Hostname required" >/dev/stderr
        return 1
    end

    set CYBERARK plcarkpsmp01.intranet.previmedical.it
    set HOSTNAME $argv[(count $argv)]
    set HOSTNAME (string replace .intranet.previmedical.it '' $HOSTNAME).intranet.previmedical.it
    set argv $argv[1..-2]

    set CMD "ssh $argv $USER@root@$HOSTNAME@$CYBERARK"
    echo Running $CMD
    eval $CMD
end
