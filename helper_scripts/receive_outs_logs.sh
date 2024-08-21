#!/bin/bash

if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

echo "Receive the log outputs..."
scp -r $REMOTE_USER@$REMOTE_HOST:~/torchtune/outs .
echo "Log files under '~/torchtune/outs' are received from $REMOTE_HOST"
