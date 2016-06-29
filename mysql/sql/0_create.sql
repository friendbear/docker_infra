CREATE DATABASE IF NOT EXISTS miraimarche;
USE miraimarche;

# --- table
create table mst_affiliation (
  id                        bigint auto_increment not null,
  company_id                bigint,
  name                      varchar(255),
  area_name                 varchar(255),
  is_admin                  tinyint(1) default 0,
  created_date              datetime(6) not null,
  updated_date              datetime(6) not null,
  constraint pk_mst_affiliation primary key (id))
;

create table mst_company (
  id                        bigint auto_increment not null,
  name                      varchar(255),
  type                      varchar(6),
  item_category_id          bigint,
  created_date              datetime(6) not null,
  updated_date              datetime(6) not null,
  constraint ck_mst_company_type check (type in ('retail','market')),
  constraint pk_mst_company primary key (id))
;

create table rel_company_contract (
  id                        bigint auto_increment not null,
  retail_company_id         bigint,
  market_company_id         bigint,
  created_date              datetime(6) not null,
  updated_date              datetime(6) not null,
  constraint pk_rel_company_contract primary key (id))
;

create table mst_delivery (
  id                        bigint auto_increment not null,
  company_contract_id       bigint,
  name                      varchar(255),
  default_extra_cost        integer,
  default_deadline_time     time,
  delivery_time             integer,
  created_date              datetime(6) not null,
  updated_date              datetime(6) not null,
  constraint pk_mst_delivery primary key (id))
;

create table rel_delivery_affiliation (
  id                        bigint auto_increment not null,
  delivery_id               bigint,
  affiliation_id            bigint,
  created_date              datetime(6) not null,
  updated_date              datetime(6) not null,
  constraint pk_rel_delivery_affiliation primary key (id))
;

create table trn_exhibit_item (
  id                        bigint auto_increment not null,
  exhibit_user_id           bigint,
  company_id                bigint,
  item_id                   bigint,
  item_production_id        bigint,
  item_production_free_input varchar(255),
  standard                  varchar(255),
  price                     integer,
  price_unit                varchar(8),
  stock                     integer,
  quantity                  integer,
  number_unit               varchar(8),
  introduction              varchar(255),
  created_date              datetime(6) not null,
  updated_date              datetime(6) not null,
  constraint ck_trn_exhibit_item_price_unit check (price_unit in ('quantity','case')),
  constraint ck_trn_exhibit_item_number_unit check (number_unit in ('kilogram','quantity','case')),
  constraint pk_trn_exhibit_item primary key (id))
;

create table trn_exhibit_item_delivery (
  id                        bigint auto_increment not null,
  exhibit_item_id           bigint,
  delivery_id               bigint,
  additional_extra_cost     integer,
  ship_date                 date,
  deadline_time             datetime(6),
  created_date              datetime(6) not null,
  updated_date              datetime(6) not null,
  constraint pk_trn_exhibit_item_delivery primary key (id))
;

create table trn_exhibit_item_image (
  id                        bigint auto_increment not null,
  exhibit_item_id           bigint,
  sort                      integer,
  url                       varchar(255),
  created_date              datetime(6) not null,
  updated_date              datetime(6) not null,
  constraint pk_trn_exhibit_item_image primary key (id))
;

create table mst_item (
  id                        bigint auto_increment not null,
  name                      varchar(255),
  name_kana                 varchar(255),
  jan_code                  varchar(255),
  item_category_id          bigint,
  created_date              datetime(6) not null,
  updated_date              datetime(6) not null,
  constraint pk_mst_item primary key (id))
;

create table mst_item_category (
  id                        bigint auto_increment not null,
  name                      varchar(255),
  created_date              datetime(6) not null,
  updated_date              datetime(6) not null,
  constraint pk_mst_item_category primary key (id))
;

create table mst_item_production (
  id                        bigint auto_increment not null,
  name                      varchar(255),
  name_kana                 varchar(255),
  item_category_id          bigint,
  is_manual                 tinyint(1) default 0,
  created_date              datetime(6) not null,
  updated_date              datetime(6) not null,
  constraint pk_mst_item_production primary key (id))
