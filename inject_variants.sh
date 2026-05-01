#!/bin/bash

set -euo pipefail

arquivo_variantes="variants.txt"
vcf_alvo=$1

#criando vcf novo
touch variantes.vcf
echo "Arquivo de variantes in silico criado."

#obtendo o header do arquivo vcf original
bcftools head "$vcf_alvo" > variantes.vcf
echo "Header escrito em arquivo de variantes in silico."

#escrevendo as variantes presentes no arquivo de referência no novo vcf
if [[ -s "$arquivo_variantes" ]]; then
    cat "$arquivo_variantes" >> variantes.vcf
    echo "Variantes escritas com sucesso."
else
    echo "Arquivo de variantes está vazio ou não existe."
fi

#removendo extensões duplicadas
base="${vcf_alvo%.vcf.gz}"
base="${base%.vcf}"

#compactando
bgzip variantes.vcf
bgzip "$vcf_alvo"
vcf_alvo_zip="${vcf_alvo}.gz"
echo "Variantes compactadas com sucesso."

#indexando arquivos
bcftools index "$vcf_alvo_zip"
bcftools index variantes.vcf.gz

#concatenando os arquivos para mesclar as variantes
bcftools concat -a "$vcf_alvo_zip" variantes.vcf.gz -O z --remove-duplicates -o "${base}_injected.vcf.gz"
bcftools sort "${base}_injected.vcf.gz" -O z -o "${base}_injected_sorted.vcf.gz"

#removendo arquivos temporários
rm *.csi
rm variantes.*
rm "${base}_injected.vcf.gz"




