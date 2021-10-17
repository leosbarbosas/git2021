
# ATIVIDADE 1

# Quantas escolas existem no municipio de Sao Bernardo do Campo, SP? 
# R: Existem 500 escolas no município, segundo os dados do INEP, 2020.

# Qual a proporcao de escolas publicas e privadas?
# R: Aproximadamente 47% das escolas existentes no município são privadas, enquanto 53% são públicas.

# ----

# se voce ainda nao possui os pacotes instalados, rode o codigo abaixo
install.packages("tidyverse")
install.packages("sf")
install.packages("geobr")

# depois, e necessario importar os pacotes
library(tidyverse)
library(sf)
library(geobr)

# primeiro, vamos fazer o download de todas as escolas do Brasil, com a funcao "read_schools"
escolas <- read_schools()

# agora e necessario filtrar apenas as escolas de sao bernardo do campo (dica: use a funcao dplyr::filter
sbc = dplyr::filter(escolas, name_muni == "São Bernardo do Campo")

# voce pode calcular a proporcao criando uma tabela (table)
prop = table(sbc$admin_category) %>% prop.table() %>% print()