#!/bin/sh

#Change the author of all previous git commits.

git filter-branch -f --env-filter '

if [ $# -eq 0]; then
    echo "No arguments passed"
    OLD_EMAIL="john.armstrong@solnetsolutions.co.nz"
    CORRECT_NAME="John Armstrong"
    CORRECT_EMAIL="j.armstrong484@gmail.com"

    echo "Using defaults:"
    echo "OLD_EMAIL=john.armstrong@solnetsolutions.co.nz"
    echo "CORRECT_NAME=John Armstrong"
    echo "CORRECT_EMAIL=j.armstrong484@gmail.com"
elif [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "You need to provide a string for old email and new email."
    echo "e.g ./author.sh old@email.com your-name new@email.com"
else
    OLD_EMAIL=$1
    CORRECT_NAME=$2
    CORRECT_EMAIL=$3
fi

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
' --tag-name-filter cat -- --branches --tags
