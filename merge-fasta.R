# Load Packages
library(tidyr)
library(seqinr)
library(dplyr)
library(ggplot2)

# Set Working Directory
setwd("C:/Users/danie/OneDrive/DQ_Documents/PhD/Chapter 1/ML/data/data-working")

# Read in Working Data
data<-read.delim("data-working.txt")
data$finclip<-as.character(data$finclip)
data$species_confirmed<-as.character(data$species_confirmed)

# Read in Fasta File
ffile<-data.frame(id=names(read.fasta("data-genetics.fasta")))
fdata<-separate(ffile, id, sep="_",into=c("tissue_id", "plate","sample","genus","species"))
fdata<-fdata%>%filter(!sample=="control" & !genus=="Unclear")

# Add to working data
add_winter<-unique(fdata$tissue_id[fdata$genus=="Leucoraja" & fdata$species=="ocellata"])
add_little<-unique(fdata$tissue_id[fdata$genus=="Leucoraja" & fdata$species=="erinacea"])
add_thorny<-unique(fdata$tissue_id[fdata$genus=="Raja" & fdata$species=="radiata"])

data$species_confirmed[data$finclip %in% add_winter]<-"winter skate"
data$species_confirmed[data$finclip %in% add_little]<-"little skate"
data$species_confirmed[data$finclip %in% add_thorny]<-"thorny skate"

