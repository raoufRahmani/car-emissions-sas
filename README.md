# Fuel Consumption and CO₂ Emissions – SAS Analysis
This project examines how fuel consumption and CO₂ emissions differ across car manufacturers and fuel types, using data from the European Environment Agency. 
It also compares two testing methods: WLTP (laboratory test) and OBFCM (real-world test). The analysis was conducted using SAS and explores which brands pollute more,
which fuel types produce higher emissions, and how fuel consumption affects CO₂ emissions.

## Project Files

- `2023_Cars_Aggregated(1).csv`: Dataset downloaded from European Environment Agency (EEA)
- `Emissions.sas`: SAS code for data exploration and summary statistics.
- `Correlation and Regression.sas`: SAS code for correlation and linear regression analysis.
- `parameter_estimates.xls`: Regression results table.
- `Outputs/`: Folder with screenshots and tables exported from SAS.
  Key Note : large WLTP-OBCFM gaps means that the lab results of emissions and emissions after use are very different

## Summary of Results

- Fuel consumption and CO2 emissions are very closely linked (correlation above 0.99). This means that the higher a car’s fuel consumption, the more pollution it produces.
- The percentage gap between the two tests is larger for low-emission vehicles and smaller for high-emission vehicles.
- Hybrid cars have very lowe CO₂ emissions (about 35 g/km), while diesel and petrol cars emit more (157.6 and 171.9 g/km, respectively).
- Brands like GEELY, TOYOTA, and RENAULT are among the most efficient.
- High-end brands such as BUGATTI, ROLLS ROYCE, and LAMBORGHINI have the highest fuel consumption and emissions.

## Regression Insights

- OBFCM fuel consumption is a significant predictor of the WLTP–OBFCM percentage gap. Higher OBFCM consumption leads to a larger gap.
- Diesel vehicles have larger gaps compared to Petrol cars.
- Some manufacturers significantly affect the gap: BENTLEY, AUDI SPORT, and ROLLS ROYCE increase it, while BUGATTI, IVECO, and ALPINE reduce it.

## Conclusions and Suggestions

- Diesel vehicles are the most environmentally friendly comparing to Petrol cars.
- Luxury manufacturers should work on reducing the difference between lab results and real-world performance.
- Policymakers can use OBFCM data to better monitor real emissions and update environmental standards.
- Manufacturers with large WLTP–OBFCM gaps should investigate the causes and improve vehicle efficiency.

