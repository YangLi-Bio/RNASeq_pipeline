#!/bin/bash 
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --time=0:40:00
#SBATCH --job-name1_Build_ref
#SBATCH --output=build_ref_%j.txt
#SBATCH --mail-type=FAIL


# Promots
echo "This script aims to build the reference genome, saved to a directory with a common prefix, based on gziped FASTA file (.fa.gz)"
echo "Usage: ./1_Build_ref.sh <work_dir/prefix> <genome_fa>"


# Set basic parameters
work_dir=$1
genome_fa=$2


# Modules
module load hisat2/2.1.0


# Build reference genome
hisat2-build -p 16 ${genome_fa} ${work_dir}
