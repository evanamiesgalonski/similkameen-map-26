library(poispkgs)

mapviewOptions(basemaps = "Esri.WorldImagery")

dtt_set_default_tz("Etc/GMT+8")

options(sbf.ask = FALSE)

sbf_set_main("output")
sbf_reset_sub()
sbf_set_db_name("alouette-bt")

rm(list = ls())
graphics.off()

source("functions.R")

current_year <- 2026

tz_data <- "PST8PDT"

project <- basename(getwd())

collections <- fwapgr::fwa_collections()
