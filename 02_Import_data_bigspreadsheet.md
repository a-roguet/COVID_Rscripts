# Deposit the data into the "big-spreadsheet"

Adelaide Roguet 3-4-21



The "big-spreadsheet" is the excel spreadsheet called "Experiment data summary in categories - Editable.xlsx"
   > SARS-CoV-2 > Experiment data summary in categories - Editable.xlsx


If you are that far in the workflow, I assume that you processed the ddPCR data according to the "01_Process_ddPCR_data.html" workflow. Thus, you must have at least one **results_[...].csv** file (with comments in the column "comment" if needed). Yes? Perfect!





## Get the "big-spreadsheet" ready

1. Open the "big-spreadsheet" on your local Excel. Do not use your browser to open the file. Do not download the file on your computer.
<a href="https://drive.google.com/uc?export=view&id=1DZyBveVDkwMYWkSn6rhut9CsbcRiliaE"><img src="https://drive.google.com/uc?export=view&id=1DZyBveVDkwMYWkSn6rhut9CsbcRiliaE" style="width: 65px; max-width: 100%; height: auto" title="Click to enlarge picture" />
   **Figure 1**

2. Open the tab **Raw data**


3. Make sure all filters are "unselected" and the 1st column is sorted alphabetically from A to Z. 







## Import ddPCR data into the "big-spreadsheet"

1. In **results_[...].csv** file, select rows except the header
   
   > R generated one file per singleplex/multiplex. So, if you ran on the same plate N1/N2 and BCoV/BRSV assays, you have 2 results files, one for N1/N2 and 1 for BCoV/BRSV. You will have to import both of them in the "big-spreadsheet".


2. Copy and paste the table (i.e., the processed ddPCR data) in the location shown in Figure 2 #1. The data should visually fit nicely with the data above. 


3. Drag the content of the dark grey cells (Figure 2 #2)
   
> Dark grey columns mirror the last 4 columns of the **results_[...].csv** file, with a conditional formatting to highlight the cells that are not "okay"

4. Fill the **Sample_ID** column. Drag the cells that contain a vlookup function (Figure 2 #3). Make when you drag/paste the function that the formula has not shifted from 1 line or 2, i.e., if you are in row 1201, that the vlookup is looking for the cell O1201, not O1200 or 1203!
   > The vlookup function reads the column "Sample" and attributes the full name of the filter by looking at the tab **Sample extraction**. The R-script will look at that specific column to merge the ddPCR data and the sample info.
   > Why we are not only using the CV and the letter (e.g., 856H1) for the R-script - that is a good question! Back in summer 2020, it was the way Shuchen and I were processing the samples. It is a fossil of the past...


5. Drag the numbers # (Figure 2 #4)


6. Enter the dilution factor (Figure 2 #5)
   > 1 = not diluted (mostly used for N1, N2, BCoV, and BRSV assays)
   > 10 = 1/10 diluted (mostly used for PMMoV assay)

7. Drag the content of the light grey cells (Figure 2 #6)
   > These columns allow visualizing if the vlookup (Figure 2 #3) worked well, the type of sample, WWTP, and CV number should match your sample. 

   > If **#N/A** pops in these columns, this means that the value in the column **Sample_ID** was not detected in the tab **Sample Extraction**. The vlookup function looks for the exact match between the template and the query. For example, for PMMoV, "1:10" is generally added to the column O (i.e., "Sample"). In this context, the lookup won't work. You will have to edit the cells in column O to remove the extra " 1:10".
   >
   > R will look at the column **Sample_ID** to merge ddPCR data and some other metadata, so if the light grey column cannot match any sample info to **Sample_ID**, R won't be able to do it too!!

<a href="https://drive.google.com/uc?export=view&id=1nVIjp7TB-xvFknOl_qwC4O5nnOa3UiJz"><img src="https://drive.google.com/uc?export=view&id=1nVIjp7TB-xvFknOl_qwC4O5nnOa3UiJz" style="width: 65px; max-width: 100%; height: auto" title="Click to enlarge picture" />
   **Figure 2**



8. What you have to name manually in Sample_ID column:
   - All NTC have to be called **NTC** not NTC_BCoV or something (R will look for the exact term "NTC")
   - All "BRSV only" have to be called **ref**, not Ref or reference or something (it is for R again!)





## Quality control #2

1. Among the dark grey columns, if any cell turns red (we allow a ratio FAM/HEX < 4), in the **Sample_ID** column, add at the end of name **"need rerun"** (Figure 3).

<a href="https://drive.google.com/uc?export=view&id=1t3Y1jJv3izB8sq_fYVa53jVtojkb494c"><img src="https://drive.google.com/uc?export=view&id=1t3Y1jJv3izB8sq_fYVa53jVtojkb494c" style="width: 65px; max-width: 100%; height: auto" title="Click to enlarge picture" />
      **Figure 3**

> For any other reasons (e.g., during downstream analysis) a sample has to be "removed" to avoid being processed and send to DHS/CDC, then just add "need rerun" and R will ignore it. 

2. Check that all NTCs are negative or below the limit of detection (3 droplets for N1 and N2). If not, flag it!

   >  You should have spotted that issue during the quality control #1. Because if the NTCs are positive, then you should not have gone that far away in the workflow!

   

3. For N1/N2: 

   - Check the number of positive droplets for the standards 1:8. It should be ~100 droplets. No? Ask the person who did the plate if something could explain the high/low droplet number. If nothing can explain it, flag it!
   - Check the concentration observed in the dupicate sample is the same than the one during the last run. Overall, I keep the value of the duplicate sample. I do not add "duplicate" at the end of **Sample_ID** to discard that data. In that context, more is better. 
     

   For BCoV/BRSV: Check that the concentration in the **BRSV only** wells are about the same.



## Re-run samples

It is most likely that a few samples will fail the quality control (#1 or #2). These samples need to be re-quantify. To do so, they have to be added to the added to the "re-run" samples list...

1. Open the ddPCR template excel spreadsheet located in the OneDrive.

   > SARS-CoV-2 > DATA > templates_ddPCR_covid.xlsx

2. Add the "re-run" sample(s) to the list of the re-run samples. See Figure 4.

<a href="https://drive.google.com/uc?export=view&id=10fqlIpZ1TJlGyva7Mj8R4C0RwbBkZrgV"><img src="https://drive.google.com/uc?export=view&id=10fqlIpZ1TJlGyva7Mj8R4C0RwbBkZrgV" style="width: 65px; max-width: 100%; height: auto" title="Click to enlarge picture" />
   **Figure 4**



