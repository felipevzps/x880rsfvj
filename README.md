# x880rsfvj

### Instruções para o uso do pipeline automatizado de Variant Calling (desenvolvido no 1 dia de desafio)

### Usage

É necessário respeitar o parentesco do diretório `data`. Exemplo:

```bash
$tree data

data/
├── amostra-lbb_R1.fq 
├── amostra-lbb_R2.fq 
├── bwa
│   ├── grch38.chr22.fasta 

```
Para rodar o pipeline automatizado, basta atualizar o arquivo [config.yaml](https://github.com/felipevzps/x880rsfvj/blob/main/workflow/config.yaml) com o `path` para os softwares e utilizar o seguinte comando:

```bash
$pwd 
/home/x880rsfvj

$cd workflow

$snakemake -np --cores 1
```

