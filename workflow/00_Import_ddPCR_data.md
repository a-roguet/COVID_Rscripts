# Import ddPCR data

Adelaide Roguet 3-25-21



*This workflow describes how to transfer raw ddPCR data from GLGC's computer to the shared SARS-CoV-2 folder located on OneDrive.*

It describes: 

- How to export the raw ddPCR (amplitude and cluster) data on your USB key
- How to export the metadata on your USB keep
- How to copy the data from your USB key to OneDrive





### Export Amplitude and Cluster Data on your USB key

*Computer located at the GLGC in the BioRad QX200 Droplet Digital PCR System area*


1. Open QuantaSoft to load your run information

2. Load your plate results.
     - Click on **Load** (Figure 1 #1)

     - Select the run folder

     - Double click on the only file that appears in the folder

         

    <a href="https://drive.google.com/uc?export=view&id=1aFtqpb4fox1oT-N0GN-x0psOtFvbJM-a"><img src="https://drive.google.com/uc?export=view&id=1aFtqpb4fox1oT-N0GN-x0psOtFvbJM-a" style="width: 65px; max-width: 100%; height: auto" title="Click to enlarge picture" />

<iframe src="https://drive.google.com/file/d/1aFtqpb4fox1oT-N0GN-x0psOtFvbJM-a/preview" width="640" height="480"></iframe>

   **Figure 1**


3. If the plate was already loaded, make sure you are on the tab “Setup” (Figure 2 #1)

4. Click on "Option" (Figure 1 #2))

5. Select all the wells you want to process (Figure 2 #2)

   > If some wells are fillers, do not select them, it will avoid R errors later

6. Click on “Export Amplitude and Cluster Data” (Figure 2 #3)


<iframe src="https://drive.google.com/file/d/1M7dwYHuTkAgVOtMKyOWW9Hl_LhTjcbjg/preview" width="640" height="480"></iframe>
   **Figure 2**




7. While in the QuantaSoft dialog window: Create a folder on your USB key to store the ddPCR amplification data. The folder has to be named as followed:

   > **Year** dash **Month** dash **Day** space **Target(s)**
   > Good examples: 2021-2-9 N1N2 or 2020-12-3 N1N2
   > Bad examples: 2021-02-09 N1N2 or 20-12-3

   

9. While in the QuantaSoft dialog window: Open the folder freshly created and click on “Select Folder” (Figure 2).

<iframe src="https://drive.google.com/file/d/1XIWNEXdM2SUqEKvFcwZs4T2vzKhFCPa7/preview" width="640" height="480"></iframe>
  **Figure 2**  



### Export metadata

*During the process of the ddPCR data, R will associate to each well to the sample name and the target ran. This information is stored in a .csv file located in the folder containing the run-RAW ddPCR data.*


1. Access the folder that contains your run raw data. A shortcut should be accessible from the Desktop (Figure 3), otherwise, the pathway to access your run is:

   > Computer > Windows7_OS (C:) > QuantaLife > Data > YOUR RUN ID FOLDER

<iframe src="https://drive.google.com/file/d/1xzWglRG4GgHjAElUlsrmUI_YdJMbRIqG/preview" width="640" height="480"></iframe>
   **Figure 3**



2. Locate the .csv file (Figure 4). THERE IS ONLY ONE. Copy and paste this file in your USB freshly created folder.
<iframe src="https://drive.google.com/file/d/1kviOYS5-ZXw5Mbd8Dqisn_AB9Stc_i9Q/preview" width="640" height="480"></iframe>
   **Figure 4**  




### Transfer the data to the OneDrive SARS-CoV-2 folder

1. Copy and paste the whole folder from your USB key to the directory **ddPCR data**
   
   > SARS-CoV-2 > DATA > ddPCR data







---

### Notes

QuantaSoft exports one file per reaction. All files contain 3 columns: 
   >
   > - Column 1 displays the amplification detected using channel 1 (FAM) within each droplet (1 droplet = 1 row)
   >
   > - Column 2 displays the amplification detected using the channel 2 (HEX) within each droplet
   >
   > - Column 3 shows the cluster to which the droplet has been classified: negative droplet, FAM-positive droplet, HEX-positive droplet, or FAM/HEX positive droplet
   >
   >   If you run a FAM or HEX singleplex assay, the column 2 or 1 will be emptied, respectively.





-----


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



- **I got an error while reading the plate.**

Click on **continue** AND inform Angie that something happened (write down the error number).

<iframe src="https://drive.google.com/file/d/10SH9qsgNUPkMo07TFcAsuUWw4E3xwu9s/preview" width="640" height="480"></iframe>