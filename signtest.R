
# Binomial distribution viewer

input <- read.table(header=TRUE, text = "
Overall.Summary.Measures	Overall.OR	Absorb.II	Absorb.China	Absorb.Japan	Absorb.III
Patient-oriented.composite.endpoint	1.09	0.76	0.82	1.19	1.22
                    Device-oriented.composite.endpoint	1.22	1.42	0.8	1.1	1.28
                    30-day.target.lesion.failure	1.49	1.99	1	1.51	1.45
                    30-day.to.1-year.target.lesion.failure	0.97	0.67	0.71	0.84	1.12
                    1-year.all-cause.mortality	1.12	NA	NA	NA	2.58
                    1-year.cardiac.mortality	1.26	NA	NA	NA	4.12
                    1-year.non-cardiac.mortality	1.02	NA	NA	NA	1.8
                    1-year.myocardial.infarction.(all)	1.34	2.37	1.24	1.51	1.22
                    1-year.target.vessel.myocardial.infarction	1.45	2.24	1.99	1.51	1.31
                    1-year.nontarget.vessel.myocardial.infarction	0.75	NA	0.5	0.5	0.71
                    1-year.peri-procedural.myocardial.infarction.(Absorb.III.Definition)	1.29	2.11	1.47	1.51	1.09
                    1-year.peri-procedural.myocardial.infarction.(SCAI.definition)	0.97	0.99	NA	NA	0.78
                    1-year.non-peri-procedural.myocardial.infarction	1.48	NA	0.99	1.51	1.43
                    1-year.revascularization.(all)	1.02	0.5	0.94	1.17	1.12
                    1-year.ischemia-driven.target.lesion.revascularization	1.14	0.66	1.19	1.17	1.21
                    1-year.ischemia-driven.target.vessel.revascularization	1.14	0.5	0.77	1.3	1.36
                    1-year.device.thrombosis.(definite.or.probable)	2.09	NA	NA	1.02	2.08
                    1-year.device.thrombosis.(definite)	2.06	NA	NA	2.03	1.87
                    1-year.device.thrombosis.(probable)	2.28	NA	NA	NA	NA
                    30-day.device.thrombosis.(definite.or.probable)	1.76	NA	NA	1.51	1.46
                    30-day.to.1-year.device.thrombosis.(definite.or.probably)	4.1	NA	NA	0.51	NA
"
)

all.OR <- unlist(input[,c("Absorb.II", "Absorb.China","Absorb.Japan","Absorb.III")])
all.OR.noNA <- all.OR[!is.na(all.OR)]

success <- length(which(all.OR.noNA>1))
fail <- length(which(all.OR.noNA<1))
trials <- length(all.OR.noNA)

# Do sign test on data
binom.test(x=success, n=trials, p=0.5)
