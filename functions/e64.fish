function e64 -d "Base64 encoder"
    if test (count $argv) -ne 1
        echo 'Use: e64 "string"' >/dev/stderr
        return 1
    end

    echo $argv[1] | base64 -w0
end

