
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
#SBATCH --time=10-15:30:00
## Memory per node
#SBATCH --mem=500G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=strigg@uw.edu
## Specify the working directory for this job
#SBATCH --workdir=/gscratch/srlab/strigg/analyses/20190729


#align with bismark

%%bash

find /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/*R1_001_trimmed.5bp_3prime.fq.gz \
| xargs basename -s _R1_001_trimmed.5bp_3prime.fq.gz | xargs -I{} /gscratch/srlab/programs/Bismark-0.19.0/bismark \
--path_to_bowtie /gscratch/srlab/programs/bowtie2-2.3.4.1-linux-x86_64 \
--samtools_path /gscratch/srlab/programs/samtools-1.9 \
--score_min <L,0,-1.2> \
-I <60> \
-p 28 \
--non_directional \
--genome /gscratch/srlab/strigg/data/Ssalar/GENOMES \
-1 /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/{}_R1_001_trimmed.5bcdp_3prime.fq.gz \
-2 /gscratch/srlab/strigg/data/Ssalar/FASTQS/TRIM_cat/{}_R2_001_trimmed.5bp_3prime.fq.gz \
-o /gscratch/srlab/strigg/analyses/20190729/Ssalar

### check in IGV is reads stack up

