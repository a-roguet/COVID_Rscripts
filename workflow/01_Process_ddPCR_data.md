# Process ddPCR data

Adelaide Roguet 3-4-21





## Before starting

1. Make sure the data you are going to process are in a folder named as followed located in the directory:
   > **Year** dash **Month** dash **Day** space **Target(s)**
   > Good examples: 2021-2-23 N1N2 or 2020-12-3 N1N2
   > Bad examples: 2021-02-23 N1N2 or 20-12-3
   
   > SARS-CoV-2 > DATA > ddPCR data > YOUR RUN

   
   
2. Make sure the .csv file containing the sample metadata contains all channel info: It happens that QuantaSoft only exports the info related to channel 1 (Figure 1). So, if you run a multiplex, make sure you have both info for channel 1 **AND** channel 2. 

<iframe src="https://drive.google.com/file/d/1RvvxP33mEIrKwd3_Z9zq0egzR2WFNX2F/preview" width="640" height="480"></iframe>
   **Figure 1.** In green are the columns that will be read by R

If you observed that channel 2 info is missing, just fix manually the .csv file (Figure 2).  sure the .csv file containing the sample metadata contains all channel info: It happens that QuantaSoft only exports the info related to channel 1 (Figure 1). So, if you run a multiplex, make sure you have both info from channels 1 and 2.

<iframe src="https://drive.google.com/file/d/11yjpJErkST9qRgG1Acswl0FdppTpyTI4/preview" width="640" height="480"></iframe>
   **Figure 2**




3. Make sure that the target(s) names are correctly spelled. 
   > Good examples: N1, N2, BCoV, PMMoV, BRSV
   > Bad examples: n1, n2, BCOV, BCV, PMOV, PMMOV, BRV, etc.


4. Make sure you don't have any "filler" samples. The amplification .csv file associated with these samples is empty. This will generate R errors during the analysis.




## Import the last R script from Github

