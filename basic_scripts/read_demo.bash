#!/bin/bash

echo -n "Hurry up and type ya dingus > "
if read -t 3 response; then
	echo "Great, you're quick as a whip"
else
	echo "*Sonic Voice* you're too slow"
fi

