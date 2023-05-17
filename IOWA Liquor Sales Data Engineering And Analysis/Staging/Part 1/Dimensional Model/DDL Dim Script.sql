--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      IOWA_Final Dimensional Model.DM1
--
-- Date Created : Friday, April 07, 2023 19:41:18
-- Target DBMS : MySQL 8.x
--

-- 
-- TABLE: dim_date 
--

CREATE TABLE dim_date(
    date_sk               BIGINT         NOT NULL,
    QtrID                 INT,
    MonthID               INT,
    MonthYear_SK          INT,
    QtrYear_SK            INT,
    date_nk               DATETIME,
    Date_Year             INT,
    date                  DATETIME,
    date_time_value       DATETIME,
    Qtr_Year_Name         VARCHAR(20),
    MonthYear_Name        VARCHAR(20),
    Day_in_Month          INT,
    Day_in_Year           INT,
    Day_Count             INT,
    Day_Name              VARCHAR(20),
    Day_Abr               VARCHAR(3),
    Week_in_Year          BIGINT,
    Week_Count            INT,
    Month_Name            VARCHAR(20),
    Month_Abr             VARCHAR(3),
    Month_Count           INT,
    First_Day_of_Month    INT,
    Last_Day_of_Month     INT,
    PRIMARY KEY (date_sk)
)ENGINE=MYISAM
;



-- 
-- TABLE: dim_iowa_city 
--

