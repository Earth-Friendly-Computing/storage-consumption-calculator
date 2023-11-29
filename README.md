# Data Storage Consumption Calculator


Author:  
Eric T. Dawson  
November 2023


## Intro
This is a small script for calculating the amount of energy used while storing a specific amount of data in various units.


## Running the applet

This repository can be cloned and run with R Shiny:

```bash
git clone --recursive https://github.com/edawson/storage-consumption-calculator.git

cd storage-consumption-calculator
```

There are two calculator apps at present:
- data-energy-calculator.R : A calculator that estimates the amount of energy
required to store a given amount of data over a set timeframe.
- patent-life-history.R : A calculator that calculates the total energy consumption
associated with a simulated life history of a healthcare patient.

To run, open the calculator you want in RStudio and click "run app" in the upper-right hand corner.

Estimates for disk energy utilization are drawn from: https://www.cloudcarbonfootprint.org/docs/methodology/#storage



## Wish list
- [ ] Add tape to the disk type radio list
- [ ] Add a slider to select among drive densities and wattages
- [ ] Add a slider for disk utilization (disks are rarely, if ever, 100% filled)
- [ ] implement logic for NAS, data center, and hyperscale storage utilization multipliers

## Citation

```
```

## License

MIT
