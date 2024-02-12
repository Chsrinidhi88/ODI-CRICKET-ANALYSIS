-- lets create a table inside the raw layer
create or replace transient table ODI_CRICKET_DATABASE.RAW.match_raw_tbl (
    meta object not null,
    info variant not null,
    innings ARRAY not null,
    stg_file_name text not null,
    stg_file_row_number int not null,
    stg_file_hashkey text not null,
    stg_modified_ts timestamp not null
)
comment = 'This is raw table to store all the json data file with root elements extracted'
;

--create pipe to copy data from external stage into match_raw_tbl table
  create or replace pipe azure_pipe
  auto_ingest=TRUE
  integration="snowpipe_event"
  as 
  copy into ODI_CRICKET_DATABASE.raw.match_raw_tbl from 
    (
    select 
        t.$1:meta::object as meta, 
        t.$1:info::variant as info, 
        t.$1:innings::array as innings, 
        --
        metadata$filename,
        metadata$file_row_number,
        metadata$file_content_key,
        metadata$file_last_modified
    from @ODI_CRICKET_DATABASE.land.STAGE_AZURE/CRICKET (file_format => 'ODI_CRICKET_DATABASE.land.my_json_format') t
    )
    on_error = continue;
  

-- execute the count
select count(*) from odi_cricket_database.raw.match_raw_tbl; 
--querying
select * from odi_cricket_database.raw.match_raw_tbl limit 10;