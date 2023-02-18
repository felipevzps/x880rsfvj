# 3º Lugar: [Desafio LBB-Mendelics 2021](https://github.com/mendelics/lbb-mendelics-2021/blob/main/pontuacao.md) 

* Nome aleatório gerado para o projeto: [x880rsfvj](https://github.com/felipevzps/x880rsfvj/blob/main/name_generator.py)

## Instruções para o uso do pipeline automatizado de Variant Calling desenvolvido no desafio

É necessário respeitar o parentesco do diretório `data`. Exemplo:

```bash
$pwd 
/home/x880rsfvj

$tree data

data/
├── amostra-lbb_R1.fq 
├── amostra-lbb_R2.fq 
├── bwa
│   ├── grch38.chr22.fasta 

```

## Uso
Para rodar o pipeline automatizado, basta atualizar o arquivo [config.yaml](https://github.com/felipevzps/x880rsfvj/blob/main/workflow/config.yaml) com o `path` para os softwares necessários e executar o seguinte comando:

```bash
$pwd 
/home/x880rsfvj

$cd workflow

$snakemake -np --cores 1
```

