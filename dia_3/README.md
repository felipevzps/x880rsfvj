# Terceiro dia de desafio

# Anotação das variantes no vcf filtrado

### Anotação de variantes conhecidas

A primeira etapa da anotaçao, seguindo as boas práticas de anotação, assim como indicado nesse [curso](https://hbctraining.github.io/In-depth-NGS-Data-Analysis-Course/sessionVI/lessons/03_annotation-snpeff.html), é fazer a anotação de variantes já conhecidas. 

Nessa etapa eu utilizei o banco de dados contendo as variações humanas "comuns" (00-common_all.vcf.gz) do banco de dados [dbSNP](00-common_all.vcf.gz). O objetivo dessa etapa foi adicionar o ID das variantes do VCF filtrado no dia anterior. 

### Requisitos e usage

* Requisitos: bcftools-1.14

Essa etapa foi executada com o código abaixo:

```bash
#Compactar o arquivo que será anotado
bgzip filtered_final_variants.vcf
tabix filtered_final_variants.vcf.gz

#Compactar o dbSNP common_all
tabix 00-common_all.vcf.gz

#Anotação de variantes conhecidas
./bcftools annotate -c ID -a 00-common_all.vcf.gz filtered_final_variants.vcf.gz > annotated_variants.vcf
```

### Anotação funcional com SnpEff

Nessa etapa final de anotação, o SnpEff obterá informações do banco de dados de anotação fornecido (hg38) e preencherá o arquivo VCF adicionando as informações da anotação no campo `INFO`.

OBS: Por padrão, o SnpEff baixa e instala bancos de dados automaticamente (desde a versão 4.0) para o organismo especificado.

### Requisitos e usage

* Requisitos: SnpEff-5.0e

A anotação de variantes utilizando como referência o genoma humano `hg38` foi realizada da seguinte forma:

```bash
./snpEff eff hg38 annotated_variants.vcf > annotated_variants_snpEff.vcf
```

O código acima gerou os seguintes arquivos:
- [annotated_variants_snpEff.vcf](https://github.com/felipevzps/x880rsfvj/blob/main/dia_3/annotated_variants_snpEff.vcf): Contém informações das variantes identificadas a fim de facilitar a interpretação dos resultados.
- [snpEff_genes.txt](https://github.com/felipevzps/x880rsfvj/blob/main/dia_3/snpEff_genes.txt): Contém informações das variantes nos genes.
- [snpEff_summary.html](https://github.com/felipevzps/x880rsfvj/blob/main/dia_3/snpEff_summary.html): Esse arquivo html é super interessante e contém estatísticas geradas pelo SnpEff, como a Ti/Tv. 

# 1 - Obtenha a razão Ti/Tv (transitions e transversions) das variantes encontradas no cromossomo 22

OBS: Apenas SNPs foram utilizados nessa estátistica.

Transitions = 2.326

Transversions = 952

**Ti/Tv = 2,4433**

# 2 - Quantas variantes são encontradas na região de 16000000 a 20000000?

- **284 variantes**

# 3 - Exiba o conteúdo da linha do VCF relativa a uma variante:

### Não-sinônima:

#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  bam/sorted.alignment.bam

chr22	32479203	.	G	A	221.98	PASS	AC=1;AN=2;BQBZ=-2.40952;DP=98;DP4=21,29,10,22;FS=0;MQ=60;MQ0F=0;MQBZ=0;MQSBZ=0;RPBZ=1.71234;SCBZ=0;SGB=-0.69312;VDB=0.69449;ANN=A|start_lost|HIGH|FBXO7|FBXO7|transcript|NM_001257990.1|protein_coding|2/9|c.3G>A|p.Met1?|385/1910|3/1227|1/408||,A|missense_variant|MODERATE|FBXO7|FBXO7|transcript|NM_012179.4|protein_coding|2/9|c.345G>A|p.Met115Ile|537/2060|345/1569|115/522||,A|missense_variant|MODERATE|FBXO7|FBXO7|transcript|NM_001033024.1|protein_coding|2/9|c.108G>A|p.Met36Ile|233/1758|108/1332|36/443||;LOF=(FBXO7|FBXO7|3|0,33)	GT:PL0/1:255,0,255

Essa é uma variante `missense` (aquela que gera a substituição de um único nucleotídeo que resulta em um aminoácido diferente, alterando a proteína codificada). Essa variante específica `G > A` altera o aminoácido `Metionina` pela `Isoleucina`. 
Esse tipo de substituição é um exemplo clássico da inativação de um gene, uma vez que sem o `start codon` o gene torna-se inativo, ou seja, não é capaz de transmitir a informação para a codificação de proteínas.

### Variante no gnomAD v3.1.1 com MAF < 0.01:

#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  bam/sorted.alignment.bam

chr22	16390737	.	A	G	222.39	PASS	AC=1;AN=2;BQBZ=-0.145156;DP=47;DP4=10,10,10,13;FS=0;MQ=60;MQ0F=0;MQBZ=0;MQSBZ=0;RPBZ=0.731334;SCBZ=0;SGB=-0.692717;VDB=0.998905;ANN=G|intergenic_region|MODIFIER|DUXAP8-CCT8L2|DUXAP8-CCT8L2|intergenic_region|DUXAP8-CCT8L2|||n.16390737A>G||||||	GT:PL	0/1:255,0,255
