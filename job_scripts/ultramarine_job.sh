#!/bin/bash
#SBATCH --job-name=Llama3.1-8B_4bit_2048_seq_8rank_10batch_4grad
#SBATCH --output=outs/%j.log
#SBATCH --container-image ghcr.io\#bouncmpe/cuda-python3
#SBATCH --time=3-00:00:00
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
echo "Model downloaded to ~/Meta-Llama-3.1-8B-Instruct"

echo "Running the fine-tuning..."
tune run lora_finetune_single_device --config ~/torchtune/recipes/configs/llama3_1/8B_qlora_single_device.yaml
echo "Fine-tuning completed."

python3 -c "import torch; used_memory = round(torch.cuda.max_memory_reserved() / 1024 / 1024 / 1024, 3); print(f'Used memory: {used_memory} GB')"
