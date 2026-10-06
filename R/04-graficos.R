# ============================================================
# 04-graficos.R - Pareto dos efeitos e curvas de nivel (ggplot2)
# Livro DOE em Usinagem - Caps 8 e 9
# ============================================================
library(ggplot2)
library(dplyr)

# --- Grafico de Pareto dos efeitos ---
efeitos <- c(Liga = -52, Vc = -107, ap = 714, f = 221,
             "Vc:ap" = -45, "ap:f" = 133)
ef_df <- data.frame(fonte = names(efeitos), efeito = efeitos) %>%
  mutate(abs_ef = abs(efeito)) %>% arrange(desc(abs_ef))

ggplot(ef_df, aes(x = reorder(fonte, abs_ef), y = abs_ef, fill = efeito > 0)) +
  geom_col() + coord_flip() +
  scale_fill_manual(values = c("FALSE"="#c0392b","TRUE"="#2c3e50"),
                    labels = c("Negativo","Positivo")) +
  labs(x = "Fonte de variacao", y = "|Efeito|",
       title = "Efeitos fatoriais sobre a forca de usinagem", fill = "Sinal") +
  theme_minimal(base_size = 12)
ggsave("pareto-efeitos.png", width = 7, height = 5, dpi = 150)

# --- Curva de nivel (requer metR) ---
# library(metR)
# grade <- expand.grid(vc = seq(-1.4,1.4,0.1), f = seq(-1.4,1.4,0.1))
# grade$Ra <- with(grade, 2 + 0.3*f + 0.2*f^2)
# ggplot(grade, aes(vc, f, z = Ra)) +
#   geom_contour_fill(aes(fill = after_stat(level))) +
#   scale_fill_viridis_c() + theme_minimal()
