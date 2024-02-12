--create tables in clean schema

create or replace transient table odi_cricket_database.clean.match_detail_clean as
select
    info:match_type_number::int as match_type_number, 
    info:event.name::text as event_name,
    case
    when 
        info:event.match_number::text is not null then info:event.match_number::text
    when 
        info:event.stage::text is not null then info:event.stage::text
    else
        'NA'
    end as match_stage,   
    info:dates[0]::date as event_date,
    date_part('year',info:dates[0]::date) as event_year,
    date_part('month',info:dates[0]::date) as event_month,
    date_part('day',info:dates[0]::date) as event_day,
    info:match_type::text as match_type,
    info:season::text as season,
    info:team_type::text as team_type,
    info:overs::text as overs,
    info:city::text as city,
    info:venue::text as venue, 
    info:gender::text as gender,
    info:teams[0]::text as first_team,
    info:teams[1]::text as second_team,
    case 
        when info:outcome.winner is not null then 'Result Declared'
        when info:outcome.result = 'tie' then 'Tie'
        when info:outcome.result = 'no result' then 'No Result'
        else info:outcome.result
    end as matach_result,
    case 
        when info:outcome.winner is not null then info:outcome.winner
        else 'NA'
    end as winner,   

    info:toss.winner::text as toss_winner,
    initcap(info:toss.decision::text) as toss_decision,
    --
    stg_file_name ,
    stg_file_row_number,
    stg_file_hashkey,
    stg_modified_ts
    from 
    odi_cricket_database.raw.match_raw_tbl;

--validate the data
select * from odi_cricket_database.clean.match_detail_clean;


--player clean table
create or replace table player_clean_tbl as 
select 
    rcm.info:match_type_number::int as match_type_number, 
    p.path::text as country,
    team.value:: text as player_name,
    stg_file_name ,
    stg_file_row_number,
    stg_file_hashkey,
    stg_modified_ts
from odi_cricket_database.raw.match_raw_tbl rcm,
lateral flatten (input => rcm.info:players) p,
lateral flatten (input => p.value) team;


--describe table
desc table player_clean_tbl;


--add not null fk relationships

alter table player_clean_tbl
modify column match_type_number set not null;

alter table player_clean_tbl
modify column player_name set not null;

alter table player_clean_tbl
modify column country set not null;


---primary keys
alter table match_detail_clean
add constraint pk_match_type_number primary key (match_type_number)

alter table player_clean_tbl
add constraint fk_match_id
foreign key (match_type_number)
references match_detail_clean(match_type_number);

desc table match_detail_clean;

select get_ddl('table','player_clean_tbl')

create or replace table delivery_clean_tbl as
select 
    m.info:match_type_number::int as match_type_number, 
    i.value:team::text as country,
    o.value:over::int as over,
    d.value:bowler::text as bowler,
    d.value:batter::text as batter,
    d.value:non_striker::text as non_striker,
    d.value:runs.batter::text as runs,
    d.value:runs.extras::text as extras,
    d.value:runs.total::text as total,
    w.value:player_out::text as player_out,
    w.value:kind::text as player_out_kind,
    w.value:fielders::variant as player_out_fielders,
    m.stg_file_name ,
    m.stg_file_row_number,
    m.stg_file_hashkey,
    m.stg_modified_ts
from odi_cricket_database.raw.match_raw_tbl m,
lateral flatten (input => m.innings) i,
lateral flatten (input => i.value:overs) o,
lateral flatten (input => o.value:deliveries) d,
lateral flatten (input => d.value:wickets, outer => True) w;

select * from match_detail_clean
where  match_type_number=4670

--gives all tables created
show tables;

--check the keys available in table
select get_ddl('table','delivery_clean_tbl')

--assign foreign keys 
alter table delivery_clean_tbl
modify column match_type_number set not null;

alter table delivery_clean_tbl
modify column team_name set not null;

alter table delivery_clean_tbl
modify column over set not null;

alter table delivery_clean_tbl
modify column bowler set not null;

alter table delivery_clean_tbl
modify column batter set not null;

alter table delivery_clean_tbl
modify column non_striker set not null;

-- fk relationship
alter table delivery_clean_tbl
add constraint fk_delivery_match_id
foreign key (match_type_number)
references match_detail_clean (match_type_number);

--validate
select * from delivery_clean_tbl
where  match_type_number=4670


