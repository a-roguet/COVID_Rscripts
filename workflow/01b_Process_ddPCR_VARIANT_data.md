

# Process VARIANT ddPCR data

Adelaide Roguet 9-9-21



This workflow is a supplemement of the workflow **Process ddPCR data**. It will only display how to quality check the VARIANT processed data. 
Each variant assay is a multiplex targeting a single mutation on the S gene. The mutant is targeted using the FAM, while the wild-type is targeted using the HEX or VIC fluorophores.
Unlike regular assays, all samples are run in duplicate when tested for the variants. 

Variant data can be processed in the same folder than other assays. The R script will be able to identify them and process them separately. 

The workflow describes: 

- The VARIANT quality control steps
- "Need rerun" exemption








## Description of the R-ddPCR output files

When processing the raw ddPCR files, R generates the same outputs, except the compiling file **results_final.csv** that is called for the variants **results_VARIANT_FINAL.csv**. 
Unlike **results_final.csv**, no concentration is calculated and only 1 line per sample is displayed. It will be handy if you need to fix manually the number of positive droplets for the mutant and/or wild-type :-)    







## Quality control #1

1. On the html file that automatically opens at the end of the ddPCR process (see Figure 5 above), make sure the number of processed samples per target match the number of samples expected. 

   

2. Open **results_VARIANT_FINAL.csv** (Figure 1). The columns you will need in this section are: **Comment**, **NeedRerun**, **Sample**, **MPositives **and **WPositives**.

   

3. **FOR EACH SAMPLE**, visually check the **correct cluster classification** on 2D cluster plots.

   > Mutant = FAM = green droplets
   >
   > Wild-type = HEX/VIC = pink droplets
   >
   > Both mutant + wild-type = orange droplets
   >
   > Negative droplets = blue droplets 

   

4. **If the clusterization is not good** (Figure 2), change **manually** the number of positive droplets (Figure 3). EVERY DROPLET COUNTS! If you do so, do not forget to add **manual split** in the column **Comment**.

   > Change the number of **mutant** positive droplets in the **MPositives** column
   >
   > Change the number of **wild-type** positive droplets in the **WPositives** column

   

5. Check that the **NTC are negatives** or below the limit of detection (2 droplets max). If not, then rerun the whole plate!

   

6. Check that the **positive controls** only have mutant positive droplets. If not, then rerun the whole plate!

   

7. If any of the points above have been violated, or anything caught you eyes, report it in the **results_VARIANT_FINAL.csv** file in the column **comment** and add **"need_rerun"** in the column **NeedRerun**. 







## "Need rerun" exemptions

Some samples may be flagged **need_rerun** in the column **NeedRerun** because they have **less than 10,000 accepted droplets**. 

1. You can delete **need_rerun** only if:

   - One of the two replicate sample has >10,000 accepted droplets.

   - The two replicates have >8,000 accepted droplets. 

   - It is an NTC

     

2. You **don't need to reprocess** a sample if at least one of the two replicates passed the quality control #1









<iframe src="https://drive.google.com/file/d/1KQyviGgivElriwukTpl5xL2KDnAuneHW/preview" width="640" height="480" allow="autoplay"></iframe>

   **Figure 1** Example of a **results_VARIANT_FINAL.csv** file.



<iframe src="https://drive.google.com/file/d/1Qg_LJLxFhTMmjPiayelK4bBGhDxDckSV/preview" width="640" height="480" allow="autoplay"></iframe>

   **Figure 2** Example of an **incorrect** clusterization.



<iframe src="https://drive.google.com/file/d/1jzYdZJiAxE1ick20yTUMQc96JiLhhJOB/preview" width="640" height="480" allow="autoplay"></iframe>

​      **Figure 3** Change manually the number of positive droplets for the mutant or wild-type* (*showed here)



