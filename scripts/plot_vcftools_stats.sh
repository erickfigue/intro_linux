#!/bin/bash

#SBATCH --mem=24GB
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -p common,scavenger
#SBATCH --output=/work/ef169/intro_linux/analysis/stats/plot_vcf_stats.out

source /hpc/group/magwenelab/ef169/programs/miniconda3/etc/profile.d/conda.sh

conda activate popgen

## Run R script to plot stats

cd /work/ef169/nrc_practice/

Rscript vcftools_stats.R

