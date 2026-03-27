#!/bin/bash

#SBATCH --mem=24GB
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH -p common,scavenger
#SBATCH --output=/work/ef169/nrc_practice/analysis/stats/vcf_stats.out

source /hpc/group/magwenelab/ef169/programs/miniconda3/etc/profile.d/conda.sh

conda activate popgen

## Function to get vcf stats to filter

vcftools_stats(){
	local VCF=$1
	local VCF_FN=$2
	local OUT_DIR=$3
	## Mean missing data per site
	vcftools --gzvcf $VCF --missing-site --out $OUT_DIR/$VCF_FN"_miss_per_site"
	## Mean missing data per sample
	vcftools --gzvcf $VCF --missing-indv --out $OUT_DIR/$VCF_FN"_miss_per_sample"
	## Allele frequency
	vcftools --gzvcf $VCF --freq2 --out $OUT_DIR/$VCF_FN"_freq" --max-alleles 2
	## Mean depth per sample
	vcftools --gzvcf $VCF --depth --out $OUT_DIR/$VCF_FN"_depth"
	## Mean depth per site
	vcftools --gzvcf $VCF --site-mean-depth --out $OUT_DIR/$VCF_FN"_dp_per_site"
	## Mean quality per site
	vcftools --gzvcf $VCF --site-quality --out $OUT_DIR/$VCF_FN"_qual_per_site"
}

### Run function

VCF=/work/ef169/nrc_practice/data/03192026_chr21_10KSNPs_sorted.vcf.gz
OUT_DIR=/work/ef169/nrc_practice/analysis/stats
FN="03192026_chr21_10KSNPs"

vcftools_stats $VCF $FN $OUT_DIR

