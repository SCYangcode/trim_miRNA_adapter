#!/bin/bash
echo "please enter the sequence of five_prime_adapter"
read five_prime_adapter
echo "please enter the sequence of three_prime_adapter"
read three_prime_adapter
echo "please enter the sequence of Index_Primers"
read Index_Primers

cutadapt -a $five_prime_adapter -n 1 -e 0.2 -O 5 -m 1 --match-read-wildcards -o tmp_Cutadapt3.fastq SRR837839.fastq 

cutadapt -g $three_prime_adapter -n 1 -e 0.125 -O 8 -m 1 --match-read-wildcards -o tmp_Cutadapt2.fastq tmp_Cutadapt3.fastq

cutadapt -b $five_prime_adapter -b $three_prime_adapter -n 1 -e 0.0625 -O 12 -m 1 --match-read-wildcards --discard-trimmed -o tmp_Cutadapt1.fastq tmp_Cutadapt2.fastq

cutadapt -b $ Index_Primers -n 1 -e 0.000 -O 23 --no-trim --untrimmed-output SRR837839_Cutadapt.fastq -o tmp_Cutadapt_rm.fastq tmp_Cutadapt.fastq

fastq_quality_filter -q 20 -p 95 -i SRR837839_Cutadapt.fastq -o SRR837839_filted.fastq

fastx_collapser -i SRR837839_filted.fastq -o SRR837839_Collapsed.fa

cutadapt -b CGTTCCCGTGG -b CCACGTTCCCG -n 1 -e 0.000 -O 11 --no-trim --untrimmed-output stp0_Processed.fa -o SRR837839_stp_mis_0.fa SRR837839_Collapsed.fa
 
cutadapt -b CGTTCCCGTGG -n 1 -e 0.091 -O 11 --no-trim --untrimmed-output stp1_Processed.fa -o SRR837839_stp_mis_1.fa stp0_Processed.fa
 
cutadapt -b CGTTCCCGTGG -n 1 -e 0.182 -O 11 --no-trim --untrimmed-output SRR837839_Processed.fa -o SRR837839_stp_mis_2.fa stp1_Processed.fa

rm SRR837839_stp_mis_2.fa SRR837839_stp_mis_1.fa SRR837839_stp_mis_0.fa stp1_Processed.fa stp0_Processed.fa SRR837839_Collapsed.fa SRR837839_filted.fastq tmp_Cutadapt_rm.fastq tmp_Cutadapt3.fastq tmp_Cutadapt2.fastq tmp_Cutadapt1.fastq tmp_Cutadapt.fastq
