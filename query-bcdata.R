source("header.R")

# Province boundary
bc_polygon <- bcmaps::bc_bound()

# Municipalities as representative points
municipalities <- bcdata::bcdc_get_data(
  "WHSE_LEGAL_ADMIN_BOUNDARIES.ABMS_MUNICIPALITIES_SP"
) %>%
  st_transform(proj_crs) %>%
  st_point_on_surface() 

hwy <- st_read("/Users/evanamies-galonski/e/Spatial/static/dra/hwy_rough.gpkg")

sbf_set_sub("bcdata", rm = TRUE)
sbf_save_datas()