CREATE TABLE dim_iowa_city(
    City_SK          INT            AUTO_INCREMENT,
    City             VARCHAR(50),
    FIPS             INT,
    Latitude         VARCHAR(30),
    Longitude        VARCHAR(30),
    DI_JobID         VARCHAR(80),
    DI_CreateDate    DATETIME       DEFAULT 'CURRENT_TIMESTAMP' NOT NULL,
    PRIMARY KEY (City_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: dim_iowa_county 
--

CREATE TABLE dim_iowa_county(
    County_SK        INT            AUTO_INCREMENT,
    County           VARCHAR(50),
    FIPS             INT,
    Latitude         VARCHAR(30),
    Longitude        VARCHAR(30),
    DI_JobID         VARCHAR(80),
    DI_CreateDate    DATETIME       DEFAULT 'CURRENT_TIMESTAMP' NOT NULL,
    PRIMARY KEY (County_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: dim_iowa_liquor_product_categories 
--

CREATE TABLE dim_iowa_liquor_product_categories(
    Category_SK        INT            AUTO_INCREMENT,
    Category_Number    INT            NOT NULL,
    Category_Name      VARCHAR(50),
    DI_JobID           VARCHAR(80),
    DI_CreateDate      DATETIME       DEFAULT 'CURRENT_TIMESTAMP' NOT NULL,
    PRIMARY KEY (Category_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: dim_iowa_liquor_products 
--

CREATE TABLE dim_iowa_liquor_products(
    Item_SK                INT              NOT NULL,
    Item_Number            VARCHAR(20)      NOT NULL,
    Item_Number_C          VARCHAR(30),
    Item_Description       VARCHAR(100),
    Category_SK            INT              NOT NULL,
    Vendor_SK              INT              NOT NULL,
    Bottle_Volume_ml       INT,
    Pack                   INT,
    Inner_Pack             INT,
    Age                    INT,
    Proof                  INT,
    List_Date              DATE,
    UPC                    BIGINT,
    SCC                    BIGINT,
    State_Bottle_Cost      DOUBLE(18, 0),
    State_Case_Cost        DOUBLE(18, 0),
    State_Bottle_Retail    DOUBLE(18, 0),
    Report_Date            DATE,
    DI_JobID               VARCHAR(80),
    DI_CreateDate          DATETIME         DEFAULT 'CURRENT_TIMESTAMP' NOT NULL,
    PRIMARY KEY (Item_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: dim_iowa_liquor_stores 
--

CREATE TABLE dim_iowa_liquor_stores(
    Store_SK         INT             NOT NULL,
    Store_ID         INT             NOT NULL,
    Store_Name       VARCHAR(100),
    Store_Status     CHAR(10),
    Address          VARCHAR(100),
    Zip_Code         INT,
    City_SK          INT             NOT NULL,
    County_SK        INT             NOT NULL,
    Report_Date      DATETIME,
    DI_JobID         VARCHAR(80),
    DI_CreateDate    DATETIME        DEFAULT 'CURRENT_TIMESTAMP' NOT NULL,
    PRIMARY KEY (Store_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: dim_iowa_liquor_vendors 
--

CREATE TABLE dim_iowa_liquor_vendors(
    Vendor_SK        INT             NOT NULL,
    Vendor_Number    INT             NOT NULL,
    Vendor_Name      VARCHAR(100),
    DI_JobID         VARCHAR(80),
    DI_CreateDate    DATETIME        DEFAULT 'CURRENT_TIMESTAMP' NOT NULL,
    PRIMARY KEY (Vendor_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: fct_iowa_city_population_by_year 
--

CREATE TABLE fct_iowa_city_population_by_year(
    City_Pop_SK        INT            AUTO_INCREMENT,
    City_SK            INT            NOT NULL,
    City               VARCHAR(50),
    FIPS               INT,
    DataAsOf           DATE,
    Population_Year    INT,
    Population         INT,
    Latitude           VARCHAR(30),
    Longitude          VARCHAR(30),
    DI_JobID           VARCHAR(80),
    DI_CreateDate      DATETIME       DEFAULT 'CURRENT_TIMESTAMP' NOT NULL,
    PRIMARY KEY (City_Pop_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: fct_iowa_county_population_by_year 
--

CREATE TABLE fct_iowa_county_population_by_year(
    County_Pop_SK      INT            AUTO_INCREMENT,
    County_SK          INT            NOT NULL,
    County             VARCHAR(50),
    FIPS               INT,
    DateAsOf           DATE,
    Population_Year    INT,
    Population         INT,
    Latitude           VARCHAR(30),
    Longitude          VARCHAR(30),
    DI_JobID           VARCHAR(80),
    DI_CreateDate      DATETIME       DEFAULT 'CURRENT_TIMESTAMP' NOT NULL,
    PRIMARY KEY (County_Pop_SK)
)ENGINE=MYISAM
;



-- 
-- TABLE: fct_iowa_liquor_sales_invoice_header 
--

CREATE TABLE fct_iowa_liquor_sales_invoice_header(
    Invoice_Number                 INT              NOT NULL,
    Invoice_Date                   DATE             NOT NULL,
    InvoiceDate_SK                 BIGINT           NOT NULL,
    Store_SK                       INT              NOT NULL,
    Store_Number                   INT,
    Invoice_Bottles_Sold           INT,
    Invoice_Sale_Dollars           DOUBLE(18, 0),
    Invoice_Volume_Sold_Liters     DOUBLE(18, 0),
    Invoice_Volume_Sold_Gallons    DOUBLE(18, 0),
    DI_JobID                       VARCHAR(80),
    DI_CreateDate                  DATETIME         DEFAULT 'CURRENT_TIMESTAMP' NOT NULL,
    PRIMARY KEY (Invoice_Number)
)ENGINE=MYISAM
;



-- 
-- TABLE: fct_iowa_liquor_sales_invoice_lineitem 
--

CREATE TABLE fct_iowa_liquor_sales_invoice_lineitem(
    Invoice_Number           INT              NOT NULL,
    Invoice_Number_LineNo    VARCHAR(50),
    Invoice_Item_Number      INT              NOT NULL,
    Item_SK                  INT              NOT NULL,
    Item_Number              INT,
    Pack                     INT,
    Bottle_Volume_ml         INT,
    State_Bottle_Cost        DOUBLE(18, 0),
    State_Bottle_Retail      DOUBLE(18, 0),
    Bottles_Sold             INT,
    Sale_Dollars             DOUBLE(18, 0),
    Volume_Sold_Liters       DOUBLE(18, 0),
    Volume_Sold_Gallons      DOUBLE(18, 0),
    DI_JobID                 VARCHAR(80),
    DI_CreateDate            DATETIME         DEFAULT 'CURRENT_TIMESTAMP' NOT NULL,
    PRIMARY KEY (Invoice_Item_Number)
)ENGINE=MYISAM
;



-- 
-- TABLE: dim_iowa_liquor_products 
--

ALTER TABLE dim_iowa_liquor_products ADD CONSTRAINT Refdim_iowa_liquor_vendors1 
    FOREIGN KEY (Vendor_SK)
    REFERENCES dim_iowa_liquor_vendors(Vendor_SK)
;

ALTER TABLE dim_iowa_liquor_products ADD CONSTRAINT Refdim_iowa_liquor_product_categories2 
    FOREIGN KEY (Category_SK)
    REFERENCES dim_iowa_liquor_product_categories(Category_SK)
;


-- 
-- TABLE: dim_iowa_liquor_stores 
--

ALTER TABLE dim_iowa_liquor_stores ADD CONSTRAINT Refdim_iowa_county5 
    FOREIGN KEY (County_SK)
    REFERENCES dim_iowa_county(County_SK)
;

ALTER TABLE dim_iowa_liquor_stores ADD CONSTRAINT Refdim_iowa_city6 
    FOREIGN KEY (City_SK)
    REFERENCES dim_iowa_city(City_SK)
;


-- 
-- TABLE: fct_iowa_city_population_by_year 
--

ALTER TABLE fct_iowa_city_population_by_year ADD CONSTRAINT Refdim_iowa_city4 
    FOREIGN KEY (City_SK)
    REFERENCES dim_iowa_city(City_SK)
;


-- 
-- TABLE: fct_iowa_county_population_by_year 
--

ALTER TABLE fct_iowa_county_population_by_year ADD CONSTRAINT Refdim_iowa_county3 
    FOREIGN KEY (County_SK)
    REFERENCES dim_iowa_county(County_SK)
;


-- 
-- TABLE: fct_iowa_liquor_sales_invoice_header 
--

ALTER TABLE fct_iowa_liquor_sales_invoice_header ADD CONSTRAINT Refdim_iowa_liquor_stores7 
    FOREIGN KEY (Store_SK)
    REFERENCES dim_iowa_liquor_stores(Store_SK)
;

ALTER TABLE fct_iowa_liquor_sales_invoice_header ADD CONSTRAINT Refdim_date11 
    FOREIGN KEY (InvoiceDate_SK)
    REFERENCES dim_date(date_sk)
;


-- 
-- TABLE: fct_iowa_liquor_sales_invoice_lineitem 
--

ALTER TABLE fct_iowa_liquor_sales_invoice_lineitem ADD CONSTRAINT Reffct_iowa_liquor_sales_invoice_header8 
    FOREIGN KEY (Invoice_Number)
    REFERENCES fct_iowa_liquor_sales_invoice_header(Invoice_Number)
;

ALTER TABLE fct_iowa_liquor_sales_invoice_lineitem ADD CONSTRAINT Refdim_iowa_liquor_products9 
    FOREIGN KEY (Item_SK)
    REFERENCES dim_iowa_liquor_products(Item_SK)
;


