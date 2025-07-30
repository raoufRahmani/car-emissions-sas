libname in "/home/u64046075/Car_emissions";
proc import datafile="/home/u64046075/Car_emissions/2023_Cars_Aggregated.csv"
out=in.car_data
dbms=csv replace;
run;
proc print data=in.car_data;
run;
/*missing values*/
proc means data=car_data nmiss;
run;

/*Data exploretary*/
proc means data=in.car_data;
run;