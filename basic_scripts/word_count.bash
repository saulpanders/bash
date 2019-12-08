#!/bin/bash

#counts the words in the file .bash_profile

count=0
for i in $(cat sysinfo_page.html); do
	count=$((count+1))
	echo "Word $count ($i) contains $(echo -n $i | wc -c) characters"
done
