#!/bin/bash
## Job Name
#SBATCH --job-name=BismarkAlign_Salmo
## Allocation Definition 
#SBATCH --account=srlab
#SBATCH --partition=srlab
## Resources
## Nodes 
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=14-23:30:00
## Memory per node
#SBATCH --mem=500G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=strigg@uw.edu
## Specify the working directory for this job
#SBATCH --chdir=/gscratch/scrubbed/strigg/analyses/20190814_Salmo


#align with bismark

%%bash

find /gscratch/scrubbed/strigg/TRIMG_adapt_5bp/TRIM_cat/*psu_*R1_001_val_1.fq.gz \
| xargs basename -s _R1_001_val_1.fq.gz| xargs -I{} /gscratch/srlab/programs/Bismark-0.19.0/bismark \
--path_to_bowtie /gscratch/srlab/programs/bowtie2-2.3.4.1-linux-x86_64 \
--samtools_path /gscratch/srlab/programs/samtools-1.9 \
--score_min L,0,-0.6 \
-p 4 \
--non_directional \
--dovetail \
--genome /gscratch/srlab/strigg/data/Ssalar/GENOMES \
-1 /gscratch/scrubbed/strigg/TRIMG_adapt_5bp/TRIM_cat/{}_R1_001_val_1.fq.gz \
-2 /gscratch/scrubbed/strigg/TRIMG_adapt_5bp/TRIM_cat/{}_R2_001_val_2.fq.gz \
-o /gscratch/scrubbed/strigg/analyses/20190814_Salmo

#create summary report
cat /gscratch/scrubbed/strigg/analyses/20190814_Salmo/*PE_report.txt | \
grep -E 'Mapping\ efficiency\:|paired-end|Sequence|C methylated' \
> /gscratch/scrubbed/strigg/analyses/20190814_Salmo/mapping_efficiency_summary.txt

#run methylation extractor
/gscratch/srlab/programs/Bismark-0.19.0/bismark_methylation_extractor \
--paired-end --bedGraph --counts --scaffolds \
--multicore 28 \
/gscratch/scrubbed/strigg/analyses/20190814_Salmo/*.bam \
-o /gscratch/scrubbed/strigg/analyses/20190814_Salmo/ \
--samtools /gscratch/srlab/programs/samtools-1.9/samtools \
2> /gscratch/scrubbed/strigg/analyses/20190814_Salmo/bme.err

#create bismark reports for individual samlpes
/gscratch/srlab/programs/Bismark-0.19.0/bismark2report

#create bismark summary report for all samples
/gscratch/srlab/programs/Bismark-0.19.0/bismark2summary

#Run coverage2cytosine command to generate cytosine coverage files
find /gscratch/scrubbed/strigg/analyses/20190814_Salmo/*.cov.gz \
| xargs basename -s _R1_001_val_1_bismark_bt2_pe.bismark.cov.gz \
| xargs -I{} /gscratch/srlab/programs/Bismark-0.19.0/coverage2cytosine --gzip \
--genome_folder /gscratch/srlab/strigg/data/Ssalar/GENOMES \
-o /gscratch/scrubbed/strigg/analyses/20190814_Salmo/{}_cytosine_CpG_cov_report \
/gscratch/scrubbed/strigg/analyses/20190814_Salmo/{}_R1_001_val_1_bismark_bt2_pe.bismark.cov.gz

#compile and sort bams for methylkit
find /gscratch/scrubbed/strigg/analyses/20190814_Salmo/*.bam| \
xargs basename -s _R1_001_val_1_bismark_bt2_pe.bam | xargs -I{} /gscratch/srlab/programs/samtools-1.9/samtools \
sort /gscratch/scrubbed/strigg/analyses/20190814_Salmo/{}_R1_001_val_1_bismark_bt2_pe.bam \
-o /gscratch/scrubbed/strigg/analyses/20190814_Salmo/{}.sorted.bam