1. Download the Github repository **COVID_Rscripts** located here [Github COVID_Rscripts.](https://github.com/AnehEf/COVID_Rscripts/)
    But you can click here to directly download the scripts:
    [Github R_scripts_download.](https://github.com/AnehEf/COVID_Rscripts/archive/master.zip)

2. Unzip the file, and copy the content of the folder **ddPCR** into the folder containing the ddPCR data you want to process





## Analyze the ddPCR data

1. Open the file **Process_ddPCR_data.Rmd** using RStudio

    

2. Change the **Run_ID** (Figure 3 #1). It is the name of the folder containing the ddPCR data:

    > **Year** dash **Month** dash **Day** space **Target(s)**

    

3. Change the **samples.info** (Figure 3 #2), it is the name of the .csv file (Figures 1 and 2)

    

4. Click on **knit** (Figure 3 #3). This option is also available here:

   > File > Knit Document

<iframe src="https://drive.google.com/file/d/1bclPkqkrNpxkPDlRoD5YyhvzkYnpFzbQ/preview" width="640" height="480"></iframe>
   **Figure 3**
   							

If everything is going well, this is what you should see in RStudio (Figure 4) 

<iframe src="https://drive.google.com/file/d/11hwroHJrxJjA8wPo7LSiVt_24FyziDyW/preview" width="640" height="480"></iframe>
   **Figure 4.** The theme and the location of your pane layout must be different from my RStudio



Once the script has been run, RStudio should open an html file. You can open that file using your favorite browser. The file is located in your ddPCR run directory:

   > SARS-CoV-2 > DATA > ddPCR data > YOUR RUN

<iframe src="https://drive.google.com/file/d/15jQRHSq57SbByS3tD5wefNk-gQ7quR-Y/preview" width="640" height="480"></iframe>
   **Figure 5.** This report allows you to quickly see what sample have been process, which target (a) and how many amplification files have been detected, and how many reactions have been properly processed (b).



### Description of the output files

- **For singleplex assays:**
   - **1x pdf figure per assay** displaying the 1D dye amplitude detected for each droplet. The x-axis shows each droplet randomly distributed from 0 to X, X being the total number of accepted droplets.
     
     > **singleplex_** TARGET **_** WELL **_** SAMPLE NAME **.pdf**
     
   - **1x csv file per dye** containing the run ID, sample names, target, concentration, etc.
     
     > **results_** TARGET **_** FAM/HEX **singleplex.csv**
     
   - **1x csv file per dye** containing detailed information than in the .csv file described above.
     
     > **results_details_** TARGET **_** FAM/HEX **singleplex.csv**
     
   - **1x RData file per dye** containing the R metadata of the plate (if you want to look in closer details to some values or want to change manually some values).
     
     > **plate_** TARGET **_** FAM/HEX **singleplex.RData**


- **For multiplex assays:**
  
	- **3x pdf figures per assay** displaying:
    - 1D FAM amplitude detected for each droplet. 
      
    > **singleplex_** TARGET **_** WELL **_** SAMPLE NAME **.pdf**
    
    - 1D HEX amplitude detected for each droplet.
      
  > **singleplex_** TARGET **_** WELL **_** SAMPLE NAME **.pdf**
  
    - 2D FAM/HEX cluster plot. 
      
  > **singleplex_** TARGET **_** WELL **_** SAMPLE NAME **.pdf**
  
   - **1x csv file per dye**, containing the run ID, sample names, target, concentration, etc.
   > **results_** TARGETS **.csv**
  
   - **1x csv file per dye** containing detailed information than in the .csv file described above.
   > **results_details_** TARGETS **.csv**
  
   - **1x RData file per dye** containing the R metadata of the plate (if you want to look in closer details to some values or want to change manually some values).
     
     > **plate_** TARGETS **.RData**



**Read results[...].csv files**
| PP: Positive droplets in channels 1 and 2 (FAM-HEX); zero if singleplex
| PN: Positive droplets in channel 1 only (FAM-only); zero if HEX singleplex
| NP: Positive droplets in channel 2 only (HEX-only); zero if FAM singleplex
| NN: Negative droplets

| Flag.positive.droplets: flagged if %Positive droplets > 70%
| Flag.total.droplets: flagged if Total Accepted Droplets ≤ 10,000 droplets
| Flag.FAM_HEX.difference: flagged if ratio FAM/HEX > 2-fold difference

For more details, just look at the twoddPCR documentation



## Quality control #1

1. Visually, check the split between the positive and negative droplets on 1D cluster plots for singleplex and 2D cluster plots for multiplex assays. 

   > A **correct** split looks like (Figure 6a) for singleplex and (Figure 6b) for multiplex.
<iframe src="https://drive.google.com/file/d/1w02PKbY4ddEvA94SvLBAS5optK5Gsidr/preview" width="640" height="480"></iframe>
   **Figure 6**

   > An **incorrect** split looks like (Figure 7a) for singleplex and (Figure 7b) for multiplex.
<iframe src="https://drive.google.com/file/d/1xTUHdWHFp161jCPChPLwl9IdR1rAco_y/preview" width="640" height="480"></iframe>
   **Figure 7**



2. Check that NTC are negatives or below the limit of detection (3 droplets for N1 or N2). If not, then rerun the whole plate!

   

3. Any weird pattern in the droplet cluster distribution? Yes, flag it (see point #4 below)

   

4. If any of the points above have been violated, or anything caught you eyes, report it in the **results_[...].csv** file in the column **comment**







### Troubleshooting

+ Line 13 Error in library(xxxx) : there is no package called 'xxxx' Calls: <Anonymous> ... withCalingHandlers -> withVisible -> eval -> eval -> library Execution halted
```
The library xxxx is not installed. To install it, just write in the R-console: install.packages("xxxx")
```




+ Line 54 Error in file(filename, "r", encoding = encoding) : cannot open the connection Calls: <Anonymous> ... withCalingHandlers -> withVisible -> eval -> eval -> source -> file Execution halted
```
It is most likely that RUN-ID is incorrect :-)
```




+ sh: 02-12: command not found
  Quitting from lines 61-62 (Process_ddPCR_data.Rmd) 
  Error: Must group by variables found in `.data`.
  Column `Well` is not found.
  Column `Sample` is not found.
<iframe src="https://drive.google.com/file/d/15zbdMnfpoE74b8dWei0loYmQtpxyjNHZ/preview" width="640" height="480"></iframe>
```
It is most likely that the name you entered for the .csv file is incorrect :-)
```





+ No error during the processing of the data, but on the html/report file, I can see that all/some of the detected amplification files have not been processed. 
<iframe src="https://drive.google.com/file/d/1xm2O1q16vOvcyoM8vduIiGnRuzq7OO3Q/preview" width="640" height="480"></iframe>
```
Check in the sample metadata .csv file that all the data are here, i.e., channel 1 and/or channel 2, target correctly spelled, etc.
```





- I have a sample with only negative droplets, while I'm almost certain it should be positive.
<iframe src="https://drive.google.com/file/d/1XoyaWnmynvnkaF1-SPEQsimxRC5Kir3a/preview" width="640" height="480"></iframe>

```
Check that the average amplitude of the negative droplets cluster is at the same levels that the NTC. If it is higher, then you may have too many positive droplets. Time to dilute your sample!
```

