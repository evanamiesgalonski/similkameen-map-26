source("header.R")
# Similkameen
collections <- fwapgr::fwa_collections()

main_stream <- fwa_add_blks_to_stream_name(tibble(stream_name = "Similkameen River")) %>%
  mutate(rm = 1000)

# doesnt work
# ws <- fwa_add_watershed_to_blk(main_stream)

ws <- fwapgr::fwa_query_collection(
  "whse_basemapping.fwa_named_watersheds_poly", filter = list(blue_line_key = main_stream$blk)
  ) %>%
  st_cast("POLYGON") 

# network <- ws %>%
#   fwa_add_collection_to_polygon("stream_network")

streams <- ws %>%
  select() %>%
  fwa_add_collection_to_polygon("named_streams")

rivers <- streams %>% filter(str_detect(gnis_name, "River"))

river_blks <- rivers$blue_line_key[rivers$blue_line_key != main_stream$blk]

ws_sub <- map(
  river_blks,
  \(x) {
    fwapgr::fwa_query_collection(
      "whse_basemapping.fwa_named_watersheds_poly",
      filter = list(blue_line_key = x)
    )
  }
) %>%
  bind_rows()


dat <- st_union(st_geometry(ws_sub))

ws <- st_sf(
  geometry = st_difference(
    st_union(st_geometry(ws)),
    st_union(st_geometry(ws_sub))
  )
) %>%
  mutate(gnis_name = "Similkameen River")

rm(main_stream, collections)
sbf_set_sub("fwa")
sbf_save_datas()