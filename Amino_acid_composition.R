#### Load required packages ----------------------------------------------------
library(tidyverse)
library(readxl)
#### Load required data --------------------------------------------------------
fig4dat <- read_xlsx(path="source_files/Amino_acids.xlsx",sheet="fig4_for_R")
fig5dat <- read_xlsx(path="source_files/Amino_acids.xlsx",sheet="fig5_for_R")
#### Data wrangling ------------------------------------------------------------
fig4dat.long <- fig4dat %>% pivot_longer(cols = `MOB1·HOB7`:XAUT)
fig4dat.long$comborpure <- "Combinations"
fig4dat.long$comborpure[!(grepl("HOB",fig4dat.long$name)|
                            grepl("CNEC",fig4dat.long$name)|
                            grepl("XAUT",fig4dat.long$name))] <- "MOB"

fig4dat.long$comborpure[(!grepl("MOB",fig4dat.long$name)|
                           grepl("CNEC",fig4dat.long$name)|
                           grepl("XAUT",fig4dat.long$name))] <- "HOB"
fig4dat.long$comborpure[fig4dat.long$name=="MOB6·CNEC"|
                          fig4dat.long$name=="MOB6·XAUT"] <- "Combinations"
fig4dat.long$name <- factor(fig4dat.long$name, levels=c("HOB7","HOB13","HOB15",
                                                        "HOB16","HOB18",
                                                        "CNEC","XAUT","MOB1","MOB4","MOB8",
                                                        "MOB1·HOB7","MOB4·HOB13","MOB5·HOB16",
                                                        "MOB6·CNEC","MOB6·HOB15","MOB6·HOB16",
                                                        "MOB6·XAUT","MOB8·HOB13","MOB8·HOB15",
                                                        "MOB8·HOB18"))
fig5dat$Category[fig5dat$Category=="Foodstuff"] <- "Food ingredient"
fig5dat$Category <- factor(fig5dat$Category, levels=c("Combinations","MOB",
                                                      "HOB","Food ingredient"))
fig5dat$`Protein source`[fig5dat$`Protein source`=="Tofu from soybean"] <- "Tofu"

fig5dat$`Protein source` <- factor(fig5dat$`Protein source`,
                                   levels=c("MOB1·HOB7","MOB4·HOB13",
                                            "MOB5·HOB16","MOB6·HOB15",
                                            "MOB6·HOB16","MOB6·CNEC",
                                            "MOB6·XAUT","MOB8·HOB13",
                                            "MOB8·HOB15","MOB8·HOB18",
                                            "MOB1","MOB4","MOB8","HOB7","HOB13",
                                            "HOB15","HOB16","HOB18","CNEC",
                                            "XAUT","Tofu","Soybean","Whole egg",
                                            "Raw chicken"))
#### Plotting fig 4-------------------------------------------------------------
fig4.plot <- fig4dat.long %>% ggplot(aes(x=name,y=value,fill=AA))
fig4.plot + geom_bar(stat="identity",colour="black") + 
  facet_grid(~comborpure,drop = TRUE,scales="free_x",space="free")+
  scale_fill_brewer(name="",palette = "Set3")+
  ylab(expression(paste("Amino acid composition (g/100",g[product],")")))+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 45,hjust=1),
        axis.title.x = element_blank())
ggsave(filename = "Figure4.tiff",device = "tiff",width = 180,height=110,
       units="mm",dpi = 300)

#### Plotting fig 5-------------------------------------------------------------
fig5.plot <- fig5dat %>% ggplot(aes(x=`Protein source`,
                                    y=`Quantity of MP to meet all AA requirements (g)`,
                                    label=round(`Quantity of MP to meet all AA requirements (g)`)))
fig5.plot + geom_point(color="blue") + 
  geom_segment(aes(y=4,
                   yend=`Quantity of MP to meet all AA requirements (g)`,
                   xend=`Protein source`),color="blue") +
  geom_text(nudge_y = 80,alpha=0.9,size=3.5)+
  scale_y_continuous(expand = c(0, 0), limits = c(0, 2400)) +
  facet_grid(~Category,drop=TRUE,scales="free_x",space="free") +
  theme_bw() +
  theme(axis.text.x = element_text(angle=45,hjust = 1))

ggsave(filename = "Figure5.tiff",device = "tiff",width = 180,height=110,
       units="mm",dpi = 300)
