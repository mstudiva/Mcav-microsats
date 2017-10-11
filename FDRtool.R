setwd("~/path/to/working/directory/")

# install.packages("fdrtool")

library(fdrtool)
library(reshape2)

#-----------------------------
# Hardy-Weinberg Equilibrium

import HWE table generated from GenAlEx
hwe <- read.csv("HWE_FDR.csv", head=TRUE)
str(hwe)

# runs FDR correction on p values
hwe.fdr <- fdrtool(hwe$Prob, statistic="pvalue")
# save plots

# outputs, q values are corrected p values
hwe.fdr$qval # estimated FDR values
hwe.fdr$lfdr # estimated local FDR

# adds q value as column in datafram
hwe$qval <- hwe.fdr$qval
hwe

# exports table with corrected q values
write.csv(hwe, file="HWE_FDR_corrected.csv")

#-----------------------------
# Linkage Disequilibrium

import LD table generated from Arlequin
ld <- read.csv("LD_FDR.csv", head=TRUE)
str(ld)

# runs FDR correction on p values
ld.fdr <- fdrtool(ld$pval, statistic="pvalue")
# save plots

# outputs, q values are corrected p values
ld.fdr$qval # estimated FDR values
ld.fdr$lfdr # estimated local FDR

# adds q value as column in datafram
ld$qval <- ld.fdr$qval
ld

# exports table with corrected q values
write.csv(ld, file="LD_FDR_corrected.csv")

#-----------------------------
# Fst pairwise by population

# import Fst table generated from GenAlEx
fst <- read.csv("Fst_FDR.csv", head=TRUE)
names(fst) <- c("X","CBC-meso", "CBC-shallow", "WFGB-meso", "WFGB-shallow", "EFGB-meso", "EFGB-shallow", "BRT-meso", "MCG-meso", "PRG-meso", "TER-shallow")
# maintains column order as given
fst$X <- factor(fst$X, levels=unique(fst$X))
fst <- melt(fst, na.rm = TRUE)
fst
str(fst)

# optional export of melted p values for web-based FDR correction calculator
# FDRtool cannot process a small number of p values, as those in an Fst matrix
write.csv(fst, file="Fst_FDR_corrected.csv")
# http://www.sdmproject.com/utilities/?show=FDR

# runs FDR correction on p values
fst.fdr <- fdrtool(fst$value, statistic="pvalue")
# save plots

# outputs, q values are corrected p values
fst.fdr$qval # estimated FDR values
fst.fdr$lfdr # estimated local FDR

# adds q value as column in datafram
fst$qval <- fst.fdr$qval
fst

# exports table with corrected q values
write.csv(fst, file="Fst_FDR_corrected.csv")