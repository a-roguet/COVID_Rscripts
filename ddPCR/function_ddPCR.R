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

  
  ## Set the run directory
  setwd(here(working_directory, run_ID))
  
  
  
  
  ################################
  ### Artificial sample
  ################################
  
  ### N1/N2 INFLUENT ###
  ## Import data 
  # setwd("~/OneDrive - UWM/SARS-CoV-2/DATA/ddPCR data/Artificial_Sample/") # BioRad Clusters: 1=NN, 2=PN (FAM), 3=PP (FAM/HEX), 4=NP (HEX)
  # Artificial.sample.plate <- ddpcrPlate(well=".")
  
  ## Select the info from the unique well (A01)
  # four.clusters<-Artificial.sample.plate[["A01"]]
  # dropletPlot(four.clusters)
  # saveRDS(four.clusters, file = "~/OneDrive - UWM/SARS-CoV-2/DATA/ddPCR data/Artificial_Sample/four_clusters_iowa.RData")
  
  
  ### N1/N2 SLUDGE ###
  ## Import data
  #setwd("~/OneDrive - UWM/SARS-CoV-2/DATA/ddPCR data/Artificial_Sample/") # BioRad Clusters: 1=NN, 2=PN (FAM), 3=PP (FAM/HEX), 4=NP (HEX)
  #Artificial.sample.plate <- ddpcrPlate(well=".")
  
  ## Select the info from the unique well (A01)
  #four.clusters<-Artificial.sample.plate[["A01"]]
  #dropletPlot(four.clusters, cMethod="Cluster")
  #saveRDS(four.clusters, file = "~/OneDrive - UWM/SARS-CoV-2/DATA/ddPCR data/Artificial_Sample/four_clusters_iowa_sludge.RData")
 
  
  ### BioRad variants ###
  ## Import data
  #setwd("~/OneDrive - UWM/SARS-CoV-2/DATA/ddPCR data/Artificial_Sample/") # BioRad Clusters: 1=NN, 2=PN (FAM), 3=PP (FAM/HEX), 4=NP (HEX)
  #Artificial.sample.plate <- ddpcrPlate(well=".")
  
  ## Select the info from the unique well (A01)
  #four.clusters<-Artificial.sample.plate[["A01"]]
  #dropletPlot(four.clusters, cMethod="Cluster")
  #saveRDS(four.clusters, file = "~/OneDrive - UWM/SARS-CoV-2/DATA/ddPCR data/Artificial_Sample/four_clusters_variant.RData")

  
  
  ### BioRad 944 variants ###
  ## Import data
  #setwd("~/OneDrive - UWM/SARS-CoV-2/DATA/ddPCR data/Artificial_Sample/") # BioRad Clusters: 1=NN, 2=PN (FAM), 3=PP (FAM/HEX), 4=NP (HEX)
  #Artificial.sample.plate <- ddpcrPlate(well=".")
  
  ## Select the info from the unique well (A01)
  #four.clusters<-Artificial.sample.plate[["A01"]]
  #dropletPlot(four.clusters, cMethod="Cluster")
  #saveRDS(four.clusters, file = "~/OneDrive - UWM/SARS-CoV-2/DATA/ddPCR data/Artificial_Sample/four_clusters_variant944.RData")
  
  
  
  ### Merge all .RData ###
  #setwd("~/OneDrive - UWM/SARS-CoV-2/DATA/ddPCR data/Artificial_Sample/") # BioRad Clusters: 1=NN, 2=PN (FAM), 3=PP (FAM/HEX), 4=NP (HEX)
  #four.clusters.genuine <- readRDS(file = "~/OneDrive - UWM/SARS-CoV-2/DATA/ddPCR data/Artificial_Sample/four_clusters_iowa.RData")
  #four.clusters.sludge.genuine <- readRDS(file = "~/OneDrive - UWM/SARS-CoV-2/DATA/ddPCR data/Artificial_Sample/four_clusters_iowa_sludge.RData")
  #four.clusters.variant.genuine <- readRDS(file = "~/OneDrive - UWM/SARS-CoV-2/DATA/ddPCR data/Artificial_Sample/four_clusters_variant.RData")
  #four.clusters.variant944.genuine <- readRDS(file = "~/OneDrive - UWM/SARS-CoV-2/DATA/ddPCR data/Artificial_Sample/four_clusters_variant944.RData")
  #save(four.clusters.genuine, four.clusters.sludge.genuine, four.clusters.variant.genuine, four.clusters.variant944.genuine, file = "~/OneDrive - UWM/SARS-CoV-2/DATA/ddPCR data/Artificial_Sample/four_clusters_ALL.RData")

  
   ### Load .RData ###
  
  load(here(working_directory, run_ID,"four_clusters_ALL.RData"))
  
  ## N1/N2 - Get the center of the negative droplets
  four.clusters.genuine.NN <- four.clusters.genuine@dropletAmplitudes[which(four.clusters.genuine@classification$Cluster == "NN"),]
  four.clusters.genuine.NN.Ch1<-mean(four.clusters.genuine.NN$Ch1.Amplitude) #1198.864
  four.clusters.genuine.NN.Ch2<-mean(four.clusters.genuine.NN$Ch2.Amplitude) #1996.125
  
  ## N1/N2 sludge - Get the center of the negative droplets
  four.clusters.sludge.genuine.NN <- four.clusters.sludge.genuine@dropletAmplitudes[which(four.clusters.sludge.genuine@classification$Cluster == "NN"),]
  four.clusters.sludge.genuine.NN.Ch1<-mean(four.clusters.sludge.genuine.NN$Ch1.Amplitude) #1398.864
  four.clusters.sludge.genuine.NN.Ch2<-mean(four.clusters.sludge.genuine.NN$Ch2.Amplitude) #1596.125
  
  ## Variant - Get the center of the negative droplets
  four.clusters.variant.genuine.NN <- four.clusters.variant.genuine@dropletAmplitudes[which(four.clusters.variant.genuine@classification$Cluster == "NN"),]
  four.clusters.variant.genuine.NN.Ch1<-mean(four.clusters.variant.genuine.NN$Ch1.Amplitude) 
  four.clusters.variant.genuine.NN.Ch2<-mean(four.clusters.variant.genuine.NN$Ch2.Amplitude) 
  #dropletPlot(four.clusters.variant.genuine, cMethod="Cluster")
  
  
  ## Variant 944 - Get the center of the negative droplets
  four.clusters.variant944.genuine.NN <- four.clusters.variant944.genuine@dropletAmplitudes[which(four.clusters.variant944.genuine@classification$Cluster == "NN"),]
  four.clusters.variant944.genuine.NN.Ch1<-mean(four.clusters.variant944.genuine.NN$Ch1.Amplitude) 
  four.clusters.variant944.genuine.NN.Ch2<-mean(four.clusters.variant944.genuine.NN$Ch2.Amplitude) 
  #dropletPlot(four.clusters.variant944.genuine, cMethod="Cluster")
  
  
  
  ################################
  ### Standards & Real samples
  ################################  
  
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
  dir.create("temp_all_files"); dir.create("temp_N1N2multiplex"); dir.create("temp_N1N2sludgemultiplex"); dir.create("temp_BCOVBRSVmultiplex"); dir.create("temp_FAMsingleplex"); dir.create("temp_HEXsingleplex"); dir.create("temp_variantsmultiplex"); dir.create("temp_variants944multiplex")
  dataRawFiles <- dir(".", "*_Amplitude.csv", ignore.case = TRUE, all.files = TRUE)
  file.copy(dataRawFiles, "./temp_all_files", overwrite = TRUE)
  
  ## Split the files between singleplex, N1/N2 multiplex, N1/N2 sludge multiplex and BCoV/BRSV multiplex
  dataTempFiles <- dir("./temp_all_files/", "*.csv", ignore.case = TRUE, all.files = TRUE)
  FAMsingleplex=HEXsingleplex=N1N2multiplex=N1N2Sludgemultiplex=BCoVBRSVmultiplex=variantmultiplex=variant944multiplex=0
  
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
        } else if(grepl("N1S_N2S", samples[which(samples$Well == wellTemp), c("target")], fixed = TRUE)){
          N1N2Sludgemultiplex=N1N2Sludgemultiplex+1
          write.table(temp, paste0("./temp_N1N2sludgemultiplex/", dataTempFiles[j]), quote = FALSE, sep = ",", col.names = TRUE, row.names = FALSE)
        } else if(grepl("BCoV_BRSV", samples[which(samples$Well == wellTemp), c("target")], fixed = TRUE)){
          BCoVBRSVmultiplex=BCoVBRSVmultiplex+1
          write.table(temp, paste0("./temp_BCOVBRSVmultiplex/", dataTempFiles[j]), quote = FALSE, sep = ",", col.names = TRUE, row.names = FALSE)
        } else if(grepl("944M_944W", samples[which(samples$Well == wellTemp), c("target")], fixed = TRUE)){
          variant944multiplex=variant944multiplex+1
          write.table(temp, paste0("./temp_variants944multiplex/", dataTempFiles[j]), quote = FALSE, sep = ",", col.names = TRUE, row.names = FALSE)
        } else if(grepl("M_W", gsub('[0-9]+', '', samples[which(samples$Well == wellTemp), c("target")]), fixed = TRUE)){
          variantmultiplex=variantmultiplex+1
          write.table(temp, paste0("./temp_variantsmultiplex/", dataTempFiles[j]), quote = FALSE, sep = ",", col.names = TRUE, row.names = FALSE)
        }
      }
    }
  
  No.BCoVBRSV.samples=No.N1N2.samples=No.N1N2Sludge.samples=No.FAM.samples=No.HEX.samples=No.variant.samples=No.variant944.samples=0
  samples$target<-str_replace(samples$target, "N1S", "N1"); samples$target<-str_replace(samples$target, "N2S", "N2")
  
  
  #####  Read the N1/N2 multiplex data - INFLUENT ###### 
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
      well.NN.Ch1<-mean(well.NN$Ch1.Amplitude)
      well.NN.Ch2<-mean(well.NN$Ch2.Amplitude)
      
      ## Determine the difference of origin between the artificial and the real sample (i.e., ch1 and ch2)
      ch1<-four.clusters.NN.Ch1-well.NN.Ch1
      ch2<-four.clusters.NN.Ch2-well.NN.Ch2
      
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
      print(ggplot(well.plot, aes(runif(nrow(well.plot),1,nrow(well.plot)), Ch1.Amplitude, colour = as.factor(kmeansSdRain))) + xlab("droplets (0-total accepted droplets)") + geom_point() + scale_color_manual(name = "Droplet clusters:", values = c("FAM" = "#009f74", "HEX"="#cb79a6", "FAM-HEX"="#edbb5b", "negative"="#0073b3", "rain"="#c1c1c1")))
      dev.off()
      pdf(paste0("multiplex_N1N2_", well_ID, "_", well_sample_plot, "_1D_ch2.pdf"), width=8, height=8)
      print(ggplot(well.plot, aes(runif(nrow(well.plot),1,nrow(well.plot)), Ch2.Amplitude, colour = as.factor(kmeansSdRain))) + xlab("droplets (0-total accepted droplets)") + geom_point() + scale_color_manual(name = "Droplet clusters:", values = c("FAM" = "#009f74", "HEX"="#cb79a6", "FAM-HEX"="#edbb5b", "negative"="#0073b3", "rain"="#c1c1c1")))
      dev.off()
    }
    
    ## Generate multiplex data
    print(paste0(No.N1N2.samples, " N1/N2 files processed"))
    cat(sep="\n\n")
    print("Compiling the output files...")
    results.N1N2.multiplex<-plateSummary(plate.cluster, cMethod="kmeansSdRain", ch1Label = "N1", ch2Label = "N2")
    results.N1N2.multiplex$FAM.HEX.difference<-round(results.N1N2.multiplex[,10]/results.N1N2.multiplex[,11], digits = 2)
    results.N1N2.multiplex$flag.FAM.HEX.difference<-ifelse(results.N1N2.multiplex$FAM.HEX.difference<=2,"okay", ifelse(results.N1N2.multiplex$N1Positives<N1.LOQ.No.droplet | results.N1N2.multiplex$N2Positives<N2.LOQ.No.droplet, paste0("okay (", results.N1N2.multiplex$FAM.HEX.difference, ")"), results.N1N2.multiplex$FAM.HEX.difference))
    results.N1N2.multiplex$flag.FAM.HEX.difference[is.na(results.N1N2.multiplex$flag.FAM.HEX.difference)] <- "okay"

    
    ## Split data to get 1 row = 1 assay
    results.N1N2.multiplex.FAM<-results.N1N2.multiplex[, c(1,2,5,6,7,10,12,18)]
    results.N1N2.multiplex.FAM$Target<-"N1"
    results.N1N2.multiplex.FAM$DyeName<-"FAM"
    results.N1N2.multiplex.FAM$Well<-row.names(results.N1N2.multiplex.FAM)
    results.N1N2.multiplex.HEX<-results.N1N2.multiplex[, c(1,3,5,8,9,11,13,18)]
    results.N1N2.multiplex.HEX$Target<-"N2"
    results.N1N2.multiplex.HEX$DyeName<-"HEX"
    results.N1N2.multiplex.HEX$Well<-row.names(results.N1N2.multiplex.HEX)
    
    results.N1N2.multiplex.export<-rbind(results.N1N2.multiplex.FAM,setnames(results.N1N2.multiplex.HEX,names(results.N1N2.multiplex.FAM)))
    names(results.N1N2.multiplex.export)<-c("PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets", "Conc(copies/µL)", "Copies/20µLWell", "Flag.FAM_HEX.difference", "Target", "DyeName", "Well")
    results.N1N2.multiplex.export$Flag.positive.droplets<-ifelse(results.N1N2.multiplex.export$PositivesDroplets/results.N1N2.multiplex.export$AcceptedDroplets>0.7,paste0("too many positive droplets (", round(results.N1N2.multiplex.export$PositivesDroplets/results.N1N2.multiplex.export$AcceptedDroplets*100, digits = 0), ")"), "okay")
    results.N1N2.multiplex.export$Flag.total.droplets<-ifelse(results.N1N2.multiplex.export$AcceptedDroplets<=10000,"low number of droplets", "okay")
    results.N1N2.multiplex.export$Run<-run_ID
    results.N1N2.multiplex.export$Comment<-""
    #print(paste0("Number of row before sample name transformation: ", nrow(results.N1N2.multiplex.export)))
    results.N1N2.multiplex.export<-setDT(samples)[results.N1N2.multiplex.export, on="Well"]
    #print(paste0("Number of row after sample name transformation (should the same): ", nrow(results.N1N2.multiplex.export)))
    results.N1N2.multiplex.export<-results.N1N2.multiplex.export[,c("Run", "Well", "Sample", "Target", "Conc(copies/µL)", "DyeName", "Copies/20µLWell", "PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets", "Flag.positive.droplets", "Flag.total.droplets", "Flag.FAM_HEX.difference", "Comment")]
    results.N1N2.multiplex.export$NeedRerun<-ifelse(results.N1N2.multiplex.export$Flag.positive.droplets=="okay" & results.N1N2.multiplex.export$Flag.total.droplets == "okay" & (results.N1N2.multiplex.export$Flag.FAM_HEX.difference<4 | grepl("okay", results.N1N2.multiplex.export$Flag.FAM_HEX.difference)) & results.N1N2.multiplex.export$Comment == "", "", "need_rerun")
    results.N1N2.multiplex.export<-results.N1N2.multiplex.export[,c("Flag.positive.droplets", "Flag.total.droplets", "Flag.FAM_HEX.difference", "Comment", "NeedRerun", "Run", "Well", "Sample", "Target", "Conc(copies/µL)", "DyeName", "Copies/20µLWell", "PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets")]
    # If there is only 1 sample, it is to avoid the Well to be called 1, and Sample to be called NA
    if(nrow(results.N1N2.multiplex.export)==2){
      results.N1N2.multiplex.export[, c("Well")]<-well_ID
      results.N1N2.multiplex.export[, c("Sample")]<-well_sample
      
    }
    
    
    ## Export the data ## 
    write.table(results.N1N2.multiplex.export, paste0("results_N1N2.csv"), quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")
    write.table(results.N1N2.multiplex, paste0("details_results_N1N2.csv"), quote = FALSE, row.names = TRUE, col.names = TRUE, sep = ",")
    saveRDS(plate.cluster, file = "plate_N1N2.RData")
    
    print("done!")
    cat(sep="\n\n")
    cat(sep="\n\n")
    
  }
  
  

  
    
  
  
  
  
