# Deposit the data into the "big-spreadsheet"

Adelaide Roguet 3-25-21



If you are that far in the workflow, I assume that you processed the ddPCR data according to the "01_Process_ddPCR_data.html" workflow. Thus, you must have at least one **results_[...].csv** file (with comments in the column "comment" if needed). Yes? Perfect!


This workflow will show how to deposit your processed ddPCR data in the "big-spreadsheet". The "big-spreadsheet" is the excel spreadsheet called "SARS-CoV-2_database_BigSpreadsheet.xlsx" in the shared SARS-CoV-2 directory.

This workflow describes: 

- How to locate and open the big-spreadsheet
- How to paste your ddPCR data
- The quality control step #2
- How to notify the samples that need to be re-run







## Open the good tab in the "big-spreadsheet" 

1. Open the "big-spreadsheet" on your local Excel. Do not use your browser to open the file. Do not download the file on your computer.

      > SARS-CoV-2 > SARS-CoV-2_database_BigSpreadsheet.xlsx



<iframe src="https://drive.google.com/file/d/1DZyBveVDkwMYWkSn6rhut9CsbcRiliaE/preview" width="640" height="480"></iframe>

   **Figure 1**

2. Open the tab **Raw data ddPCR**





## Import ddPCR data into the "big-spreadsheet"

1. Open **results_final.csv** file, **copy** all the table, except the header
   
   


2. **Paste-special > values** the table in the location shown in Figure 2 #1. The data should visually fit nicely with the data above. 




3. Enter the dilution factor (Figure 2 #2)
   
> 1 = not diluted (mostly used for N1, N2, BCoV, and BRSV assays)
> 10 = 1/10 diluted (mostly used for PMMoV assay)



4. Make sure sample ID in column **Sample_ID** (column M) are correct (Figure 2 #3):
   
   - All NTC have to be called **NTC** not NTC_BCoV or something (R will look for the exact term "NTC")
   
   - All "BRSV only" have to be called **ref**, not Ref or reference or something (it is for R again!)
   
    - Do not add extra caracters such as "1:10" or spaces after the sample name.
   

To make sure the sample ID is correct, you can look at the column B and C, if they display #N/A, then your sample ID is not recognized. If the City and the date is correctly displayed, then you are golden! 



5. You can leave comments in the "CDC_analytical_comment" (column E) to leave an analytical  comment in the database sent to DHS/CDC



<iframe src="https://drive.google.com/file/d/1UU68NxTdTP0rikk9sNkibpcVc4FzTtQA/preview" width="640" height="480"></iframe>

   **Figure 2**







 	


## Quality control #2

1. Among the dark grey columns, if any cell turned red among the columns "Positive/Accepted droplet ratio" (column F), "Total droplets" (column G), "FAM/HEX ratio" (column H; we allow a ratio FAM/HEX < 4 ), the column "NeedRerun" should displays "need_rerun". However, if you manually added "weird pattern" in the column "Comment" (column I), then you have to add **"need_rerun"** in the "NeedRerun" column (column J).

> For any other reasons (e.g., during downstream analysis) a sample has to be "removed" to avoid being processed and send to DHS/CDC, then just add **"need_rerun"** in the "NeedRerun" column (column J).



2. Check that all NTCs are negative or below the limit of detection (3 droplets for N1 and N2). If not, flag it!

   >  You should have spotted that issue during the quality control #1. Because if the NTCs are positive, then you should not have gone that far away in the workflow!

   

3. **For N1/N2:**
   - Check the number of positive droplets for the standards 1:8. It should be ~100 droplets. No? Ask the person who did the plate if something could explain the high/low droplet number. If nothing can explain it, flag it!
   - Check the concentration observed in the dupicate sample is the same than the one during the last run. Overall, I keep the value of the duplicate sample. I do not add "duplicate" in the "NeedRerun" column. But if you want to ignore that sample for that specific reason, add "duplicate" in the "NeedRerun" column
     

   **For BCoV/BRSV:**
   
   - Check that the concentration in the **BRSV only** wells are about the same.





## Re-run samples

It is most likely that a few samples will fail the quality control (#1 or #2). These samples need to be re-quantify. To do so, they have to be added to the added to the "re-run" samples list...

1. Open the ddPCR template excel spreadsheet located in the OneDrive.

   > SARS-CoV-2 > DATA > templates_ddPCR_covid.xlsx

2. Add the "re-run" sample(s) to the list of the re-run samples. See Figure 4.

<iframe src="https://drive.google.com/file/d/10fqlIpZ1TJlGyva7Mj8R4C0RwbBkZrgV/preview" width="640" height="480"></iframe>
   **Figure 4**



