# extracts database schema and writes to new r file
# fomat is off at first but if you copy then re-paste the text again the formatting is correct
extract_schema <- function(conn, new_file_name) {
  new_file_name <- paste0(new_file_name, ".R")
  
  if(file.exists(new_file_name)) {
    delete <- askYesNo(msg = paste("file '", new_file_name, "' already exists, overwrite?"))
    if(delete == TRUE) unlink(new_file_name)
  }
  
  schema <- DBI::dbGetQuery(conn, "SELECT sql FROM sqlite_master") %>%
    filter(!is.na(sql))
  
  for(i in 1:length(schema[, 1])) {
    schema[i, 1] <- paste0("DBI::dbGetQuery(conn,\n", "\"", schema[i, 1], "\"", ")", "\n\n",
                           "rws_write( , conn = conn)", "\n\n")
  }
  
  lapply(schema, write, new_file_name, append = TRUE, ncolumns = 1000)
  message(paste("your schema file can be found here:", file.path(getwd(), new_file_name)))
}

cc_var <- function(x){
  chk_data(x)
  x <- names(x)
  y <- gsub("_|\\.", "", x)
  
  for(i in seq_along(x)) {
    if(str_detect(y[i], "[[:punct:]]") |
       str_detect(x[i], "^\\d|\\s|^_") |
       str_detect(x[i], "^\\.\\d")) {
      
      x[i] <- paste0("`", x[i], "`")
    }
  }
  
  cat(x, sep = ", ")
  
}

cc_char <- function(x, col = FALSE) {
  chk_character(x)
  
  if(col){
    cat(cat("'"), cat(x, sep = "',\n'"), "'", sep = "")
  } else {
    cat(cat("'"), cat(x, sep = "', '"), "'", sep = "")
  }
}

cc_num <- function(x, col = FALSE) {
  chk_numeric(x)
  
  if(col){
    cat(x, sep = ",\n")
  } else {
    cat(x, sep = ", ")
  }
}

char_na_nr_to_na <- function(x){
  map_chr(x, function(x){
    chk_character(x)
    if(tolower(x) %in% c("na", "nr", "")){
      x <- NA
    }
    x
  })
}
