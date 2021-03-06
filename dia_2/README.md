# Segundo dia de desafio

# 1 - Quais variantes deverão ser desconsideradas do VCF?

A filtragem de variantes é essencial para manter variantes com qualidades. Existem diversos métodos de se filtrar as variantes de um VCF, desde métodos clássicos/tradicionais, no qual são aplicados `hard filters` para selecionar `threshold` específicos, até os métodos mais sofisticados, como a aplicação de algoritmos de machine learning para encontrar os melhores filtros, como o [Variant Quality Score Recalibration](https://gatk.broadinstitute.org/hc/en-us/articles/360035531612-Variant-Quality-Score-Recalibration-VQSR-). 

Infelizmente, devido a minha falta de reconhecimento em trabalhar com arquivos VCFs e o tempo corrido de desafio, eu optei por aplicar apenas `hard filters`, seguindo as boas práticas de bioinformática no assunto [GATK Best Practices - Filter Variants](https://gatk.broadinstitute.org/hc/en-us/articles/360035531112--How-to-Filter-variants-either-with-VQSR-or-by-hard-filtering).

### Métricas utilizadas

Essas métricas foram escolhidas por serem as mais recomendadas na filtragem, e ao mesmo tempo, os valores mais conservadores. Decidi aplicar esses valores pra tentar equilibar a especificidade junto com a sensibilidade, com o objetivo de não perder variantes importantes e com qualidades não tão altas. 

Tomei a decisão de não aplicar um filtro da qualidade tão alto pois eu não conheço a qualidade do sequenciamento (o arquivo FASTQ fornecido não possui a qualidade). Lembrando que a qualidade do sequenciamento pode afetar o alinhamento e a inferência do VCF, e consequentemente, as 'downstream analysis'.

OBS: Devido ao tempo limite de desafio, eu não pude testar vários filtros, por conta disso, os filtros escolhidos são totalmente arbitrários.

* QUAL < 30.0
* FS > 60.0
* MQ < 40.0

### Requisitos e aplicação do filtro

* Requisitos: gatk-4.2.2.0

A aplicação do filtro foi realizada com o código abaixo:

```bash
/x880rsfvj/src/gatk-4.2.2.0/./gatk VariantFiltration -V final_variants.vcf -filter "QUAL < 30.0" --filter-name "QUAL30" -filter "FS > 60.0" --filter-name "FS60" -filter "MQ < 40.0" --filter-name "MQ40" -O filtered_final_variants.vcf 
```

### Resultado

O arquivo abaixo foi gerado após a aplicação do filtro e contém apenas as variantes que serão consideradas na anotação.

- Arquivo [VCF pós filtragem](https://github.com/felipevzps/x880rsfvj/blob/main/dia_2/filtered_final_variants.vcf.gz)

# 2 - Discussão sobre as regiões com baixa cobertura

A avaliação da cobertura foi realizada com o [mosdepth](https://github.com/brentp/mosdepth), uma ferramenta especializada no cálculo de coberturas.

### Requisitos e código para rodar mosdepth

* Requisitos: samtools-1.14, mosdepth-0.2.6

Primeiramente, é necessário criar o index do arquivo BAM de alinhamento, gerado no primeiro dia de desafio:

```bash
/samtools-1.14/samtools index sorted.alignment.bam
```
Com o arquivo `sorted.alignment.bam.bai` em mãos, é possível prosseguir e rodar o mosdepth: 

```bash
./mosdepth --by coverage.bed sample-output sorted.alignment.bam
```

O código acima gerou métricas gerais sobre as coberturas, detacadas a seguir, e também, o arquivo [sample-output.regions.bed.gz](https://github.com/felipevzps/x880rsfvj/blob/main/dia_2/sample-output.regions.bed.gz) que contém as coberturas por regies. A partir desse arquivo, eu extrai apenas as regiões NÃO cobertas, gerando o arquivo com [regioes_nao_cobertas.bed](https://github.com/felipevzps/x880rsfvj/blob/main/dia_2/regioes_nao_cobertas.bed) que foi solicitado.

### Resultado

Um dos resultados gerados pelo mosdepth é o resumo das coberturas por regiões.

* Mosdepth Summary

|chrom |	length |	bases |	mean |	min |	max |
| ---- | ---- | ---- | ---- | ---- | ---- |
|chr22 |	50818468	 | 148028122 |	2.91 |	0 |	782 |
|chr22_region |	926400	 | 101137292 |	109.17 |	0 |	782 |
|total | 	50818468 |	148028122 |	2.91 |	0 |	782 |
|total_region |	926400 |	101137292 |	109.17 |	0	 | 782 |

- Arquivo [BED contendo regiões não cobertas](https://github.com/felipevzps/x880rsfvj/blob/main/dia_2/regioes_nao_cobertas.bed)
- Arquivo [BED contendo regiões cobertas](https://github.com/felipevzps/x880rsfvj/blob/main/dia_2/sample-output.regions.bed.gz)


# 3 - Informações sobre o alinhamento

Eu utilizei o samtools para avaliar as métricas de mapeamento e responder as seguintes questões: 
*   Quantos reads? 
*   Qual a porcentagem deles que foi mapeada corretamente? 
*   Muitos alinharam em mais de um local do genoma com a mesma qualidade?

### Requisitos e código para gerar informações sobre o alinhamento

* Requisitos: samtools-1.14

Para gerar as informações gerais sobre o alinhamento, eu utilizei a opção `flagstat` do samtools: 

```bash
samtools-1.14/samtools flagstat sorted.alignment.bam
```

Esse comando gerou as seguintes informações:

```bash
1734246 + 0 in total (QC-passed reads + QC-failed reads)
1734090 + 0 primary
0 + 0 secondary
156 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
1732956 + 0 mapped (99.93% : N/A)
1732800 + 0 primary mapped (99.93% : N/A)
1734090 + 0 paired in sequencing
867045 + 0 read1
867045 + 0 read2
1729340 + 0 properly paired (99.73% : N/A)
1731510 + 0 with itself and mate mapped
1290 + 0 singletons (0.07% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)
```

A quantidade de `numreads` e `properly paired` foi utilizada na criação do [TSV com informações sobre o alinhamento](https://github.com/felipevzps/x880rsfvj/blob/main/dia_2/informacoes_alinhamento.tsv)

Para gerar uma melhor visualização, eu optei por fazer um histograma utilizando caracteres ascii para demonstrar a cobertura do cromossomo mapeado. Gerei o histograma com a opção `coverage` do samtools:

```bash
samtools-1.14/samtools coverage -A -w 32 -r chr22:1-50818468 sorted.alignment.bam
```
O código acima gerou o seguinte histograma:

```bash
chr22 (50.82Mbp)
  15.74% |                       .       :| Number of reads: 1732956
  13.99% |            :.     .   :  .    :|     
  12.24% |            :: .   :   :: :    :| Covered bases:   3.73Mbp
  10.50% |            ::::  .:   :: :    :| Percent covered: 7.346%
   8.75% |           :::::  ::   ::.:.   :| Mean coverage:   3.42x
   7.00% |           :::::. ::. ::::::.: :| Mean baseQ:      29.9
   5.25% |           :::::: ::: :::::::: :| Mean mapQ:       55.8
   3.50% |          ::::::: ::: :::::::: :| 
   1.75% |       . .::::::::::: ::::::::.:| Histo bin width: 1.59Mbp
   0.00% |      :: :::::::::::::::::::::::| Histo max bin:   17.492%
          1       15.88M    31.76M      50.82M
```

### Resultado

- Arquivo [TSV com informações sobre o alinhamento](https://github.com/felipevzps/x880rsfvj/blob/main/dia_2/informacoes_alinhamento.tsv) 
