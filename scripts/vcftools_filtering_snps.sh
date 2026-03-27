#!/bin/bash

source /home/efigueroa/miniforge3/etc/profile.d/conda.sh ## Update to conda
conda activate popgen

vcftools_filtering(){
	local VCF=$1
	local FN=$2
    local OUT_DIR=$3
    local alleles=$4
    local mindp=$5
    local maxmiss=$6
    local minmaf=$7
	local GQ=$8

    OUT="${OUT_DIR}/${FN}_${alleles}all_dp${mindp}_miss${maxmiss}_maf${minmaf}_minGQ${GQ}"

	vcftools --gzvcf $VCF \
	--min-alleles $alleles --max-alleles $alleles \
	--min-meanDP $mindp --minDP $mindp \
	--max-missing $maxmiss --mac $minmaf \
	--minGQ $GQ \
	--out $OUT \
	--recode --recode-INFO-all \
	--stdout | bgzip -c > $OUT".vcf.gz"

	tabix $OUT".vcf.gz"
}

OUT_DIR=/FastData/efigueroa/popgenomics/variants_gatk/mapping/diploid_vcfs/VNI_x1202/4_vcftools/1_snps_filtering
VCF=/FastData/efigueroa/popgenomics/variants_gatk/mapping/diploid_vcfs/VNI_x1202/3_nocentromere/VNI_x1202_snps_HardFiltered_noCent.vcf.gz
FN="VNI_x1202_nocent_diploid_snps"
alleles=2
mindp=5
maxmiss=0.9
minmaf=0
GQ=30

# Run the function 1
#vcftools_filtering $VCF $FN $OUT_DIR $alleles $mindp $maxmiss $minmaf $GQ

# Run the function 2
alleles=2
mindp2=5
maxmiss2=0.9
minmaf2=0.005
GQ2=30
#vcftools_filtering $VCF $FN $OUT_DIR $alleles $mindp2 $maxmiss2 $minmaf2 $GQ2

# Run the function 2
alleles=2
mindp3=5
maxmiss3=0.9
minmaf3=4
GQ3=30

vcftools_filtering $VCF $FN $OUT_DIR $alleles $mindp3 $maxmiss3 $minmaf3 $GQ3