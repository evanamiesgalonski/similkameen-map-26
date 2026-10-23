source("header.R")
# Similkameen


stream_info <- fwa_add_blks_to_stream_name(tibble(stream_name = "Similkameen River")) 

filter <- list(blue_line_key = stream_info$blk)

ws <- fwapgr::fwa_query_collection(
  "whse_basemapping.fwa_named_watersheds_poly", filter = filter
  ) %>%
  st_cast("POLYGON") %>%
  select()

# network <- ws %>%
#   fwa_add_collection_to_polygon("stream_network")


streams <- ws %>%
  fwa_add_collection_to_polygon("named_streams")
