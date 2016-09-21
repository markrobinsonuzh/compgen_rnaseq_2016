
library("Rsamtools")

fq <- dir("../FASTQ",".fq.gz$", full=TRUE)
names(fq) <- gsub("_[12].fq.gz","",basename(fq))

fqs <- split(fq, names(fq))

inddir <- "~/projects/teaching/compgen_rnaseq_2016/data/indices/STAR_index_100"

for(i in 1:length(fqs)) {
  out <- paste0( names(fqs)[i], "_STAR.bam" )
  outs <- gsub(".bam","_s",out)
  cmd <- paste0("STAR --genomeDir ", inddir, " --readFilesIn ", fqs[[i]][1], " ", fqs[[i]][2],
                " --runThreadN 4 --outFilterMultimapNmax 1 --readFilesCommand gzcat; samtools view -Sb Aligned.out.sam > ",
                out, " && rm Aligned.out.sam; mv Log.final.out ", out, ".log")
  cat(cmd, "\n")
  st <- system.time(system(cmd))
  print(st)
  indexBam(sortBam(out,outs))
  unlink(out)
}


