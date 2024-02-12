# ODI-CRICKET-ANALYSIS

This project delivers a powerful cricket analytics pipeline built on the dynamic duo of Azure and Snowflake. Unleash a seamless flow of data from various sources, starting with APIs that feed directly into Azure Data Lake Storage Gen2 (ADLS Gen2), your data's secure landing pad.Snowpipe, seamlessly integrated with Azure Active Directory, acts as your data scout, continuously fetching the latest information into Snowflake, ensuring near real-time analysis. Dive into intuitive data validation at each stage – landing, raw, clean, and consumption – thanks to the user-friendly interface of Snowsight. Ensure your data is in top form before the analysis game begins.

Let automation be your star player! SnowSQL stored procedures and a well-structured hierarchical task tree take over the intricate transformations, guaranteeing smooth data flow like a well-executed cover drive.This pipeline meticulously constructs dimensional and fact tables like "teams," "players," and "matches," all optimized for lightning-fast joins and insightful aggregations, helping you hit analytical sixes with ease.

To maintain sparkling data quality, streams and tasks work in perfect harmony, automating data refreshes and ensuring your data stays in top form, just like a well-oiled fielding unit.The entire process is orchestrated to uncover patterns, trends, and key metrics in ODI_CRICKET data.The project culminates with the integration of snowflake into Power BI for visually compelling and interactive dashboards.

**Tools & Technologies:**

Cloud - Azure
Data Storage - Azure Data Lake Gen2
Data Orchestration - snowpipe
Data Ingestion,Processing - streams, tasks, task trees
Data Modelling - snowflake, Dbeaver
Datawarehouse - snowflake
Data Visualization - Power BI
Programming Language - SQL, snowsql


**Architecture:**

<img width="500" alt="image" src="https://github.com/Chsrinidhi88/ODI-CRICKET-ANALYSIS/assets/34069596/e82f3ea2-dd92-4050-94a0-5d961df5e2a1">





**DataSet used:**

The project utilizes a dataset extracted from the ODI cricket matches, sourced from the cricbuzz website. The dataset consists of semi-structured data in JSON format, encompassing essential fields such as venue details, player information, match specifics, bowler and batter details, and match outcomes. It should be noted that all the data pertains to ODI cricket matches from the year 2023. The repository contains these curated datasets, offering a snapshot suitable for analysis and visualization within the project's defined scope.



