#!/bin/bash

source /home/efigueroa/programs/miniforge3/etc/profile.d/mamba.sh
mamba activate popgen

### LD pruning and PCA

## This script is used to perform LD pruning and PCA on a VCF file
## The script uses plink2 to perform the LD pruning and PCA
ld_prun_pca(){
	local VCF=$1
	local FN=$2
	local OUT_DIR=$3
    local r2=$4
    local maf=$5
    local geno=$6
    local mind=$7
	
    ## LD pruning r2 treshold
	## This command generates a list of SNPs to be prunned based on the LD

    OUT="${OUT_DIR}/${FN}_r${r2}_maf${maf}_geno${geno}_mind${mind}"
    echo "LD pruning with r2=$r2, maf=$maf, geno=$geno, mind=$mind"

	plink2 --vcf $VCF --allow-extra-chr --set-missing-var-ids @:# --double-id \
	--indep-pairwise 50 10 $r2 --maf $maf --geno $geno --mind $mind --out $OUT

    ## PCA 
    ## This command generates a PCA results

    plink2 --vcf $VCF --allow-extra-chr --set-missing-var-ids @:# --double-id \
    --extract $OUT.prune.in --make-bed --export 12 ped --pca biallelic-var-wts --out $OUT"_pca" 

}

###### Running the functions

OUT_DIR=/FastData/efigueroa/popgenomics/pop_structure/pca/VNI_x1191/no_mac_filtered
VCF=/FastData/efigueroa/popgenomics/variants_gatk/mapping/diploid_vcfs/VNI_x1202/6_final_VCFs/For_popgen/VNI_x1191_maf0_AD1_miss10_filtered_samples_ann.vcf.gz
FN="03052026_VNI_x1191"
r2=0.5
maf=0
geno=0.1
mind=0.5

ld_prun_pca $VCF $FN $OUT_DIR $r2 $maf $geno $mind