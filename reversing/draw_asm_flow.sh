cat shellcode.hex | tr -d '\\\x' | xxd -r -p | sctest -vvv -Ss 99999 -G shellcode.dot; dot -Tpng -o shellcode.png shellcode.dot
