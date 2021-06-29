#!/bin/bash

# RAxML rapid bootstrapping and subsequent ML search
raxmlHPC-PTHREADS-AVX -s /source_files/arb-silva.de_2018-05-03_id523101_mindnoMOB.fasta -n Tree1 -N 1000 -x 123 -m GTRGAMMA -f a -k -T 12 -w /output_files/raxmloutput/ -p 12345 -u

# RAxML thorough tree optimization
raxmlHPC-PTHREADS-AVX -s /source_files/arb-silva.de_2018-05-03_id523101_mindnoMOB.fasta -n Tree1Opt -m GTRGAMMA -f T -t /output_files/raxmloutput/RAxML_bestTree.Tree1 -k -T 12 -w /output_files/raxmloutput/ -p 12345

# Extended majority rule consens tree
raxmlHPC-PTHREADS-AVX -m GTRGAMMA -J MRE -z /output_files/raxmloutput/RAxML_bootstrap.Tree11 -T 12 -n Tree1MREconsensus

# Rogue taxa identification (0 found)
raxmlHPC-PTHREADS-AVX -m GTRGAMMA -J MR_DROP -z /output_files/raxmloutput/RAxML_bootstrap.Tree1 -T 12 -n Tree1dropcons