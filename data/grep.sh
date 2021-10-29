#!/bin/bash

#POS_variants.txt = cat pequeno-gabarito.vcf | tail -n10 | cut -f2 

#./grep.sh POS_variants.txt

while IFS= read -r line; do
    grep "$line" vcf/final_variants.vcf 
done < "$1"
