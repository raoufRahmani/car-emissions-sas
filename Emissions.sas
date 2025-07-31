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

/*Data Exploration*/
proc means data=in.car_data;
run;

/*Which manufacturers have lowest fuel consumption*/
proc means data=in.car_data noprint;
    class Manufacturer;
    var 'WLTP Fuel consumption (l/100 km)'n;
    output out=summary_data mean=mean_WLTP;
run;

data summary_data;
    set summary_data;
    if _TYPE_ = 1;
    drop _TYPE_ _FREQ_;
run;

/*boxplot*/
proc sgplot data=in.car_data;
    hbox 'WLTP Fuel consumption (l/100 km)'n / category=Manufacturer;
    yaxis label='Manufacturer';
    xaxis label='Fuel consumption (l/100km)';
run;

/*bar chart*/
proc sgplot data=summary_data;
    hbar Manufacturer / response=mean_WLTP datalabel;
    yaxis label="Manufacturer";
    xaxis label="Mean WLTP Fuel Consumption (l/100 km)";
run;

/*Percentage of cars in our database*/
proc freq data=in.car_data;
tables Manufacturer /nocum;
run;

/*CO2 Emissions*/
proc means data=in.car_data;
var 'WLTP CO2 emissions (g/km)'n;
run;









