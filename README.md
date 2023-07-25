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

### Introduction:
In our base model, we explore two cases: Recessive and Dominant, with two alleles 0 (Non-Defenders) and 1 (Defenders). The presence of allele 01 determines whether an individual will defend or not based on their genotype (R/D). We consider haploid males and diploid females. Males arise when a female remains unmated with a probability 'u', and if mated (with probability 1-u), the offspring ratio is 'r' males and '1-r' females. Offspring genotype is determined by their parents' genotypes. Males only inherit from their mother, while females inherit 50% from each parent. Our primary focus is to determine the proportion of each type of adult from one generation to the next.

### Genotypes:
Females have three genotypes: 00, 01, and 11, while males have two genotypes: 0 and 1. A genetic correlation exists between the sexes since the same locus influences individuals' phenotypes. To address this correlation, we propose an alternative mechanism.

### Investigating the Effect of Cost on Defender Proportions:
We explore the influence of defender cost, represented by the parameter 'alpha', on defender proportions in both sexes. We construct heatmaps with 'alpha' on the y-axis for males and 'c' (cost to female defenders) on the x-axis. These heatmaps illustrate changes in defender proportions with each generation, enabling us to observe trends in each cell more clearly.

### Results:
In both the recessive and dominant cases, we observe a decrease in defender proportions with increasing cost for each sex. However, we find a notable disparity in defender proportions between the sexes. In the recessive case, a higher proportion of males defend compared to females, while this pattern reverses in the dominant case. Such a discrepancy contradicts real-world observations, prompting us to investigate the underlying reasons.

### Possible Explanation: Genetic Correlation:
The presence of mostly 01 females in the recessive case leads to a decline in overall female defender proportions. As these females do not defend, it impacts the overall proportion of female defenders. In contrast, the presence of defending 01 females in the dominant case leads to an increase in the proportion of female defenders.

### Addressing Genetic Correlation:
To mitigate this genetic correlation between the sexes, we propose an alternate mechanism. Each sex will use a different locus for the defender allele. By employing distinct loci for male and female defender alleles, we aim to uncouple the genetic correlation, leading to more realistic defender proportions in both sexes.

### Conclusion:
Our study highlights the importance of considering genetic correlation when modeling allele-dependent defense strategies. The observed disparity in defender proportions between sexes in our base model emphasizes the need for a more refined approach to achieve a more accurate representation of real-world scenarios. By adopting a mechanism with separate loci for male and female defenders, we strive to overcome genetic correlation and enhance the robustness of our model. Further investigations using this modified approach may provide valuable insights into the dynamics of defender proportions in natural populations.

## Multi Locus Model

### Introduction:
In our previous model, we encountered a genetic correlation issue between sexes, which led to discrepancies in defender proportions in the recessive and dominant cases. To overcome this limitation, we introduce an alternative mechanism employing distinct loci for male and female defender alleles, eliminating the inactive alleles from each sex. This modification increases the number of genotypes, and the proportion of allele 1 in the female locus is represented by p<sub>f</sub>, while in the male locus, it is represented by p<sub>m</sub>. By exploring the frequency of each genotype given p<sub>f</sub> and p<sub>m</sub> in both sexes, we aim to investigate the impact of this novel approach on defender proportions.

### Genotype Frequency Calculations:
For females, we calculate the genotype frequency table based on p<sub>f</sub> and p<sub>m</sub>. The table outlines the frequencies of genotypes resulting from combinations of alleles at the female and male loci.
| **M. Locus\F. Locus** | **00**                           | **01**                                    | **11**                       |
|:---------------------:|:--------------------------------:|:-----------------------------------------:|:----------------------------:|
| **00**                | (1 - p<sub>f</sub><sup>2</sup>) * (1 - p<sub>m</sub><sup>2</sup>)          | (2 * p<sub>f</sub> * (1 - p<sub>f</sub>)) * (1 - p<sub>m</sub><sup>2</sup>)          | (p<sub>f</sub><sup>2</sup>) * (1 - p<sub>m</sub><sup>2</sup>)          |
| **01**                | (1 - p<sub>f</sub><sup>2</sup>) * (2 * p<sub>m</sub> * (1 - p<sub>m</sub>)) | (2 * p<sub>f</sub> * (1 - p<sub>f</sub>)) * (2 * p<sub>m</sub> * (1 - p<sub>m</sub>)) | (p<sub>f</sub><sup>2</sup>) * (2 * p<sub>m</sub> * (1 - p<sub>m</sub>)) |
| **11**                | (1 - p<sub>f</sub><sup>2</sup>) * (p<sub>m</sub><sup>2</sup>)              | (2 * p<sub>f</sub> * (1 - p<sub>f</sub>)) * (p<sub>m</sub><sup>2</sup>)              | (p<sub>f</sub><sup>2</sup>) * (p<sub>m</sub><sup>2</sup>)              |


Similarly, we perform genotype frequency calculations for males, illustrating the frequencies of genotypes resulting from combinations of alleles at the male and female loci.
| **M. Locus\F. Locus**| **0**                                    | **1**                                |
|:--------------------:|:----------------------------------------:|:------------------------------------:|
| **0**                | (1 - p<sub>f</sub>) * (1 - p<sub>m</sub>)| (p<sub>f</sub>) * (1 - p<sub>m</sub>)|
| **1**                | (1 - p<sub>f</sub>) * (p<sub>m</sub>)    | (p<sub>f</sub>) * (p<sub>m</sub>)    |


### Results:
Upon implementing the alternative mechanism, we plot heatmaps to visualize defender proportions with increasing cost to male (alpha) and female (c) defenders. Notably, in both the recessive and dominant cases, we observe a logical pattern where defender proportions in both sexes decrease with rising costs for each respective sex. Additionally, the overall pattern of differences demonstrates that higher female defender proportions are associated with higher male costs, while higher male defender proportions are linked to higher female costs. This aligns more closely with real-world observations and is consistent across both the dominant and recessive cases.

### Advantages of the Alternative Mechanism:
The removal of genetic correlation between sexes through distinct loci for defender alleles has provided more realistic results, which better reflect natural defense dynamics. By increasing the number of genotypes and explicitly accounting for active alleles in each sex, we achieved a more accurate representation of defender proportions in the population.

### Future Directions:
With the genetic correlation-free model established, further investigations can explore the effects of varying 'r' (the proportion of males produced) and 'u' (the probability of females remaining unmated) on defender proportions. By examining how these parameters impact the number of males present in single-sex and mixed-sex broods, we can validate empirically observed trends where females tend to defend less in male-biased broods.

### Conclusion:
Our alternative mechanism, which employs separate loci for male and female defender alleles while eliminating inactive alleles, successfully eliminates genetic correlation and improves the accuracy of defender proportion predictions. The logical pattern observed in defender proportions with varying costs for each sex provides a promising avenue for investigating the effects of 'r' and 'u' on defense strategies in different brood compositions. By continuing to refine our model, we aim to gain deeper insights into the complexities of allele-dependent defense strategies in natural populations.

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
