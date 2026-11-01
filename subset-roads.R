source("header.R")

hwy <- st_read("/Users/evanamies-galonski/e/Spatial/static/dra/named_roads.gpkg")

hwy_rough <- hwy %>% 
  filter(ROAD_CLASS %in% c("freeway", "arterial", "highway"))

unique(hwy_rough$ROAD_CLASS)

sbf_set_main("/Users/evanamies-galonski/e/Spatial/static/dra")
sbf_save_gpkg(hwy_rough)
