
# ATIVIDADE 3

# Quantas pessoas moram em areas de risco (sujeitas a enchentes, inundacoes e deslizamentos) em Sao Bernardo do Campo, SP? 
# Dica: usar a grade estatistica do IBGE (geobr::read_statistical_grid) e mapeamento de areas de risco do IBGE/CEMADEN (geobr::read_disaster_risk_area).
# R: Potencialmente, cerca de 233621 pessoas moram em áreas de risco em SBC, segundo os dados do IBGE e do CEMADEN para 2010. Contudo, este valor pode estar superestimado por conta da metodologia aplicada.

# ----

library(sf)
library(tidyverse)
library(geobr)
library(tmap)

lista_grade = grid_state_correspondence_table %>%
  filter(abbrev_state=='SP') %>% print()

mun = read_municipality(code_muni=3548708, year = 2010) %>% st_transform(31983)

grade_sbc = read_statistical_grid(code_grid=25) %>% st_transform(31983) %>% st_intersection(mun)

risco = read_disaster_risk_area() %>% st_transform(31983) %>% st_intersection(mun)

grade_sbc$pop_risco = lengths(st_intersects(grade_sbc,risco)) > 0 #Inspirado em: https://gis.stackexchange.com/questions/394954/r-using-st-intersects-to-classify-points-inside-outside-and-within-a-buffer

pop_risco = filter(grade_sbc,pop_risco==TRUE)
sum(pop_risco$POP)
sum(grade_sbc$POP)

tm_shape(grade_sbc)+
  tm_polygons('pop_risco',palette='viridis')+
  tm_shape(risco)+
  tm_fill(col='red')