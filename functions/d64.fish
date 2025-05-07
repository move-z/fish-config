function d64 -d "Base64 decoder"
    if test (count $argv) -ne 1
        echo 'Use: d64 "string"' >/dev/stderr
        return 1
    end

    echo $argv[1] | base64 -d -w0
end

