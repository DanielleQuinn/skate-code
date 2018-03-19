# Load Packages
library(tidyr)
library(seqinr)
library(dplyr)


# Read in Working Data
data<-read.delim("data-working.txt")
data$finclip<-as.character(data$finclip)
data$species_confirmed<-as.character(data$species_confirmed)

# Read in Fasta File
ffile<-data.frame(id=names(read.fasta("data-genetics.fasta")))
fdata<-separate(ffile, id, sep="_",into=c("tissue_id", "plate","sample","genus","species"))
fdata<-fdata%>%filter(!sample=="control" & !genus=="Unclear")

# Populate species_confirmed with species names
data$species_confirmed[data$finclip %in% unique(fdata$tissue_id[fdata$species=="ocellata"])]<-"winter skate"
data$species_confirmed[data$finclip %in% unique(fdata$tissue_id[fdata$species=="erinacea"])]<-"little skate"
data$species_confirmed[data$finclip %in% unique(fdata$tissue_id[fdata$species=="radiata"])]<-"thorny skate"

