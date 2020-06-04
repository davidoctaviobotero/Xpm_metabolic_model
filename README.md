# *Xanthomonas phaseoli* pv. *manihotis* Metabolic Model
This is the repository of *Xanthomonas phaseoli* pv. *manihotis* (*Xpm*) metabolic models (*Xpm* M-model), maps (constructed in [Escher](https://escher.github.io/#/)) and code used for analyses. This repository is divided in three folders:

## Code Folder
This folder includer four subfolders, each one with a jupyter notebook and the corresponding input files to run the code. Results are included into the folders. The code was run in pyhton 3.6 and [COBRApy 0.17.1v] (https://opencobra.github.io/cobrapy/).The analyses included are:

- **Clustering**: hierarchical clustering of Context Specific Models (CSM) of *Xpm* WT and mutant strains with and without the addition of Xanthan production in the objective function.

- **Loops**: analyses of *Xpm* M-model loops using pyCOBRA.

- **S-Matrix**: loops calculations using null space.

- **Tradeoff**: tradeoff between xanthan and biomass production in growth rate.

## Metabolic Maps
Inlcuding all the metabolic maps of *Xpm* M-model generate with [Escher](https://escher.github.io/#/)

•	Metabolic map of the central metabolism and carbohydrate sources of *Xpm* : *Xpm_Central_metabolism_map.json*

•	Metabolic map of amino acid biosynthesis of *Xpm*: *Xpm-Aminoacid_map.json*

•	Metabolic map of xanthan biosynthesis of *Xpm*: *Xpm-Xanthan_biosynthesis_map.json*

## Models
Including all the models versions used in the analyses:

- *Xpm_model_May_29_2020.xml*: Full *Xpm* M-model with metabolite annotations (sbml format)

- *Xam_Biomass&Xanthan(completed_mar15)_model.xml*: Full *Xpm* M-model without metabolite annotations (sbml format)

- *Xpm_model_May_29_2020.mat*: Full *Xpm* M-model with metabolite annotations (matlab format)

- *Xam_Biomass&Xanthan(completed_mar15)_model.json*: Full *Xpm* M-model without metabolite annotations (json format)

- *Xam_void_CSM.mat*: Context Specific Metabolic Model of *Xpm* CIO151 EV strain (matlab format)

- *Xam_rpfCGH_CSM.mat*: Context Specific Metabolic Model of *Xpm* CIO151 ΔrpfCGH-EV strain (matlab format)

- *Xam_BiGG_full_media.json*: *Xpm* M-model used for loops and null space calculations (json format)

