# Masters_2023_DrHannaK
## Parameters:

| **Variables**    | **Definations**                                                                           |
|:----------------:|:-----------------------------------------------------------------------------------------:|
|p<sub>f</sub>     | Initial frequency of defender allele in female/female locus                               |
|p<sub>m</sub>     | Initial frequency of defender allele in male/male locus                                   |
|C                 | Number of eggs laid by non defender females                                               |
|c                 | Number of eggs laid by defender females                                                   |
|a                 | Advantage for non defender mails in mating rate                                           |
|u                 | Probability female stays unmated                                                          |
|r                 | Sex ration (Prob of male larvae in offsprings)                                            |
|s(d)              | Function defining the probability of survival of larvae group based on number of defenders|



## Base Model:
The base model consists of two cases, Recessive and Dominant.
We have two alleles 0 (Non Defenders) and 1 (Defenders) depending on the case (R/D) 01 will be defending or not.
The males in the population are haploids and females are diploids, males are produced when a female stays unmated (with probability 'u') and a ratio of males (r) and females (1-r) are produced if the female is mated (with probability (1-u)). The offspring's genotype is based on the parents genotype. Males inherit only from the mother while females inherit 50perc from both parents.
The goal of our base model is just to find out the proportion of each type of adult from first gen to the next.

The female genotypes are: 00, 01, 11 while male genotypes are: 0 and 1. There is genetic correlation between the sexes since the same locus defines the phenotype of individuals. We also propose another mechanism which solves this correlation.

In this simplistic model we focused on analysing what would happen to the defender proportion in the sexes if we change the cost. To do the same we plotted heatmaps with cost to defender males (inc value of alpha) on y-axis and defender females (inc value of c) on x-axis.

We also plot the change in proportion of defenders with generations. To see what happens in each cell of the heatmap more clearly.

We find that in both recessive and dominant case our defender population for each sex ends up decreasing with increasing cost for that sex. But the difference in def. prop. between the sexes (Female def prop. - Male def. prop.) shows some unlikely results. In the recessive case, higher proportion of males defend than females, this is reversed in the dominant case. This pattern is observed across all the shapes of s (survivability function) but this is not what is seen in nature.

A possible reason for this could be genetic correlation between the sexes, in the recessive case, mostly 01 females are present which dont defend. This causes an overall dip in the female defender proportion. While these females do defend in the dominant case causing the defender proportion to inc.

To get rid of this correlation we decided to use another mechanism with each sex using a different locus defender allele.


## Multi Locus Model

In this model we have different locii for each sex, though they still carry the alleles for the other sex (inactive).

This increases the number of genotypes, females: 00, 01, 02, 10, 11, 12, 20, 21, 22 and males: 00, 01, 10, 11
Here the first number is the sum of alleles in first locus (active in females) and second in the second locus (sctive in males), so 0: 00,0, 1: 01,10,1, 2:11

The proportion of alele 1 in female locus is given by p<sub>f</sub> and in male locus by p<sub>m</sub>, so the frequency of each genotype given p<sub>f</sub> and p<sub>m</sub> in females is:
| **M. Locus\F. Locus** | **00**                           | **01**                                    | **11**                       |
|:---------------------:|:--------------------------------:|:-----------------------------------------:|:----------------------------:|
| **00**                | (1 - p<sub>f</sub><sup>2</sup>) * (1 - p<sub>m</sub><sup>2</sup>)          | (2 * p<sub>f</sub> * (1 - p<sub>f</sub>)) * (1 - p<sub>m</sub><sup>2</sup>)          | (p<sub>f</sub><sup>2</sup>) * (1 - p<sub>m</sub><sup>2</sup>)          |
| **01**                | (1 - p<sub>f</sub><sup>2</sup>) * (2 * p<sub>m</sub> * (1 - p<sub>m</sub>)) | (2 * p<sub>f</sub> * (1 - p<sub>f</sub>)) * (2 * p<sub>m</sub> * (1 - p<sub>m</sub>)) | (p<sub>f</sub><sup>2</sup>) * (2 * p<sub>m</sub> * (1 - p<sub>m</sub>)) |
| **11**                | (1 - p<sub>f</sub><sup>2</sup>) * (p<sub>m</sub><sup>2</sup>)              | (2 * p<sub>f</sub> * (1 - p<sub>f</sub>)) * (p<sub>m</sub><sup>2</sup>)              | (p<sub>f</sub><sup>2</sup>) * (p<sub>m</sub><sup>2</sup>)              |

