#!/bin/bash
# some troubles highlighted with bash

number=1

set -x
if [ "$number" = "1" ]; then
	echo "Number equals 1"
else
	echo "Number is not 1"
fi
set +x
