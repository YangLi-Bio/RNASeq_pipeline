#!/usr/bin/bash
#SBATCH --account PCON0022
#SBATCH --time=00:30:00
#SBATCH --nodes=1 
#SBATCH --ntasks=16
#SBATCH --mem=32GB


# Parameters
tools=/fs/ess/PCON0022/liyang/tools
wd=/fs/scratch/PAS1475/cankun/awc59/mapping
gtf=$tools/genome/Homo_sapiens.GRCh38.99.gtf
bam_dir=$wd/alignment_out


# Load modules
module load samtools
module load hisat2
module load subread


# Calculate feature counts
cd $bamdir
bamfiles="$(find $bam_dir -maxdepth 2 -name "*.sorted.bam" -print)"

featureCounts -T 16 -g gene_name --primary -a $gtf -o $wd/result/out.txt $bamfiles

echo "Remember to remove all large alignment files when finished"
