# Stochastic community assembly model

This repository implements a simple stochastic community assembly model based on birth–death dynamics with colonization from a regional species pool.

The model tracks species presence and abundance through time and shows how community composition emerges from basic ecological processes.

## Model

At each time step:

- **Colonization**: species from a regional pool can enter the local community with probability c  
- **Birth**: individuals reproduce with rate b  
- **Death**: individuals die with rate d  

Community dynamics are therefore driven by the balance between colonization, local population growth, and extinction.

## Implementation

The model is simulated in discrete time using stochastic updates.

Species are tracked individually, and community composition is updated at each time step based on probabilistic transitions.

## Output

The simulation produces:

- time series of species richness  
- abundance trajectories  
- final community composition  

## Requirements

```r
install.packages(c("ggplot2", "dplyr"))
