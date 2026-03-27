#!/bin/bash

#SBATCH --mem=24GB
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -p common,scavenger
#SBATCH --output=/work/ef169/intro_linux/download_chr21.out

source /hpc/group/magwenelab/ef169/programs/miniconda3/etc/profile.d/conda.sh

cd /work/ef169/intro_linux/data

wget https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000G_2504_high_coverage/working/20190425_NYGC_GATK/CCDG_13607_B01_GRM_WGS_2019-02-19_chr21.recalibrated_variants.vcf.gz



