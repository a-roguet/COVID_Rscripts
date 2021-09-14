# Deposit the VARIANT data into the "big-spreadsheet"

Adelaide Roguet 9-9-21



If you are that far in the workflow, I assume that you already know how to import "regular" data to the big-spreadsheet. Thus, I'll only going to talk about the variants here.

This workflow describes: 

- How to paste your ddPCR VARIANT data
- How to notify the samples that need to be re-run





## Open the good tab in the "big-spreadsheet" 

1. Open the "big-spreadsheet" on your local Excel. Do not use your browser to open the file. Do not download the file on your computer.

   > SARS-CoV-2 > SARS-CoV-2_database_BigSpreadsheet.xlsx

2. Open the tab **Raw data ddPCR variant**





## Import ddPCR VARIANT data into the "big-spreadsheet"

1. Open **results_VARIANT_FINAL.csv** file, **copy** all the table, except the header
   
   


2. **Paste-special > values** the table in the location shown in Figure 1 #1. The data should visually fit nicely with the data above. 

   

3. Make sure sample ID in column **Sample_ID** (column G) are correct (Figure 1 #2):

- All NTC have to be called **NTC** not NTC_DELTA or something (R will look for the exact term "NTC")
- The positive samples are not yet automatically detected. Sorry :-(

To make sure the sample ID is correct, you can look at the column B, if they display #N/A, then your sample ID is not recognized. If the City is correctly displayed, then you are golden! 



<iframe src="https://drive.google.com/file/d/1FAGeeSB2pRCRs6ROOqcIfErxoOVWon0e/preview" width="640" height="480" allow="autoplay"></iframe>

   **Figure 1**





 	



## Re-run samples

It is pretty unlikely that samples will fail the quality control steps (both replicates have to fail the quality controls). If so, they need to be re-quantify. To do so, they have to be added to the added to the "re-run" samples list...

1. Open the ddPCR template excel spreadsheet located in the OneDrive.

   > SARS-CoV-2 > DATA > templates_ddPCR_covid.xlsx

2. Add the "re-run" sample(s) to the list of the re-run samples. See Figure 2.

<iframe src="https://drive.google.com/file/d/1gNFi2C574z2GZYDnZelbKISVeMY34P0O/preview" width="640" height="480" allow="autoplay"></iframe>

   **Figure 2**



