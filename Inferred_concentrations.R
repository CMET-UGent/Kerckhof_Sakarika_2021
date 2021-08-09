#### Load required packages ----------------------------------------------------
library(tidyverse)
library(readxl)
#### Load required data --------------------------------------------------------
tab3dat <- read_xlsx(path="source_files/Inferred_concentrations.xlsx",
                     sheet="forR")
tab3datCA <- read_xlsx(path="source_files/Inferred_concentrations_CNECXAUT.xlsx",
                     sheet="forR")

MOB1ax <- tab3dat %>% filter(MOB=="MOB1"&
                             is.na(HOB) &
                             TimePoint=="t2")

HOB7ax <- tab3dat %>% filter(is.na(MOB)&
                               HOB=="HOB7" &
                               TimePoint=="t2")

MOB1HOB7 <-  tab3dat %>% filter(MOB=="MOB1"&
                                  HOB=="HOB7" &
                                  TimePoint=="t2")
format(MOB1HOB7$CellsPermL,scientific=TRUE,digits=3)

expectedMOB1HOB7 <- HOB7ax$CellsPermL/2 + MOB1ax$inferred_cellspermL/2
format(expectedMOB1HOB7,scientific=TRUE,digits = 3)

MOB4ax <- tab3dat %>% filter(MOB=="MOB4"&
                               is.na(HOB) &
                               TimePoint=="t2")

HOB13ax <- tab3dat %>% filter(is.na(MOB)&
                               HOB=="HOB13" &
                               TimePoint=="t2")

MOB4HOB13 <-  tab3dat %>% filter(MOB=="MOB4"&
                                  HOB=="HOB13" &
                                  TimePoint=="t2") 
format(MOB4HOB13$inferred_cellspermL,scientific=TRUE,digits=3)
expectedMOB4HOB13 <- HOB13ax$inferred_cellspermL/2 + MOB4ax$inferred_cellspermL/2
format(expectedMOB4HOB13,scientific=TRUE,digits=3)

MOB5ax <- tab3dat %>% filter(MOB=="MOB5"&
                               is.na(HOB) &
                               TimePoint=="t2") 

HOB16ax <- tab3dat %>% filter(is.na(MOB)&
                                HOB=="HOB16" &
                                TimePoint=="t2")

MOB5HOB16 <-  tab3dat %>% filter(MOB=="MOB5"&
                                   HOB=="HOB16" &
                                   TimePoint=="t2")
format(MOB5HOB16$CellsPermL,scientific=TRUE,digits=3)
expectedMOB5HOB16 <- HOB16ax$inferred_cellspermL/2 + MOB5ax$inferred_cellspermL/2
format(expectedMOB5HOB16,scientific=TRUE,digits=3)

MOB6ax <- tab3dat %>% filter(MOB=="MOB6"&
                               is.na(HOB) &
                               TimePoint=="t2") 
HOB15ax <- tab3dat %>% filter(is.na(MOB)&
                                HOB=="HOB15" &
                                TimePoint=="t2")

MOB6HOB15 <-  tab3dat %>% filter(MOB=="MOB6"&
                                   HOB=="HOB15" &
                                   TimePoint=="t2")
format(MOB6HOB15$inferred_cellspermL,scientific=TRUE,digits=3)
expectedMOB6HOB15 <- HOB15ax$inferred_cellspermL/2 + MOB6ax$inferred_cellspermL/2
format(expectedMOB6HOB15,scientific=TRUE,digits=3)


HOB16ax <- tab3dat %>% filter(is.na(MOB)&
                                HOB=="HOB16" &
                                TimePoint=="t2")

MOB6HOB16 <-  tab3dat %>% filter(MOB=="MOB6"&
                                   HOB=="HOB16" &
                                   TimePoint=="t2")
format(MOB6HOB16$inferred_cellspermL,scientific=TRUE,digits=3)
expectedMOB6HOB16 <- HOB16ax$inferred_cellspermL/2 + MOB6ax$inferred_cellspermL/2
format(expectedMOB6HOB16,scientific=TRUE,digits=3)


MOB8ax <- tab3dat %>% filter(MOB=="MOB8"&
                               is.na(HOB) &
                               TimePoint=="t2")

MOB8HOB13 <-  tab3dat %>% filter(MOB=="MOB8"&
                                   HOB=="HOB13" &
                                   TimePoint=="t2") 
format(MOB8HOB13$inferred_cellspermL,scientific=TRUE,digits=3)
expectedMOB8HOB13 <- HOB13ax$inferred_cellspermL/2 + MOB8ax$inferred_cellspermL/2
format(expectedMOB8HOB13,scientific=TRUE,digits=3)


MOB8HOB15 <-  tab3dat %>% filter(MOB=="MOB8"&
                                   HOB=="HOB15" &
                                   TimePoint=="t2") 
format(MOB8HOB15$inferred_cellspermL,scientific=TRUE,digits=3)
expectedMOB8HOB15 <- HOB15ax$inferred_cellspermL/2 + MOB8ax$inferred_cellspermL/2
format(expectedMOB8HOB15,scientific=TRUE,digits=3)


HOB18ax <- tab3dat %>% filter(is.na(MOB)&
                                HOB=="HOB18" &
                                TimePoint=="t2")

MOB8HOB18 <-  tab3dat %>% filter(MOB=="MOB8"&
                                   HOB=="HOB18" &
                                   TimePoint=="t2")
format(MOB8HOB18$inferred_cellspermL,scientific=TRUE,digits=3)
expectedMOB8HOB18 <- HOB18ax$inferred_cellspermL/2 + MOB8ax$inferred_cellspermL/2
format(expectedMOB8HOB18,scientific=TRUE,digits=3)



MOB6CAax <- tab3datCA %>% filter(MOB=="MOB6"&
                               is.na(HOB) &
                               TimePoint=="t2")

CNECax <- tab3datCA %>% filter(is.na(MOB)&
                               HOB=="LMG1201" &
                               TimePoint=="t2")

CNECMOB6 <-  tab3datCA %>% filter(MOB=="MOB6"&
                                  HOB=="LMG1201" &
                                  TimePoint=="t2")
format(mean(CNECMOB6$CellsPermLInferred),scientific=TRUE,digits=3)

expectedCNECMOB6 <- CNECax$CellsPermLInferred/2 + MOB6CAax$CellsPermLInferred/2
format(expectedCNECMOB6,scientific=TRUE,digits = 3)

XAUTax <- tab3datCA %>% filter(is.na(MOB)&
                                 HOB=="X.autotrophicus" &
                                 TimePoint=="t1")

XAUTMOB6 <-  tab3datCA %>% filter(MOB=="MOB6"&
                                    HOB=="X.autotrophicus" &
                                    TimePoint=="t2")
format(mean(XAUTMOB6$CellsPermLInferred),scientific=TRUE,digits=3)

expectedXAUTMOB6 <- XAUTax$CellsPermLInferred/2 + MOB6CAax$CellsPermLInferred/2
format(expectedXAUTMOB6,scientific=TRUE,digits = 3)
