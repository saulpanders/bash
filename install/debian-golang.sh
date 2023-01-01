#!/bin/bash
# 1/1/2023 (@saulpanders)
# debian-goinstall.sh: installs golang 1.19.4 to a debian host
# optionally creates & runs a helloworld program to test install
# should be run as root

##GLOBALS
# path for the test helloworld module
test_path='work/src/test_project/hello'

goinstall()
{
        echo "[+] updating repos & installing git, curl, moreutils (sponge)"
        sudo apt -qq update
        sudo apt install git && sudo apt install curl && sudo apt install moreutils
        echo "[+] downloading go"
        curl -s -O https://dl.google.com/go/go1.19.4.linux-amd64.tar.gz
        echo "[+] extracting go & adding to /usr/local"
        tar -xf go1.19.4.linux-amd64.tar.gz
        sudo chown -R root:root ./go
        sudo mv -f go /usr/local
        sudo rm -r ./go
        echo "[+] setting gopaths"
        echo "export GOROOT=/usr/local/go" >> ~/.profile
        echo "export GOPATH=$HOME/work" >> ~/.profile
        echo "export PATH=/usr/local/go/bin:$GOPATH/bin:$GOROOT/bin:$PATH" >> ~/.profile
        #uses sponge from morelibs to avoid temp file when stripping duplicates from profile
        awk '!a[$0]++' ~/.profile | sponge ~/.profile
        source ~/.profile
        echo "[+] creating go workspace at $HOME/work"
        mkdir $HOME/work
}

check()
{
        echo "[+] creating test project (helloworld!)"
        mkdir -p $test_path
        echo -e 'package main\nimport "fmt"\n\nfunc main() {\n\tfmt.Printf("Hello, World!\\n")\n}' > ~/$test_path/hello.go
        cd $test_path
        go mod init
        go mod tidy
        go build
        ./hello
}

cleanup()
{
        rm ~/*.gz
}

## main
goinstall

if [ $# -gt 0 ]; then
        check
fi
cleanup
