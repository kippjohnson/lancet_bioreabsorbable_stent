
# Meta-Analyis Replication

# Clear memory
rm(list=ls())

# Required packages
library(metafor) # meta analysis
library(data.table) # data manipulation

# Read in prepared data
input <- read.table(header=TRUE, text=
"
Outcome.Measure	Study	Absorb.Events	Absorb.N	Xience.Events	Xience.N
Patient-oriented.composite.endpoint	Absorb.II	36	331	17	165
Patient-oriented.composite.endpoint	Absorb.China	19	238	23	237
Patient-oriented.composite.endpoint	Absorb.Japan	26	265	11	133
Patient-oriented.composite.endpoint	Absorb.III	184	1313	78	677
Device-oriented.composite.endpoint	Absorb.II	20	331	7	165
Device-oriented.composite.endpoint	Absorb.China	8	238	10	237
Device-oriented.composite.endpoint	Absorb.Japan	11	265	5	133
Device-oriented.composite.endpoint	Absorb.III	102	1313	41	677
30-day.target.lesion.failure	Absorb.II	16	331	4	165
30-day.target.lesion.failure	Absorb.China	3	238	3	237
30-day.target.lesion.failure	Absorb.Japan	6	265	2	133
30-day.target.lesion.failure	Absorb.III	64	1313	23	677
30-day.to.1-year.target.lesion.failure	Absorb.II	4	331	3	165
30-day.to.1-year.target.lesion.failure	Absorb.China	5	238	7	237
30-day.to.1-year.target.lesion.failure	Absorb.Japan	5	265	3	133
30-day.to.1-year.target.lesion.failure	Absorb.III	39	1313	18	677
1-year.all-cause.mortality	Absorb.II	0	331	1	165
1-year.all-cause.mortality	Absorb.China	0	238	5	237
1-year.all-cause.mortality	Absorb.Japan	2	265	0	133
1-year.all-cause.mortality	Absorb.III	15	1313	3	677
1-year.cardiac.mortality	Absorb.II	0	331	0	165
1-year.cardiac.mortality	Absorb.China	0	238	3	237
1-year.cardiac.mortality	Absorb.Japan	0	265	0	133
1-year.cardiac.mortality	Absorb.III	8	1313	1	677
1-year.non-cardiac.mortality	Absorb.II	0	331	1	165
1-year.non-cardiac.mortality	Absorb.China	0	238	2	237
1-year.non-cardiac.mortality	Absorb.Japan	2	265	0	133
1-year.non-cardiac.mortality	Absorb.III	7	1313	2	677
1-year.myocardial.infarction.(all)	Absorb.II	19	331	4	165
1-year.myocardial.infarction.(all)	Absorb.China	5	238	4	237
1-year.myocardial.infarction.(all)	Absorb.Japan	9	265	3	133
1-year.myocardial.infarction.(all)	Absorb.III	90	1313	38	677
1-year.target.vessel.myocardial.infarction	Absorb.II	18	331	4	165
1-year.target.vessel.myocardial.infarction	Absorb.China	4	238	2	237
1-year.target.vessel.myocardial.infarction	Absorb.Japan	9	265	3	133
1-year.target.vessel.myocardial.infarction	Absorb.III	79	1313	31	677
1-year.nontarget.vessel.myocardial.infarction	Absorb.II	2	331	0	165
1-year.nontarget.vessel.myocardial.infarction	Absorb.China	1	238	2	237
1-year.nontarget.vessel.myocardial.infarction	Absorb.Japan	1	265	1	133
1-year.nontarget.vessel.myocardial.infarction	Absorb.III	11	1313	8	677
1-year.peri-procedural.myocardial.infarction.(Absorb.III.Definition)	Absorb.II	17	331	4	165
1-year.peri-procedural.myocardial.infarction.(Absorb.III.Definition)	Absorb.China	3	238	2	237
1-year.peri-procedural.myocardial.infarction.(Absorb.III.Definition)	Absorb.Japan	3	265	1	133
1-year.peri-procedural.myocardial.infarction.(Absorb.III.Definition)	Absorb.III	40	1313	19	677
1-year.peri-procedural.myocardial.infarction.(SCAI.definition)	Absorb.II	2	331	1	165
1-year.peri-procedural.myocardial.infarction.(SCAI.definition)	Absorb.China	2	238	0	237
1-year.peri-procedural.myocardial.infarction.(SCAI.definition)	Absorb.Japan	0	265	0	133
1-year.peri-procedural.myocardial.infarction.(SCAI.definition)	Absorb.III	12	1313	8	677
1-year.non-peri-procedural.myocardial.infarction	Absorb.II	3	331	0	165
1-year.non-peri-procedural.myocardial.infarction	Absorb.China	2	238	2	237
1-year.non-peri-procedural.myocardial.infarction	Absorb.Japan	6	265	2	133
1-year.non-peri-procedural.myocardial.infarction	Absorb.III	50	1313	18	677
1-year.revascularization.(all)	Absorb.II	12	331	12	165
1-year.revascularization.(all)	Absorb.China	16	238	17	237
1-year.revascularization.(all)	Absorb.Japan	21	265	9	133
1-year.revascularization.(all)	Absorb.III	120	1313	55	677
1-year.ischemia-driven.target.lesion.revascularization	Absorb.II	4	331	3	165
1-year.ischemia-driven.target.lesion.revascularization	Absorb.China	6	238	5	237
1-year.ischemia-driven.target.lesion.revascularization	Absorb.Japan	7	265	3	133
1-year.ischemia-driven.target.lesion.revascularization	Absorb.III	40	1313	17	677
1-year.ischemia-driven.target.vessel.revascularization	Absorb.II	6	331	6	165
1-year.ischemia-driven.target.vessel.revascularization	Absorb.China	7	238	9	237
1-year.ischemia-driven.target.vessel.revascularization	Absorb.Japan	13	265	5	133
1-year.ischemia-driven.target.vessel.revascularization	Absorb.III	66	1313	25	677
1-year.device.thrombosis.(definite.or.probable)	Absorb.II	3	331	0	165
1-year.device.thrombosis.(definite.or.probable)	Absorb.China	1	238	0	237
1-year.device.thrombosis.(definite.or.probable)	Absorb.Japan	4	265	2	133
1-year.device.thrombosis.(definite.or.probable)	Absorb.III	20	1313	5	677
1-year.device.thrombosis.(definite)	Absorb.II	2	331	0	165
1-year.device.thrombosis.(definite)	Absorb.China	0	238	0	237
1-year.device.thrombosis.(definite)	Absorb.Japan	4	265	1	133
1-year.device.thrombosis.(definite)	Absorb.III	18	1313	5	677
1-year.device.thrombosis.(probable)	Absorb.II	1	331	0	165
1-year.device.thrombosis.(probable)	Absorb.China	1	238	0	237
1-year.device.thrombosis.(probable)	Absorb.Japan	0	265	1	133
1-year.device.thrombosis.(probable)	Absorb.III	2	1313	0	677
30-day.device.thrombosis.(definite.or.probable)	Absorb.II	2	331	0	165
30-day.device.thrombosis.(definite.or.probable)	Absorb.China	1	238	0	237
30-day.device.thrombosis.(definite.or.probable)	Absorb.Japan	3	265	1	133
30-day.device.thrombosis.(definite.or.probable)	Absorb.III	14	1313	5	677
30-day.to.1-year.device.thrombosis.(definite.or.probably)	Absorb.II	1	331	0	165
30-day.to.1-year.device.thrombosis.(definite.or.probably)	Absorb.China	0	238	0	237
30-day.to.1-year.device.thrombosis.(definite.or.probably)	Absorb.Japan	1	265	1	133
30-day.to.1-year.device.thrombosis.(definite.or.probably)	Absorb.III	6	1313	0	677
"
)

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
forest(res, slab=paste(input.subset$Study), atransf=exp)
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

