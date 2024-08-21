#!/bin/bash
#SBATCH --job-name=torchtune_Llama3.1-8B_model_download
#SBATCH --output=outs/%j.log
#SBATCH --container-image ghcr.io\#bouncmpe/cuda-python3
#SBATCH --time=0-01:00:00
#SBATCH --gpus=1
#SBATCH --cpus-per-gpu=8
#SBATCH --mem-per-gpu=40G

cd ~/torchtune
source /opt/python3/venv/base/bin/activate

echo "Installing dependencies..."
pip3 install -q -r requirements.txt

if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

echo "Downloading the model..."
tune download meta-llama/Meta-Llama-3.1-8B-Instruct --output-dir /tmp/Meta-Llama-3.1-8B-Instruct --ignore-patterns "original/consolidated.00.pth" --hf-token $HF_TOKEN
echo "Model downloaded to /tmp/Meta-Llama-3.1-8B-Instruct"
