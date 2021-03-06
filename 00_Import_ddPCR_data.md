# Export ddPCR data

Adelaide Roguet 3-3-21



Notes: Because of the new probes, ddPCR data can be processed using QuantaSoft installed on Melinda’s computer. The quantitative values will be similar, just they will need to be formatted to match the column order in the “big-spreadsheet”




### Export Amplitude and Cluster Data
*Computer located at the GLGC in the BioRad QX200 Droplet Digital PCR System area*


1. Open QuantaSoft to load your run information

2.	Click on “Setup” (Figure 1 #1)

3. Select all the wells you want to process (Figure 1 #2)

   > If some wells are fillers, do not select them, it will avoid R errors later
   
4.	Click on “Export Amplitude and Cluster Data” (Figure 1 #3)

5. Select the parent directory where you want to save the data

   > On my USB key for example
   
   <iframe src="https://drive.google.com/file/d/1M7dwYHuTkAgVOtMKyOWW9Hl_LhTjcbjg/preview" width="640" height="480"></iframe>
   **Figure 1**  
   
   
<a href="https://drive.google.com/uc?export=view&id=1M7dwYHuTkAgVOtMKyOWW9Hl_LhTjcbjg"><img src="https://drive.google.com/uc?export=view&id=1M7dwYHuTkAgVOtMKyOWW9Hl_LhTjcbjg" style="width: 65px; max-width: 100%; height: auto" title="Click to enlarge picture" />   
   
   
6. Create a folder on your USB key to store the ddPCR amplification data. The folder name has to be written as followed:

   > **Year** dash **Month** dash **Day** space **Target(s)**
   > Good examples: 2021-2-23 N1N2 or 2020-12-3 N1N2
   > Bad examples: 2021-02-23 N1N2 or 20-12-3

   

7. Open the folder freshly created and click on “Select Folder” (Figure 2).

   > QuantaSoft will export one file per reaction. All files contain 3 columns: 
   >
   > - Column 1 displays the amplification detected using channel 1 (FAM) within each droplet (1 droplet = 1 row)
   >
   > - Column 2 displays the amplification detected using the channel 2 (HEX) within each droplet
   >
   > - Column 3 shows the cluster to which the droplet has been classified: negative droplet, FAM-positive droplet, HEX-positive droplet, or FAM/HEX positive droplet
   >
   >   If you run a FAM or HEX singleplex assay, the column 2 or 1 will be emptied, respectively.

<iframe src="https://drive.google.com/file/d/1XIWNEXdM2SUqEKvFcwZs4T2vzKhFCPa7/preview" width="640" height="480"></iframe>
  **Figure 2**  



### Export metadata

*During the process of the ddPCR data, R will associate to each well, the sample name and the target ran. This information is stored in a .csv file located in the folder containing all the raw information of the run.*


1. Access the folder that contains the raw data of your run. A shortcut should be accessible from the Desktop (Figure 3), otherwise, the pathway to access your run is:

   > Computer > Windows7_OS (C:) > QuantaLife > Data > YOUR RUN ID

<iframe src="https://drive.google.com/file/d/1xzWglRG4GgHjAElUlsrmUI_YdJMbRIqG/preview" width="640" height="480"></iframe>
   **Figure 3**



2. Locate the .csv file (Figure 4) that contains the sample metadata and copy and paste it into the folder (you freshly created) that contains the amplification files.
<iframe src="https://drive.google.com/file/d/1kviOYS5-ZXw5Mbd8Dqisn_AB9Stc_i9Q/preview" width="640" height="480"></iframe>
   **Figure 4**  




### Transfer the data to the OneDrive SARS-CoV-2 folder

1. Copy and paste the whole folder into the directory **ddPCR data**
   
   > SARS-CoV-2 > DATA > ddPCR data




### Troubleshooting

+ **I cannot open the shortcut to access my folder's run**
  **I cannot copy/paste**

```
1. Open Windows Task Manager
2. Click on the tab **Processes**
3. Click on **explorer.exe**
4. Click on **End Process**
   > All the icons on the Desktop will disappear, but that is okay
5. Click on the tab **Applications**
6. Click on **New Task...**
7. Write **explorer.exe** and press **enter**
8. Done!
```

