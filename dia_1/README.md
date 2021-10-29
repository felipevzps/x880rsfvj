# Primeiro dia de desafio

Para essa atividade de Variant Calling eu desenvolvi o (Workflow Automatizado)[https://github.com/felipevzps/x880rsfvj/blob/main/workflow/Snakefile] com a ferramenta Snakemake. Este workflow foi desenvolvido para desempenhar uma rotina padrão de Variant Calling, onde os dados fornecidos (reads e cromossomo de referência) passam pelos seguintes processos de trabalho:

1) rule bwa_index: Indexação do cromossomo de referência - (com o objetivo de acelerar o alinhamento e obter melhores alinhamentos em potencial)
2) rule bwa_mem: Alinhamento das reads no cromossomo de referência. Nessa etapa, as reads são alinhadas no cromossomo com o algoritmo BWA_MEM. 
3) rule SAM_to_BAM: Nessa etapa, o alinhamento no formato SAM é convertido no binário BAM (verso binária do SAM). Esse processo é utilizado para reduzir o tamanho do arquivo de alinhamento e maximizar a eficiência de acesso dos dados.
4) sort_BAM_coordinates: Essa é uma etapa importante para tratar os alinhamentos antes de gerar o VCF final. Nessa etapa, os alinhamentos são ordenados em ordem crescente, tendo a posição das bases como referência.
5) calculate_coverage: Aqui ocorre a primeira etapa do Variant Calling propriamente dito. Nessa etapa, é utilizado o bcftools, ferramenta que calcula a cobertura de reads alinhadas no genoma.
6) detect_SNVs: Nessa etapa ocorre a detecção de SNVs com o software bcftools. Nessa etapa, parâmetros importantes precisam ser cuidadosamente observados, como a ploidia do organismo (homo sapiens = 2n) e caractersticas desejáveis sobre as variantes, como por exemplo, variantes raras.
7) filter_SNVs: Essa é a última etapa do processo de Variant Calling que escolhi aplicar neste desafio. Aqui, eu faço uma filtragem das variantes e mantenho apenas as variantes SNVs. 

O resultado final das variantes encontradas nesse primeiro dia de desafio está no arquivo [final_variants.vcf.gz](https://github.com/felipevzps/x880rsfvj/blob/main/dia_1/final_variants.vcf.gz)

# Dependências

- python 3.6
- snakemake 6.10.0
- bwa 0.7.17
- samtools 1.14
- bcftools 1.14

# Validação do resultado da Variant Calling

Para validar as variantes encontradas, eu desenvolvi um script em bash (disponível [grep.sh](https://github.com/felipevzps/x880rsfvj/blob/main/data/grep.sh)) capaz de validar as variantes encontradas e as variantes presentes no gabarito fornecido pela Mendelics. Como é possvel observar nas tabelas abaixo, todas as variantes presentes no gabarito também estão presentes no processo de Variant Calling aqui descrito.

### Pequeno Gabarito
| CHROM  | POS | ID | REF | ALT | QUAL | FILTER | INFO | FORMAT | AMOSTRA-LBB |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |  ------------- |
| chr22 | 19039100 | . | A | G | . | PASS  | .  | GT | 0/1  |
| chr22 | 19764306 | . | C | T | . | PASS  | .  | GT | 0/1  |
| chr22 | 21975710 | . | T | C | . | PASS  | .  | GT | 0/1  |
| chr22 | 23069838 | . | A | G | . | PASS  | .  | GT | 0/1  |
| chr22 | 26027014 | . | A | G | . | PASS  | .  | GT | 1/1  |
| chr22 | 29441577 | . | TTCC | T | . | PASS  | .  | GT | 0/1  |
| chr22 | 33006594 | . | C | T | . | PASS  | .  | GT | 0/1  |
| chr22 | 35264882 | . | G | T | . | PASS  | .  | GT | 1/1  |
| chr22 | 37746461 | . | A | G | . | PASS  | .  | GT | 1/1  |
| chr22 | 43180898 | . | G | A | . | PASS  | .  | GT | 0/1  |

### Validação do processo de Variant Calling
| CHROM  | POS | ID | REF | ALT | QUAL | AMOSTRA-LBB |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| chr22 | 19039100 | . | A | G | 222.231 | 0/1  |
| chr22 | 19764306 | . | C | T | 222.317 | 0/1  |
| chr22 | 21975710 | . | T | C | 222.103 | 0/1  |
| chr22 | 23069838 | . | A | G | 222.404 | 0/1  |
| chr22 | 26027014 | . | A | G | 225.417 | 1/1  |
| chr22 | 29441577 | . | TTCCTCCTC | TTCCTC | 222.406 |0/1  |
| chr22 | 33006594 | . | C | T | 222.349 | 0/1  |
| chr22 | 35264882 | . | G | T | 225.417 | 1/1  |
| chr22 | 37746461 | . | A | G | 225.417 | 1/1  |
| chr22 | 43180898 | . | G | A | 222.001 | 0/1  |
