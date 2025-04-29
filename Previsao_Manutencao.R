#--------------------------------------------------
# Bibliotecas Necessarias
#--------------------------------------------------
library(knitr)
library(forecast)
library(ggplot2)
library(dplyr)
library(readxl)
library(zoo)

#--------------------------------------------------
# Previsao de Servicos de Manutencao - Motores MTU
#--------------------------------------------------

# Carregando dados de manutenção de motores
motores_data <- data.frame(Ano = 2017:2022, motores_mnt = c(1,4,6,3,2,12))
kable(motores_data)

# Separando variável de interesse
motores <- motores_data$motores_mnt

# Plotando a série histórica
plot(motores, xaxt = "n", xlab = "Ano", ylab = "Manutenções", main = "Série Histórica - Motores MTU")
axis(1, at = 1:length(motores_data$Ano), labels = motores_data$Ano)
lines(motores, col = "blue")

# Dividindo os dados em treino e teste
y_train <- ts(motores[1:5], start = c(2017), frequency = 1)
y_test  <- ts(motores[6])

# Ajustando modelo ETS
modelo_ets <- ets(y_train)
forecast_ets <- forecast(modelo_ets, h = 1)

# Prevendo para dois anos futuros com toda a serie
serie_completa <- ts(motores, start = c(2017), frequency = 1)
modelo_completo <- ets(serie_completa)
previsao_futura <- forecast(modelo_completo, h = 2)

# Estimando previsão ajustada (média entre previsão e intervalo superior 80%)
previsao_matriz <- cbind(previsao_futura$mean, previsao_futura$upper[,1])
prev_ajustada <- colMeans(t(previsao_matriz))

# Tabela de previsões
anos_prev <- 2023:2024
tabela_prev <- data.frame(Ano = anos_prev, Previsao = prev_ajustada)
kable(tabela_prev)

#--------------------------------------------------
# Previsao via Media Movel Simples
#--------------------------------------------------

media_movel <- rollmean(motores, k = 3, fill = NA, align = "right")
media_movel <- na.omit(media_movel)

# Previsao para 4 anos a frente
previsao_mm <- forecast(media_movel, h = 4)
plot(previsao_mm, main = "Previsões - Media Movel Simples")

#--------------------------------------------------
# Comparacao de Desempenho - ETS x Media Movel
#--------------------------------------------------

# Métricas ETS
mae_ets <- mean(abs(y_test - forecast_ets$mean))
rmse_ets <- sqrt(mean((y_test - forecast_ets$mean)^2))
mape_ets <- mean(abs((y_test - forecast_ets$mean) / y_test)) * 100

# Métricas Media Movel
ultimo_valor_mm <- tail(media_movel, 1)
mae_mm <- mean(abs(y_test - ultimo_valor_mm))
rmse_mm <- sqrt(mean((y_test - ultimo_valor_mm)^2))
mape_mm <- mean(abs((y_test - ultimo_valor_mm) / y_test)) * 100

# Resultado Comparativo
tabela_comp <- data.frame(
  Metodo = c("ETS", "Media Movel"),
  MAE = c(mae_ets, mae_mm),
  RMSE = c(rmse_ets, rmse_mm),
  MAPE = c(mape_ets, mape_mm)
)
kable(tabela_comp)

#--------------------------------------------------
# Previsao de Servicos de Manutencao - Bombas Injetoras
#--------------------------------------------------

# Carregando dados
bombas_data <- data.frame(Ano = 2017:2022, bombas_mnt = c(5,4,11,6,5,6))
kable(bombas_data)

# Separando variável de interesse
bombas <- bombas_data$bombas_mnt

# Plotando a série histórica
plot(bombas, xaxt = "n", xlab = "Ano", ylab = "Manutenções", main = "Série Histórica - Bombas Injetoras")
axis(1, at = 1:length(bombas_data$Ano), labels = bombas_data$Ano)
lines(bombas, col = "blue")

# Modelo e previsão
serie_bombas <- ts(bombas, start = c(2017), frequency = 1)
modelo_bombas <- ets(serie_bombas)
previsao_bombas <- forecast(modelo_bombas, h = 2)

# Estimativa Ajustada
previsao_matriz_bmb <- cbind(previsao_bombas$mean, previsao_bombas$upper[,1])
prev_ajustada_bmb <- colMeans(t(previsao_matriz_bmb))

# Tabela final
anos_prev_bmb <- 2023:2024
tabela_prev_bmb <- data.frame(Ano = anos_prev_bmb, Previsao = prev_ajustada_bmb)
kable(tabela_prev_bmb)
