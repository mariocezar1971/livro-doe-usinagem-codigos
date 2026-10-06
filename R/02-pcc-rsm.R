# ============================================================
# 02-pcc-rsm.R - Planejamento composto central e RSM
# Livro DOE em Usinagem - Caps 5 e 9
# ============================================================
library(rsm)

# --- Criar PCC para 3 fatores, 4 pontos centrais, ortogonal ---
plano_pcc <- ccd(
  basis = 3, n0 = 4, alpha = "orthogonal", randomize = TRUE,
  coding = list(
    x1 ~ (Vc - 400)/200,
    x2 ~ (f - 0.275)/0.075,
    x3 ~ (ap - 2.5)/1.5
  )
)
print(plano_pcc)

# --- Inserir respostas e ajustar modelo de 2a ordem ---
# plano_pcc$Fu <- read.csv("../dados/pcc.csv")$Fu
plano_pcc$Fu <- rnorm(nrow(plano_pcc), 500, 50)   # exemplo - substituir

modelo_rsm <- rsm(Fu ~ SO(x1, x2, x3), data = plano_pcc)
print(summary(modelo_rsm))

# --- Curvas de nivel e superficie 3D ---
par(mfrow = c(1, 2))
contour(modelo_rsm, ~ x1 + x2, image = TRUE)
persp(modelo_rsm, ~ x1 + x2, zlab = "Fu (N)", col = terrain.colors(50))
par(mfrow = c(1, 1))

# --- Ponto estacionario (otimo) ---
cat("\nPonto estacionario (codificado):\n")
print(canonical(modelo_rsm)$xs)
