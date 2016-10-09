#!/bin/sh

#Change the author of all previous git commits.

if [ $# -eq 0 ]; then
    echo "No arguments passed"
    export OLD_EMAIL="john.armstrong@solnetsolutions.co.nz"
    export CORRECT_NAME="John Armstrong"
    export CORRECT_EMAIL="j.armstrong484@gmail.com"

    echo "Using defaults:"
    echo "OLD_EMAIL=john.armstrong@solnetsolutions.co.nz"
    echo "CORRECT_NAME=John Armstrong"
    echo "CORRECT_EMAIL=j.armstrong484@gmail.com"
elif [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "You need to provide a string for old email and new email."
    echo "e.g ./author.sh old@email.com your-name new@email.com"
    exit 1
else
    export OLD_EMAIL=$1
    export CORRECT_NAME=$2
    export CORRECT_EMAIL=$3
fi


git filter-branch -f --env-filter '

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi

if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tagsi

unset OLD_EMAIL
unset CORRECT_NAME
unset CORRECT_EMAIL
