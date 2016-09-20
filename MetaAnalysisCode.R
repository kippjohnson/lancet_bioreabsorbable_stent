
# Meta-Analyis Replication
# Kipp W. Johnson
# kipp -dot- johnson -at- icahn -dot- mssm -dot- edut

# Clear memory
rm(list=ls())

# Required packages
library(metafor) # meta analysis
library(data.table) # data manipulation

# Read in prepared data
input <- read.csv("~/Projects/lancet_bioreabsorbable_stent/data/odds_ratios.csv")

###
### Random effects model
###

outcomes <- unique(input$Outcome.Measure)
input.dt <- as.data.table(input)

effect.store <- as.data.frame(matrix(NA, nrow=0, ncol=5))
colnames(effect.store) <- c("measure", "zval","pval","I2","H2")

# Loop over all of the studied outcomes
for(i in 1:length(outcomes)){
input.subset <- input.dt[Outcome.Measure==outcomes[i]]

es <- escalc(measure="RR", ai=Absorb.Events,
                           bi=Absorb.N-Absorb.Events,
                           ci=Xience.Events,
                           di=Xience.N-Xience.Events,
                          n1i=Absorb.N,
                          n2i=Xience.N,
                         data=input.subset)

res <- rma.uni(yi, vi, data=es, method="REML")

  # Plot results
  pdf(paste0("~/Dropbox/dudleylab/bioreabsorbable.stents/RandomEffectsPlots/plot_",sprintf("%02d", i),"_",outcomes[i],".pdf"))
  forest(res, slab=paste(gsub("\\.", " ", input.subset$Study)), atransf=exp)
  text(0, 5.2, paste("Random Effects Model", paste0(i,":"), gsub("\\.", " ", input.subset$Outcome.Measure), sep=" "))
  text(-1,7.2, paste0("Z value: ", round(res$zval, digits=3)))
  text(-1,6.9, paste0("P value: ", round(res$pval, digits=3)))
  text(-1,6.6, paste0("I^2: ", round(res$I2, digits=3)))
  text(-1,6.3, paste0("H^2: ", round(res$zval, digits=3)))
  dev.off()

  results <- data.frame(outcomes[i], res$zval, res$pval, res$I2, res$H2)
  names(results) <- c("measure", "zval","pval","I2","H2")
  effect.store <- rbind(effect.store, results)
}

random.effect.store <- effect.store

###
### Fixed effects model
###

effect.store <- as.data.frame(matrix(NA, nrow=0, ncol=5))
colnames(effect.store) <- c("measure", "zval","pval","I2","H2")

# Loop over all of the studied outcomes
for(i in 1:length(outcomes)){

  input.subset <- input.dt[Outcome.Measure==outcomes[i]]

  es <- escalc(measure="RR", ai=Absorb.Events,
               bi=Absorb.N-Absorb.Events,
               ci=Xience.Events,
               di=Xience.N-Xience.Events,
               n1i=Absorb.N,
               n2i=Xience.N,
               data=input.subset
              )

  res <- rma.uni(yi, vi, data=es, method="FE")

  # Plot results
  pdf(paste0("~/Dropbox/dudleylab/bioreabsorbable.stents/FixedEffectsPlots/plot_",sprintf("%02d", i),"_",outcomes[i],".pdf"))
  forest(res, slab=paste(gsub("\\.", " ", input.subset$Study)), atransf=exp)
  text(0, 5.2, paste("Fixed Effects Model", paste0(i,":"), gsub("\\.", " ", input.subset$Outcome.Measure), sep=" "))
  text(-1,7.2, paste0("Z value: ", round(res$zval, digits=3)))
  text(-1,6.9, paste0("P value: ", round(res$pval, digits=3)))
  text(-1,6.6, paste0("I^2: ", round(res$I2, digits=3)))
  text(-1,6.3, paste0("H^2: ", round(res$zval, digits=3)))
  dev.off()

  results <- data.frame(outcomes[i], res$zval, res$pval, res$I2, res$H2)
  names(results) <- c("measure", "zval","pval","I2","H2")
  effect.store <- rbind(effect.store, results)
}

fixed.effect.store <- effect.store

