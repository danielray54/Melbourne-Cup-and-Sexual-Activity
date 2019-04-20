/* DIRECT SAS TO FILE LOCATION */ 
FILENAME REFFILE '/folders/myfolders/1/data/SA.csv'; 
/* IMPORT DATASET INTO SAS */ 
PROC IMPORT DATAFILE=REFFILE 
DBMS=CSV 
OUT=SA; 
GETNAMES=YES; 
RUN; 
ODS SELECT VARIABLES; 
/*PRODUCE THE CONTENTS TABLE OF THE DATASET*/ 
PROC CONTENTS DATA=SA; RUN; 
ODS SELECT DEFAULT; 
/*change partners variable to numerical value*/ 
DATA SA2; SET SA; 
INT_PARTNERS = INPUT(PARTNERS, BEST5.); 
RUN; 
/*PRODUCE THE CONTENTS TABLE OF THE DATASET*/ 
ODS SELECT VARIABLES; 
PROC CONTENTS DATA=SA2; RUN; 
ODS SELECT DEFAULT; 
/*PRODUCE THE STAT DESC OF THE DATASET*/ 
PROC MEANS DATA=SA2;
VAR INT_PARTNERS; 
RUN; 
/*PRODUCE Bar chart of the average number of partners per sex*/ 
PROC SGPLOT DATA=SA2; 
VBAR SEX / RESPONSE = INT_PARTNERS STAT=MEAN; 
XAXIS GRID; 
YAXIS GRID; 
TITLE 'Average (Mean) # of Partners For Each Sex'; 
LABEL INT_PARTNERS = '# of Partners'; 
RUN; 
/*PRODUCE new data set that only contains males*/ 
DATA SA3; 
   SET SA2; 
   WHERE(SEX='M');
RUN; 
/*PRODUCE bar chart of frequency of # of partners for males*/ 
PROC SGPLOT DATA=SA3; 
VBAR INT_PARTNERS; 
XAXIS GRID; 
YAXIS GRID; 
TITLE '# of Partners for Males';
LABEL INT_PARTNERS = '# of Partners'; 
RUN;  
/*PRODUCE new data set that only contains females*/   
DATA SA4; 
   SET SA2; 
   WHERE(SEX='F'); 
RUN; 
/*PRODUCE bar chart of frequency of # of partners for females*/ 
PROC SGPLOT DATA=SA4; 
  VBAR INT_PARTNERS; 
  XAXIS GRID; 
YAXIS GRID; 
TITLE '# of Partners for Females'; 
LABEL INT_PARTNERS = '# of Partners'; 
RUN;  
/*PRODUCE grouped bar chart of frequency of # of partners for both sexes*/  
PROC SGPLOT DATA=SA2; 
  VBAR INT_PARTNERS / GROUP=SEX; 
    XAXIS GRID; 
YAXIS GRID; 
TITLE '# of Partners for Both Sexes'; 
LABEL INT_PARTNERS = '# of Partners'; 
  RUN;
 /*PRODUCE clustered grouped bar chart of frequency of # of partners for both sexes*/  
PROC SGPLOT DATA=SA2; 
  VBAR INT_PARTNERS / GROUP=SEX GROUPDISPLAY = CLUSTER; 
    XAXIS GRID; 
YAXIS GRID; 
TITLE '# of Partners for Both Sex-es';
 