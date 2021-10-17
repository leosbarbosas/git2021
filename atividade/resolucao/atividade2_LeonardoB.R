
# ATIVIDADE 2

# Qual e a area urbanizada de Sao Bernardo do Campo, SP, em hectares?
# R: A área urbanizada de SBC é de aproximadamente 8318.5 hectares, segundo os dados do IBGE, 2015.

# Faca um mapa da area urbanizada de Sao Bernardo do Campo, SP.


# ----
library(sf)
library(tidyverse)
library(geobr)
library(units)
library(tmap)

code = lookup_muni(name_muni = 'São Bernardo do Campo')
sbc_muni = read_municipality(code_muni = code$code_muni, year = 2015, simplified = F) %>% st_transform(31983)

urb = read_urban_area(year = 2015, simplified = F) %>% st_transform(31983)

sbc_urb = st_intersection(urb, sbc_muni)
  
area_urb = st_area(sbc_urb) %>% sum() %>% set_units(hectare) %>% print()

tm_shape(sbc_muni) +
  tm_fill(col = 'lightyellow') +
  tm_shape(sbc_urb) +
  tm_fill(col = 'red') +
  tm_add_legend(type='symbol', size=1,col = 'red',labels = 'Área urbanizada')+
  tm_shape(sbc_muni) +
  tm_borders(col = 'black', lwd = 1.5) +
  tm_compass(type = '4star',size=2)+
  tm_scale_bar() +
  tm_grid(alpha=.4)+
  tm_layout(main.title = 'Área urbanizada de São Bernardo do Campo (IBGE, 2015)',main.title.size = 0.7, main.title.position = 'center',inner.margins=c(.05,.1,.05,.2))