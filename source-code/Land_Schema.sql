create schema land;
create schema raw;
create schema clean;
create schema consumption;

--- create integration object that contains the access information
CREATE OR REPLACE STORAGE INTEGRATION azure_snowpipe_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = AZURE
  ENABLED = TRUE
  AZURE_TENANT_ID =  '17f1a87e-2a25-4eaa-b9df-9d439034b080'
  STORAGE_ALLOWED_LOCATIONS = ( 'azure://storage22001.blob.core.windows.net/raw');

  -- Describe integration object to provide access
DESC STORAGE integration azure_snowpipe_integration;


-- json file format
create or replace file format ODI_CRICKET_DATABASE.LAND.my_json_format
 type = json
 null_if = ('\\n', 'null', '')
    strip_outer_array = true
    comment = 'Json File Format with outer stip array flag true'; 




-- create stage object
create or replace stage ODI_CRICKET_DATABASE.LAND.stage_azure
    STORAGE_INTEGRATION = azure_snowpipe_integration
   URL = 'azure://storage22001.blob.core.windows.net/raw>'
    FILE_FORMAT = my_json_format;
    

list @ODI_CRICKET_DATABASE.LAND.stage_azure

--create notification integration object
CREATE OR REPLACE NOTIFICATION INTEGRATION snowpipe_event
  ENABLED = true
  TYPE = QUEUE
  NOTIFICATION_PROVIDER = AZURE_STORAGE_QUEUE
  AZURE_STORAGE_QUEUE_PRIMARY_URI = 'https://storage22001.queue.core.windows.net/snowqueue'
  AZURE_TENANT_ID = '17f1a87e-2a25-4eaa-b9df-9d439034b080';
  
  
  -- Register Integration
  
  DESC notification integration snowpipe_event;

