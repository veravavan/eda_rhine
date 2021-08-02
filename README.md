Code for the course of Exploratory Data Analysis of the Bachelor of Environmental Data Science.

Analysis hypothesis: The hydroclimatic changes predicted by Middelkoop et al. (2001) are happening across the Rhine basin.

Workflow: Follow numbering of scripts in folder 'code'.

Script description:

00_init.R Creates necessary folders, not available in the repo (omited by .gitignore).
01a_import_runoff_info.R Imports information about runoff stations and makes the format tidy.
01b_import_runoff_day.R Imports information about runoff values and makes the format tidy.
02_preparation.R Inspects two stations and cleans the data (removing missing values and limiting the years).
03_transformaton.R Creates summary statistics, aggregates and maps the data.
04_classification.R Divides the data into categories.
05_comparison.R Compares the data by years and seasons by making plots.