#####  Read the N1/N2 multiplex data - SLUDGE ###### 
  if(N1N2Sludgemultiplex>0){
    print("N1/N2 sludge multiplex sample(s) detected")
    plate.sludge.genuine.multiplex <- ddpcrPlate(well="temp_N1N2sludgemultiplex/.")
    No.N1N2Sludge.samples<-length(names(plate.sludge.genuine.multiplex))
    names(plate.sludge.genuine.multiplex) # list all the N1/N2 wells
    plate.sludge.cluster <- plate.sludge.genuine.multiplex # duplicate "plate.sludge.genuine". "plate.sludge.cluster" will store the k-means clusters
    
    ## Display original clusters
    #commonClassificationMethod(plate.sludge.genuine.multiplex) # 
    #facetPlot(plate.sludge.genuine.multiplex, cMethod="Cluster") # droplets per well
    
    
    ## Define 4 clusters (i.e. NN (negative), PN (N1), PP (N1/N2) and NP (N2) for each well)
    for(i in 1:No.N1N2Sludge.samples) {
      
      ## Preparation
      well = 0
      four.clusters.NN.Ch1 = four.clusters.sludge.genuine.NN.Ch1
      four.clusters.NN.Ch2 = four.clusters.sludge.genuine.NN.Ch2
      four.clusters <- four.clusters.sludge.genuine
      well_ID=as.character(names(plate.sludge.genuine.multiplex)[i])
      print(paste0(well_ID, " - N1/N2 - sludge"))
      well<-plate.sludge.genuine.multiplex[[well_ID]]
      well_sample<-as.character(samples[which(samples$Well == well_ID), 2])
      well_sample_plot<-str_replace(well_sample, ":", "to")
      
      #dropletPlot(well)
      
      ## Define the center of the Negative droplets for the well
      well.NN <- well@dropletAmplitudes[which(well@classification$Cluster == "NN"),]
      well.NN.Ch1<-mean(well.NN$Ch1.Amplitude)
      well.NN.Ch2<-mean(well.NN$Ch2.Amplitude)
      
      ## Determine the difference of origin between the artificial and the real sample (i.e., ch1 and ch2)
      ch1<-four.clusters.NN.Ch1-well.NN.Ch1
      ch2<-four.clusters.NN.Ch2-well.NN.Ch2
      
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
                             centres=matrix(c(1400-ch1, 1600-ch2,    1400-ch1, 3000-ch2,   5500-ch1, 1900-ch2,   5500-ch1, 3300-ch2), ncol=2, byrow=TRUE))
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
      plate.sludge.cluster[[well_ID]]<-well
      
      ## Print plots
      pdf(paste0("multiplex_N1N2sludge_", well_ID, "_", well_sample_plot, "_2D.pdf"), width=8, height=8)
      print(dropletPlot(well, cMethod="kmeansSdRain"))
      dev.off()
      
      well.plot<-as.data.frame(cbind(well@dropletAmplitudes$Ch1.Amplitude, well@dropletAmplitudes$Ch2.Amplitude, well@classification$kmeansSdRain))
      names(well.plot)<-c("Ch1.Amplitude", "Ch2.Amplitude", "kmeansSdRain")
      well.plot$kmeansSdRain<-gsub(1, "negative", well.plot$kmeansSdRain)
      well.plot$kmeansSdRain<-gsub(2, "HEX", well.plot$kmeansSdRain)
      well.plot$kmeansSdRain<-gsub(3, "FAM", well.plot$kmeansSdRain)
      well.plot$kmeansSdRain<-gsub(4, "FAM-HEX", well.plot$kmeansSdRain)
      well.plot$kmeansSdRain<-gsub(5, "rain", well.plot$kmeansSdRain)
      
      pdf(paste0("multiplex_N1N2sludge_", well_ID, "_", well_sample_plot, "_1D_ch1.pdf"), width=8, height=8)
      print(ggplot(well.plot, aes(runif(nrow(well.plot),1,nrow(well.plot)), Ch1.Amplitude, colour = as.factor(kmeansSdRain)))+ xlab("droplets (0-total accepted droplets)") + geom_point() + scale_color_manual(name = "Droplet clusters:", values = c("FAM" = "#009f74", "HEX"="#cb79a6", "FAM-HEX"="#edbb5b", "negative"="#0073b3", "rain"="#c1c1c1")))
      dev.off()
      pdf(paste0("multiplex_N1N2sludge_", well_ID, "_", well_sample_plot, "_1D_ch2.pdf"), width=8, height=8)
      print(ggplot(well.plot, aes(runif(nrow(well.plot),1,nrow(well.plot)), Ch2.Amplitude, colour = as.factor(kmeansSdRain))) + xlab("droplets (0-total accepted droplets)") + geom_point() + scale_color_manual(name = "Droplet clusters:", values = c("FAM" = "#009f74", "HEX"="#cb79a6", "FAM-HEX"="#edbb5b", "negative"="#0073b3", "rain"="#c1c1c1")))
      dev.off()
    }
    
    ## Generate multiplex data
    print(paste0(No.N1N2Sludge.samples, " N1/N2 sludge files processed"))
    cat(sep="\n\n")
    print("Compiling the output files...")
    results.N1N2sludge.multiplex<-plateSummary(plate.sludge.cluster, cMethod="kmeansSdRain", ch1Label = "N1", ch2Label = "N2")
    results.N1N2sludge.multiplex$FAM.HEX.difference<-round(results.N1N2sludge.multiplex[,10]/results.N1N2sludge.multiplex[,11], digits = 2)
    results.N1N2sludge.multiplex$flag.FAM.HEX.difference<-ifelse(results.N1N2sludge.multiplex$FAM.HEX.difference<=2,"okay", ifelse(results.N1N2sludge.multiplex$N1Positives<N1.LOQ.No.droplet | results.N1N2sludge.multiplex$N2Positives<N2.LOQ.No.droplet, paste0("okay (", results.N1N2sludge.multiplex$FAM.HEX.difference, ")"), results.N1N2sludge.multiplex$FAM.HEX.difference))
    results.N1N2sludge.multiplex$flag.FAM.HEX.difference[is.na(results.N1N2sludge.multiplex$flag.FAM.HEX.difference)] <- "okay"
    
    
    ## Split data to get 1 row = 1 assay
    results.N1N2sludge.multiplex.FAM<-results.N1N2sludge.multiplex[, c(1,2,5,6,7,10,12,18)]
    results.N1N2sludge.multiplex.FAM$Target<-"N1"
    results.N1N2sludge.multiplex.FAM$DyeName<-"FAM"
    results.N1N2sludge.multiplex.FAM$Well<-row.names(results.N1N2sludge.multiplex.FAM)
    results.N1N2sludge.multiplex.HEX<-results.N1N2sludge.multiplex[, c(1,3,5,8,9,11,13,18)]
    results.N1N2sludge.multiplex.HEX$Target<-"N2"
    results.N1N2sludge.multiplex.HEX$DyeName<-"HEX"
    results.N1N2sludge.multiplex.HEX$Well<-row.names(results.N1N2sludge.multiplex.HEX)
    
    results.N1N2sludge.multiplex.export<-rbind(results.N1N2sludge.multiplex.FAM,setnames(results.N1N2sludge.multiplex.HEX,names(results.N1N2sludge.multiplex.FAM)))
    names(results.N1N2sludge.multiplex.export)<-c("PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets", "Conc(copies/µL)", "Copies/20µLWell", "Flag.FAM_HEX.difference", "Target", "DyeName", "Well")
    results.N1N2sludge.multiplex.export$Flag.positive.droplets<-ifelse(results.N1N2sludge.multiplex.export$PositivesDroplets/results.N1N2sludge.multiplex.export$AcceptedDroplets>0.7,paste0("too many positive droplets (", round(results.N1N2sludge.multiplex.export$PositivesDroplets/results.N1N2sludge.multiplex.export$AcceptedDroplets*100, digits = 0), ")"), "okay")
    results.N1N2sludge.multiplex.export$Flag.total.droplets<-ifelse(results.N1N2sludge.multiplex.export$AcceptedDroplets<=10000,"low number of droplets", "okay")
    results.N1N2sludge.multiplex.export$Run<-run_ID
    results.N1N2sludge.multiplex.export$Comment<-""
    #print(paste0("Number of row before sample name transformation: ", nrow(results.N1N2sludge.multiplex.export)))
    results.N1N2sludge.multiplex.export<-setDT(samples)[results.N1N2sludge.multiplex.export, on="Well"]
    #print(paste0("Number of row after sample name transformation (should the same): ", nrow(results.N1N2sludge.multiplex.export)))
    results.N1N2sludge.multiplex.export<-results.N1N2sludge.multiplex.export[,c("Run", "Well", "Sample", "Target", "Conc(copies/µL)", "DyeName", "Copies/20µLWell", "PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets", "Flag.positive.droplets", "Flag.total.droplets", "Flag.FAM_HEX.difference", "Comment")]
    results.N1N2sludge.multiplex.export$NeedRerun<-ifelse(results.N1N2sludge.multiplex.export$Flag.positive.droplets=="okay" & results.N1N2sludge.multiplex.export$Flag.total.droplets == "okay" & (results.N1N2sludge.multiplex.export$Flag.FAM_HEX.difference<4 | grepl("okay", results.N1N2sludge.multiplex.export$Flag.FAM_HEX.difference)) & results.N1N2sludge.multiplex.export$Comment == "", "", "need_rerun")
    results.N1N2sludge.multiplex.export<-results.N1N2sludge.multiplex.export[,c("Flag.positive.droplets", "Flag.total.droplets", "Flag.FAM_HEX.difference", "Comment", "NeedRerun", "Run", "Well", "Sample", "Target", "Conc(copies/µL)", "DyeName", "Copies/20µLWell", "PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets")]
    # If there is only 1 sample, it is to avoid the Well to be called 1, and Sample to be called NA
    if(nrow(results.N1N2sludge.multiplex.export)==2){
      results.N1N2sludge.multiplex.export[, c("Well")]<-well_ID
      results.N1N2sludge.multiplex.export[, c("Sample")]<-well_sample
      
    }
    
    ## Export the data ## 
    write.table(results.N1N2sludge.multiplex.export, paste0("results_N1N2sludge.csv"), quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")
    write.table(results.N1N2sludge.multiplex, paste0("details_results_N1N2sludge.csv"), quote = FALSE, row.names = TRUE, col.names = TRUE, sep = ",")
    saveRDS(plate.sludge.cluster, file = "plate_N1N2sludge.RData")
    
    print("done!")
    cat(sep="\n\n")
    cat(sep="\n\n")
    
  }
  
  
  
  
  
  
  
  
  
  #####  Read the BioRad variants multiplex data  ###### 
  if(variantmultiplex>0){
    print("variant multiplex sample(s) detected")
    plate.variant.genuine.multiplex <- ddpcrPlate(well="temp_variantsmultiplex/.")
    No.variant.samples<-length(names(plate.variant.genuine.multiplex))
    names(plate.variant.genuine.multiplex) # list all the N1/N2 wells
    plate.variant.cluster <- plate.variant.genuine.multiplex # duplicate "plate.sludge.genuine". "plate.sludge.cluster" will store the k-means clusters
    list.variant<-matrix(NA, No.variant.samples, 1)
    
    #commonClassificationMethod(plate.variant.genuine.multiplex) # 
    #facetPlot(plate.variant.genuine.multiplex, cMethod="Cluster") # droplets per well
    
    
    ## Define 4 clusters (i.e. NN (negative), PN (N1), PP (N1/N2) and NP (N2) for each well)
    for(i in 1:No.variant.samples) {
      
      ## Preparation
      well = 0
      four.clusters.NN.Ch1 = four.clusters.variant.genuine.NN.Ch1
      four.clusters.NN.Ch2 = four.clusters.variant.genuine.NN.Ch2
      four.clusters <- four.clusters.variant.genuine
      well_ID=as.character(names(plate.variant.genuine.multiplex)[i])
      
      well<-plate.variant.genuine.multiplex[[well_ID]]
      well_sample<-as.character(samples[which(samples$Well == well_ID), 2])
      well_target<-as.numeric(gsub("([0-9]+).*$", "\\1", strsplit(as.character(samples[which(samples$Well == well_ID), 3]), '_' ,fixed=TRUE)[[1]][1]))
      well_sample_plot<-str_replace(well_sample, ":", "to")
      print(paste0(well_ID, " - ", well_target,  " variant"))
      list.variant[i, ]<-well_target
      #dropletPlot(well)
      
      ## Define the center of the Negative droplets for the well
      well.NN <- well@dropletAmplitudes[which(well@classification$Cluster == "NN"),]
      well.NN.Ch1<-mean(well.NN$Ch1.Amplitude)
      well.NN.Ch2<-mean(well.NN$Ch2.Amplitude)
      
      ## Determine the difference of origin between the artificial and the real sample (i.e., ch1 and ch2)
      ch1<-four.clusters.NN.Ch1-well.NN.Ch1
      ch2<-four.clusters.NN.Ch2-well.NN.Ch2
      
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
                             centres=matrix(c(4000-ch1, 2500-ch2,    8000-ch1, 2500-ch2,   8000-ch1, 5000-ch2,   2500-ch1, 5000-ch2), ncol=2, byrow=TRUE))
      dropletPlot(well, cMethod="kmeans")
      
      ## Remove the rain between the clusters
      well <- sdRain(well, cMethod="kmeans", errorLevel = 5) #5 = default 
      #dropletPlot(well, cMethod="kmeansSdRain")
      
      ## Remove artificial droplets
      well@dropletAmplitudes<-well@dropletAmplitudes[which(well@classification$Cluster != "artificial"),]
      well@classification<-well@classification[which(well@classification$Cluster != "artificial"),]
      dropletPlot(well, cMethod="kmeansSdRain")
      
      ## Replace FAM-HEX droplets by rain
      #well@classification$kmeansSdRain['Rain']<-well@classification$kmeansSdRain['PP']
      #well@classification$kmeansSdRain<-as.factor(gsub("PP", "Rain", well@classification$kmeansSdRain))
      PP<-which(well@classification$kmeansSdRain=="PP")
      well@classification$kmeansSdRain[PP]<-'Rain'
      dropletPlot(well, cMethod="kmeansSdRain")
      
      ## If NA are generated during the last step, replace NA by kmeans classification
      na<-which(is.na(well@classification$kmeansSdRain))
      well@classification$kmeansSdRain[na]<-well@classification$kmeans[na]
      dropletPlot(well, cMethod="kmeansSdRain")
      
      
      ## Add info to the plate
      plate.variant.cluster[[well_ID]]<-well
      
      ## Print plots
      pdf(paste0("multiplex_", well_target, "variant_", well_ID, "_", well_sample_plot, "_2D.pdf"), width=8, height=8)
      print(dropletPlot(well, cMethod="kmeansSdRain"))
      dev.off()
      
      well.plot<-as.data.frame(cbind(well@dropletAmplitudes$Ch1.Amplitude, well@dropletAmplitudes$Ch2.Amplitude, well@classification$kmeansSdRain))
      names(well.plot)<-c("Ch1.Amplitude", "Ch2.Amplitude", "kmeansSdRain")
      well.plot$kmeansSdRain<-gsub(1, "negative", well.plot$kmeansSdRain)
      well.plot$kmeansSdRain<-gsub(2, "HEX", well.plot$kmeansSdRain)
      well.plot$kmeansSdRain<-gsub(3, "FAM", well.plot$kmeansSdRain)
      well.plot$kmeansSdRain<-gsub(4, "FAM-HEX", well.plot$kmeansSdRain)
      well.plot$kmeansSdRain<-gsub(5, "rain", well.plot$kmeansSdRain)
      
      pdf(paste0("multiplex_", well_target, "variant_", well_ID, "_", well_sample_plot, "_1D_ch1.pdf"), width=8, height=8)
      print(ggplot(well.plot, aes(runif(nrow(well.plot),1,nrow(well.plot)), Ch1.Amplitude, colour = as.factor(kmeansSdRain)))+ xlab("droplets (0-total accepted droplets)") + geom_point() + scale_color_manual(name = "Droplet clusters:", values = c("FAM" = "#009f74", "HEX"="#cb79a6", "FAM-HEX"="#edbb5b", "negative"="#0073b3", "rain"="#c1c1c1")))
      dev.off()
      pdf(paste0("multiplex_", well_target, "variant_", well_ID, "_", well_sample_plot, "_1D_ch2.pdf"), width=8, height=8)
      print(ggplot(well.plot, aes(runif(nrow(well.plot),1,nrow(well.plot)), Ch2.Amplitude, colour = as.factor(kmeansSdRain))) + xlab("droplets (0-total accepted droplets)") + geom_point() + scale_color_manual(name = "Droplet clusters:", values = c("FAM" = "#009f74", "HEX"="#cb79a6", "FAM-HEX"="#edbb5b", "negative"="#0073b3", "rain"="#c1c1c1")))
      dev.off()
    }
    
    ## Generate multiplex data
    print(paste0(No.variant.samples, " variant files processed"))
    cat(sep="\n\n")
    print("Compiling the output files...")
    results.variant.multiplex<-plateSummary(plate.variant.cluster, cMethod="kmeansSdRain", ch1Label = "M", ch2Label = "W")
    results.variant.multiplex$FAM.HEX.difference<-round(results.variant.multiplex[,10]/results.variant.multiplex[,11], digits = 2)
    results.variant.multiplex$flag.FAM.HEX.difference<-"okay"
    results.variant.multiplex$flag.FAM.HEX.difference[is.na(results.variant.multiplex$flag.FAM.HEX.difference)] <- "okay"
    
    
    ## Split data to get 1 row = 1 assay
    results.variant.multiplex.FAM<-results.variant.multiplex[, c(1,2,5,6,7,10,12,18)]
    results.variant.multiplex.FAM$Target<-paste0(list.variant, "M")
    results.variant.multiplex.FAM$DyeName<-"FAM"
    results.variant.multiplex.FAM$Well<-row.names(results.variant.multiplex.FAM)
    results.variant.multiplex.HEX<-results.variant.multiplex[, c(1,3,5,8,9,11,13,18)]
    results.variant.multiplex.HEX$Target<-paste0(list.variant, "W")
    results.variant.multiplex.HEX$DyeName<-"HEX"
    results.variant.multiplex.HEX$Well<-row.names(results.variant.multiplex.HEX)
    
    results.variant.multiplex.export<-rbind(results.variant.multiplex.FAM,setnames(results.variant.multiplex.HEX,names(results.variant.multiplex.FAM)))
    names(results.variant.multiplex.export)<-c("PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets", "Conc(copies/µL)", "Copies/20µLWell", "Flag.FAM_HEX.difference", "Target", "DyeName", "Well")
    results.variant.multiplex.export$Flag.positive.droplets<-ifelse(results.variant.multiplex.export$PositivesDroplets/results.variant.multiplex.export$AcceptedDroplets>0.7,paste0("too many positive droplets (", round(results.variant.multiplex.export$PositivesDroplets/results.variant.multiplex.export$AcceptedDroplets*100, digits = 0), ")"), "okay")
    results.variant.multiplex.export$Flag.total.droplets<-ifelse(results.variant.multiplex.export$AcceptedDroplets<=10000,"low number of droplets", "okay")
    results.variant.multiplex.export$Run<-run_ID
    results.variant.multiplex.export$Comment<-""
    #print(paste0("Number of row before sample name transformation: ", nrow(results.variant.multiplex.export)))
    results.variant.multiplex.export<-setDT(samples)[results.variant.multiplex.export, on="Well"]
    #print(paste0("Number of row after sample name transformation (should the same): ", nrow(results.variant.multiplex.export)))
    results.variant.multiplex.export<-results.variant.multiplex.export[,c("Run", "Well", "Sample", "Target", "Conc(copies/µL)", "DyeName", "Copies/20µLWell", "PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets", "Flag.positive.droplets", "Flag.total.droplets", "Flag.FAM_HEX.difference", "Comment")]
    results.variant.multiplex.export$NeedRerun<-ifelse(results.variant.multiplex.export$Flag.positive.droplets=="okay" & results.variant.multiplex.export$Flag.total.droplets == "okay" & (results.variant.multiplex.export$Flag.FAM_HEX.difference<4 | results.variant.multiplex.export$Flag.FAM_HEX.difference=="okay") & results.variant.multiplex.export$Comment == "", "", "need_rerun")
    results.variant.multiplex.export<-results.variant.multiplex.export[,c("Flag.positive.droplets", "Flag.total.droplets", "Flag.FAM_HEX.difference", "Comment", "NeedRerun", "Run", "Well", "Sample", "Target", "Conc(copies/µL)", "DyeName", "Copies/20µLWell", "PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets")]
    # If there is only 1 sample, it is to avoid the Well to be called 1, and Sample to be called NA
    if(nrow(results.variant.multiplex.export)==2){
      results.variant.multiplex.export[, c("Well")]<-well_ID
      results.variant.multiplex.export[, c("Sample")]<-well_sample
    }
    
    #Export summarized data for BioRad variant assays
    results.variant.multiplex.summarized<-cbind(row.names(results.variant.multiplex), results.variant.multiplex); names(results.variant.multiplex.summarized)[1]<-"Well"
    results.variant.multiplex.summarized<-setDT(as.data.frame(results.variant.multiplex.export))[as.data.frame(results.variant.multiplex.summarized), on="Well"]
    results.variant.multiplex.summarized$BioRadAssay<-gsub("[^0-9.-]", "", results.variant.multiplex.summarized$Target)
    results.variant.multiplex.summarized<-results.variant.multiplex.summarized[,c("Run","Well", "NeedRerun", "Sample", "BioRadAssay", "MPositives", "WPositives", "AcceptedDroplets", "Flag.positive.droplets", "Flag.total.droplets")]
    results.variant.multiplex.summarized<-unique(results.variant.multiplex.summarized)
    
    
    ## Export the data ## 
    write.table(results.variant.multiplex.export, paste0("results_variant.csv"), quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")
    write.table(results.variant.multiplex, paste0("details_results_variant.csv"), quote = FALSE, row.names = TRUE, col.names = TRUE, sep = ",")
    saveRDS(plate.variant.cluster, file = "plate_variant.RData")
    
    print("done!")
    cat(sep="\n\n")
    cat(sep="\n\n")
    
  }
  
  
  
  
  
  
  
  
  
  


  #####  Read the BioRad variant 944 multiplex data  ###### 
  if(variant944multiplex>0){
    print("variant 944 multiplex sample(s) detected")
    plate.variant944.genuine.multiplex <- ddpcrPlate(well="temp_variants944multiplex/.")
    No.variant944.samples<-length(names(plate.variant944.genuine.multiplex))
    names(plate.variant944.genuine.multiplex) # list all the N1/N2 wells
    plate.variant944.cluster <- plate.variant944.genuine.multiplex # duplicate "plate.sludge.genuine". "plate.sludge.cluster" will store the k-means clusters
    list.variant944<-matrix(NA, No.variant944.samples, 1)
    
     #commonClassificationMethod(plate.variant944.genuine.multiplex) # 
     #facetPlot(plate.variant944.genuine.multiplex, cMethod="Cluster") # droplets per well
    
    
    ## Define 4 clusters (i.e. NN (negative), PN (N1), PP (N1/N2) and NP (N2) for each well)
    for(i in 1:No.variant944.samples) {
      
      ## Preparation
      well = 0
      four.clusters.NN.Ch1 = four.clusters.variant944.genuine.NN.Ch1
      four.clusters.NN.Ch2 = four.clusters.variant944.genuine.NN.Ch2
      four.clusters <- four.clusters.variant944.genuine
      well_ID=as.character(names(plate.variant944.genuine.multiplex)[i])
      
      well<-plate.variant944.genuine.multiplex[[well_ID]]
      well_sample<-as.character(samples[which(samples$Well == well_ID), 2])
      well_target<-as.numeric(gsub("([0-9]+).*$", "\\1", strsplit(as.character(samples[which(samples$Well == well_ID), 3]), '_' ,fixed=TRUE)[[1]][1]))
      well_sample_plot<-str_replace(well_sample, ":", "to")
      print(paste0(well_ID, " - ", well_target,  " variant"))
      list.variant944[i, ]<-well_target
      #dropletPlot(well)
      
      ## Define the center of the Negative droplets for the well
      well.NN <- well@dropletAmplitudes[which(well@classification$Cluster == "NN"),]
      well.NN.Ch1<-mean(well.NN$Ch1.Amplitude)
      well.NN.Ch2<-mean(well.NN$Ch2.Amplitude)
      
      ## Determine the difference of origin between the artificial and the real sample (i.e., ch1 and ch2)
      ch1<-four.clusters.NN.Ch1-well.NN.Ch1
      ch2<-four.clusters.NN.Ch2-well.NN.Ch2
      
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
                             centres=matrix(c(4000-ch1, 2500-ch2,    8000-ch1, 2500-ch2,   8000-ch1, 5000-ch2,   2500-ch1, 5000-ch2), ncol=2, byrow=TRUE))
      dropletPlot(well, cMethod="kmeans")
      
      ## Remove the rain between the clusters
      well <- sdRain(well, cMethod="kmeans", errorLevel = 5) #5 = default 
      #dropletPlot(well, cMethod="kmeansSdRain")
      
      ## Remove artificial droplets
      well@dropletAmplitudes<-well@dropletAmplitudes[which(well@classification$Cluster != "artificial"),]
      well@classification<-well@classification[which(well@classification$Cluster != "artificial"),]
      dropletPlot(well, cMethod="kmeansSdRain")
      
      ## Replace FAM-HEX droplets by rain
      #well@classification$kmeansSdRain['Rain']<-well@classification$kmeansSdRain['PP']
      #well@classification$kmeansSdRain<-as.factor(gsub("PP", "Rain", well@classification$kmeansSdRain))
      PP<-which(well@classification$kmeansSdRain=="PP")
      well@classification$kmeansSdRain[PP]<-'Rain'
      dropletPlot(well, cMethod="kmeansSdRain")
      
      ## If NA are generated during the last step, replace NA by kmeans classification
      na<-which(is.na(well@classification$kmeansSdRain))
      well@classification$kmeansSdRain[na]<-well@classification$kmeans[na]
      dropletPlot(well, cMethod="kmeansSdRain")
      
      
      ## Add info to the plate
      plate.variant944.cluster[[well_ID]]<-well
      
      ## Print plots
      pdf(paste0("multiplex_", well_target, "variant_", well_ID, "_", well_sample_plot, "_2D.pdf"), width=8, height=8)
      print(dropletPlot(well, cMethod="kmeansSdRain"))
      dev.off()
      
      well.plot<-as.data.frame(cbind(well@dropletAmplitudes$Ch1.Amplitude, well@dropletAmplitudes$Ch2.Amplitude, well@classification$kmeansSdRain))
      names(well.plot)<-c("Ch1.Amplitude", "Ch2.Amplitude", "kmeansSdRain")
      well.plot$kmeansSdRain<-gsub(1, "negative", well.plot$kmeansSdRain)
      well.plot$kmeansSdRain<-gsub(2, "HEX", well.plot$kmeansSdRain)
      well.plot$kmeansSdRain<-gsub(3, "FAM", well.plot$kmeansSdRain)
      well.plot$kmeansSdRain<-gsub(4, "FAM-HEX", well.plot$kmeansSdRain)
      well.plot$kmeansSdRain<-gsub(5, "rain", well.plot$kmeansSdRain)
      
      pdf(paste0("multiplex_", well_target, "variant_", well_ID, "_", well_sample_plot, "_1D_ch1.pdf"), width=8, height=8)
      print(ggplot(well.plot, aes(runif(nrow(well.plot),1,nrow(well.plot)), Ch1.Amplitude, colour = as.factor(kmeansSdRain)))+ xlab("droplets (0-total accepted droplets)") + geom_point() + scale_color_manual(name = "Droplet clusters:", values = c("FAM" = "#009f74", "HEX"="#cb79a6", "FAM-HEX"="#edbb5b", "negative"="#0073b3", "rain"="#c1c1c1")))
      dev.off()
      pdf(paste0("multiplex_", well_target, "variant_", well_ID, "_", well_sample_plot, "_1D_ch2.pdf"), width=8, height=8)
      print(ggplot(well.plot, aes(runif(nrow(well.plot),1,nrow(well.plot)), Ch2.Amplitude, colour = as.factor(kmeansSdRain))) + xlab("droplets (0-total accepted droplets)") + geom_point() + scale_color_manual(name = "Droplet clusters:", values = c("FAM" = "#009f74", "HEX"="#cb79a6", "FAM-HEX"="#edbb5b", "negative"="#0073b3", "rain"="#c1c1c1")))
      dev.off()
    }
    
    ## Generate multiplex data
    print(paste0(No.variant944.samples, " variant 944 files processed"))
    cat(sep="\n\n")
    print("Compiling the output files...")
    results.variant944.multiplex<-plateSummary(plate.variant944.cluster, cMethod="kmeansSdRain", ch1Label = "M", ch2Label = "W")
    results.variant944.multiplex$FAM.HEX.difference<-round(results.variant944.multiplex[,10]/results.variant944.multiplex[,11], digits = 2)
    results.variant944.multiplex$flag.FAM.HEX.difference<-"okay"
    results.variant944.multiplex$flag.FAM.HEX.difference[is.na(results.variant944.multiplex$flag.FAM.HEX.difference)] <- "okay"
    
    
    ## Split data to get 1 row = 1 assay
    results.variant944.multiplex.FAM<-results.variant944.multiplex[, c(1,2,5,6,7,10,12,18)]
    results.variant944.multiplex.FAM$Target<-paste0(list.variant944, "M")
    results.variant944.multiplex.FAM$DyeName<-"FAM"
    results.variant944.multiplex.FAM$Well<-row.names(results.variant944.multiplex.FAM)
    results.variant944.multiplex.HEX<-results.variant944.multiplex[, c(1,3,5,8,9,11,13,18)]
    results.variant944.multiplex.HEX$Target<-paste0(list.variant944, "W")
    results.variant944.multiplex.HEX$DyeName<-"HEX"
    results.variant944.multiplex.HEX$Well<-row.names(results.variant944.multiplex.HEX)
    
    results.variant944.multiplex.export<-rbind(results.variant944.multiplex.FAM,setnames(results.variant944.multiplex.HEX,names(results.variant944.multiplex.FAM)))
    names(results.variant944.multiplex.export)<-c("PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets", "Conc(copies/µL)", "Copies/20µLWell", "Flag.FAM_HEX.difference", "Target", "DyeName", "Well")
    results.variant944.multiplex.export$Flag.positive.droplets<-ifelse(results.variant944.multiplex.export$PositivesDroplets/results.variant944.multiplex.export$AcceptedDroplets>0.7,paste0("too many positive droplets (", round(results.variant944.multiplex.export$PositivesDroplets/results.variant944.multiplex.export$AcceptedDroplets*100, digits = 0), ")"), "okay")
    results.variant944.multiplex.export$Flag.total.droplets<-ifelse(results.variant944.multiplex.export$AcceptedDroplets<=10000,"low number of droplets", "okay")
    results.variant944.multiplex.export$Run<-run_ID
    results.variant944.multiplex.export$Comment<-""
    #print(paste0("Number of row before sample name transformation: ", nrow(results.variant944.multiplex.export)))
    results.variant944.multiplex.export<-setDT(samples)[results.variant944.multiplex.export, on="Well"]
    #print(paste0("Number of row after sample name transformation (should the same): ", nrow(results.variant944.multiplex.export)))
    results.variant944.multiplex.export<-results.variant944.multiplex.export[,c("Run", "Well", "Sample", "Target", "Conc(copies/µL)", "DyeName", "Copies/20µLWell", "PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets", "Flag.positive.droplets", "Flag.total.droplets", "Flag.FAM_HEX.difference", "Comment")]
    results.variant944.multiplex.export$NeedRerun<-ifelse(results.variant944.multiplex.export$Flag.positive.droplets=="okay" & results.variant944.multiplex.export$Flag.total.droplets == "okay" & (results.variant944.multiplex.export$Flag.FAM_HEX.difference<4 | results.variant944.multiplex.export$Flag.FAM_HEX.difference=="okay") & results.variant944.multiplex.export$Comment == "", "", "need_rerun")
    results.variant944.multiplex.export<-results.variant944.multiplex.export[,c("Flag.positive.droplets", "Flag.total.droplets", "Flag.FAM_HEX.difference", "Comment", "NeedRerun", "Run", "Well", "Sample", "Target", "Conc(copies/µL)", "DyeName", "Copies/20µLWell", "PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets")]
    # If there is only 1 sample, it is to avoid the Well to be called 1, and Sample to be called NA
    if(nrow(results.variant944.multiplex.export)==2){
      results.variant944.multiplex.export[, c("Well")]<-well_ID
      results.variant944.multiplex.export[, c("Sample")]<-well_sample
    }
    
    #Export summarized data for BioRad variant944 assays
    results.variant944.multiplex.summarized<-cbind(row.names(results.variant944.multiplex), results.variant944.multiplex); names(results.variant944.multiplex.summarized)[1]<-"Well"
    results.variant944.multiplex.summarized<-setDT(as.data.frame(results.variant944.multiplex.export))[as.data.frame(results.variant944.multiplex.summarized), on="Well"]
    results.variant944.multiplex.summarized$BioRadAssay<-gsub("[^0-9.-]", "", results.variant944.multiplex.summarized$Target)
    results.variant944.multiplex.summarized<-results.variant944.multiplex.summarized[,c("Run","Well", "NeedRerun", "Sample", "BioRadAssay", "MPositives", "WPositives", "AcceptedDroplets", "Flag.positive.droplets", "Flag.total.droplets")]
    results.variant944.multiplex.summarized<-unique(results.variant944.multiplex.summarized)
    
    
    ## Export the data ## 
    write.table(results.variant944.multiplex.export, paste0("results_variant944.csv"), quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")
    write.table(results.variant944.multiplex, paste0("details_results_variant944.csv"), quote = FALSE, row.names = TRUE, col.names = TRUE, sep = ",")
    saveRDS(plate.variant944.cluster, file = "plate_variant944.RData")
    
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
    well.plot$Cluster<-gsub(1, "negative", well.plot$Cluster)
    well.plot$Cluster<-gsub(2, "HEX", well.plot$Cluster)
    well.plot$Cluster<-gsub(3, "FAM", well.plot$Cluster)
    well.plot$Cluster<-gsub(4, "FAM-HEX", well.plot$Cluster)
    
    pdf(paste0("multiplex_BCOVBRSV_", well_ID, "_", well_sample_plot, "_1D_ch1.pdf"), width=8, height=8)
    print(ggplot(well.plot, aes(runif(nrow(well.plot),1,nrow(well.plot)), Ch1.Amplitude, colour = as.factor(Cluster))) + xlab("droplets (0-total accepted droplets)") + geom_point() + scale_color_manual(name = "Droplet clusters:", values = c("FAM" = "#009f74", "HEX"="#cb79a6", "FAM-HEX"="#edbb5b", "negative"="#0073b3", "rain"="#c1c1c1")))
    dev.off()
    pdf(paste0("multiplex_BCOVBRSV_", well_ID, "_", well_sample_plot, "_1D_ch2.pdf"), width=8, height=8)
    print(ggplot(well.plot, aes(runif(nrow(well.plot),1,nrow(well.plot)), Ch2.Amplitude, colour = as.factor(Cluster))) + xlab("droplets (0-total accepted droplets)") + geom_point() + scale_color_manual(name = "Droplet clusters:", values = c("FAM" = "#009f74", "HEX"="#cb79a6", "FAM-HEX"="#edbb5b", "negative"="#0073b3", "rain"="#c1c1c1")))
    dev.off()
  }
  
  ## Generate multiplex data
  print(paste0(No.BCoVBRSV.samples, " BCoV/BRSV files processed"))
  cat(sep="\n\n")
  print("Compiling the output files...")
  results.BCOVBRSV.multiplex<-plateSummary(plate.cluster, cMethod="Cluster", ch1Label = "BCoV", ch2Label = "BRSV")
  results.BCOVBRSV.multiplex$FAM.HEX.difference<-round(results.BCOVBRSV.multiplex[,10]/results.BCOVBRSV.multiplex[,11], digits = 2)
  results.BCOVBRSV.multiplex$Flag.FAM_HEX.difference<-""

  ## Split data to get 1 row = 1 assay
  results.BCOVBRSV.multiplex.FAM<-results.BCOVBRSV.multiplex[, c(1,2,5,6,7,10,12,18)]
  results.BCOVBRSV.multiplex.FAM$Target<-"BCoV"
  results.BCOVBRSV.multiplex.FAM$DyeName<-"FAM"
  results.BCOVBRSV.multiplex.FAM$Well<-row.names(results.BCOVBRSV.multiplex.FAM)
  results.BCOVBRSV.multiplex.HEX<-results.BCOVBRSV.multiplex[, c(1,3,5,8,9,11,13,18)]
  results.BCOVBRSV.multiplex.HEX$Target<-"BRSV"
  results.BCOVBRSV.multiplex.HEX$DyeName<-"HEX"
  results.BCOVBRSV.multiplex.HEX$Well<-row.names(results.BCOVBRSV.multiplex.HEX)
  
  results.BCOVBRSV.multiplex.export<-rbind(results.BCOVBRSV.multiplex.FAM,setnames(results.BCOVBRSV.multiplex.HEX,names(results.BCOVBRSV.multiplex.FAM)))
  names(results.BCOVBRSV.multiplex.export)<-c("PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets", "Conc(copies/µL)", "Copies/20µLWell", "Flag.FAM_HEX.difference", "Target", "DyeName", "Well")
  results.BCOVBRSV.multiplex.export$Flag.positive.droplets<-ifelse(results.BCOVBRSV.multiplex.export$PositivesDroplets/results.BCOVBRSV.multiplex.export$AcceptedDroplets>0.7,paste0("too many positive droplets (", round(results.BCOVBRSV.multiplex.export$PositivesDroplets/results.BCOVBRSV.multiplex.export$AcceptedDroplets*100, digits = 0), ")"), "okay")
  results.BCOVBRSV.multiplex.export$Flag.total.droplets<-ifelse(results.BCOVBRSV.multiplex.export$AcceptedDroplets<=10000,"low number of droplets", "okay")
  results.BCOVBRSV.multiplex.export$Run<-run_ID
  results.BCOVBRSV.multiplex.export$Comment<-""
  #print(paste0("Number of row before sample name transformation: ", nrow(results.BCOVBRSV.multiplex.export)))
  results.BCOVBRSV.multiplex.export<-setDT(samples)[results.BCOVBRSV.multiplex.export, on="Well"]
  #print(paste0("Number of row after sample name transformation (should the same): ", nrow(results.BCOVBRSV.multiplex.export)))
  results.BCOVBRSV.multiplex.export<-results.BCOVBRSV.multiplex.export[,c("Run", "Well", "Sample", "Target", "Conc(copies/µL)", "DyeName", "Copies/20µLWell", "PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets", "Flag.positive.droplets", "Flag.total.droplets", "Flag.FAM_HEX.difference", "Comment")]
  results.BCOVBRSV.multiplex.export$NeedRerun<-ifelse(results.BCOVBRSV.multiplex.export$Flag.positive.droplets=="okay" & results.BCOVBRSV.multiplex.export$Flag.total.droplets == "okay" & results.BCOVBRSV.multiplex.export$Comment == "", "", "need_rerun")
  results.BCOVBRSV.multiplex.export<-results.BCOVBRSV.multiplex.export[,c("Flag.positive.droplets", "Flag.total.droplets", "Flag.FAM_HEX.difference", "Comment", "NeedRerun", "Run", "Well", "Sample", "Target", "Conc(copies/µL)", "DyeName", "Copies/20µLWell", "PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets")]
  
  ## Export the data ## 
  write.table(results.BCOVBRSV.multiplex.export, paste0("results_BCOVBRSV.csv"), quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")
  write.table(results.BCOVBRSV.multiplex, paste0("details_results_BCOVBRSV.csv"), quote = FALSE, row.names = TRUE, col.names = TRUE, sep = ",")
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
      print(ggplot(well.plot, aes(runif(nrow(well.plot),1,nrow(well.plot)), Ch1.Amplitude, colour = as.factor(Cluster))) + xlab("droplets (0-total accepted droplets)") + scale_color_discrete(name = "Droplet clusters:") + geom_point())
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
    results.FAMsingleplex.export$Flag.positive.droplets<-ifelse(results.FAMsingleplex.export$PositivesDroplets/results.FAMsingleplex.export$AcceptedDroplets>0.7,paste0("too many positive droplets (", round(results.FAMsingleplex.export$PositivesDroplets/results.FAMsingleplex.export$AcceptedDroplets*100, digits = 0), ")"), "okay")
    results.FAMsingleplex.export$Flag.total.droplets<-ifelse(results.FAMsingleplex.export$AcceptedDroplets<=10000,"low number of droplets", "okay")
    results.FAMsingleplex.export$Well<-row.names(results.FAMsingleplex.export)
    results.FAMsingleplex.export$Run<-run_ID
    results.FAMsingleplex.export$DyeName<-"FAM"
    results.FAMsingleplex.export$Flag.FAM_HEX.difference<-""
    results.FAMsingleplex.export$Comment<-""
    #print(paste0("Number of row before sample name transformation: ", nrow(results.FAMsingleplex.export)))
    results.FAMsingleplex.export<-setDT(samples)[results.FAMsingleplex.export, on="Well"]
    #print(paste0("Number of row after sample name transformation (should the same): ", nrow(results.FAMsingleplex.export)))
    results.FAMsingleplex.export<-results.FAMsingleplex.export[,c("Run", "Well", "Sample", "Target", "Conc(copies/µL)", "DyeName", "Copies/20µLWell", "PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets", "Flag.positive.droplets", "Flag.total.droplets", "Flag.FAM_HEX.difference", "Comment")]
    results.FAMsingleplex.export$NeedRerun<-ifelse(results.FAMsingleplex.export$Flag.positive.droplets=="okay" & results.FAMsingleplex.export$Flag.total.droplets == "okay"  & results.FAMsingleplex.export$Comment == "", "", "need_rerun")
    results.FAMsingleplex.export<-results.FAMsingleplex.export[,c("Flag.positive.droplets", "Flag.total.droplets", "Flag.FAM_HEX.difference", "Comment", "NeedRerun", "Run", "Well", "Sample", "Target", "Conc(copies/µL)", "DyeName", "Copies/20µLWell", "PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets")]
    
    write.table(results.FAMsingleplex.export, paste0("results_", singleplex_FAMassay, "_FAMsingleplex.csv"), quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")
    write.table(results.FAMsingleplex, paste0("details_results_", singleplex_FAMassay, "_FAMsingleplex.csv"), quote = FALSE, row.names = TRUE, col.names = TRUE, sep = ",")
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
      print(ggplot(well.plot, aes(runif(nrow(well.plot),1,nrow(well.plot)), Ch2.Amplitude, colour = as.factor(Cluster))) + xlab("droplets (0-total accepted droplets)") + scale_color_discrete(name = "Droplet clusters:") + geom_point())
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
    results.HEXsingleplex.export$Flag.positive.droplets<-ifelse(results.HEXsingleplex.export$PositivesDroplets/results.HEXsingleplex.export$AcceptedDroplets>0.7,paste0("too many positive droplets (", round(results.HEXsingleplex.export$PositivesDroplets/results.HEXsingleplex.export$AcceptedDroplets*100, digits = 0), ")"), "okay")
    results.HEXsingleplex.export$Flag.total.droplets<-ifelse(results.HEXsingleplex.export$AcceptedDroplets<=10000,"low number of droplets", "okay")
    results.HEXsingleplex.export$Well<-row.names(results.HEXsingleplex.export)
    results.HEXsingleplex.export$Run<-run_ID
    results.HEXsingleplex.export$DyeName<-"HEX"
    results.HEXsingleplex.export$Flag.FAM_HEX.difference<-""
    results.HEXsingleplex.export$Comment<-""
    #print(paste0("Number of row before sample name transformation: ", nrow(results.HEXsingleplex.export)))
    results.HEXsingleplex.export<-setDT(samples)[results.HEXsingleplex.export, on="Well"]
    #print(paste0("Number of row after sample name transformation (should the same): ", nrow(results.HEXsingleplex.export))) 
    results.HEXsingleplex.export<-results.HEXsingleplex.export[,c("Run", "Well", "Sample", "Target", "Conc(copies/µL)", "DyeName", "Copies/20µLWell", "PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets", "Flag.positive.droplets", "Flag.total.droplets", "Flag.FAM_HEX.difference", "Comment")]
    results.HEXsingleplex.export$NeedRerun<-ifelse(results.HEXsingleplex.export$Flag.positive.droplets=="okay" & results.HEXsingleplex.export$Flag.total.droplets == "okay" & results.HEXsingleplex.export$Comment == "", "", "need_rerun")
    results.HEXsingleplex.export<-results.HEXsingleplex.export[,c("Flag.positive.droplets", "Flag.total.droplets", "Flag.FAM_HEX.difference", "Comment", "NeedRerun", "Run", "Well", "Sample", "Target", "Conc(copies/µL)", "DyeName", "Copies/20µLWell", "PP", "PN_NP", "AcceptedDroplets", "PositivesDroplets", "NegativesDroplets")]
    
    write.table(results.HEXsingleplex.export, paste0("results_", singleplex_HEXassay, "_HEXsingleplex.csv"), quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")
    write.table(results.HEXsingleplex, paste0("details_results_", singleplex_HEXassay, "_HEXsingleplex.csv"), quote = FALSE, row.names = TRUE, col.names = TRUE, sep = ",")
    saveRDS(plate.genuine.HEXsingleplex, file = paste0("plate_", singleplex_HEXassay, "_HEXsingleplex.RData")) 
    
    print("done!")
    cat(sep="\n\n")
    cat(sep="\n\n")
    
  }
  
  
  

  #####  Merge all final databases  #####
  final.results <- rbind(if(exists("results.N1N2.multiplex.export")) results.N1N2.multiplex.export,
                         if(exists("results.N1N2sludge.multiplex.export")) results.N1N2sludge.multiplex.export, 
                         if(exists("results.BCOVBRSV.multiplex.export")) results.BCOVBRSV.multiplex.export, 
                         if(exists("results.FAMsingleplex.export")) results.FAMsingleplex.export, 
                         if(exists("results.HEXsingleplex.export")) results.HEXsingleplex.export)
  if(isTRUE(is.null(final.results)==FALSE)){write.table(final.results, paste0("results_final.csv"), quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")}
  
  
  
  
  #####  Merge all final VARIANT databases  #####
  final.variant.results <- rbind(if(exists("results.variant944.multiplex.summarized")) results.variant944.multiplex.summarized,
                         if(exists("results.variant.multiplex.summarized")) results.variant.multiplex.summarized) 
  if(isTRUE(is.null(final.variant.results)==FALSE)){write.table(final.variant.results, paste0("results_VARIANT_FINAL.csv"), quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")}
  
  
  
  
  

  #####  Delete temporary folders ###### 
  unlink("temp_all_files", recursive=TRUE)
  unlink("temp_BCOVBRSVmultiplex", recursive=TRUE)
  unlink("temp_N1N2multiplex", recursive=TRUE)
  unlink("temp_N1N2sludgemultiplex", recursive=TRUE)
  unlink("temp_variantsmultiplex", recursive=TRUE)
  unlink("temp_variants944multiplex", recursive=TRUE)
  unlink("temp_FAMsingleplex", recursive=TRUE)
  unlink("temp_HEXsingleplex", recursive=TRUE)
  
  
  
  ##### Recap number of samples ######
  print(paste0(length(dataRawFiles), " raw amplification files detected"))
  print(paste0(No.BCoVBRSV.samples+No.N1N2.samples+No.N1N2Sludge.samples+No.FAM.samples+No.HEX.samples+No.variant.samples+No.variant944.samples, " files processed at the end"))

  
  }





