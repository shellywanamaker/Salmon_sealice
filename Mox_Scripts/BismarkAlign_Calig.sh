#!/bin/bash
## Job Name
#SBATCH --job-name=BismarkAlign_Calig
## Allocation Definition 
#SBATCH --account=srlab
#SBATCH --partition=srlab
## Resources
## Nodes 
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=10-15:30:00
## Memory per node
#SBATCH --mem=500G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=strigg@uw.edu
## Specify the working directory for this job
#SBATCH --workdir=/gscratch/srlab/strigg/analyses/20190730



#align with bismark
%%bash

find /gscratch/srlab/strigg/data/Caligus/FASTQS/TRIM_cat/*R1_001_trimmed.5bp_3prime.fq.gz \
| xargs basename -s _R1_001_trimmed.5bp_3prime.fq.gz | xargs -I{} /gscratch/srlab/programs/Bismark-0.19.0/bismark \
--path_to_bowtie /gscratch/srlab/programs/bowtie2-2.3.4.1-linux-x86_64 \
--samtools_path /gscratch/srlab/programs/samtools-1.9 \
--score_min <L,0,-1.2> \
-I <60> \
-p 28 \
--non_directional \
--genome /gscratch/srlab/strigg/data/Caligus/GENOMES \
-1 /gscratch/srlab/strigg/data/Caligus/FASTQS/TRIM_cat/{}_R1_001_trimmed.5bcdp_3prime.fq.gz \
-2 /gscratch/srlab/strigg/data/Caligus/FASTQS/TRIM_cat/{}_R2_001_trimmed.5bp_3prime.fq.gz \
-o /gscratch/srlab/strigg/analyses/20190730/Caligus

#run deduplicaiton
%%bash
/gscratch/srlab/programs/Bismark-0.19.0/deduplicate_bismark \
--bam -p \
--samtools_path /gscratch/srlab/programs/samtools-1.9/ \
/gscratch/srlab/strigg/analyses/20190730/*.bam \
-o /gscratch/srlab/strigg/analyses/20190730 \
2> /gscratch/srlab/strigg/analyses/20190730/dedup.err 


#compile and sort bams
find /gscratch/srlab/strigg/analyses/20190730/*deduplicated.bam| \
xargs basename -s _R1_001_bismark_bt2_pe.deduplicated.bam | xargs -I{} /gscratch/srlab/programs/samtools-1.9/samtools \
sort /gscratch/srlab/strigg/analyses/20190730/{}_R1_001_bismark_bt2_pe.deduplicated.bam \
-o /gscratch/srlab/strigg/analyses/20190730/{}_dedup.sorted.bam

#run methylation extractor
/gscratch/srlab/programs/Bismark-0.19.0/bismark_methylation_extractor \
--paired-end --bedGraph --counts --scaffolds \
--multicore 28 \
/gscratch/srlab/strigg/analyses/20190730/*deduplicated.bam \
-o /gscratch/srlab/strigg/analyses/20190730/ \
--samtools /gscratch/srlab/programs/samtools-1.9/samtools \
2> /gscratch/srlab/strigg/analyses/20190730/bme.err

#create bismark reports for individual samlpes
/gscratch/srlab/programs/Bismark-0.19.0/bismark2report

#create bismark summary report for all samples
/gscratch/srlab/programs/Bismark-0.19.0/bismark2summary

#Run coverage2cytosine command to generate cytosine coverage files

%%bash

find /gscratch/srlab/strigg/analyses/20190730/*.cov.gz | \
xargs basename -s _R1_001_bismark_bt2_pe.deduplicated.bismark.cov.gz | \
xargs -I{} /gscratch/srlab/programs/Bismark-0.19.0/coverage2cytosine \
--gzip --genome_folder /gscratch/srlab/strigg/data/Caligus/GENOMES \
-o /gscratch/srlab/strigg/analyses/20190730/{}_cytosine_CpG_cov_report \
/gscratch/srlab/strigg/analyses/20190730/{}_R1_001_bismark_bt2_pe.deduplicated.bismark.cov.gz



