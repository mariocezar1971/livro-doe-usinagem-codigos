#!/usr/bin/env python3
"""
nsga2_pareto.py - Fronteira de Pareto com NSGA-II (pymoo)
Livro DOE em Usinagem - Caps 6 e 10
"""
import numpy as np
from pymoo.core.problem import Problem
from pymoo.algorithms.moo.nsga2 import NSGA2
from pymoo.optimize import minimize
import matplotlib.pyplot as plt


# Modelos de 2a ordem (coeficientes da regressao - Cap 9/10)
def modelo_Fu(x1, x2, x3):
    return 380 + 120*x1 + 15*x2 + 90*x3 + 25*x1*x3 + 18*x1**2


def modelo_Ra(x1, x2, x3):
    return 1.6 + 0.1*x1 + 0.7*x3 + 0.3*x3**2


class UsinagemMulti(Problem):
    def __init__(self):
        super().__init__(n_var=3, n_obj=2,
                         xl=np.array([-1.5, -1.5, -1.5]),
                         xu=np.array([1.5, 1.5, 1.5]))

    def _evaluate(self, X, out, *args, **kwargs):
        x1, x2, x3 = X[:, 0], X[:, 1], X[:, 2]
        out["F"] = np.column_stack([modelo_Fu(x1, x2, x3),
                                    modelo_Ra(x1, x2, x3)])


if __name__ == "__main__":
    res = minimize(UsinagemMulti(), NSGA2(pop_size=100),
                   ("n_gen", 200), seed=1, verbose=False)
    print(f"Solucoes na fronteira: {len(res.F)}")

    plt.scatter(res.F[:, 0], res.F[:, 1], c="steelblue", s=20)
    plt.xlabel("Forca de usinagem Fu (N)")
    plt.ylabel("Rugosidade Ra (um)")
    plt.title("Fronteira de Pareto: forca vs rugosidade")
    plt.grid(True, alpha=0.3)
    plt.savefig("fronteira-pareto.png", dpi=150, bbox_inches="tight")
    print("Grafico salvo: fronteira-pareto.png")
