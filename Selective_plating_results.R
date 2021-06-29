#### load packages -------------------------------------------------------------
library(readxl)
library(dplyr)
library(plyr)
library(ggplot2)
library(tidyr)
library(gtools)
library(gplots)
library(NMF)
library(gridExtra)
library(ggpubr)

#### Custom functions ----------------------------------------------------------
fancy_scientific <- function(l) { 
  # turn in to character string in scientific notation 
  l <- format(l, scientific = TRUE) 
  # quote the part before the exponent to keep all the digits 
  l <- gsub("^(.*)e", "'\\1'e", l) 
  # turn the 'e+' into plotmath format 
  l <- gsub("e.*[^0-8]", "%*%10^", l) 
  # return this as an expression 
  parse(text=l) 
}


#### load data -----------------------------------------------------------------
plate_count_data <- data.frame(read_excel("source_files/Selective_plate_counts.xlsx",
                              sheet = "forR"))

#### Data wrangling ------------------------------------------------------------
TotMOB <- c()
TotMOB[1] <- sum(data[which(plate_count_data$MOB == "MOB1"),]$Counts)
TotMOB[2] <- sum(data[which(plate_count_data$MOB == "MOB2"),]$Counts)
TotMOB[3] <- sum(data[which(plate_count_data$MOB == "MOB3"),]$Counts)
TotMOB[4] <- sum(data[which(plate_count_data$MOB == "MOB4"),]$Counts)
TotMOB[5] <- sum(data[which(plate_count_data$MOB == "MOB5"),]$Counts)
TotMOB[6] <- sum(data[which(plate_count_data$MOB == "MOB6"),]$Counts)
TotMOB[7] <- sum(data[which(plate_count_data$MOB == "MOB7"),]$Counts)
TotMOB[8] <- sum(data[which(plate_count_data$MOB == "MOB8"),]$Counts)
TotMOB[9] <- sum(data[which(plate_count_data$MOB == "MOB9"),]$Counts)

order(TotMOB)

plate_count_data <- data.frame(plate_count_data)
plate_count_data$combi <- paste0(plate_count_data$MOB, "_", plate_count_data$HOB)

plate_count_data$HOB <- factor(plate_count_data$HOB,levels = paste0("HOB", 1:19))
HOB <- plate_count_data[which(plate_count_data$Species == "HOB"),]
MOB <- plate_count_data[which(plate_count_data$Species == "MOB"),]
HOBs <- ddply(HOB,~combi,summarise,mean=mean(Cell.counts),sd=sd(Cell.counts))
se <- HOBs$sd/sqrt(HOBs$mean)

HOBs <- cbind(HOBs, se)
HOBs$combi <- factor(HOBs$combi,levels = c(paste0("MOB1_HOB", 1:19), 
                                           paste0("MOB2_HOB", 1:19),
                                           paste0("MOB3_HOB", 1:19), 
                                           paste0("MOB4_HOB", 1:19),
                                           paste0("MOB5_HOB", 1:19), 
                                           paste0("MOB6_HOB", 1:19),
                                           paste0("MOB7_HOB", 1:19), 
                                           paste0("MOB8_HOB", 1:19),
                                           paste0("MOB9_HOB", 1:19)))

MOBs <- ddply(MOB,~combi,summarise,mean=mean(Cell.counts),sd=sd(Cell.counts))
MOBs$combi <- factor(MOBs$combi,levels = c(paste0("MOB1_HOB", 1:19), 
                                           paste0("MOB2_HOB", 1:19),
                                           paste0("MOB3_HOB", 1:19), 
                                           paste0("MOB4_HOB", 1:19),
                                           paste0("MOB5_HOB", 1:19), 
                                           paste0("MOB6_HOB", 1:19),
                                           paste0("MOB7_HOB", 1:19), 
                                           paste0("MOB8_HOB", 1:19),
                                           paste0("MOB9_HOB", 1:19)))
se <- MOBs$sd/sqrt(MOBs$mean)
MOBs <- cbind(MOBs, se)
hob <- rep(paste0("HOB", c(1,10:19,2:9)), 9)
mob <- c(rep("MOB1", 19), rep("MOB2", 19), rep("MOB3", 19), rep("MOB4", 19), 
         rep("MOB5", 19), rep("MOB6", 19), rep("MOB7", 19), rep("MOB8", 19), 
         rep("MOB9", 19))
Species <- c(rep("MOB", 171), rep("HOB", 171))

HOBs <- cbind(mob, hob, HOBs)
MOBs <- cbind(mob, hob, MOBs)

Everything <- rbind(MOBs, HOBs)
Everything <- cbind(Everything, Species)

colnames(plate_count_data) <- c("MOB", "HOB", "dilution", "Species", "Counts", "combi")
HOBmin4 <- plate_count_data[which(plate_count_data$Species == "HOB" & 
                                  plate_count_data$dilution == "min4"),]
MOBmin4 <- plate_count_data[which(plate_count_data$Species == "MOB" & 
                                  plate_count_data$dilution == "min4"),]
min4 <- plate_count_data[which(plate_count_data$dilution == "min4"),]

min4$HOB <- factor(min4$HOB,levels = paste0("HOB", 1:19))


min4x <- min4[which(min4$Species == "MOB"),][,1:2]
min4x$combi <- min4[which(min4$Species == "MOB"),][,6]
min4x$sum <- c()
min4x$ratio <- c()
min4x$hob <- c()
min4x$mob <- c()

for(i in 1:length(min4x$combi)){
  comb <- min4[which(min4$combi == min4x$combi[i]),]
  min4x$sum[i] <- sum(comb$Counts)
  HOB <- comb[which(comb$Species == "HOB"),]$Counts
  MOB <- comb[which(comb$Species == "MOB"),]$Counts
  min4x$hob[i] <- HOB
  min4x$mob[i] <- MOB
  min4x$ratio[i] <- HOB/MOB
}

oke <- min4x[which(min4x$ratio >= 1/2 & min4x$ratio <= 2),]
okeMin4 <- oke[order(oke$sum),]
okeMin4$rang <- c(97:1)

my_palette <- colorRampPalette(c("blue", "white", "red"))(n = 171)
min4x$na <- min4x$ratio >= 0.5 & min4x$ratio <= 2

#### Figure 2 ------------------------------------------------------------------

g1 <- ggplot(min4x, aes(x = MOB, y = HOB, fill = log10(sum))) +
  geom_raster() + 
  scale_fill_gradientn(colours=my_palette) +
  geom_point(aes(size=ifelse(na, "dot", "no_dot")))  +
  scale_size_manual(values=c(dot=2, no_dot=NA), guide="none") +
  labs(x= "Methane oxidizing bacterium (MOB)", 
       y= "Hydrogen oxidizing bacterium (HOB)")

g1 + theme_bw(base_size=12)