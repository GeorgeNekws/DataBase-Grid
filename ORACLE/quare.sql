prompt <== Creating table QUARE...;

drop table QUARE cascade constraints;

create table QUARE
(ID integer not null);

alter table QUARE add constraint quare_key#PK primary key(ID);

prompt <== Creating table QUARE_DETAILS...;

drop table QUARE_DETAILS;

create table QUARE_DETAILS
( ID integer not null
, x1 integer not null
, y1 integer not null
, x2 integer not null
, y2 integer not null
);

alter table QUARE_DETAILS add constraint quare_details_key#PK primary key(ID);
alter table QUARE_DETAILS add constraint quare_details_fk#FK foreign key(ID) references QUARE(ID);