# Pine Sawfly Model

## The Problem
In our model, we aim to capture the chemical defense behavior of Pine Sawfly larvae, which have evolved a unique mechanism to survive predator attacks. These larvae regurgitate a distasteful and irritating liquid (they puke) when threatened, deterring potential predators such as birds or ants. To increase their chances of survival, the larvae exhibit group living behavior, where not all individuals need to defend to protect the entire group from an attack. This could potentially create a disparity between the fitness of defender and non-defender larvae [3].

Adding to the complexity of the system, Pine Sawfly larvae show haplodiploidy, where females are diploid, and males are haploid. This leads to an intriguing relatedness structure within broods, as sisters are more closely related to each other than to their brothers. Due to this asymmetry, the females in a brood are expected to defend more frequently. Hamilton's equation, rb - c > 0, where r represents relatedness, b denotes benefit, and c signifies cost, suggests that the defense behavior is favored when the benefit of saving a related individual exceeds the cost. As a result, females tend to defend more, as the benefit of protecting another sister outweighs the cost. This prediction aligns with empirical observations. Conversely, in a male-biased group, females are less related to their brothers, leading to reduced defense behavior in line with observed patterns in real-world scenarios. By capturing these dynamics, our model aims to provide valuable insights into the mechanisms driving defense strategies in Pine Sawfly larvae, offering a deeper understanding of their survival strategies in the face of predation.



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

#### Introduction:
In our base model, we explore two cases: Recessive and Dominant, with two alleles 0 (Non-Defenders) and 1 (Defenders). The presence of allele 01 determines whether an individual will defend or not based on their genotype (R/D). We consider haploid males and diploid females. Males arise when a female remains unmated with a probability 'u', and if mated (with probability 1-u), the offspring ratio is 'r' males and '1-r' females. Offspring genotype is determined by their parents' genotypes. Males only inherit from their mother, while females inherit 50% from each parent. Our primary focus is to determine the proportion of each type of adult from one generation to the next.

#### Genotypes:
Females have three genotypes: 00, 01, and 11, while males have two genotypes: 0 and 1. A genetic correlation exists between the sexes since the same locus influences individuals' phenotypes. To address this correlation, we propose an alternative mechanism later on.

#### Investigating the Effect of Cost on Defender Proportions:
We explore the influence of defender cost, represented by the parameter 'alpha', on defender proportions in both sexes. We construct heatmaps with 'alpha' on the y-axis for males and 'c' (cost to female defenders) on the x-axis. These heatmaps illustrate changes in defender proportions with each generation, enabling us to observe trends in each cell more clearly.

#### Results:
In both the recessive and dominant cases, we observe a decrease in defender proportions with increasing cost for each sex. However, we find a notable disparity in defender proportions between the sexes. In the recessive case, a higher proportion of males defend compared to females, while this pattern reverses in the dominant case. Such a discrepancy contradicts real-world observations, prompting us to investigate the underlying reasons.

Below are the heatmaps, the costs of each sex increase as we move along the axes (Male cost on y-axis, Female on x-axis), Each column shows us what shape of survival function is being used and each row shows female defender proportion, male defender proportion and difference in defender proportion (Female - Male) respectively.

