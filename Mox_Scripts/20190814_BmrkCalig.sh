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
#SBATCH --time=14-23:30:00
## Memory per node
#SBATCH --mem=500G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=strigg@uw.edu
## Specify the working directory for this job
#SBATCH --chdir=/gscratch/scrubbed/strigg/analyses/20190814_Calig


#align with bismark

%%bash

find /gscratch/scrubbed/strigg/TRIMG_adapt_5bp/TRIM_cat/Sealice*R1_001_val_1.fq.gz \
| xargs basename -s _R1_001_val_1.fq.gz| xargs -I{} /gscratch/srlab/programs/Bismark-0.19.0/bismark \
--path_to_bowtie /gscratch/srlab/programs/bowtie2-2.3.4.1-linux-x86_64 \
--samtools_path /gscratch/srlab/programs/samtools-1.9 \
--score_min L,0,-0.6 \
-p 4 \
--non_directional \
--dovetail \
--genome /gscratch/srlab/strigg/data/Caligus/GENOMES \
-1 /gscratch/scrubbed/strigg/TRIMG_adapt_5bp/TRIM_cat/{}_R1_001_val_1.fq.gz \
-2 /gscratch/scrubbed/strigg/TRIMG_adapt_5bp/TRIM_cat/{}_R2_001_val_2.fq.gz \
-o /gscratch/scrubbed/strigg/analyses/20190814_Calig

#run deduplicaiton
%%bash
/gscratch/srlab/programs/Bismark-0.19.0/deduplicate_bismark \
--bam -p \
/gscratch/scrubbed/strigg/analyses/20190814_Calig/*.bam \
-o /gscratch/scrubbed/strigg/analyses/20190814_Calig/ \
2> /gscratch/scrubbed/strigg/analyses/20190814_Calig/dedup.err \
--samtools_path /gscratch/srlab/programs/samtools-1.9/


#create summary report
cat /gscratch/scrubbed/strigg/analyses/20190814_Calig/*PE_report.txt | \
grep -E 'Mapping\ efficiency\:|paired-end|Sequence|C methylated' \
cat - /gscratch/scrubbed/strigg/analyses/20190814_Calig/*.deduplication_report.txt | \
grep 'Mapping\ efficiency\:\|removed' \
> /gscratch/scrubbed/strigg/analyses/20190814_Calig/mapping_dedup_summary.txt

#run methylation extractor
/gscratch/srlab/programs/Bismark-0.19.0/bismark_methylation_extractor \
--paired-end --bedGraph --counts --scaffolds \
--multicore 28 \
/gscratch/scrubbed/strigg/analyses/20190814_Calig/*deduplicated.bam \
-o /gscratch/scrubbed/strigg/analyses/20190814_Calig/ \
--samtools /gscratch/srlab/programs/samtools-1.9/samtools \
2> /gscratch/scrubbed/strigg/analyses/20190814_Calig/bme.err

#create bismark reports for individual samlpes
/gscratch/srlab/programs/Bismark-0.19.0/bismark2report

#create bismark summary report for all samples
/gscratch/srlab/programs/Bismark-0.19.0/bismark2summary

#Run coverage2cytosine command to generate cytosine coverage files
find /gscratch/scrubbed/strigg/analyses/20190814_Calig/*.cov.gz \
| xargs basename -s _R1_001_val_1_bismark_bt2_pe.deduplicated.bismark.cov.gz \
| xargs -I{} /gscratch/srlab/programs/Bismark-0.19.0/coverage2cytosine --gzip \
--genome_folder /gscratch/srlab/strigg/data/Caligus/GENOMES \
-o /gscratch/scrubbed/strigg/analyses/20190814_Calig/{}_cytosine_CpG_cov_report \
/gscratch/scrubbed/strigg/analyses/20190814_Calig/{}_R1_001_val_1__bismark_bt2_pe.deduplicated.bismark.cov.gz

#compile and sort bams for methylkit
find /gscratch/scrubbed/strigg/analyses/20190814_Calig/**deduplicated.bam| \
xargs basename -s _R1_001_val_1_bismark_bt2_pe.deduplicated.bam | xargs -I{} /gscratch/srlab/programs/samtools-1.9/samtools \
sort /gscratch/scrubbed/strigg/analyses/20190814_Calig/{}_R1_001_val_1_bismark_bt2_pe.deduplicated.bam \
-o /gscratch/scrubbed/strigg/analyses/20190814_Calig/{}.sorted.bam



