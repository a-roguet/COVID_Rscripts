Analyse_ddPCR_results <- function() {

  ################################
  ### Import function
  ################################  
  substrRight <- function(x, n){
    substr(x, nchar(x)-n+1, nchar(x))
  }
  substrLeft <- function(x, n){
    substr(x, 1, n)
  }
  
  library(twoddpcr, quietly=TRUE)
  library(ggplot2, quietly=TRUE)
  library(data.table, quietly=TRUE)
  library(dplyr, quietly=TRUE)
  library(stringr, quietly=TRUE)
  
  ################################
  ### Artificial sample
  ################################
  
  ## Import data 
  # setwd("~/OneDrive - UWM/SARS-CoV-2/DATA/ddPCR data/Articificial_Sample/")
  # articificial.sample.plate <- ddpcrPlate(well=".")
  
  ## Select the info from the unique well (A01)
  # four.clusters<-articificial.sample.plate[["A01"]]
  # dropletPlot(four.clusters)
  # saveRDS(four.clusters, file = "~/OneDrive - UWM/SARS-CoV-2/DATA/ddPCR data/four_clusters_iowa.RData")
  four.clusters.genuine<-readRDS("~/OneDrive - UWM/SARS-CoV-2/DATA/ddPCR data/four_clusters_iowa.RData")
  
  ## Get the center of the negative droplets
  four.clusters.genuine.NN <- four.clusters.genuine@dropletAmplitudes[which(four.clusters.genuine@classification$Cluster == "NN"),]
  four.clusters.genuine.NN.Ch1<-mean(four.clusters.genuine.NN$Ch1.Amplitude) #1198.864
  four.clusters.genuine.NN.Ch2<-mean(four.clusters.genuine.NN$Ch2.Amplitude) #1996.125
  
  ## Get the centers of the 4 clusters
  #four.clusters <- kmeansClassify(four.clusters, centres=4)
  #dropletPlot(four.clusters, cMethod="kmeans")
  #clusterCentres(four.clusters, cMethod="kmeans")  
  
  
  
  
  ################################
  ### Standards & Real samples
  ################################
  
  
  ##### Prepare the data ###### 
  
  ## Set the run directory
  setwd(paste0(working_directory, run_ID, "/"))
  
  ## Read sample info data
  samples<-data.table::fread(samples.info, fill=TRUE, select=c("Well", "Sample", "Target"))
  samples<-samples %>%
    group_by(Well, Sample) %>%
    summarize(
              target = paste(unique(Target, na.rm=TRUE), collapse = "_"), 
              .groups = 'drop')
  samples<-as.data.frame(samples) 
  samples$target<-toupper(samples$target)
  samples$target<-str_replace(samples$target, "BCOV", "BCoV")
  samples$target<-str_replace(samples$target, "PMMOV", "PMMoV")
  
  ## Create temporary folders and copy raw files in them
  dir.create("temp_all_files"); dir.create("temp_N1N2multiplex"); dir.create("temp_BCOVBRSVmultiplex"); dir.create("temp_FAMsingleplex"); dir.create("temp_HEXsingleplex")
  dataRawFiles <- dir(".", "*_Amplitude.csv", ignore.case = TRUE, all.files = TRUE)
  file.copy(dataRawFiles, "./temp_all_files", overwrite = TRUE)
  
  ## Split the files between singleplex, N1/N2 multiplex and BCoV/BRSV multiplex
  dataTempFiles <- dir("./temp_all_files/", "*.csv", ignore.case = TRUE, all.files = TRUE)
  FAMsingleplex=HEXsingleplex=N1N2multiplex=BCoVBRSVmultiplex=0
  
  for(j in 1:length(dataTempFiles)) {
    fileTemp<-dataTempFiles[j]
    wellTemp<-substrLeft(substrRight(fileTemp, 17), 3)
    temp<-read.table(paste0("./temp_all_files/", dataTempFiles[j]), h=T, sep = ",")
    head(temp)
    if(any(is.na(temp$Ch2.Amplitude))){
      temp$Ch2.Amplitude[is.na(temp$Ch2.Amplitude)] <- 1
      FAMsingleplex=FAMsingleplex+1
      write.table(temp, paste0("./temp_FAMsingleplex/", dataTempFiles[j]), quote = FALSE, sep = ",", col.names = TRUE, row.names = FALSE)
    } else if(any(is.na(temp$Ch1.Amplitude))) {
      temp$Ch1.Amplitude[is.na(temp$Ch1.Amplitude)] <- 1
      HEXsingleplex=HEXsingleplex+1
      write.table(temp, paste0("./temp_HEXsingleplex/", dataTempFiles[j]), quote = FALSE, sep = ",", col.names = TRUE, row.names = FALSE)
    } else {
        if(samples[which(samples$Well == wellTemp), c("target")] == "N1_N2"){
          N1N2multiplex=N1N2multiplex+1
          write.table(temp, paste0("./temp_N1N2multiplex/", dataTempFiles[j]), quote = FALSE, sep = ",", col.names = TRUE, row.names = FALSE)
        } else if(grepl("BCoV_BRSV", samples[which(samples$Well == wellTemp), c("target")], fixed = TRUE)){
          BCoVBRSVmultiplex=BCoVBRSVmultiplex+1
          write.table(temp, paste0("./temp_BCOVBRSVmultiplex/", dataTempFiles[j]), quote = FALSE, sep = ",", col.names = TRUE, row.names = FALSE)
        }
      }
    }
  
  No.BCoVBRSV.samples=No.N1N2.samples=No.FAM.samples=No.HEX.samples=0
  
  
  
  #####  Read the N1/N2 multiplex data ###### 
  if(N1N2multiplex>0){
    print("N1/N2 multiplex sample(s) detected")
    plate.genuine.multiplex <- ddpcrPlate(well="temp_N1N2multiplex/.")
    No.N1N2.samples<-length(names(plate.genuine.multiplex))
    names(plate.genuine.multiplex) # list all the N1/N2 wells
    plate.cluster <- plate.genuine.multiplex # duplicate "plate.genuine". "plate.cluster" will store the k-means clusters
    
    ## Display original clusters
    #commonClassificationMethod(plate.genuine.multiplex) # 
    #facetPlot(plate.genuine.multiplex, cMethod="Cluster") # droplets per well
    
    
    ## Define 4 clusters (i.e. NN (negative), PN (N1), PP (N1/N2) and NP (N2) for each well)
    for(i in 1:No.N1N2.samples) {
      
      ## Preparation
      well = 0
      four.clusters.NN.Ch1 = four.clusters.genuine.NN.Ch1
      four.clusters.NN.Ch2 = four.clusters.genuine.NN.Ch2
      four.clusters <- four.clusters.genuine
      well_ID=as.character(names(plate.genuine.multiplex)[i])
      print(paste0(well_ID, " - N1/N2"))
      well<-plate.genuine.multiplex[[well_ID]]
      well_sample<-as.character(samples[which(samples$Well == well_ID), 2])
      well_sample_plot<-str_replace(well_sample, ":", "to")
      
      #dropletPlot(well)
      
      ## Define the center of the Negative droplets for the well
      well.NN <- well@dropletAmplitudes[which(well@classification$Cluster == "NN"),]
      well.NN.Ch1<-mean(well.NN$Ch1.Amplitude); well.NN.Ch1
      well.NN.Ch2<-mean(well.NN$Ch2.Amplitude); well.NN.Ch2
      
      ## Determine the difference of origin between the artificial and the real sample (i.e., ch1 and ch2)
      ch1<-four.clusters.NN.Ch1-well.NN.Ch1; ch1
      ch2<-four.clusters.NN.Ch2-well.NN.Ch2; ch2
      
      ## Correct the position of the artificial sample to match the real sample
      four.clusters@dropletAmplitudes$Ch1.Amplitude<-four.clusters@dropletAmplitudes$Ch1.Amplitude-ch1
      four.clusters@dropletAmplitudes$Ch2.Amplitude<-four.clusters@dropletAmplitudes$Ch2.Amplitude-ch2
      four.clusters@classification$Cluster<-"artificial"
      
      ## Add artificial sample to the real sample
      well@classification<-rbind(four.clusters@classification, well@classification)
      well@dropletAmplitudes<-rbind(four.clusters@dropletAmplitudes, well@dropletAmplitudes)
      #dropletPlot(well)
      
      ## Define the 4 clusters (NN (negative), PN (N1), PP (N1/N2) and NP (N2))
      well <- kmeansClassify(well, 
                             centres=matrix(c(2000-ch1, 2000-ch2,    2000-ch1, 4500-ch2,   8000-ch1, 2500-ch2,   8000-ch1, 6000-ch2), ncol=2, byrow=TRUE))
      #dropletPlot(well, cMethod="kmeans")
      
      ## Remove the rain between the clusters
      well <- sdRain(well, cMethod="kmeans", errorLevel = 5) #5 = default 
      #dropletPlot(well, cMethod="kmeansSdRain")
      
      ## Remove artificial droplets
      well@dropletAmplitudes<-well@dropletAmplitudes[which(well@classification$Cluster != "artificial"),]
      well@classification<-well@classification[which(well@classification$Cluster != "artificial"),]
      #dropletPlot(well, cMethod="kmeansSdRain")
      
      
      ## If NA are generated during the last step, replace NA by kmeans classification
      na<-which(is.na(well@classification$kmeansSdRain))
      well@classification$kmeansSdRain[na]<-well@classification$kmeans[na]
      
      ## Add info to the plate
      plate.cluster[[well_ID]]<-well
      
      ## Print plots
      pdf(paste0("multiplex_N1N2_", well_ID, "_", well_sample_plot, "_2D.pdf"), width=8, height=8)
      print(dropletPlot(well, cMethod="kmeansSdRain"))
      dev.off()
      
      well.plot<-as.data.frame(cbind(well@dropletAmplitudes$Ch1.Amplitude, well@dropletAmplitudes$Ch2.Amplitude, well@classification$kmeansSdRain))
      names(well.plot)<-c("Ch1.Amplitude", "Ch2.Amplitude", "kmeansSdRain")
      well.plot$kmeansSdRain<-gsub(1, "negative", well.plot$kmeansSdRain)
      well.plot$kmeansSdRain<-gsub(2, "HEX", well.plot$kmeansSdRain)
      well.plot$kmeansSdRain<-gsub(3, "FAM", well.plot$kmeansSdRain)
      well.plot$kmeansSdRain<-gsub(4, "FAM-HEX", well.plot$kmeansSdRain)
      well.plot$kmeansSdRain<-gsub(5, "rain", well.plot$kmeansSdRain)
      
      pdf(paste0("multiplex_N1N2_", well_ID, "_", well_sample_plot, "_1D_ch1.pdf"), width=8, height=8)
      print(ggplot(well.plot, aes(runif(nrow(well.plot),1,nrow(well.plot)), Ch1.Amplitude, colour = as.factor(kmeansSdRain))) + 
              geom_point())
      dev.off()
      pdf(paste0("multiplex_N1N2_", well_ID, "_", well_sample_plot, "_1D_ch2.pdf"), width=8, height=8)
      print(ggplot(well.plot, aes(runif(nrow(well.plot),1,nrow(well.plot)), Ch2.Amplitude, colour = as.factor(kmeansSdRain))) + 
              geom_point())
      dev.off()
    }
    
    ## Generate multiplex data
    print(paste0(No.N1N2.samples, " N1/N2 files processed"))
    cat(sep="\n\n")
    print("Compiling the output files...")
    results.multiplex<-plateSummary(plate.cluster, cMethod="kmeansSdRain", ch1Label = "N1", ch2Label = "N2")
    results.multiplex$FAM.HEX.difference<-round(results.multiplex[,10]/results.multiplex[,11], digits = 2)
    results.multiplex$flag.FAM.HEX.difference<-ifelse(results.multiplex$FAM.HEX.difference>2,results.multiplex$FAM.HEX.difference, "okay")
    
    ## Split data to get 1 row = 1 assay
    results.multiplex.FAM<-results.multiplex[, c(1,2,5,6,7,10,12,18)]
    results.multiplex.FAM$Target<-"N1"
    results.multiplex.FAM$DyeName<-"FAM"
    results.multiplex.FAM$Well<-row.names(results.multiplex.FAM)
    results.multiplex.HEX<-results.multiplex[, c(1,3,5,8,9,11,13,18)]
    results.multiplex.HEX$Target<-"N2"
    results.multiplex.HEX$DyeName<-"HEX"
    results.multiplex.HEX$Well<-row.names(results.multiplex.HEX)
    
    results.multiplex.export<-rbind(results.multiplex.FAM,setnames(results.multiplex.HEX,names(results.multiplex.FAM)))
    names(results.multiplex.export)<-c("PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets", "Conc(copies/µL)", "Copies/20µLWell", "Flag.FAM_HEX.difference", "Target", "DyeName", "Well")
    results.multiplex.export$Flag.positive.droplets<-ifelse(results.multiplex.export$PositivesDroplets/results.multiplex.export$AcceptedDroplets>0.7,results.multiplex.export$PositivesDroplets/results.multiplex.export$AcceptedDroplets, "okay")
    results.multiplex.export$Flag.total.droplets<-ifelse(results.multiplex.export$AcceptedDroplets<=12000,"low number of droplets", "okay")
    results.multiplex.export$Run<-run_ID
    results.multiplex.export$Comment<-""
    #print(paste0("Number of row before sample name transformation: ", nrow(results.multiplex.export)))
    results.multiplex.export<-setDT(samples)[results.multiplex.export, on="Well"]
    #print(paste0("Number of row after sample name transformation (should the same): ", nrow(results.multiplex.export)))
    results.multiplex.export<-results.multiplex.export[,c("Run", "Well", "Sample", "Target", "Conc(copies/µL)", "DyeName", "Copies/20µLWell", "PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets", "Flag.positive.droplets", "Flag.total.droplets", "Flag.FAM_HEX.difference", "Comment")]
    

    ## Export the data ## 
    write.table(results.multiplex.export, paste0("results_N1N2.csv"), quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")
    write.table(results.multiplex, paste0("results_details_N1N2.csv"), quote = FALSE, row.names = TRUE, col.names = TRUE, sep = ",")
    saveRDS(plate.cluster, file = "plate_N1N2.RData")
    
    print("done!")
    cat(sep="\n\n")
    cat(sep="\n\n")
    
  }
  
  

#####  Read the BCOV/BRSV multiplex data ###### 
if(BCoVBRSVmultiplex>0){
  print("BCOV/BRSV multiplex sample(s) detected")
  plate.genuine.multiplex <- ddpcrPlate(well="temp_BCOVBRSVmultiplex/.")
  No.BCoVBRSV.samples<-length(names(plate.genuine.multiplex))
  names(plate.genuine.multiplex) # list all the BCOV/BRSV wells
  plate.cluster <- plate.genuine.multiplex # duplicate "plate.genuine". "plate.cluster" will store the k-means clusters
  
  ## Display original clusters
  #commonClassificationMethod(plate.genuine.multiplex) # 
  #facetPlot(plate.genuine.multiplex, cMethod="Cluster") # droplets per well
  
  
  ## Read BioRad data
  for(i in 1:No.BCoVBRSV.samples) {
    
    ## Preparation
    well = 0
    well_ID=as.character(names(plate.genuine.multiplex)[i])
    print(paste0(well_ID, " - BCoV/BRSV"))
    well<-plate.genuine.multiplex[[well_ID]]
    well_sample<-as.character(samples[which(samples$Well == well_ID), 2])
    well_sample_plot<-str_replace(well_sample, ":", "to")
    
    ## Remove the rain between the clusters
    #well <- sdRain(well, cMethod="Cluster", errorLevel = 4) #5 = default 
    #dropletPlot(well, cMethod="ClusterSdRain")
    
    ## Add info to the plate
    plate.cluster[[well_ID]]<-well
    
    ## Print plots
    pdf(paste0("multiplex_BCOVBRSV_", well_ID, "_", well_sample_plot, "_2D.pdf"), width=8, height=8)
    print(dropletPlot(well, cMethod="Cluster"))
    dev.off()
    
    well.plot<-as.data.frame(cbind(well@dropletAmplitudes$Ch1.Amplitude, well@dropletAmplitudes$Ch2.Amplitude, well@classification$Cluster))
    names(well.plot)<-c("Ch1.Amplitude", "Ch2.Amplitude", "Cluster")
    well.plot$kmeansSdRain<-gsub(1, "negative", well.plot$Cluster)
    well.plot$kmeansSdRain<-gsub(2, "HEX", well.plot$Cluster)
    well.plot$kmeansSdRain<-gsub(3, "FAM", well.plot$Cluster)
    well.plot$kmeansSdRain<-gsub(4, "FAM-HEX", well.plot$Cluster)

    pdf(paste0("multiplex_BCOVBRSV_", well_ID, "_", well_sample_plot, "_1D_ch1.pdf"), width=8, height=8)
    print(ggplot(well.plot, aes(runif(nrow(well.plot),1,nrow(well.plot)), Ch1.Amplitude, colour = as.factor(Cluster))) + 
            geom_point())
    dev.off()
    pdf(paste0("multiplex_BCOVBRSV_", well_ID, "_", well_sample_plot, "_1D_ch2.pdf"), width=8, height=8)
    print(ggplot(well.plot, aes(runif(nrow(well.plot),1,nrow(well.plot)), Ch2.Amplitude, colour = as.factor(Cluster))) + 
            geom_point())
    dev.off()
  }
  
  ## Generate multiplex data
  print(paste0(No.BCoVBRSV.samples, " BCoV/BRSV files processed"))
  cat(sep="\n\n")
  print("Compiling the output files...")
  results.multiplex<-plateSummary(plate.cluster, cMethod="Cluster", ch1Label = "BCoV", ch2Label = "BRSV")
  results.multiplex$FAM.HEX.difference<-round(results.multiplex[,10]/results.multiplex[,11], digits = 2)
  results.multiplex$flag.FAM.HEX.difference<-ifelse(results.multiplex$FAM.HEX.difference>2,results.multiplex$FAM.HEX.difference, "okay")
  
  ## Split data to get 1 row = 1 assay
  results.multiplex.FAM<-results.multiplex[, c(1,2,5,6,7,10,12,18)]
  results.multiplex.FAM$Target<-"BCoV"
  results.multiplex.FAM$DyeName<-"FAM"
  results.multiplex.FAM$Well<-row.names(results.multiplex.FAM)
  results.multiplex.HEX<-results.multiplex[, c(1,3,5,8,9,11,13,18)]
  results.multiplex.HEX$Target<-"BRSV"
  results.multiplex.HEX$DyeName<-"HEX"
  results.multiplex.HEX$Well<-row.names(results.multiplex.HEX)
  
  results.multiplex.export<-rbind(results.multiplex.FAM,setnames(results.multiplex.HEX,names(results.multiplex.FAM)))
  names(results.multiplex.export)<-c("PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets", "Conc(copies/µL)", "Copies/20µLWell", "Flag.FAM_HEX.difference", "Target", "DyeName", "Well")
  results.multiplex.export$Flag.positive.droplets<-ifelse(results.multiplex.export$PositivesDroplets/results.multiplex.export$AcceptedDroplets>0.7,results.multiplex.export$PositivesDroplets/results.multiplex.export$AcceptedDroplets, "okay")
  results.multiplex.export$Flag.total.droplets<-ifelse(results.multiplex.export$AcceptedDroplets<=12000,"low number of droplets", "okay")
  results.multiplex.export$Run<-run_ID
  results.multiplex.export$Comment<-""
  #print(paste0("Number of row before sample name transformation: ", nrow(results.multiplex.export)))
  results.multiplex.export<-setDT(samples)[results.multiplex.export, on="Well"]
  #print(paste0("Number of row after sample name transformation (should the same): ", nrow(results.multiplex.export)))
  results.multiplex.export<-results.multiplex.export[,c("Run", "Well", "Sample", "Target", "Conc(copies/µL)", "DyeName", "Copies/20µLWell", "PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets", "Flag.positive.droplets", "Flag.total.droplets", "Flag.FAM_HEX.difference", "Comment")]
  
  
  ## Export the data ## 
  write.table(results.multiplex.export, paste0("results_BCOVBRSV.csv"), quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")
  write.table(results.multiplex, paste0("results_details_BCOVBRSV.csv"), quote = FALSE, row.names = TRUE, col.names = TRUE, sep = ",")
  saveRDS(plate.cluster, file = "plate_BCOVBRSV.RData")
  
  print("done!")
  cat(sep="\n\n")
  cat(sep="\n\n")
  
  
}

  




  
  #####  Read the FAM singleplex data ###### 
  if(FAMsingleplex>0){
    print("singleplex FAM sample(s) detected")
    plate.genuine.FAMsingleplex <- ddpcrPlate(well="temp_FAMsingleplex/.")
    No.FAM.samples<-length(names(plate.genuine.FAMsingleplex))
    
    for(i in 1:No.FAM.samples) {
      
      ## Preparation
      well = well.plot = 0
      well_ID=as.character(names(plate.genuine.FAMsingleplex)[i])
      target<-samples[which(samples$Well == well_ID), c("target")]
      print(paste0(well_ID, " - ", target))
      well<-plate.genuine.FAMsingleplex[[well_ID]]
      well_sample<-as.character(samples[which(samples$Well == well_ID), 2])
      well_sample_plot<-str_replace(well_sample, ":", "to")
      
      ## Print plots
      well.plot<-as.data.frame(cbind(well@dropletAmplitudes$Ch1.Amplitude, well@classification$Cluster))
      names(well.plot)<-c("Ch1.Amplitude", "Cluster")
      well.plot$Cluster<-gsub(1, "negative", well.plot$Cluster)
      well.plot$Cluster<-gsub(3, "positive", well.plot$Cluster)
      pdf(paste0("singleplex_", target, "_", well_ID, "_", well_sample_plot, ".pdf"), width=8, height=8)
      print(ggplot(well.plot, aes(runif(nrow(well.plot),1,nrow(well.plot)), Ch1.Amplitude, colour = as.factor(Cluster))) + 
              geom_point())
      dev.off()
    }
    
    ## Generate singleplex data
    print(paste0(No.FAM.samples, " FAM singletex files processed"))
    cat(sep="\n\n")
    print("Compiling the output files...")
    singleplex_FAMassay<-as.character(target)
    results.FAMsingleplex<-plateSummary(plate.genuine.FAMsingleplex, cMethod="Cluster", ch1Label = singleplex_FAMassay, ch2Label = "NA")
    
    ## Split data to get 1 row = 1 assay
    results.FAMsingleplex.export<-results.FAMsingleplex[, c(1,2,5,6,7,10,12)]
    names(results.FAMsingleplex.export)<-c("PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets", "Conc(copies/µL)", "Copies/20µLWell")
    results.FAMsingleplex.export$Target<-singleplex_FAMassay
    results.FAMsingleplex.export$Flag.positive.droplets<-ifelse(results.FAMsingleplex.export$PositivesDroplets/results.FAMsingleplex.export$AcceptedDroplets>0.7,results.FAMsingleplex.export$PositivesDroplets/results.FAMsingleplex.export$AcceptedDroplets, "okay")
    results.FAMsingleplex.export$Flag.total.droplets<-ifelse(results.FAMsingleplex.export$AcceptedDroplets<=12000,"low number of droplets", "okay")
    results.FAMsingleplex.export$Well<-row.names(results.FAMsingleplex.export)
    results.FAMsingleplex.export$Run<-run_ID
    results.FAMsingleplex.export$DyeName<-"FAM"
    results.FAMsingleplex.export$Flag.FAM_HEX.difference<-""
    results.FAMsingleplex.export$Comment<-""
    #print(paste0("Number of row before sample name transformation: ", nrow(results.FAMsingleplex.export)))
    results.FAMsingleplex.export<-setDT(samples)[results.FAMsingleplex.export, on="Well"]
    #print(paste0("Number of row after sample name transformation (should the same): ", nrow(results.FAMsingleplex.export)))
    results.FAMsingleplex.export<-results.FAMsingleplex.export[,c("Run", "Well", "Sample", "Target", "Conc(copies/µL)", "DyeName", "Copies/20µLWell", "PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets", "Flag.positive.droplets", "Flag.total.droplets", "Flag.FAM_HEX.difference", "Comment")]
    
    write.table(results.FAMsingleplex.export, paste0("results_", singleplex_FAMassay, "_FAMsingleplex.csv"), quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")
    write.table(results.FAMsingleplex, paste0("results_details_", singleplex_FAMassay, "_FAMsingleplex.csv"), quote = FALSE, row.names = TRUE, col.names = TRUE, sep = ",")
    saveRDS(plate.genuine.FAMsingleplex, file = paste0("plate_", singleplex_FAMassay, "_FAMsingleplex.RData")) 
    
    print("done!")
    cat(sep="\n\n")
    cat(sep="\n\n")
    
  }
  
  
  
  



  #####  Read the HEX singleplex data ###### 
  if(HEXsingleplex>0){
    print("singleplex HEX sample(s) detected")
    plate.genuine.HEXsingleplex <- ddpcrPlate(well="temp_HEXsingleplex/.")
    No.HEX.samples<-length(names(plate.genuine.HEXsingleplex))
    
    for(i in 1:No.HEX.samples) {
      
      ## Preparation
      well = well.plot = 0
      well_ID=as.character(names(plate.genuine.HEXsingleplex)[i])
      target<-samples[which(samples$Well == well_ID), c("target")]
      print(paste0(well_ID, " - ", target))
      well<-plate.genuine.HEXsingleplex[[well_ID]]
      well_sample<-as.character(samples[which(samples$Well == well_ID), 2])
      well_sample_plot<-str_replace(well_sample, ":", "to")
      
      ## Print plots
      well.plot<-as.data.frame(cbind(well@dropletAmplitudes$Ch2.Amplitude, well@classification$Cluster))
      names(well.plot)<-c("Ch2.Amplitude", "Cluster")
      well.plot$Cluster<-gsub(1, "negative", well.plot$Cluster)
      well.plot$Cluster<-gsub(2, "positive", well.plot$Cluster)
      pdf(paste0("singleplex_", target, "_", well_ID, "_", well_sample_plot, ".pdf"), width=8, height=8)
      print(ggplot(well.plot, aes(runif(nrow(well.plot),1,nrow(well.plot)), Ch2.Amplitude, colour = as.factor(Cluster))) + 
              geom_point())
      dev.off()
    }
    
    
    
    
    ## Generate singleplex data
    print(paste0(No.HEX.samples, " HEX singletex files processed"))
    cat(sep="\n\n")
    print("Compiling the output files...")
    singleplex_HEXassay<-as.character(target)
    results.HEXsingleplex<-plateSummary(plate.genuine.HEXsingleplex, cMethod="Cluster", ch1Label = "NA", ch2Label = singleplex_HEXassay)
    
    ## Split data to get 1 row = 1 assay
    results.HEXsingleplex.export<-results.HEXsingleplex[, c(1,3,5,8,9,11,13)]
    names(results.HEXsingleplex.export)<-c("PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets", "Conc(copies/µL)", "Copies/20µLWell")
    results.HEXsingleplex.export$Target<-singleplex_HEXassay
    results.HEXsingleplex.export$Flag.positive.droplets<-ifelse(results.HEXsingleplex.export$PositivesDroplets/results.HEXsingleplex.export$AcceptedDroplets>0.7,results.HEXsingleplex.export$PositivesDroplets/results.HEXsingleplex.export$AcceptedDroplets, "okay")
    results.HEXsingleplex.export$Flag.total.droplets<-ifelse(results.HEXsingleplex.export$AcceptedDroplets<=12000,"low number of droplets", "okay")
    results.HEXsingleplex.export$Well<-row.names(results.HEXsingleplex.export)
    results.HEXsingleplex.export$Run<-run_ID
    results.HEXsingleplex.export$DyeName<-"HEX"
    results.HEXsingleplex.export$Flag.FAM_HEX.difference<-""
    results.HEXsingleplex.export$Comment<-""
    #print(paste0("Number of row before sample name transformation: ", nrow(results.HEXsingleplex.export)))
    results.HEXsingleplex.export<-setDT(samples)[results.HEXsingleplex.export, on="Well"]
    #print(paste0("Number of row after sample name transformation (should the same): ", nrow(results.HEXsingleplex.export))) 
    results.HEXsingleplex.export<-results.HEXsingleplex.export[,c("Run", "Well", "Sample", "Target", "Conc(copies/µL)", "DyeName", "Copies/20µLWell", "PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets", "Flag.positive.droplets", "Flag.total.droplets", "Flag.FAM_HEX.difference", "Comment")]
    
    write.table(results.HEXsingleplex.export, paste0("results_", singleplex_HEXassay, "_HEXsingleplex.csv"), quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")
    write.table(results.HEXsingleplex, paste0("results_details_", singleplex_HEXassay, "_HEXsingleplex.csv"), quote = FALSE, row.names = TRUE, col.names = TRUE, sep = ",")
    saveRDS(plate.genuine.HEXsingleplex, file = paste0("plate_", singleplex_HEXassay, "_HEXsingleplex.RData")) 
    
    print("done!")
    cat(sep="\n\n")
    cat(sep="\n\n")
    
  }
  
  
  #####  Delete temporary folders ###### 
  unlink("temp_all_files", recursive=TRUE)
  unlink("temp_BCOVBRSVmultiplex", recursive=TRUE)
  unlink("temp_N1N2multiplex", recursive=TRUE)
  unlink("temp_FAMsingleplex", recursive=TRUE)
  unlink("temp_HEXsingleplex", recursive=TRUE)
  
  
  
  ##### Recap number of samples ######
  print(paste0(length(dataRawFiles), " raw amplification files detected"))
  print(paste0(No.BCoVBRSV.samples+No.N1N2.samples+No.FAM.samples+No.HEX.samples, " files processed at the end"))
}


