#!/bin/bash

which golint
if [ $? -ne 0 ]; then
	echo "Downloading golint tool"
	go get -u golang.org/x/lint/golint
fi

RETVAL=0
for file in $(find . -path ./vendor -prune -o -type f -name '*.go' -print | grep -E "functests/utils"); do
	golint -min_confidence=.9 -set_exit_status "$file"
	if [[ $? -ne 0 ]]; then 
		RETVAL=1
 	fi
done
exit $RETVAL
