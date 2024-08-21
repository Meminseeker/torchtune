#!/bin/bash

if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

echo "Sending the config file..."
scp recipes/configs/llama3_1/8B_qlora_single_device.yaml $REMOTE_USER@$REMOTE_HOST:~/torchtune/recipes/configs/llama3_1/8B_qlora_single_device.yaml
echo "Config file 'recipes/configs/llama3_1/8B_qlora_single_device.yaml' sent to $REMOTE_HOST"
