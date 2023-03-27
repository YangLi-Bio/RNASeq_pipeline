###########################################################
#                                                         #
#               Build a list of FASTQ files               #
#                                                         #
###########################################################


# Usage
message ("Usage: Rscript 2_Get_FASTQ_list.R <work.dir>")


# Parameters
args <- commandArgs(T)
work.dir <- args[1]


# Get file list
all_files <- list.files(dir = work.dir, pattern = "*.fastq.gz", recursive = TRUE)
raw_list <- all_files
raw_list_split <- strsplit(all_files,"/")
raw_list <- raw_list[sapply(raw_list_split, length) == 2]
raw_list_split <- raw_list_split[sapply(raw_list_split, length) == 2]
sample_id <- sapply(raw_list_split, function(x) {
  strsplit(x[2],"_R[12]")[[1]][1]
})
row1 <- which(!duplicated(sample_id))
row2 <- which(duplicated(sample_id))
fastq1 <- raw_list[row1]
fastq2 <- raw_list[row2]
result <- data.frame(fastq1,fastq2,unique(sample_id))
dir.create(paste0(work.dir, "/log/")
write.table(result, paste0(work.dir, "/fastq_list.txt"), row.names = FALSE, 
        col.names = FALSE, quote = FALSE)
message ("Wrote the list of FASTQ files to: ", work.dir, "/fastq_list.txt")
