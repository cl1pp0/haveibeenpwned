#!/bin/bash

APIURL="https://api.pwnedpasswords.com/range/"
echo -n "Enter Password: "
read -s PASS
echo
#SHA=$(echo -n $PASS | sha1sum | tr -d ' -');
SHA=$(echo -n $PASS | openssl sha1 | awk '{print $2}');
APIRES=$(curl -s $APIURL${SHA:0:5} | grep -i ${SHA:5:35} | tr -d '\r');

if [ "$APIRES" != "" ]; then
    NUM=$(echo $APIRES | awk -F':' '{print $2}');
    echo "Password breached $NUM times."
    exit 1
fi
echo "Password not breached."
exit 0
