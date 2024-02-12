# ODI-CRICKET-ANALYSIS

This repository demonstrates the development and automation of a data pipeline for cricket analytics using Snowflake. The pipeline ingests data from external sources, processes it through various stages (landing, raw, clean, consumption), and populates dimensional and fact tables for multi-dimensional analysis. It showcases expertise in the following areas:

Snowflake features: Snowpipe, Snowsight, SnowSQL, stored procedures, tasks, task trees

Data pipeline development: Ingestion, transformation, loading, automation

Data modeling: Dimensional and fact tables, data cleaning, optimization

Key highlights:

Continuous data ingestion: Leverages Snowpipe for near real-time data arrival from ADLS Gen 2.
Interactive data exploration and validation: Employs Snowsight for user-friendly analysis at each processing stage.
Automated data transformations and loading: Utilizes SnowSQL stored procedures and a hierarchical task tree to orchestrate the pipeline efficiently.
Optimized data model: Creates dimensional tables (teams, players) and a fact table (matches) for efficient joins and aggregations.
Data refresh and consistency: Incorporates streams and tasks to automate data updates and maintain data quality.