;

create table trn_message (
  id                        bigint auto_increment not null,
  exhibit_item_id           bigint,
  user_id                   bigint,
  message                   varchar(255),
  created_date              datetime(6) not null,
  updated_date              datetime(6) not null,
  constraint pk_trn_message primary key (id))
;

create table trn_order (
  id                        bigint auto_increment not null,
  exhibit_item_id           bigint,
  order_user_id             bigint,
  order_user_affiliation_id bigint,
  order_num                 integer,
  price                     integer,
  delivery_flight_id        bigint,
  additional_extra_cost     integer,
  ship_date                 datetime(6),
  delivery_date             datetime(6),
  status                    varchar(7),
  weight                    double,
  created_date              datetime(6) not null,
  updated_date              datetime(6) not null,
  constraint ck_trn_order_status check (status in ('sale','soldout')),
  constraint pk_trn_order primary key (id))
;

create table trn_sms_token (
  id                        bigint auto_increment not null,
  user_id                   bigint,
  token                     varchar(255),
  expires                   datetime(6),
  created_date              datetime(6) not null,
  updated_date              datetime(6) not null,
  constraint pk_trn_sms_token primary key (id))
;

create table trn_user (
  id                        bigint auto_increment not null,
  email                     varchar(255),
  password                  varchar(255),
  first_name                varchar(255),
  last_name                 varchar(255),
  company_id                bigint,
  profile_img_url           varchar(255),
  introduction              varchar(255),
  is_enable_push            tinyint(1) default 1,
  phone_number              integer,
  auth_token                varchar(255),
  last_login                datetime(6),
  role                      varchar(5),
  is_active                 tinyint(1) default 1,
  created_date              datetime(6) not null,
  updated_date              datetime(6) not null,
  constraint ck_trn_user_role check (role in ('admin','user')),
  constraint uq_trn_user_email unique (email),
  constraint uq_trn_user_phone_number unique (phone_number),
  constraint pk_trn_user primary key (id))
;

create table rel_user_affiliation (
  id                        bigint auto_increment not null,
  user_id                   bigint,
  affiliation_id            bigint,
  item_category_id          bigint,
  created_date              datetime(6) not null,
  updated_date              datetime(6) not null,
  constraint pk_rel_user_affiliation primary key (id))
;

