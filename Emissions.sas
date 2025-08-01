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


/*The table shows fuel consumption (l/100 km) by car brand. GEELY has the lowest average,
 just 2.48, which is great for saving fuel. On the other hand, BUGATTI, ROLLS ROYCE,
 and LAMBORGHINI have very high values, over 14, which is expected for luxury cars. 
 Most other brands are between 3 and 6, like TOYOTA, RENAULT, and HYUNDAI — 
 pretty efficient overall.*/

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

/*Visualisation of number of vehicles by Manufacturer*/
proc sgplot data=in.car_data;
    hbar Manufacturer / response='Number of vehicles'n stat=sum datalabel;
    title "Total Number of Vehicles by Manufacturer";
run;

/*Percentage of cars in our database*/
proc freq data=in.car_data;
tables Manufacturer /nocum;
run;

/*CO2 Emissions*/
/*Summarize CO2 emissions by Manufacturer */
proc means data=in.car_data noprint;
    class Manufacturer;
    var 'WLTP CO2 emissions (g/km)'n;
    output out=summary_CO2 mean=mean_CO2;
run;


data summary_CO2_clean;
    set summary_CO2;
    if _TYPE_ = 1;
    drop _TYPE_ _FREQ_;
run;

/*This table shows the CO2 emissions (g/km) by car manufacturer. The cleanest is MITSUBISHI
MOTORS CORPORATION with just 46 g/km, followed by GEELY and SUZUKI, very eco-friendly. On
 the other side, luxury brands like BUGATTI, ROLLS ROYCE, and LAMBORGHINI have super high
 emissions, over 300 or even 500 g/km, which is expected. Most brands stay between 90 and
 130, like TOYOTA, RENAULT, and HYUNDAI, which is acceptable for daily use.*/


/*mean CO2 emissions per Manufacturer */
proc sgplot data=summary_CO2_clean;
    hbar Manufacturer / response=mean_CO2 datalabel;
    yaxis label="Manufacturer";
    xaxis label="WLTP CO2 emissions (g/km)";
run;

/*Check distributions*/
proc univariate data=in.car_data;
    var 'WLTP Fuel consumption (l/100 km)'n;
    histogram / normal;
run;


/*which Fuel type causes more pollution : */
proc sgplot data=in.car_data;
    vbar 'Fuel Type'n / response='WLTP CO2 emissions (g/km)'n stat=mean datalabel;
    title "Average WLTP CO2 Emissions by Fuel Type";
run;

/*On average, diesel engines emit 157.6 g/km of CO2, while petrol engines emit slightly 
more at 171.9 g/km. In contrast, hybrid vehicles emit significantly less—only 35 g/km, 
making them much more environmentally friendly. This highlights the growing role of 
hybrid technologies in reducing emissions and meeting climate targets.*/










