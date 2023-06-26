echo "please enter the sequence of five_prime_adapter"
read five_prime_adapter
echo "please enter the sequence of three_prime_adapter"
read three_prime_adapter
echo "please enter the sequence of Index_Primers"
read Index_Primers
echo "please enter the name of fastq"
read fastq

cutadapt -a $five_prime_adapter -n 1 -e 0.2 -O 5 -m 1 --match-read-wildcards -o tmp_Cutadapt3.fastq $fastq

cutadapt -g $three_prime_adapter -n 1 -e 0.125 -O 8 -m 1 --match-read-wildcards -o tmp_Cutadapt2.fastq tmp_Cutadapt3.fastq

cutadapt -b $five_prime_adapter -b $three_prime_adapter -n 1 -e 0.0625 -O 12 -m 1 --match-read-wildcards --discard-trimmed -o tmp_Cutadapt1.fastq tmp_Cutadapt2.fastq

cutadapt -b $Index_Primers -n 1 -e 0.0625 -O 15 --no-trim --untrimmed-output purpose_Cutadapt.fastq -o tmp_Cutadapt.fastq tmp_Cutadapt1.fastq

fastq_quality_filter -q 20 -p 95 -i purpose_Cutadapt.fastq -o purpose_filted.fastq

fastx_collapser -i purpose_filted.fastq -o purpose_Collapsed.fa

cutadapt -b CGTTCCCGTGG -b CCACGTTCCCG -n 1 -e 0.000 -O 11 --no-trim --untrimmed-output stp0_Processed.fa -o purpose_stp_mis_0.fa purpose_Collapsed.fa

cutadapt -b CGTTCCCGTGG -n 1 -e 0.091 -O 11 --no-trim --untrimmed-output stp1_Processed.fa -o purpose_stp_mis_1.fa stp0_Processed.fa

cutadapt -b CGTTCCCGTGG -n 1 -e 0.182 -O 11 --no-trim --untrimmed-output purpose_Processed.fa -o purpose_stp_mis_2.fa stp1_Processed.fa

rm purpose_stp_mis_2.fa purpose_stp_mis_1.fa purpose_stp_mis_0.fa stp1_Processed.fa stp0_Processed.fa purpose_Collapsed.fa purpose_filted.fastq tmp_Cutadapt.fastq tmp_Cutadapt3.fastq tmp_Cutadapt2.fastq tmp_Cutadapt1.fastq purpose_Cutadapt.fastq
