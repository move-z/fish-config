function clip -d "Copy to clipboard"
    function _clip_wayland
        wl-copy -t text/plain
    end

    function _clip_x
        xclip -sel clipboard
    end

    if test "$XDG_SESSION_TYPE" = wayland
        _clip_wayland
    else if test "$XDG_SESSION_TYPE" = x11
        _clip_x
    else
        echo No session!
    end
end

