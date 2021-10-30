# Terceiro dia de desafio

# 1 - Obtenha a razão Ti/Tv (transitions e transversions) das variantes encontradas no cromossomo 22

OBS: Apenas SNPs foram utilizados nessa estátistica.

Transitions = 2.326
Transversions = 952
**Ti/Tv = 2,4433**

# 2 - Quantas variantes são encontradas na região de 16000000 a 20000000?

- **284 variantes**

# 3 - Exiba o conteúdo da linha do VCF relativa a uma variante:

- Não-sinônima:

#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  bam/sorted.alignment.bam
chr22	32479203	.	G	A	221.98	PASS	AC=1;AN=2;BQBZ=-2.40952;DP=98;DP4=21,29,10,22;FS=0;MQ=60;MQ0F=0;MQBZ=0;MQSBZ=0;RPBZ=1.71234;SCBZ=0;SGB=-0.69312;VDB=0.69449;ANN=A|start_lost|HIGH|FBXO7|FBXO7|transcript|NM_001257990.1|protein_coding|2/9|c.3G>A|p.Met1?|385/1910|3/1227|1/408||,A|missense_variant|MODERATE|FBXO7|FBXO7|transcript|NM_012179.4|protein_coding|2/9|c.345G>A|p.Met115Ile|537/2060|345/1569|115/522||,A|missense_variant|MODERATE|FBXO7|FBXO7|transcript|NM_001033024.1|protein_coding|2/9|c.108G>A|p.Met36Ile|233/1758|108/1332|36/443||;LOF=(FBXO7|FBXO7|3|0,33)	GT:PL0/1:255,0,255

Essa é uma variante `missense` (aquela que gera a substituição de um único nucleotídeo que resulta em um aminoácido diferente, alterando a proteína codificada). Essa variante específica `G > A` altera o aminoácido `Metionina` pela `Isoleucina`. 
Esse tipo de substituição é um exemplo clássico da inativação de um gene, uma vez que sem o `start codon` o gene torna-se inativo, ou seja, não é capaz de transmitir a informação para a codificação de proteínas.

- Variante no gnomAD v3.1.1 com MAF < 0.01:

#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  bam/sorted.alignment.bam
chr22	16390737	.	A	G	222.39	PASS	AC=1;AN=2;BQBZ=-0.145156;DP=47;DP4=10,10,10,13;FS=0;MQ=60;MQ0F=0;MQBZ=0;MQSBZ=0;RPBZ=0.731334;SCBZ=0;SGB=-0.692717;VDB=0.998905;ANN=G|intergenic_region|MODIFIER|DUXAP8-CCT8L2|DUXAP8-CCT8L2|intergenic_region|DUXAP8-CCT8L2|||n.16390737A>G||||||	GT:PL	0/1:255,0,255
