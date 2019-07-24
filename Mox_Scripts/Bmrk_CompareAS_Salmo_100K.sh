#!/bin/bash
## Job Name
#SBATCH --job-name=Bmrk_CompareAS_Salmo_100K
## Allocation Definition 
#SBATCH --account=srlab
#SBATCH --partition=srlab
## Resources
## Nodes 
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=04-15:30:00
## Memory per node
#SBATCH --mem=500G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=strigg@uw.edu
## Specify the working directory for this job
#SBATCH --workdir=/gscratch/srlab/strigg/analyses/20190725


#align with bismark
%%bash
find /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/*R1_001_trimmed.5bp_3prime.fq.gz \
| xargs basename -s _R1_001_trimmed.5bp_3prime.fq.gz | xargs -I{} /gscratch/srlab/programs/Bismark-0.19.0/bismark \
--path_to_bowtie /gscratch/srlab/programs/bowtie2-2.3.4.1-linux-x86_64 \
--samtools_path /gscratch/srlab/programs/samtools-1.9 \
--score_min L,0,-0.2 \
-p 28 \
-u 100000 \
--non_directional \
--genome /gscratch/srlab/strigg/data/Ssalar/GENOMES \
-1 /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/{}_R1_001_trimmed.5bp_3prime.fq.gz \
-2 /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/{}_R2_001_trimmed.5bp_3prime.fq.gz \
-o /gscratch/srlab/strigg/analyses/20190725/AS-0.2



#align with bismark
%%bash
find /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/*R1_001_trimmed.5bp_3prime.fq.gz \
| xargs basename -s _R1_001_trimmed.5bp_3prime.fq.gz | xargs -I{} /gscratch/srlab/programs/Bismark-0.19.0/bismark \
--path_to_bowtie /gscratch/srlab/programs/bowtie2-2.3.4.1-linux-x86_64 \
--samtools_path /gscratch/srlab/programs/samtools-1.9 \
--score_min L,0,-0.6 \
-p 28 \
-u 100000 \
--non_directional \
--genome /gscratch/srlab/strigg/data/Ssalar/GENOMES \
-1 /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/{}_R1_001_trimmed.5bp_3prime.fq.gz \
-2 /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/{}_R2_001_trimmed.5bp_3prime.fq.gz \
-o /gscratch/srlab/strigg/analyses/20190725/AS-0.6


#align with bismark
%%bash
find /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/*R1_001_trimmed.5bp_3prime.fq.gz \
| xargs basename -s _R1_001_trimmed.5bp_3prime.fq.gz | xargs -I{} /gscratch/srlab/programs/Bismark-0.19.0/bismark \
--path_to_bowtie /gscratch/srlab/programs/bowtie2-2.3.4.1-linux-x86_64 \
--samtools_path /gscratch/srlab/programs/samtools-1.9 \
--score_min L,0,-1 \
-p 28 \
-u 100000 \
--non_directional \
--genome /gscratch/srlab/strigg/data/Ssalar/GENOMES \
-1 /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/{}_R1_001_trimmed.5bp_3prime.fq.gz \
-2 /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/{}_R2_001_trimmed.5bp_3prime.fq.gz \
-o /gscratch/srlab/strigg/analyses/20190725/AS-1


#align with bismark
%%bash
find /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/*R1_001_trimmed.5bp_3prime.fq.gz \
| xargs basename -s _R1_001_trimmed.5bp_3prime.fq.gz | xargs -I{} /gscratch/srlab/programs/Bismark-0.19.0/bismark \
--path_to_bowtie /gscratch/srlab/programs/bowtie2-2.3.4.1-linux-x86_64 \
--samtools_path /gscratch/srlab/programs/samtools-1.9 \
--score_min L,0,-1 \
-I 60 \
-p 28 \
-u 100000 \
--non_directional \
--genome /gscratch/srlab/strigg/data/Ssalar/GENOMES \
-1 /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/{}_R1_001_trimmed.5bp_3prime.fq.gz \
-2 /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/{}_R2_001_trimmed.5bp_3prime.fq.gz \
-o /gscratch/srlab/strigg/analyses/20190725/AS-1_I60


#align with bismark
%%bash
find /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/*R1_001_trimmed.5bp_3prime.fq.gz \
| xargs basename -s _R1_001_trimmed.5bp_3prime.fq.gz | xargs -I{} /gscratch/srlab/programs/Bismark-0.19.0/bismark \
--path_to_bowtie /gscratch/srlab/programs/bowtie2-2.3.4.1-linux-x86_64 \
--samtools_path /gscratch/srlab/programs/samtools-1.9 \
--score_min L,0,-1.2 \
-I 60 \
-p 28 \
-u 100000 \
--non_directional \
--genome /gscratch/srlab/strigg/data/Ssalar/GENOMES \
-1 /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/{}_R1_001_trimmed.5bp_3prime.fq.gz \
-2 /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/{}_R2_001_trimmed.5bp_3prime.fq.gz \
-o /gscratch/srlab/strigg/analyses/20190725/AS-1.2_I60

#align with bismark
%%bash
find /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/*R1_001_trimmed.5bp_3prime.fq.gz \
| xargs basename -s _R1_001_trimmed.5bp_3prime.fq.gz | xargs -I{} /gscratch/srlab/programs/Bismark-0.19.0/bismark \
--path_to_bowtie /gscratch/srlab/programs/bowtie2-2.3.4.1-linux-x86_64 \
--samtools_path /gscratch/srlab/programs/samtools-1.9 \
--score_min L,0,-2 \
-p 28 \
-u 100000 \
--non_directional \
--genome /gscratch/srlab/strigg/data/Ssalar/GENOMES \
-1 /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/{}_R1_001_trimmed.5bp_3prime.fq.gz \
-2 /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/{}_R2_001_trimmed.5bp_3prime.fq.gz \
-o /gscratch/srlab/strigg/analyses/20190725/AS-2


#concatenate sample reports from each bismark run

!cat /gscratch/srlab/strigg/analyses/20190725/AS-0.2/*PE_report.txt | \
grep -E 'Mapping\ efficiency\:|paired-end|Sequence|C methylated' \
> /gscratch/srlab/strigg/analyses/20190725/AS-0.2/AS0.2_mapping_CpG_summary.txt

!cat /gscratch/srlab/strigg/analyses/20190725/AS-0.6/*PE_report.txt | \
grep -E 'Mapping\ efficiency\:|paired-end|Sequence|C methylated' \
awk -F"\t" '{print $2}' \
> /gscratch/srlab/strigg/analyses/20190725/AS-0.6/AS0.6_mapping_CpG_summary.txt

!cat /gscratch/srlab/strigg/analyses/20190725/AS-1/*PE_report.txt | \
grep -E 'Mapping\ efficiency\:|paired-end|Sequence|C methylated' \
awk -F"\t" '{print $2}' \
> /gscratch/srlab/strigg/analyses/20190725/AS-1/AS1_mapping_CpG_summary.txt

!cat /gscratch/srlab/strigg/analyses/20190725/AS-1_I60/*PE_report.txt | \
grep -E 'Mapping\ efficiency\:|paired-end|Sequence|C methylated' \
awk -F"\t" '{print $2}' \
> /gscratch/srlab/strigg/analyses/20190725/AS-1_I60/AS1_I60_mapping_CpG_summary.txt

!cat /gscratch/srlab/strigg/analyses/20190725/AS-1.2_I60/*PE_report.txt | \
grep -E 'Mapping\ efficiency\:|paired-end|Sequence|C methylated' \
awk -F"\t" '{print $2}' \
> /gscratch/srlab/strigg/analyses/20190725/AS-1.2_I60/AS1.2_I60_mapping_CpG_summary.txt

!cat /gscratch/srlab/strigg/analyses/20190725/AS-2/*PE_report.txt | \
grep -E 'Mapping\ efficiency\:|paired-end|Sequence|C methylated' \
awk -F"\t" '{print $2}' \
> /gscratch/srlab/strigg/analyses/20190725/AS-2/AS2_mapping_CpG_summary.txt

#paste columns together

!paste -d'\t' \
/gscratch/srlab/strigg/analyses/20190725/AS-0.2/AS0.2_mapping_CpG_summary.txt \
/gscratch/srlab/strigg/analyses/20190725/AS-0.6/AS0.6_mapping_CpG_summary.txt \
/gscratch/srlab/strigg/analyses/20190725/AS-1/AS1_mapping_CpG_summary.txt \
/gscratch/srlab/strigg/analyses/20190725/AS-1_I60/AS1_I60_mapping_CpG_summary.txt \
/gscratch/srlab/strigg/analyses/20190725/AS-1.2_I60/AS1.2_I60_mapping_CpG_summary.txt \
/gscratch/srlab/strigg/analyses/20190725/AS-2/AS2_mapping_CpG_summary.txt \
> /gscratch/srlab/strigg/analyses/20190725/bismarkASthreshold_bigger_comparison.txt


