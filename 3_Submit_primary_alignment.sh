#!/bin/bash


# Please set the following parameters:
# 1. log: change the working directory as the parent directory of log/
# 2. fastq_list.txt: move the fastq_list.txt to the parent directory of log/


while read FASTQ1 FASTQ2 NAME
do
   echo $NAME
   sbatch --job-name=$NAME.run --output=./log/$NAME.out --export=R1=$FASTQ1,R2=$FASTQ2,NAME=$NAME 3_Run_primary_alignment.sh
   sleep 0.1s
done < fastq_list.txt