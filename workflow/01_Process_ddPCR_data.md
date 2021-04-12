# Process ddPCR data

Adelaide Roguet 3-25-21



This workflow will show how to process the raw amplification and cluster data into concentrations and even more :-)

It describes: 

- How to download the last version of the scripts from Github
- How to process and analyze ddPCR data using R markdown
- The quality control step #1





## Before starting

1. Make sure the ddPCR data you are about to process are in the shared **ddPCR data** OneDrive folder, and named as such:
   > SARS-CoV-2 > DATA > ddPCR data > YOUR RUN
   
   
   
   > **Year** dash **Month** dash **Day** space **Target(s)**
> Good examples: 2021-2-23 N1N2 or 2020-12-3 N1N2
   > Bad examples: 2021-02-23 N1N2 or 20-12-3

   

2. If you ran a multiplex assay, make sure the .csv file (containing the metadata) exported BOTH **channel 1** AND **channel 2**. 
   For N1/N2 multiplex, you should have for each well, one line describing **N1** information and another line describing **N2**. For BCoV/BRSV multiplex, you should have for each well, one line describing **BCoV** information and another line describing **BRSV**.

   On Figure 1, the **good** file contains both N1, N2, BCoV and BRSV information. While the **bad** file only contains N1 and BCoV information (information related to N2 and BRSV are missing). If you observed such omission, just fix manually the .csv file (trying to re-export it from QuantaSoft never worked for me!). To do so (Figure 2), just copy and paste the green columns (the only ones read by R in the following step), and replace **N1** by **N2** and/or **BCoV** by **BRSV**. Done!

   

<iframe src="https://drive.google.com/file/d/1RvvxP33mEIrKwd3_Z9zq0egzR2WFNX2F/preview" width="640" height="480"></iframe>
   **Figure 1.** Ecample of good and bad csv files for multiplex assays



<iframe src="https://drive.google.com/file/d/14obii2B3CSGcdNg0NGo5r6NqnM0wPhip/preview" width="640" height="480"></iframe>

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





## Quality control #1

1. Make sure the number of processed samples per target match the number of samples expected.

2. **FOR EACH SAMPLE**, visually check the **split between the positive and negative droplets** on 1D cluster plots for singleplex and the **correct cluster classification** on 2D cluster plots for multiplex assays. Something is incorrect, flag it (see point #5 below) (Figures 6, 7 and 8).

   > BCoV/BRSV split is made by QuantaSoft. R is just reading BioRad's clusters. So, if the clusterization is wrong, don't blame Adelaide or the R package :-)

3. **FOR EACH SAMPLE**, report any "weird pattern" (see point #5 below) (Figure 9).

   > It is most likely that weird patters are associated with too few accepted droplets (<10,000).

   

4. Check that **NTC are negatives** or below the limit of detection (3 droplets for N1 or N2). If not, then rerun the whole plate!

   

5. If any of the points above have been violated, or anything caught you eyes, report it in the **results_final.csv** file in the column **comment** and add **"need_rerun"** in the column **NeedRerun**. FOR MULTIPLEX ASSAYS, **do not forget** to report for both N1 and N2, or BCoV and BRSV (Figure 10). 




<iframe src="https://drive.google.com/file/d/1w02PKbY4ddEvA94SvLBAS5optK5Gsidr/preview" width="640" height="480"></iframe>
   **Figure 6** Example of **correct** splits for singleplex (a) and for multiplex (b).



<iframe src="https://drive.google.com/file/d/1EZZibfUHtQTuteKYKisEphcwER_zHIY1/preview" width="640" height="480"></iframe>

   **Figure 7** Example of **incorrect** spits for singleplex (a) and multiplex (b).



<iframe src="https://drive.google.com/file/d/1wYFAaeqqdjMTa2mWGc-cxiu0t6Ws8l4k/preview" width="640" height="480"></iframe>

​    **Figure 8** More example of **incorrect** spits for multiplexed assays.



<iframe src="https://drive.google.com/file/d/1fe1XlIKq2yauwKh_E-C0UgnX5zb-FNLp/preview" width="640" height="480"></iframe>

​    **Figure 9**  Example of **"weird patterns"** for multiplexed assays.







<iframe src="https://drive.google.com/file/d/1QrKk-ac0t08CsgrGhrYkA5z0DVbHEg7_/preview" width="640" height="480"></iframe>

​    **Figure 10**  Example of a sample (N1/N2 assay) that has been manually flagged as "weird patterns"









----

### Notes



### Description of the R-ddPCR output files

- **Per plate**:

  - **1x csv file per plate** compiling all the results of all assays performed on the plate

    > **results_final.csv**

- **For singleplex assays:**

  - **1x pdf figure per assay** displaying the 1D dye amplitude detected for each droplet. The x-axis shows each droplet randomly distributed from 0 to X, X being the total number of accepted droplets.

    > **singleplex_** TARGET **_** WELL **_** SAMPLE NAME **.pdf**

  - **1x csv file per dye** containing the run ID, sample names, target, concentration, etc.

    > **results_** TARGET **_** FAM/HEX **singleplex.csv**

  - **1x csv file per dye** containing detailed information than in the .csv file described above.

    > **details_results_** TARGET **_** FAM/HEX **singleplex.csv**

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









----

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

