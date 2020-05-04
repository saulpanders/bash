#! /bin/bash
# https://gist.github.com/Plazmaz/cafd0bd3a3a4471446cc8fe6e4f0c036

sudo bash -c 'while true; do echo "HTTP/1.1 200 OK\n\n" |nc -l -p 80 |egrep -v "Accept" |egrep -v "Content-Length" |egrep -v "Host" |egrep -vi "cache"; done'
# Original (no sudo): 
# while true; do echo "HTTP/1.1 200 OK\n\n" |nc -l -p 80 |egrep -v "Accept" |egrep -v "Content-Length" |egrep -v "Host" |egrep -vi "cache"; done
# Raw (Skip filtering header lines):
# sudo bash -c 'while true; do echo "HTTP/1.1 200 OK\n\n" |nc -l -p 80; done'