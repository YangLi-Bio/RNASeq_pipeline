#!/usr/bin/bash


# Please change the following content according to your machine
#SBATCH --account PCON0022
#SBATCH --time=02:00:00
#SBATCH --nodes=1 
#SBATCH --ntasks=16
#SBATCH --mem=64GB


# Please change the following parameters
# tools: The directory of reference genome
# wd: The working directory
# ref_index: The indices of reference genome
tools=/fs/project/PAS1475/tools
wd=/fs/scratch/PCON0022/cankun/210305_Pearlly_GSL-PY-2037-transfer
ref_index=$tools/genome/Mus_musculus.GRCm38.99


# Load modules
module load samtools
module load hisat2
module load subread


# Change directory
cd $wd
echo $NAME
mkdir $wd/log
mkdir $wd/fastp_out
mkdir $wd/result
mkdir $wd/result/pre_alignment
mkdir $wd/alignment_out


# FASTQ quality control, trimming, filtering
$tools/fastp -w 16 -i $R1 -I $R2 -o $wd/fastp_out/$NAME.R1.fastq.gz -O $wd/fastp_out/$NAME.R2.fastq.gz -h $wd/result/pre_alignment/$NAME.html -j $wd/result/pre_alignment/$NAME.json


# Reads alignment to reference genome using HISAT2
hisat2 -p 16 -x $ref_index -1 $wd/fastp_out/$NAME.R1.fastq.gz -2 $wd/fastp_out/$NAME.R2.fastq.gz -S $wd/alignment_out/$NAME.sam


# Convert SAM file to BAM file
samtools view -S -b $wd/alignment_out/$NAME.sam -@ 16 > $wd/alignment_out/$NAME.bam


# Sort bam files
samtools sort -@ 16 $wd/alignment_out/$NAME.bam -o $wd/alignment_out/$NAME.sorted.bam


# Post alignment quality control
# module load java
#java -jar $tools/picard.jar CollectAlignmentSummaryMetrics R=$ref_fasta I=$wd/alignment_out/$NAME.sorted.bam O=$wd/result/post_alignment/$NAME.sorted.txt
