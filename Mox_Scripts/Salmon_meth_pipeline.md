# Library Prep Methods
[https://shellytrigg.github.io/93th-post/](https://shellytrigg.github.io/93th-post/)
[https://shellytrigg.github.io/94th-post/](https://shellytrigg.github.io/94th-post/)
[https://shellytrigg.github.io/107th-post/](https://shellytrigg.github.io/107th-post/)
[https://shellytrigg.github.io/110th-post/](https://shellytrigg.github.io/110th-post/)
[https://shellytrigg.github.io/120th-post/](https://shellytrigg.github.io/120th-post/)
[https://shellytrigg.github.io/121th-post/](https://shellytrigg.github.io/121th-post/)
[https://shellytrigg.github.io/122th-post/](https://shellytrigg.github.io/122th-post/)
[https://shellytrigg.github.io/123th-post/](https://shellytrigg.github.io/123th-post/)

---

# Raw data
Notebook entry: [https://shellytrigg.github.io/130th-post/](https://shellytrigg.github.io/130th-post/)

Meta data: [MetaData\_SalmonSealice\_for_nightingales](https://docs.google.com/spreadsheets/d/1LM3-sf1IkK5jFR4Apc0gG73TEB9NOuxF9t9nWjffyu0/edit#gid=0)

Data location on Gannet: [https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/FASTQS/UW_Trigg_190718_done/](https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/FASTQS/UW_Trigg_190718_done/)

Tar zip file of all raw data on Gannet: [https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/FASTQS/UW_Trigg_190718.tar.gz](https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/FASTQS/UW_Trigg_190718.tar.gz)

---

# Trimming

notebook post: [https://shellytrigg.github.io/315th-post/](https://shellytrigg.github.io/315th-post/)

mox script for trimming reads: [https://gannet.fish.washington.edu/metacarcinus/mox_jobs/20200427_TG_SalmoCalig.sh](https://gannet.fish.washington.edu/metacarcinus/mox_jobs/20200427_TG_SalmoCalig.sh)

log file: [https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20200427/slurm-2535023.out](https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20200427/slurm-2535023.out)

Trimmed reads are here: [https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20200427/TG_PE_FASTQS/](https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20200427/TG_PE_FASTQS/)

FastQC: [https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20200427/TG_PE_FASTQS/FastQC/](https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20200427/TG_PE_FASTQS/FastQC/)

script to concatenate fastqs from different lanes: [https://gannet.fish.washington.edu/metacarcinus/mox_jobs/20200612_CatTGlanes_Salmo.sh](https://gannet.fish.washington.edu/metacarcinus/mox_jobs/20200612_CatTGlanes_Salmo.sh)

log file: [https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20200612/slurm-2706792.out](https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20200612/slurm-2706792.out)

concatenated fastqs are here: [https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20200612/](https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20200612/)

---

# Genome Preparation

notebook post: [https://shellytrigg.github.io/171th-post/](https://shellytrigg.github.io/171th-post/)

jupyter notebook to exclude unplaced sequences from the genome: [https://github.com/shellytrigg/Salmon_sealice/blob/master/jupyter/Remove_unplaced_genome_seqs.ipynb](https://github.com/shellytrigg/Salmon_sealice/blob/master/jupyter/Remove_unplaced_genome_seqs.ipynb)

genome excluding unplaced sequences: [https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/GENOMES/v2/RefSeq/GCF_000233375.1_ICSASG_v2_genomic.fa](https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/GENOMES/v2/RefSeq/GCF_000233375.1_ICSASG_v2_genomic.fa)

mox script to build bismark genome: [https://gannet.fish.washington.edu/metacarcinus/mox_jobs/20190828_BmrkBld_Salmo1-29MT.sh](https://gannet.fish.washington.edu/metacarcinus/mox_jobs/20190828_BmrkBld_Salmo1-29MT.sh)

---

# Bismark Alignment

notebook post for testing alignment parameters: [https://shellytrigg.github.io/315th-post/](https://shellytrigg.github.io/315th-post/)

notebook post for aligning salmon reads to genome: [https://shellytrigg.github.io/320th-post/](https://shellytrigg.github.io/320th-post/)

```
#!/bin/bash
## Job Name
#SBATCH --job-name=BmrkAln_Salmo
## Allocation Definition 
#SBATCH --account=srlab
#SBATCH --partition=srlab
## Resources
## Nodes 
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=5-23:30:00
## Memory per node
#SBATCH --mem=500G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=strigg@uw.edu
## Specify the working directory for this job
#SBATCH --chdir=/gscratch/scrubbed/strigg/analyses/20200613


%%bash

#record each command that is called in slurm file

set -ex

#add paths to programs to bash profile

source /gscratch/srlab/strigg/bin/paths.sh

#print the path of the programs

which samtools
which bowtie2
which bismark

#define genome folder

genome_folder="/gscratch/srlab/strigg/data/Ssalar/GENOMES/chr1-29MT"

#run bismark in PE mode on trimmed reads

find /gscratch/scrubbed/strigg/analyses/20200612/*_R1_001_val_1.fq.gz |\
xargs basename -s _R1_001_val_1.fq.gz| \
xargs -I{} bismark \
--score_min L,0,-0.3 \
-p 4 \
--non_directional \
--genome ${genome_folder} \
-1 /gscratch/scrubbed/strigg/analyses/20200612/{}_R1_001_val_1.fq.gz \
-2 /gscratch/scrubbed/strigg/analyses/20200612/{}_R2_001_val_2.fq.gz \

# deduplicate

find *.bam | \
xargs basename -s .bam | \
xargs -I{} deduplicate_bismark \
--bam \
--paired \
{}.bam

#run methylation extractor
bismark_methylation_extractor \
--paired-end \
--bedGraph \
--comprehensive \
--counts \
--scaffolds \
--multicore 14 \
--buffer_size 75% \
*.deduplicated.bam


#######################################################
### Generate bed graphs for IGV and bedtools analysis##
#######################################################

# Sort files for methylkit and IGV

find *.deduplicated.bam | \
xargs basename -s .bam | \
xargs -I{} samtools \
sort --threads 28 {}.bam \
-o {}.sorted.bam

# Index sorted files for IGV
# The "-@ 16" below specifies number of CPU threads to use.

find *.sorted.bam | \
xargs basename -s .sorted.bam | \
xargs -I{} samtools \
index -@ 28 {}.sorted.bam

# Run multiqc 

/gscratch/srlab/strigg/bin/anaconda3/bin/multiqc \
/gscratch/scrubbed/strigg/analyses/20200612/ \
/gscratch/scrubbed/strigg/analyses/20200613/

# create merged
find *.deduplicated.bismark.cov.gz |\
xargs basename -s .deduplicated.bismark.cov.gz |\
xargs -I{} coverage2cytosine \
--genome_folder ${genome_folder} \
-o {} \
--merge_CpG \
--zero_based \
{}.deduplicated.bismark.cov.gz


#creating tab files with % me, raw mCpG and total CpG counts

for f in *merged_CpG_evidence.cov
do
  STEM=$(basename "${f}" .CpG_report.merged_CpG_evidence.cov)
  cat "${f}" | awk -F $'\t' 'BEGIN {OFS = FS} {if ($5+$6 >= 5) {print $1, $2, $3, $4, $5, $5+$6}}' \
  > "${STEM}"_5x.bed
done



```
---

**Original script:** 

[https://gannet.fish.washington.edu/metacarcinus/mox_jobs/20200613_BmrkAln_Salmo.sh](https://gannet.fish.washington.edu/metacarcinus/mox_jobs/20200613_BmrkAln_Salmo.sh)

**Log file:** 

[https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20200613/slurm-2708939.out](https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20200613/slurm-2708939.out)


**All Output from Bismark Aligment:**

[https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20200613/](https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20200613/)

**multiqc summary report:** [https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20200613/multiqc_report.html](https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20200613/multiqc_report.html)


---

# DMR analysis

noebook post: [https://shellytrigg.github.io/320th-post/](https://shellytrigg.github.io/320th-post/)

### Genomic feature analysis 

notebook post: [https://shellytrigg.github.io/350th-post/](https://shellytrigg.github.io/350th-post/)

---


# RNAseq

notebook post: [https://shellytrigg.github.io/375th-post/](https://shellytrigg.github.io/375th-post/)

rsync log for copying raw data locally: [https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20201027/readme.txt](https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20201027/readme.txt)

fastqc on raw data: [https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20201104/fastqc/](https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20201104/fastqc/)

nf-core screen log: [https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20201027/screenlog.1103](https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20201027/screenlog.1103)

results: [https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20201027/results/](https://gannet.fish.washington.edu/metacarcinus/Salmo_Calig/analyses/20201027/results/)

Sam White's RNA-seq analysis:

- trimming: [https://robertslab.github.io/sams-notebook/2020/10/29/Trimming-Shelly-S.salar-RNAseq-Using-fastp-and-MultiQC-on-Mox.html](https://robertslab.github.io/sams-notebook/2020/10/29/Trimming-Shelly-S.salar-RNAseq-Using-fastp-and-MultiQC-on-Mox.html)
- alignments: 
	- [https://robertslab.github.io/sams-notebook/2020/11/04/RNAseq-Alignments-S.salar-HISAT2-BAMs-to-GCF_000233375.1_ICSASG_v2_genomic.gtf-Transcriptome-Using-StringTie-on-Mox.html](https://robertslab.github.io/sams-notebook/2020/11/04/RNAseq-Alignments-S.salar-HISAT2-BAMs-to-GCF_000233375.1_ICSASG_v2_genomic.gtf-Transcriptome-Using-StringTie-on-Mox.html)
	- [https://robertslab.github.io/sams-notebook/2020/11/03/RNAseq-Alignments-Trimmed-S.salar-RNAseq-to-GCF_000233375.1_ICSASG_v2_genomic.fa-Using-Hisat2-on-Mox.html](https://robertslab.github.io/sams-notebook/2020/11/03/RNAseq-Alignments-Trimmed-S.salar-RNAseq-to-GCF_000233375.1_ICSASG_v2_genomic.fa-Using-Hisat2-on-Mox.html)