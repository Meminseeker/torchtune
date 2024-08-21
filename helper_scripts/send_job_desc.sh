#!/bin/bash

if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

echo "Sending the job description file..."
scp -r job_scripts/ $REMOTE_USER@$REMOTE_HOST:~/torchtune
echo "Job description file 'ultramarine_job.sh' sent to $REMOTE_HOST"
