setwd("~/path/to/working/directory")
#install.packages("ggplot2")
#install.packages("ggrepel")
library(ggplot2)
library(ggrepel)

##create a .csv with Eigen values for "PCo 1" and "PCo 2". Add site names as "pop" and add columns for "site", "depth" and "size"(size used to change point size on plot)
pCoa=read.csv("PCoa.csv")
pCoa
#----------------------------------
##Plotting PCoA
PCoA=ggplot(pCoa,aes(x=PCo1,y=PCo2,label=pop))+
    	geom_point(aes(colour=factor(site),size=factor(depth),shape=factor(depth)))+
	scale_color_manual(values=c("#D0B03C","#8EB33B","#C75646","#218693"))+
    	scale_shape_manual(values=c(17,18,15,19))+
    	scale_size_manual(values=c(4.5,6.5,5,5))+ 
	geom_hline(yintercept=0,colour="black",size=0.5)+
	geom_vline(xintercept=0,colour="black",size=0.5)+
	xlab("PCo 1 (34.69%)")+
	ylab("PCo 2 (11.72%)")+
	geom_text_repel(colour="black",nudge_x=0.015,segment.colour="transparent", size=4.5)+
	theme_bw()
	
PCoA+theme(axis.title.x=element_text(colour="black",size=20),
		axis.text.x=element_blank(),
		axis.ticks.x=element_blank(),
		axis.line.x=element_blank(),
		axis.title.y=element_text(colour="black",size=20),
		axis.text.y=element_blank(),
		axis.ticks.y=element_blank(),
		axis.line.y=element_blank(),
		legend.position="none",
		panel.border=element_rect(colour="black",size=1.5),
		panel.background=element_blank(),
		plot.background=element_blank(),
		panel.grid.major=element_blank(),
		panel.grid.minor=element_blank())
		
#----------------------------------
##Save plot
ggsave("PCoA.tiff", plot=last_plot(),scale=1,dpi=300,device="tiff")
ggsave("PCoA.eps", plot=last_plot(),scale=1,dpi=300,device="eps")