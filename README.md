# 📈 Previsão de Demanda para Serviços de Manutenção – Motores e Bombas Injetoras

## 💡 Objetivo
Prever a demanda de manutenção de motores MTU e bombas injetoras para uma frota de veículos, utilizando técnicas de séries temporais. O objetivo é subsidiar o planejamento logístico e otimizar a gestão de recursos.

## 📊 Técnicas Aplicadas
- Modelagem de séries temporais com **ETS (Exponential Smoothing)**
- Comparação com **média móvel simples**
- Avaliação de desempenho preditivo: MAE, RMSE, MAPE

## 📁 Estrutura
- `scripts/`: contém o script em R com análises, gráficos e previsões (`previsao_manutencao_mtu_revisado.R`)
- `report/`: (opcional) pode conter relatórios associados em `.pdf` ou `.odt`
- `outputs/`: imagens e tabelas exportadas

## 🛠️ Ferramentas
- Linguagem: **R**
- Principais pacotes: `forecast`, `zoo`, `ggplot2`, `knitr`, `dplyr`, `tseries`
- Editor utilizado: RStudio

## 🔍 Resultados
As previsões obtidas com o modelo ETS apontam para:
- **Motores MTU em 2024**: previsão de 10 serviços (intervalo de 7 a 13)
- **Bombas Injetoras em 2024**: previsão de 7 serviços (intervalo de 6 a 9)

O modelo ETS apresentou melhor desempenho que a média móvel simples, segundo as métricas MAE, RMSE e MAPE.

## 📊 Visualizações

![Série Histórica - Motores](outputs/serie_motores_MTU.png)  
*Evolução anual da demanda de manutenção de motores MTU*

![Série Histórica - Bombas](outputs/serie_bombas_mtu.png)  
*Evolução anual da demanda de manutenção de bombas injetoras MTU*

## 📌 Observações
Este projeto foi desenvolvido a partir de um caso real de gestão de frota, com os dados tratados e simulados para fins de portfólio.

---
👤 **Autor:** Glaucio Jorge Ferreira Rosa  
🎓 Estatístico | Cientista de Dados
