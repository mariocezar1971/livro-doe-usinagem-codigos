# ============================================================
# 01-fatorial.R - Planejamento fatorial 2^k
# Livro DOE em Usinagem - Caps 4 e 8
# ============================================================
library(FrF2)
library(ggplot2)

# --- Criar plano fatorial 2^3, 2 replicas, aleatorizado ---
plano <- FrF2(
  nruns = 8, nfactors = 3, replications = 2, randomize = TRUE,
  factor.names = list(
    Liga = c("1350-O", "7075-T6"),
    Vc   = c(200, 600),
    f    = c(0.20, 0.35)
  ),
  seed = 42
)

# --- Inserir respostas medidas (substituir pelos dados reais) ---
# Fu = forca de usinagem (N) na ordem da matriz
# Carregar de dados/ ou inserir manualmente:
# dados <- read.csv("../dados/ensaios.csv")
Fu <- c(210, 385, 195, 360, 340, 590, 315, 555,
        215, 380, 200, 365, 335, 585, 320, 560)

plano_resp <- add.response(plano, Fu)
modelo <- lm(plano_resp)

# --- ANOVA e efeitos ---
print(anova(modelo))
print(summary(modelo))
cat("\nEfeitos estimados:\n")
print(round(2 * coef(modelo)[-1], 1))

# --- Graficos de diagnostico ---
MEPlot(modelo)                                    # efeitos principais
IAPlot(modelo)                                    # interacoes
DanielPlot(modelo, half = TRUE, alpha = 0.05)     # efeitos significativos

# --- Validacao por residuos ---
par(mfrow = c(2, 2)); plot(modelo); par(mfrow = c(1, 1))
cat("\nR2:", round(summary(modelo)$r.squared, 3),
    "| R2 ajustado:", round(summary(modelo)$adj.r.squared, 3), "\n")
