# Códigos — Planejamento de Experimentos em Usinagem

Códigos R e Python do livro **"Planejamento de Experimentos em Usinagem: Fatorial, RSM e otimização multirresposta aplicados às ligas de alumínio"**, de Mário Cezar dos Santos Jr.

Livro: https://mariocezar1971.github.io/livro-doe-usinagem/

## Estrutura

```
R/              Scripts R (planejamento, regressão, otimização, gráficos)
python/         Scripts Python (NSGA-II, visualização)
dados/          Dados experimentais em CSV (ver dicionário no Apêndice D)
```

## R — pacotes necessários

```r
install.packages(c("FrF2", "rsm", "GA", "desirability", "ggplot2", "dplyr", "metR"))
```

| Script | Conteúdo | Capítulo |
|---|---|---|
| `01-fatorial.R` | Planejamento fatorial 2^k (FrF2) | 4, 8 |
| `02-pcc-rsm.R` | PCC e superfície de resposta (rsm) | 5, 9 |
| `03-otimizacao.R` | Desejabilidade + algoritmo genético | 6, 10 |
| `04-graficos.R` | Pareto e curvas de nível (ggplot2) | 8, 9 |

## Python — pacotes necessários

```bash
pip install pymoo numpy matplotlib pandas
```

| Script | Conteúdo | Capítulo |
|---|---|---|
| `nsga2_pareto.py` | Fronteira de Pareto (NSGA-II) | 6, 10 |

## Como reproduzir as análises

1. Clone este repositório
2. Instale os pacotes (acima)
3. Os scripts carregam os dados de `dados/` — veja o dicionário no Apêndice D do livro
4. Execute na ordem numérica dos scripts R

## Licença

Código sob licença MIT. Dados experimentais sob CC BY 4.0 (cite o livro ao usar).

## Citação

> SANTOS JR., M. C. *Planejamento de Experimentos em Usinagem*. 2026.
> Disponível em: https://mariocezar1971.github.io/livro-doe-usinagem/
