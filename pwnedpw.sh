#!/bin/bash

APIURL="https://api.pwnedpasswords.com/range/"
if [ "$1" == "" ]; then
    echo "Usage: pwnedpw.sh <password>"
    exit 1
fi
echo -n "Is password \"$1\" pwned...? "
SHA=$(echo -n $1 | sha1sum | tr -d ' -');
#SHA=$(echo -n $1 | openssl sha1 | awk '{print $2}');
SHA5C=$(echo $SHA | cut -b 1-5);
SHA35C=$(echo $SHA | cut -b 6-);
APIRES=$(curl -s $APIURL$SHA5C | grep -i $SHA35C | tr -d '\r');

if [ "$APIRES" != "" ]; then
    NUM=$(echo $APIRES | awk -F':' '{print $2}');
    echo "Yes! $NUM times."
    exit 1
fi
echo "No."
exit 0
