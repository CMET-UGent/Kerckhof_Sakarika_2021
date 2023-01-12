# Kerckhof_Sakarika_2021

Accompanying code to [Kerckhof, Sakarika, *et. al.* 2021](https://www.frontiersin.org/articles/10.3389/fbioe.2021.733753/full)

Kerckhof FM, Sakarika M, Van Giel M, Muys M, Vermeir P, De Vrieze J, Vlaeminck SE, Rabaey K, Boon N. From Biogas and Hydrogen to Microbial Protein Through Co-Cultivation of Methane and Hydrogen Oxidizing Bacteria. Front Bioeng Biotechnol. 2021 Aug 30;9:733753. doi: 10.3389/fbioe.2021.733753. PMID: 34527661; PMCID: PMC8435580.

## Dependencies

- [RAxML](https://cme.h-its.org/exelixis/web/software/raxml/) we used v. 8.2.11 and visualized with [iTOL](https://itol.embl.de/)
- [R](https://www.r-project.org/) we used v. 4.0.4 in our preferred IDE, [RStudio](https://www.rstudio.com/)
- The CRAN R packages ggplot2, ggthemes, grid, gridextra, ggpubr, lawstat, readxl, dplyr, NMF
- The [Phenoflow R package for flow cytometry fingerprinting](https://github.com/CMET-UGent/Phenoflow_package) and it's dependencies

## Repository structure

File/folder in root | Description
--------------------|-------------------------
output_files/raxmloutput | intermediary output files for RAxML phylogenetic inference (SI Figure 1)
source_files | processed datafiles (not the ones in the repositories) needed to run certain scripts
.gitignore | file to describe which files git should not track
Kerckhof_Sakarika_etal_2021.Rproj | Rstudio project file 
LICENSE | License
README.md | This file
raxml_code.sh | RAxML options used to infer phylogeny (SI Figure 1)
Selective_plating_results.R | Processing of selective plating results (Figure 2)
Amino_acid_composition.R | Code to reproduce Figure 4 and Figure 5
