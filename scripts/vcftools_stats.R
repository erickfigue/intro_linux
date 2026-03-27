#install.packages("tidyverse")
#install.packages("ggplot2")
#install.packages("patchwork")

library(dplyr)
library(ggplot2)
library(patchwork)

setwd("/work/ef169/intro_linux/scripts/stats")

##################### Loading plotting functions ###################### 

source("/work/ef169/intro_linux/scripts/vcftools_stats_plot_functions.R")

FN="03192026_chr21_10KSNPs"
OUT_FN="03202026_chr21_10KSNPs"

###### Missing data per site ######

msite_df <- read.table(paste0(FN,"_miss_per_site.lmiss"),header = T)

msite_plot <- miss_site_stats(msite_df)

ggsave(paste0(OUT_FN,"_miss_per_site.png"),msite_plot, height = 4, width = 7)

###### Missing data per sample ######

msample_df <- read.table(paste0(FN,"_miss_per_sample.imiss"),header = T)

msample_plot <- miss_sample_stats(msample_df)

ggsave(paste0(OUT_FN,"_miss_per_sample.png"),msample_plot, height = 4, width = 7)

###### MAF ######

af_df <- read.delim(paste0(FN,"_freq.frq"), sep = '\t',
                              col.names = c("CHR", "POS", "N_ALLELES", "N_CHR", "A1", "A2"))

af_df$MAF <- af_df %>% select(A1, A2) %>% apply(1, function(z) min(z))

af_plot <- allele_freq_dist(af_df)

ggsave(paste0(OUT_FN,"_MAF.png"),af_plot, height = 4, width = 7)

###### Depth per site ######

dp_site_df <- read.delim(paste0(FN,"_dp_per_site.ldepth.mean"),
                                sep = "\t",col.names = c("CHR","POS","MEAN_DEPTH","VAR_DEPTH"))
dp_site_plot <- depth_site(dp_site_df)

ggsave(paste0(OUT_FN,"_dp_per_site.png"),dp_site_plot, height = 4, width = 7)

###### Depth per sample ######

depth_sample_df <- read.delim(paste0(FN,"_depth.idepth"),
                                   sep = "\t")
depth_sample_plot <- depth_sample(depth_sample_df)

ggsave(paste0(OUT_FN,"_depth_per_sample.png"),depth_sample_plot, height = 4, width = 7)

###### Qual per site ######

qual_df <- read.delim(paste0(FN,"_qual_per_site.lqual"),
                                   sep = "\t",col.names = c("CHR","POS","QUAL"))
qual_plot <- qual_site(qual_df)

ggsave(paste0(OUT_FN,"_qual_per_site.png"),qual_plot, height = 4, width = 7)


