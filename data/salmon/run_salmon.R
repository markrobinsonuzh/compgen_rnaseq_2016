
index <- "../indices/salmon_index"

fq <- dir("../FASTQ",".fq.gz$", full=TRUE)
names(fq) <- gsub("_[12].fq.gz","",basename(fq))

fqs <- split(fq, names(fq))

for(i in 1:length(fqs)) {
  cmd <- sprintf("salmon quant --index %s -1 %s -2 %s --libType IU --output %s",
                 index, fqs[[i]][1], fqs[[i]][2], names(fqs)[i])
  cat(cmd,"\n"); 
  st <- system.time(system(cmd))
  print(st)
}


