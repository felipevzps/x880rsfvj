# Segundo dia de desafio

# 1 - Quais variantes deverão ser desconsideradas do VCF?

A filtragem de variantes é essencial para manter variantes com qualidades. Existem diversos métodos de se filtrar as variantes de um VCF, desde métodos clássicos/tradicionais, no qual são aplicados 'hard filters' para selecionar 'threshold' específicos, até os métodos mais sofisticados, como a aplicação de algoritmos de machine learning para encontrar os melhores filtros, como o [Variant Quality Score Recalibration](https://gatk.broadinstitute.org/hc/en-us/articles/360035531612-Variant-Quality-Score-Recalibration-VQSR-). 

Infelizmente, devido a minha falta de reconhecimento em trabalhar com arquivos VCFs e o tempo corrido de competição, eu optei por aplicar apenas 'hard filters', seguindo as boas práticas de bioinformática no assunto [GATK Best Practices - Filter Variants](https://gatk.broadinstitute.org/hc/en-us/articles/360035531112--How-to-Filter-variants-either-with-VQSR-or-by-hard-filtering).

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

### Critérios:

### Figuras

### Resultado

* Mosdepth Summary

|chrom |	length |	bases |	mean |	min |	max |
| ---- | ---- | ---- | ---- | ---- | ---- |
|chr22 |	50818468	 | 148028122 |	2.91 |	0 |	782 |
|chr22_region |	926400	 | 101137292 |	109.17 |	0 |	782 |
|total | 	50818468 |	148028122 |	2.91 |	0 |	782 |
|total_region |	926400 |	101137292 |	109.17 |	0	 | 782 |


- Arquivo [BED contendo regiões não cobertas]()
- Arquivo [BED contendo regies cobertas]()

# 3 - Informações sobre o alinhamento

### Reads totais

### Porcentagem de reads mapeadas corretamente

### Alinhamento de reads em mais de um local do genoma com a mesma qualidade

### Resultado

- Arquivo [TSV com informações sobre o alinhamento]() 