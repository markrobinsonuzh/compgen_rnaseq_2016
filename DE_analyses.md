# CompGen 2016 RNA-seq session

A differential analysis, depending on the overall goals, may proceed with the following steps:

(Note: you can run `git clone https://github.com/markrobinsonuzh/compgen_rnaseq_2016.git` to check out this repository.  Note that the large data and annotation files are not available in the github repo, so you will have to insert the files)

1. It is suggested to organize your files in a nice way.  The following is just one possibility, where the R scripts of downstream analysis are kept in the `analysis` directory and the `data` directory contains a set of directories for the relevant data (`anno` for annotation information, `FASTQ` for the raw FASTQ sequence files, `indices` for the indices that the tools need and so on).  You do not necessarily need to follow this exactly, but a system like this is helpful to stay organized.

![Alt](/img/tree.png "Tree of overall directory structure")

2. Put the raw FASTQ files in the `FASTQ` directory and {`genome.fa`, `transcripts.fa`, `transcripts.gtf`} in the `anno` directory.  All other directories will be populated from the mapping or quantitation tools.
3. Given the annotation, create the indices, one for `STAR` and one for `salmon`.  There are shell scripts in the `indices` directory to guide you on the relevant command.
4. Run `STAR`.  In the `BAM` directory, there is an R script that generates the commands and then invokes them through a call to `system()`.  There is a shell script there to run and log the whole thing, but it may be worth babysitting it in an R session.  It is a good idea to have a look at the logs.  Also note that depending on the system you use, you may need to adjust the zcat/gzcat option.
5. Run `salmon`.  In the `salmon` directory, there is a likewise an R script that builds the unix commands and inokes them via `system()` as well as a shell script to run and log the whole thing.  Note: there are other ways to do this (e.g., makefiles, snakemake)
6. Run DEXSeq counting.  The `dexseq` directory contains a script with some commands, given the BAM files and the pre-processed annotation.
7. Following all these preprocessing steps, we can then jump to R and follow the R-markdown files in the `analysis` directory.

