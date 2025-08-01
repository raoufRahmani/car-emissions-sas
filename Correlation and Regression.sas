/*rename variables*/
proc import datafile="/home/u64046075/Car_emissions/2023_Cars_Aggregated(1).csv"
out=car_data
dbms=csv replace;
run;

proc contents data=car_data varnum;
run;


data car_data;
    set car_data(rename=(
        'WLTP Fuel con (l/100 km)'n              = WLTP_Fuel_cons
        'OBFCM Fuel consumption (l/100 km'n      = OBFCM_Fuel_cons
        'absolute gap Fuel cons (l/100 km'n      = AbsGap_Fuel_cons
        'percentage gap Fuel con'n               = PctGap_Fuel_cons
        'WLTP CO2 emissions (g/km)'n             = WLTP_CO2
        'OBFCM CO2 emissions (g/km)'n            = OBFCM_CO2
        'absolute gap CO2 emissions (g/km'n      = AbsGap_CO2
        'percentage gap CO2 emissions (%)'n      = PctGap_CO2
    ));
run;




/*Check all correlations*/
proc corr data=car_data plots=matrix(histogram);
    var 
        WLTP_Fuel_cons
        OBFCM_Fuel_cons
        AbsGap_Fuel_cons
        PctGap_Fuel_cons
        WLTP_CO2
        OBFCM_CO2
        AbsGap_CO2
        PctGap_CO2;
run;

/*The WLTP and OBFCM tests show very strong agreement, especially between fuel consumption
 and CO2 emissions (correlations above 0.99). Fuel use and CO2 are almost perfectly linked
 in both test types. WLTP and OBFCM results also match well overall (r = 0.79 for fuel,
 r = 0.81 for CO2). However, the percentage gap between the two tests becomes smaller 
 as fuel consumption or emissions increase (around -0.7). This means that more efficient
 cars show bigger differences between tests. Finally, absolute gaps are more related to 
 OBFCM values than WLTP.*/



/*Save correlations into a table*/
proc corr data=car_data outp=corr_table;
    var WLTP_Fuel_cons OBFCM_Fuel_cons AbsGap_Fuel_cons PctGap_Fuel_cons
        WLTP_CO2 OBFCM_CO2 AbsGap_CO2 PctGap_CO2;
run;

/*Visualise the correlation betwwen Fuel consumption and CO2 emissions*/
proc sgplot data=car_data;
    scatter x=WLTP_Fuel_cons y=WLTP_CO2 / markerattrs=(symbol=CircleFilled color=blue);
    title "WLTP Fuel Consumption vs WLTP CO2 Emissions";
    xaxis label="WLTP Fuel Consumption (l/100 km)";
    yaxis label="WLTP CO2 Emissions (g/km)";
run;



/*Linear Regression*/

proc reg data=car_data plots=none; 
	model WLTP_CO2 = OBFCM_Fuel_cons; run;

/*Mutiple Linear Regression*/
proc glm data=car_data;
    class Manufacturer 'Fuel Type'n;
    model WLTP_Fuel_cons = OBFCM_Fuel_cons 'Number of vehicles'n Manufacturer 'Fuel Type'n / solution;
run;

/* 
Interpretation of Regression Results (PctGap_Fuel_cons as Dependent Variable)

This regression explains the percentage gap between WLTP and OBFCM fuel consumption.

Holding all other variables constant:
- OBFCM_Fuel_cons has a strong positive and significant effect (β = 0.5678, p < 0.0001). 
  A 1-unit increase in OBFCM fuel consumption is associated with a 0.57-point increase in the gap.
- Number of vehicles has a small but significant negative effect (β = -0.0000042, p = 0.0006), 
  suggesting the gap slightly decreases as the number of vehicles increases.

Manufacturer effects (compared to baseline = VOLVO):
- Significant increase in the gap: AUDI SPORT (β = 1.29), BENTLEY (β = 1.48), ROLLS ROYCE (β = 2.54).
- Significant decrease in the gap: ALPINE (β = -1.37), BUGATTI (β = -4.76), FERRARI (β = -1.55), 
  IVECO (β = -4.04), DACIA (β = -0.67), HYUNDAI ASSAN (β = -0.85), MAZDA EUROPE (β = -1.02).
- Other manufacturers do not show significant effects.

Fuel type effects (compared to baseline = PETROL/ELECTRIC hybrid):
- Diesel vehicles increase the gap significantly (β = 3.95, p < 0.0001).
- Petrol vehicles also increase the gap significantly (β = 4.28, p < 0.0001).

Conclusion:
The percentage gap between WLTP and OBFCM fuel consumption tends to be larger 
for vehicles with higher OBFCM fuel use, for petrol or diesel vehicles, and for some high-end manufacturers. 
*/



