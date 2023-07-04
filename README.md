# Masters_2023_DrHannaK
## Parameters:
 - p : Initial frequency of defender allele
 - q : Frequency of non defenders
 - C : Number of eggs laid by non defender females
 - c : Number of eggs laid by defender females
 - a : Advantage for non defender mails in mating rate
 - u : Probability female stays unmated
 - r : Sex ration (Prob of male larvae in offsprings)
 - s : Function defining the probability of survival of larvae group based on number of defenders

## Base Model:
The base model consists of two cases, Recessive and Dominant.
We have two alleles 0 (Non Defenders) and 1 (Defenders) depending on the case 01 will be defending or not.
The males in the population are haploids and females are diploids, males are produced when a female stays unmated and a ratio of males and females are produced if the female is mated. The offsprings genotype is based on the parents genotype.
The goal of our base model is just to find out the proportion of each type of adult from first gen to the next.

Current analysis present in the files:
 - Proportion v/s Generation Time : For each case (Recessive and Dominant) we find the proportion of defenders in males and in females, we are also plotting the proportion of each genotype in the population.
 - Heatmap of proportion of defenders : We plot a heatmap with varying costs for defenders, each square represents the difference in proportion of Female and Male defenders. The annotations represent the size of total defender population.

Interesting stuff:
 - With a very low value of 'c' (= 1), we end up observing oscillations in the population, as we increase 'a' the oscillations start to go away.
 ![Oscillation GenPlot with c = 1 and a = 2](https://github.com/AbhayGupta115/Masters_2023_DrHannaK/blob/c14976c683fc1f6b573fcde909ccf664c4363840/outputs/GenPlot_c1_a2.png)
 - For dominant case, Female defenders >= Male defenders
 - For recessive case, Male defenders >= Female defenders

Stuff to do:
 - [x] Find an appropriate value for u and r; the population of male and females should be comparable, otherwise the heatmap will always be skewed. One option is use u=0, r=0.5, but this removes the whole non mating set, alternative required. (Seems as if difference between u=0.0 and u=0.1 with scaled r is not very different).
 - [x] For u > 0, the population seems to become somewhat male biased. Could be used to try different bias in populations.
 - [x] Optimise the mating functions, triple loops are not efficient at all and extremely slow.

 # References (For thesis)
 - Davies, N.G., Ross, L. and Gardner, A. (2016), The ecology of sex explains patterns of helping in arthropod societies. Ecol Lett, 19: 862-872. https://doi.org/10.1111/ele.12621 {Larvae don&#39;t reproduce while they are larvae, but they do have reproductive value because they might survive to an age at which they are able to reproduce. So the Gardner &amp; Ross / Davies et al effect does appear to readily apply to this life history stage}
 - A. Gardner, L. Ross, Haplodiploidy, Sex-Ratio Adjustment, and Eusociality. Am. Nat. 181, 455 E60–E67 (2013). {Sex Ratio adjustment and the costs associated with it, with different amount of benefit to the population by each sex and how defender population changes because of it.}
 - Lots by Carita Lindstedt
