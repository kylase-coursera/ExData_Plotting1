# This script downloads file into the specified directory and take care
# of the OS by itself
get_file <- function(src_url, dest_path, dest_filename, unzip = FALSE) {
  dest_dir <- file.path(dest_path)
  if(!file.exists(dest_dir)) {
    dir.create(dest_dir)
  }
  
  dest_full_path_and_filename <- file.path(dest_dir, dest_filename)
  if(!file.exists(dest_full_path_and_filename)) {
    cat("Downloading file from ", src_url, "\n")
    if(Sys.info()["sysname"] == "Windows") {
      download.file(src_url, destfile = dest_full_path_and_filename, quiet = TRUE)
    } else {
      download.file(src_url, destfile = dest_full_path_and_filename, method = "curl", quiet = TRUE)
    }
    
    if(file.exists(dest_full_path_and_filename)) {
      print("Download finished.")
      if(unzip) {
        unzip(dest_full_path_and_filename)
      }
      return(dest_full_path_and_filename)
    } else {
      print("Download failed.")
    }
  } else {
    return(dest_full_path_and_filename)
  }
  
  
}