#!/bin/bash

#SBATCH --mem=24GB
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -p common,scavenger
#SBATCH --output=/work/ef169/intro_linux/subset_chr21.out

source /hpc/group/magwenelab/ef169/programs/miniconda3/etc/profile.d/conda.sh

conda activate popgen

cd /work/ef169/intro_linux/data

VCF=/work/ef169/intro_linux/data/CCDG_13607_B01_GRM_WGS_2019-02-19_chr21.recalibrated_variants.vcf.gz

bcftools view --header-only  $VCF > subsample.vcf
bcftools view --no-header $VCF | awk '{printf("%f\t%s\n",rand(),$0);}' | sort -t $'\t' -k1,1g | cut -f2-  | head -n 10000 >>  subsample.vcf

bcftools sort subsample.vcf -Oz -o 03192026_chr21_10KSNPs_sorted.vcf.gz