and in males is:
| **M. Locus\F. Locus**| **0**                                    | **1**                                |
|:--------------------:|:----------------------------------------:|:------------------------------------:|
| **0**                | (1 - p<sub>f</sub>) * (1 - p<sub>m</sub>)| (p<sub>f</sub>) * (1 - p<sub>m</sub>)|
| **1**                | (1 - p<sub>f</sub>) * (p<sub>m</sub>)    | (p<sub>f</sub>) * (p<sub>m</sub>)    |

Following this we programmed all the interactions based on the parameters and plotted the heatmaps,
The results again showed a logical pattern in Male and Female def prop with each decresing as cost of that sex inc. The overall pattern of difference also showed higher female prop with high male cost and higher male prop with higher female cost, much like what we see in nature. The data was similar across both dominant and recessive case.

So ridding the model of genetic corellation gave us the desired results, next steps would be to see how the def. prop. are affected with change in r and u, this would affect the amount of males present in single sex broods and mix sex broods. Empirically we know that females defend less in male biased broods, this will be checked via this analysis.

## Repo navigation

Data: It contains all the CSVs and any other files generated by the scripts
outputs: It contains all the figures
Scripts: Contains all the scripts used to run or analyse the simulations

## Rest

Current analysis present in the files:
 - Proportion v/s Generation Time : For each case (Recessive and Dominant) we find the proportion of defenders in males and in females, we are also plotting the proportion of each genotype in the population.
 - Heatmap of proportion of defenders : We plot a heatmap with varying costs for defenders, each square represents the difference in proportion of Female and Male defenders. The annotations represent the size of total defender population.

Interesting stuff:
 - With a very low value of 'c' (= 1), we end up observing oscillations in the population, as we increase 'a' the oscillations start to go away.
 ![Oscillation GenPlot with c = 1 and a = 2](https://github.com/AbhayGupta115/Masters_2023_DrHannaK/blob/c14976c683fc1f6b573fcde909ccf664c4363840/outputs/GenPlot_c1_a2.png)
 - For dominant case, Female defenders proportion >= Male defenders proportion
 - For recessive case, Male defenders proportion >= Female defenders proportion
 - Possible reason could be that that in recessive since only x11 is contributing to female defender population, it is always lower than x01  most of the time.

Stuff to do:
 - [x] Find an appropriate value for u and r; the population of male and females should be comparable, otherwise the heatmap will always be skewed. One option is use u=0, r=0.5, but this removes the whole non mating set, alternative required. (Seems as if difference between u=0.0 and u=0.1 with scaled r is not very different).
 - [x] For u > 0, the population seems to become somewhat male biased. Could be used to try different bias in populations.
 - [x] Optimise the mating functions, triple loops are not efficient at all and extremely slow.
 - [] Change the endpoints of survival function? Maybe between 0.3 and 0.9 or something similar. So that non defenders have a bit more survival chance.
 - []

 # References (For thesis)
 - Davies, N.G., Ross, L. and Gardner, A. (2016), The ecology of sex explains patterns of helping in arthropod societies. Ecol Lett, 19: 862-872. https://doi.org/10.1111/ele.12621 {Larvae don't reproduce while they are larvae, but they do have reproductive value because they might survive to an age at which they are able to reproduce. So the Gardner Ross / Davies et al effect does appear to readily apply to this life history stage}
 - A. Gardner, L. Ross, Haplodiploidy, Sex-Ratio Adjustment, and Eusociality. Am. Nat. 181, 455 E60–E67 (2013). {Sex Ratio adjustment and the costs associated with it, with different amount of benefit to the population by each sex and how defender population changes because of it.}
 - Lots by Carita Lindstedt
