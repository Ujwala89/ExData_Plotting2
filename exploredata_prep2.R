### Download and unzip the files from the given url ###

if(!file.exists("./data")){
  print("creating data directoy in home directory")
  dir.create("./data")
}

### delete zip file from the directory if exists ###

if(file.exists("./data/emmissiondata.zip")) {
  filenm <- file_path_as_absolute("./data/emmissiondata.zip")
  if (file.remove(filenm)) {
    print(c("deleting existing zip file from the directory: file name=",filenm))
  } else {
    stop("Error deleting existing zip file")
  }
}
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"         #url to the input dataset


print("downloading the assignment dataset as emmissiondata.zip")
download.file(fileUrl,destfile="./data/emmissiondata.zip")

print("unzipping the files in a folder under data directory")
unzip("./data/emmissiondata.zip",exdir="./data",overwrite = TRUE)

print("### completed downloading and unzipping the files   ###")

