#connects to snowflake account
snowsql -a organization-accountname -u username

# database and schema connections

use database ODI_CRICKET_DATABASE

use schema LAND

use role ACCOUNTADMIN

#loading data from local to stage.
Put file:///local/path/to/file @your_stage