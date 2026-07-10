# Variant_Injection

Ferramenta de injecao *in silico* de variantes genomicas em arquivos VCF. Utilizada para avaliar a performance de pipelines de chamada de variantes, injetando variantes de referencia conhecidas em conjuntos de dados reais.

## Visao Geral

O **Variant_Injection** recebe um arquivo VCF de entrada e um arquivo de referencia contendo variantes conhecidas (`variants.txt`), e gera um novo arquivo VCF com as variantes de referencia mescladas as variantes originais. O resultado e um arquivo comprimido, ordenado e sem duplicatas, pronto para analise.

O pipeline executado pelo script inclui:

1. Extracao do header do arquivo VCF de entrada
2. Injecao das variantes de referencia no novo VCF
3. Ordenacao, compactacao e indexacao dos arquivos
4. Concatenacao e remocao de duplicatas
5. Limpeza de arquivos temporarios

## Instalacao

### Pre-requisitos

| Ferramenta | Descricao |
|------------|-----------|
| [bcftools](https://samtools.github.io/bcftools/) | Manipulacao de arquivos VCF/BCF |
| [bgzip](https://www.htslib.org/doc/bgzip.html) | Compressao BGZF (parte do htslib) |

### Processo de instalacao

**Via conda (recomendado):**

```bash
conda install -c bioconda bcftools
```

**Via Homebrew (macOS):**

```bash
brew install bcftools
```

**Via apt (Ubuntu/Debian):**

```bash
sudo apt install bcftools
```

Apos instalar, clone o repositorio:

```bash
git clone https://github.com/seu-usuario/Variant_Injection.git
cd Variant_Injection
chmod +x inject_variants.sh
```

## Uso

```bash
./inject_variants.sh <arquivo_vcf>
```

**Parametros:**

| Parametro | Descricao |
|-----------|-----------|
| `<arquivo_vcf>` | Caminho para o arquivo VCF de entrada (`.vcf` ou `.vcf.gz`) |

**Exemplo:**

```bash
./inject_variants.sh my_calls.vcf.gz
```

O arquivo de referencia `variants.txt` deve estar presente no diretorio de execucao. O script le automaticamente as variantes listadas nesse arquivo.

**Saida gerada:**

O script gera um arquivo `{nome_base}_injected_sorted.vcf.gz` no diretorio atual, contendo as variantes originais mescladas com as variantes injetadas.

**Arquivo de variantes de referencia (`variants.txt`):**

O arquivo segue o formato VCF (tab-separado), contendo pelo menos: cromossomo, posicao, ref, alt e campos de genotipo. Exemplo de registro:

```
chr13  32340705  .  GTGTAAACTCAGAAA  G  50  PASS  ...  GT:PS:DP:ADALL:AD:GQ  0/1:.:1084:540,544:530,535:99
```

## Feedback

Se encontrar algum bug ou tiver sugestoes de melhoria, por favor abra uma [issue](https://github.com/seu-usuario/Variant_Injection/issues) no repositorio. Sua contribuicao e muito bem-vinda!

## Contribuicoes

Contribuicoes sao bem-vindas! Para contribuir:

1. Faca um fork do repositorio
2. Crie uma branch para sua feature (`git checkout -b feature/nova-funcionalidade`)
3. Faca commit das suas alteracoes (`git commit -m 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

## Licenca

Este projeto esta licenciado sob a licenca MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

Copyright (c) 2026 Joao Gabriel
