library(poispkgs)
library(bcdata)
library(bcmaps)

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

proj_crs <- 3005

project <- basename(getwd())

spatial_dir <- "~/Poisson/Spatial/similkameen-map-26/2026"
