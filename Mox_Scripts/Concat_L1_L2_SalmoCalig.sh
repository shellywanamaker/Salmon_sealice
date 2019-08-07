#!/bin/bash
## Job Name
#SBATCH --job-name=Concat_L1_L2_SalmoCalig
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
#SBATCH --workdir=/gscratch/scrubbed/strigg/TRIM_cat

#concatenate files
%%bash
find /gscratch/srlab/strigg/data/Salmo_Calig/TRIM_1st5bp/*_L001_R1_001_trimmed.5bp_3prime.fq.gz \
| xargs basename -s _L001_R1_001_trimmed.5bp_3prime.fq.gz | xargs -I{} sh -c 'cat \
"/gscratch/srlab/strigg/data/Salmo_Calig/TRIM_1st5bp/$1_L001_R1_001_trimmed.5bp_3prime.fq.gz" \
"/gscratch/srlab/strigg/data/Salmo_Calig/TRIM_1st5bp/$1_L002_R1_001_trimmed.5bp_3prime.fq.gz" \
> "/gscratch/scrubbed/strigg/TRIM_cat/$1_R1_001_trimmed.5bp_3prime.fq.gz"' -- {}

find /gscratch/srlab/strigg/data/Salmo_Calig/TRIM_1st5bp/*_L001_R2_001_trimmed.5bp_3prime.fq.gz \
| xargs basename -s _L001_R2_001_trimmed.5bp_3prime.fq.gz | xargs -I{} sh -c 'cat \
"/gscratch/srlab/strigg/data/Salmo_Calig/TRIM_1st5bp/$1_L001_R2_001_trimmed.5bp_3prime.fq.gz" \
"/gscratch/srlab/strigg/data/Salmo_Calig/TRIM_1st5bp/$1_L002_R2_001_trimmed.5bp_3prime.fq.gz" \
> "/gscratch/scrubbed/strigg/TRIM_cat/$1_R2_001_trimmed.5bp_3prime.fq.gz"' -- {}
