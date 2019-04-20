/* Direct SAS to file location */ 
FILENAME REFFILE '/folders/myfolders/1/data/melb.csv'; 
/* Import dataset into SAS */ 
PROC IMPORT DATAFILE=REFFILE 
DBMS=CSV 
OUT=melb; 
GETNAMES=YES; 
RUN; 
ODS SELECT VARIABLES; 
/*Produce the contents table of the dataset*/ 
PROC CONTENTS DATA=melb; RUN; 
ODS SELECT DEFAULT; 
/*Produce the stat desc of the dataset*/ 
PROC MEANS DATA=melb; 
VAR TIME YEAR; 
RUN; 
/*Plot the scatter graph*/ 
PROC SGPLOT DATA = melb; 
SCATTER X=Year Y=Time / markerattrs=(color=blue symbol=plus size=10); 
XAXIS GRID; 
YAXIS GRID; 
TITLE 'Winning Times of the Melbourne Cup (1861-2013)'; 
LABEL Time = 'Time (Seconds)'; 
RUN; 
/*Plot the scatter graph w/ linear regression*/ 
PROC SGPLOT DATA = melb; 
REG X=Year Y=Time / markerattrs=(color=blue symbol=plus size=10) lineattrs=(color=black) 
					curvelabel='Winning Times' nolegfit; 
XAXIS GRID; 
YAXIS GRID; 
TITLE 'Winning Times of the Melbourne Cup (1861-2013)'; 
LABEL Time = 'Time (Seconds)'; 
RUN; 
/*Plot the scatter graph w/ loess regression(non-linear)*/ 
PROC SGPLOT DATA = melb; 
LOESS X=Year Y=Time  / markerattrs=(color=blue symbol=plus size=10) lineattrs=(color=black) 
					curvelabel='Winning Times' nolegfit; 
XAXIS GRID; 
YAXIS GRID; 
TITLE 'Winning Times of the Melbourne Cup (1861-2013)'; 
LABEL Time = 'Time (Seconds)'; 
RUN;

