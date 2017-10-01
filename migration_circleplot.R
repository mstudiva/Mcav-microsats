setwd("~/Documents/Grad_School/Dissertation/Data/Microsatellites/BayesAss/NWGOM")

# install.packages("migest")
# install.packages("circlize")

library(migest)
library(circlize)

# reading in migration and plot data
df0 <- read.csv("NWGOM_migration.csv", stringsAsFactors=FALSE)
df1 <- read.csv("NWGOM_plot.csv", stringsAsFactors=FALSE)
str(df1)

# default chord diagram, don't worry about colors or appearance
chordDiagram(x = df0)

#-----------------------
# plot parameters
circos.clear()

circos.par(start.degree = 90, gap.degree = 4, track.margin = c(-0.1, 0.1), points.overflow.warning = FALSE)
# increasing the gaps between sectors, start at 12 o'clock, ensure no gap between the chord and the sector at the begining
# subdue warning messages and have no margins in the plot
par(mar = rep(0, 4))

# chord diagram with user selected adjustments for bilateral migration flow data
chordDiagram(x = df0, grid.col = df1$col, transparency = 0.25,
	order = df1$region, directional = 1,
	direction.type = c("arrows", "diffHeight"), diffHeight  = -0.04,
	annotationTrack = "grid", annotationTrackHeight = c(0.05, 0.1),
	link.arr.type = "big.arrow", link.sort = FALSE, link.largest.ontop = TRUE)
# First line of arguments reads in the data (df0) and sets the colours base on the meta data (df1).
# Second line provides the order of outer sectors and indicates that chords should be directional.
# Third line indicates that the direction of the chords will be illustrated by both arrows and a difference in height. The height difference is negative to make the chord shorter at the end (with the arrow head).
# Fourth line ensures the annotations outside the sectors are not plotted, but provides a track measures to later add annotatinos such as labels and axis (see below).
# Fifth line indicates the plot should use big arrows, does not sort the chords left to right in each sector and plots the smallest chords first.

# add in labels and axis
circos.trackPlotRegion(
	track.index = 1, 
	bg.border = NA, 
	panel.fun = function(x, y) 
{
	xlim = get.cell.meta.data("xlim")
	sector.index = get.cell.meta.data("sector.index")
	reg1 = df1$reg1[df1$region == sector.index]
	reg2 = df1$reg2[df1$region == sector.index]
	circos.text(x = mean(xlim), y = ifelse(test = nchar(reg2) == 0, yes = 7.5, no = 	7.5), labels = reg1, facing = "bending", cex = 1.4)
	circos.text(x = mean(xlim), y = 5, labels = reg2, facing = "bending", cex = 		1.4)
	circos.axis(h = "top", major.tick=TRUE, major.at = seq(from = 0, to = 1, by = 		0.5), major.tick.percentage = 0.5, minor.ticks = 10, 								labels.niceFacing = FALSE)
}
)
# First line indicates that first track (rather than any other that may have been created) will be used.
# Second line ensures no borders are plotted on the track.
# Third line adds a track.
# Fourth and fifth line collect individual track meta data from plot object.
# Sixth and seventh line collect matching name information from plot data frame (df1).
# The first circos.text adds text from (reg1) at y = 7.5.
# The second circost.text adds text (reg2).
# The circos.axis add axis with major ticks every 0.5 and minor ticks at every 0.05, without flipping the axis labels in the bottom half. This plots the proportion of emigrants on a quantitative scale, with immigrants without a scale

##Printing
dev.copy2pdf(file = "NWGOM_migration.pdf", height=10, width=10)