alter table mst_affiliation add constraint fk_mst_affiliation_company_1 foreign key (company_id) references mst_company (id) on delete restrict on update restrict;
create index ix_mst_affiliation_company_1 on mst_affiliation (company_id);
alter table mst_company add constraint fk_mst_company_itemCategory_2 foreign key (item_category_id) references mst_item_category (id) on delete restrict on update restrict;
create index ix_mst_company_itemCategory_2 on mst_company (item_category_id);
alter table rel_company_contract add constraint fk_rel_company_contract_retailCompany_3 foreign key (retail_company_id) references mst_company (id) on delete restrict on update restrict;
create index ix_rel_company_contract_retailCompany_3 on rel_company_contract (retail_company_id);
alter table rel_company_contract add constraint fk_rel_company_contract_marketCompany_4 foreign key (market_company_id) references mst_company (id) on delete restrict on update restrict;
create index ix_rel_company_contract_marketCompany_4 on rel_company_contract (market_company_id);
alter table mst_delivery add constraint fk_mst_delivery_companyContract_5 foreign key (company_contract_id) references rel_company_contract (id) on delete restrict on update restrict;
create index ix_mst_delivery_companyContract_5 on mst_delivery (company_contract_id);
alter table rel_delivery_affiliation add constraint fk_rel_delivery_affiliation_delivery_6 foreign key (delivery_id) references mst_delivery (id) on delete restrict on update restrict;
create index ix_rel_delivery_affiliation_delivery_6 on rel_delivery_affiliation (delivery_id);
alter table rel_delivery_affiliation add constraint fk_rel_delivery_affiliation_affiliation_7 foreign key (affiliation_id) references mst_affiliation (id) on delete restrict on update restrict;
create index ix_rel_delivery_affiliation_affiliation_7 on rel_delivery_affiliation (affiliation_id);
alter table trn_exhibit_item add constraint fk_trn_exhibit_item_exhibitUser_8 foreign key (exhibit_user_id) references trn_user (id) on delete restrict on update restrict;
create index ix_trn_exhibit_item_exhibitUser_8 on trn_exhibit_item (exhibit_user_id);
alter table trn_exhibit_item add constraint fk_trn_exhibit_item_company_9 foreign key (company_id) references mst_company (id) on delete restrict on update restrict;
create index ix_trn_exhibit_item_company_9 on trn_exhibit_item (company_id);
alter table trn_exhibit_item add constraint fk_trn_exhibit_item_item_10 foreign key (item_id) references mst_item (id) on delete restrict on update restrict;
create index ix_trn_exhibit_item_item_10 on trn_exhibit_item (item_id);
alter table trn_exhibit_item add constraint fk_trn_exhibit_item_itemProduction_11 foreign key (item_production_id) references mst_item_production (id) on delete restrict on update restrict;
create index ix_trn_exhibit_item_itemProduction_11 on trn_exhibit_item (item_production_id);
alter table trn_exhibit_item_delivery add constraint fk_trn_exhibit_item_delivery_exhibitItem_12 foreign key (exhibit_item_id) references trn_exhibit_item (id) on delete restrict on update restrict;
create index ix_trn_exhibit_item_delivery_exhibitItem_12 on trn_exhibit_item_delivery (exhibit_item_id);
alter table trn_exhibit_item_delivery add constraint fk_trn_exhibit_item_delivery_delivery_13 foreign key (delivery_id) references mst_delivery (id) on delete restrict on update restrict;
create index ix_trn_exhibit_item_delivery_delivery_13 on trn_exhibit_item_delivery (delivery_id);
alter table trn_exhibit_item_image add constraint fk_trn_exhibit_item_image_exhibitItem_14 foreign key (exhibit_item_id) references trn_exhibit_item (id) on delete restrict on update restrict;
create index ix_trn_exhibit_item_image_exhibitItem_14 on trn_exhibit_item_image (exhibit_item_id);
alter table mst_item add constraint fk_mst_item_itemCategory_15 foreign key (item_category_id) references mst_item_category (id) on delete restrict on update restrict;
create index ix_mst_item_itemCategory_15 on mst_item (item_category_id);
alter table mst_item_production add constraint fk_mst_item_production_itemCategory_16 foreign key (item_category_id) references mst_item_category (id) on delete restrict on update restrict;
create index ix_mst_item_production_itemCategory_16 on mst_item_production (item_category_id);
alter table trn_message add constraint fk_trn_message_exhibitItem_17 foreign key (exhibit_item_id) references trn_exhibit_item (id) on delete restrict on update restrict;
create index ix_trn_message_exhibitItem_17 on trn_message (exhibit_item_id);
alter table trn_message add constraint fk_trn_message_user_18 foreign key (user_id) references trn_user (id) on delete restrict on update restrict;
create index ix_trn_message_user_18 on trn_message (user_id);
alter table trn_order add constraint fk_trn_order_exhibitItemId_19 foreign key (exhibit_item_id) references trn_exhibit_item (id) on delete restrict on update restrict;
create index ix_trn_order_exhibitItemId_19 on trn_order (exhibit_item_id);
alter table trn_user add constraint fk_trn_user_company_20 foreign key (company_id) references mst_company (id) on delete restrict on update restrict;
create index ix_trn_user_company_20 on trn_user (company_id);
alter table rel_user_affiliation add constraint fk_rel_user_affiliation_affiliation_21 foreign key (affiliation_id) references mst_affiliation (id) on delete restrict on update restrict;
create index ix_rel_user_affiliation_affiliation_21 on rel_user_affiliation (affiliation_id);

