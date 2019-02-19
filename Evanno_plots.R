setwd("~/path/to/working/directory/")

# install.packages("ggplot2")
library(ggplot2)
library(gridExtra)
#----------------------------------
# create a .csv with the Evanno output table 
structure<-read.csv("Evanno.csv", head=T)
str(structure)

ln<- ggplot(structure, aes(x=K,y=Mean.LnP.K.)) +
  geom_point(shape=21,size=3, colour="black", fill="grey75", stroke=1) +
  geom_errorbar(aes(ymin=Mean.LnP.K.-Stdev.LnP.K., ymax=Mean.LnP.K.+Stdev.LnP.K.), width=.2, position=position_dodge(.9))+
  xlab("Genetic Clusters (K)") +
  ylab("Mean Ln Probability") +
  ggtitle("L(K) (mean ± SD)")+
  scale_x_continuous(breaks=seq(1,13, by=2))+
  theme_bw() +theme(axis.title.x=element_text(color="black",size=20),
                           axis.text.x=element_text(color="black",size=16),
                           axis.title.y=element_text(color="black",size=20),
                           axis.text.y=element_text(color="black",size=16),
                           plot.title=element_text(color="black", size=20, hjust=0.5),
                           panel.border = element_rect(color="black", size=1.5),
                           axis.ticks = element_line(size=1))

deltaK<- ggplot(structure, aes(x=K,y=Delta.K)) +
  geom_path(size=1, color="black")+
  geom_point(shape=21,size=3, colour="black", fill="grey75", stroke=1) +
  xlab("Genetic Clusters (K)") +
  ylab("Delta K") +
  ggtitle("Delta K = mean(|L''(K)|) / sd(L(K))")+
  scale_x_continuous(breaks=seq(1,13, by=2))+
  theme_bw() +theme(axis.title.x=element_text(color="black",size=20),
                      axis.text.x=element_text(color="black",size=16),
                      axis.title.y=element_text(color="black",size=20),
                      axis.text.y=element_text(color="black",size=16),
                      plot.title=element_text(color="black", size=20, hjust=0.5),
                    panel.border = element_rect(color="black", size=1.5),
                      axis.ticks = element_line(size=1))

# creates window containing both plots
evanno<-grid.arrange(ln,deltaK, nrow=1)

# exports as PDF and EPS
ggsave("structure.pdf", plot=evanno,width=16,height=6,dpi=400,device="pdf")
ggsave("structure.eps", plot=evanno,width=16,height=6,dpi=400,device="eps")