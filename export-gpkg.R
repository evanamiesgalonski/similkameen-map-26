source("header.R")

sbf_load_datas(sub = "fwa")
sbf_load_datas(sub = "bcdata")

ws %<>% mutate(ws_name = paste(str_extract(gnis_name, "^[^ ]+"), "Watershed"))
ws_sub %<>% mutate(ws_name = paste(str_extract(gnis_name, "^[^ ]+"), "Watershed"))

ws %<>% bind_rows(ws_sub)

sbf_set_main(spatial_dir)
sbf_save_gpkgs()
