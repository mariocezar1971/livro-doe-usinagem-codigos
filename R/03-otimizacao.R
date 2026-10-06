# ============================================================
# 03-otimizacao.R - Desejabilidade + algoritmo genetico
# Livro DOE em Usinagem - Caps 6 e 10
# ============================================================
library(GA)
library(desirability)

# --- Desejabilidades individuais (minimizar as 4 respostas) ---
d_Fu <- dMin(low = 200, high = 900)
d_Ne <- dMin(low = 500, high = 3000)
d_Tc <- dMin(low = 300, high = 600)
d_Ra <- dMin(low = 0.4, high = 4.0)
D    <- dOverall(d_Fu, d_Ne, d_Tc, d_Ra)

# --- Funcao objetivo: desejabilidade global (maximizar) ---
# Substituir pelas funcoes de predicao dos modelos de 2a ordem (Cap 9/10)
objetivo <- function(x) {
  fu <- 500 + 100*x[1]; ne <- 1500 + 300*x[2]
  tc <- 400 + 50*x[3];  ra <- 2 + 0.5*x[1]
  predict(D, data.frame(D1=fu, D2=ne, D3=tc, D4=ra))
}

# --- Algoritmo genetico ---
resultado <- ga(
  type = "real-valued", fitness = objetivo,
  lower = rep(-1.41, 6), upper = rep(1.41, 6),
  popSize = 100, maxiter = 200, seed = 42
)
summary(resultado)
cat("\nSolucao otima:\n"); print(resultado@solution)