Recessive Case:
![Change in defender proportion with increasing costs. u = 0.1, r = 0.475, DOMINANT = False](https://github.com/AbhayGupta115/PineSawflyModel/blob/6067db961b2c9da56df1e5cbae0f1fca3cc9bb5d/outputs/BM_prop_def_recessive.png)

Dominant Case:
![Change in defender proportion with increasing costs. u = 0.1, r = 0.475, DOMINANT = True](https://github.com/AbhayGupta115/PineSawflyModel/blob/6067db961b2c9da56df1e5cbae0f1fca3cc9bb5d/outputs/BM_prop_def_dominant.png)

#### Possible Explanation: Genetic Correlation:
The presence of mostly 01 females in the recessive case leads to a decline in overall female defender proportions. As these females do not defend, it impacts the overall proportion of female defenders. In contrast, the presence of defending 01 females in the dominant case leads to an increase in the proportion of female defenders.

#### Addressing Genetic Correlation:
To mitigate this genetic correlation between the sexes, we propose an alternate mechanism. Each sex will use a different locus for the defender allele. By employing distinct loci for male and female defender alleles, we aim to uncouple the genetic correlation, leading to more realistic defender proportions in both sexes.

#### Conclusion:
Our study highlights the importance of considering genetic correlation when modeling allele-dependent defense strategies. The observed disparity in defender proportions between sexes in our base model emphasizes the need for a more refined approach to achieve a more accurate representation of real-world scenarios. By adopting a mechanism with separate loci for male and female defenders, we strive to overcome genetic correlation and enhance the robustness of our model. Further investigations using this modified approach may provide valuable insights into the dynamics of defender proportions in natural populations.




## Multi Locus Model

#### Introduction:
In our previous model, we encountered a genetic correlation issue between sexes, which led to discrepancies in defender proportions in the recessive and dominant cases. To overcome this limitation, we introduce an alternative mechanism employing distinct loci for male and female defender alleles, eliminating the inactive alleles from each sex. This modification increases the number of genotypes, and the proportion of allele 1 in the female locus is represented by p<sub>f</sub>, while in the male locus, it is represented by p<sub>m</sub>. By exploring the frequency of each genotype given p<sub>f</sub> and p<sub>m</sub> in both sexes, we aim to investigate the impact of this novel approach on defender proportions.

#### Genotype Frequency Calculations:
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


#### Results:
Upon implementing the alternative mechanism, we plot heatmaps to visualize defender proportions with increasing cost to male (alpha) and female (c) defenders. Notably, in both the recessive and dominant cases, we observe a logical pattern where defender proportions in both sexes decrease with rising costs for each respective sex. Additionally, the overall pattern of differences demonstrates that higher female defender proportions are associated with higher male costs, while higher male defender proportions are linked to higher female costs. This aligns more closely with real-world observations and is consistent across both the dominant and recessive cases.

The heatmaps are as follows, structure is the same as the heatmaps in the previous model,

Recessive Case:
![Change in defender proportion with increasing costs. u = 0.1, r = 0.475, DOMINANT = False](https://github.com/AbhayGupta115/Masters_2023_DrHannaK/blob/b25f8f7db2e9ae74477baddd70a5f2b756b23e62/outputs/ML_prop_def_recessive.png)

Dominant Case:
![Change in defender proportion with increasing costs. u = 0.1, r = 0.475, DOMINANT = True](https://github.com/AbhayGupta115/Masters_2023_DrHannaK/blob/b25f8f7db2e9ae74477baddd70a5f2b756b23e62/outputs/ML_prop_def_dominant.png)


Following this we explored the impact of varying sex ratios on defender populations by continuously varying 'r' (proportion of males produced) and 'u' (probability of females remaining unmated). Increasing 'r' led to more males in mixed-sex broods, causing females to defend less due to reduced relatedness with male siblings, resulting in a rise in male defender proportions. Similarly, higher 'u' increased male-only broods, elevating male defender proportions. These results align with empirical observations, showcasing the model's effectiveness in simulating realistic defense dynamics and highlighting the crucial role of sex ratios in shaping defense strategies in natural populations.

Here we only plotted the heatmaps for the simplest shape of s(d) function, ie, linear with c = 8 and a = 2.58 (similar costs to both males and females). We show both the Recessive and Dominant case side by side.
![Change in defender proportion with change in sex ratio. c = 8, a = 2.58, SHAPE = linear](https://github.com/AbhayGupta115/Masters_2023_DrHannaK/blob/b25f8f7db2e9ae74477baddd70a5f2b756b23e62/outputs/ML_prop_def_changeSR_linear.png)

#### Advantages of the Alternative Mechanism:
The removal of genetic correlation between sexes through distinct loci for defender alleles has provided more realistic results, which better reflect natural defense dynamics. By increasing the number of genotypes and explicitly accounting for active alleles in each sex, we achieved a more accurate representation of defender proportions in the population.

#### Conclusion:
Our alternative mechanism, which employs separate loci for male and female defender alleles while eliminating inactive alleles, successfully eliminates genetic correlation and improves the accuracy of defender proportion predictions. The logical pattern observed in defender proportions with varying costs for each sex provides a promising avenue for investigating the effects of 'r' and 'u' on defense strategies in different brood compositions. By continuing to refine our model, we aim to gain deeper insights into the complexities of allele-dependent defense strategies in natural populations.

# Repo navigation

- Data: It contains all the CSVs and any other files generated by the scripts
- outputs: It contains all the figures
- Scripts: Contains all the scripts used to run or analyse the simulations


# References (For thesis)
- Davies, N.G., Ross, L. and Gardner, A. (2016), The ecology of sex explains patterns of helping in arthropod societies. Ecol Lett, 19: 862-872. https://doi.org/10.1111/ele.12621 {Larvae don't reproduce while they are larvae, but they do have reproductive value because they might survive to an age at which they are able to reproduce. So the Gardner Ross / Davies et al effect does appear to readily apply to this life history stage} [1]
- A. Gardner, L. Ross, Haplodiploidy, Sex-Ratio Adjustment, and Eusociality. Am. Nat. 181, 455 E60–E67 (2013). {Sex Ratio adjustment and the costs associated with it, with different amount of benefit to the population by each sex and how defender population changes because of it.} [2]
- Lindstedt Carita, Miettinen Antti, Freitak Dalial, Ketola Tarmo, López-Sepulcre Andres, Mäntylä Elina and Pakkanen Hannu 2018 Ecological conditions alter cooperative behaviour and its costs in a chemically defended sawflyProc. R. Soc. B.2852018046620180466
http://doi.org/10.1098/rspb.2018.0466 [3]
- West, S.A., Cooper, G.A., Ghoul, M.B. et al. Ten recent insights for our understanding of cooperation. Nat Ecol Evol 5, 419–430 (2021). https://doi.org/10.1038/s41559-020-01384-x [4]
- Laura Ross, Andy Gardner, Nate Hardy, Stuart A. West, Ecology, Not the Genetics of Sex Determination, Determines Who Helps in Eusocial Populations, Current Biology, Volume 23, Issue 23, 2013, Pages 2383-2387, ISSN 0960-9822, https://doi.org/10.1016/j.cub.2013.10.013. [5]
- Pureswaran, D.S., Roques, A. & Battisti, A. Forest Insects and Climate Change. Curr Forestry Rep 4, 35–50 (2018). https://doi.org/10.1007/s40725-018-0075-6 [6] 
