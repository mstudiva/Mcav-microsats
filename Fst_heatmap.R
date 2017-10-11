setwd("~/path/to/working/directory/")

library(ggplot2)
library(reshape2)
library(stringr)

# reads in fst matrix
fst <- read.csv("fst.csv", head=TRUE)
# renames row headers
names(fst) <- c("X","CBC-meso", "CBC-shallow", "WFGB-meso", "WFGB-shallow", "EFGB-meso", "EFGB-shallow", "BRT-meso", "MCG-meso", "PRG-meso", "TER-shallow")
# maintains column order as given
fst$X <- factor(fst$X, levels=unique(fst$X))
fst

# reads in q value matrix
q <- read.csv("q.csv")
names(q) <- c("X","CBC-meso", "CBC-shallow", "WFGB-meso", "WFGB-shallow", "EFGB-meso", "EFGB-shallow", "BRT-meso", "MCG-meso", "PRG-meso", "TER-shallow")
q$X <- factor(q$X, levels=unique(q$X))
q

# melts fst and q value matrices into table used by ggplot2
# missing values (NA) not used
melted_fst <- melt(fst, na.rm = TRUE)
head(melted_fst)

melted_q <- melt(q, na.rm = TRUE)
head(melted_q)

# ggplot2 heatmap using geom_tile
# uses gradient of red color to denote increasing pop differentiation through Fst
# change the upper threshold based on your highest Fst
# geom_text puts the Fst value in each grid
# color and size ifelse statements under geom_text reference the q value matrix and base conditions on a q < 0.05 threshold
# blank theme removes axis labes and grid
# guides changes legend position
heatmap <- ggplot(data = melted_fst, aes(X, variable, fill = value)) + geom_tile(color = "white") + scale_fill_gradient2(low = "white", high = "red", midpoint = 0, limit = c(0,0.067), space = "Lab", name="Fst") + theme_minimal() + theme(axis.text.x = element_text(vjust = 1, size = 12, hjust = 0.5), axis.text.y = element_text(size=12))  + geom_text(data=subset(melted_fst, value != 0), aes(X, variable, label = value), color = ifelse(melted_q$value < 0.05, "black", "darkgrey"), size = ifelse(melted_q$value < 0.05, 4, 3)) + theme(
  axis.title.x = element_blank(),
  axis.title.y = element_blank(),
  panel.grid.major = element_blank(),
  panel.border = element_blank(),
  panel.background = element_blank(),
  axis.ticks = element_blank(),
  legend.justification = c(1, 0),
  legend.position = c(0.6, 0.7),
  legend.direction = "horizontal") + guides(fill = guide_colorbar(barwidth = 7, barheight = 1, title.position = "top", title.hjust = 0.5)) + scale_y_discrete(position="right") + scale_x_discrete(labels=str_wrap(melted_fst$X, width=6))
  
# saving plot
ggsave(filename="Fst heatmap.pdf", width=10, height=4)
ggsave(filename="Fst heatmap.eps", width=10, height=4)
