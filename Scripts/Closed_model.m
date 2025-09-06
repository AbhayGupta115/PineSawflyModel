clear
maxgen=5001;
N=1000; B=20; cF=0.5; cM=0.5; 
matingefficiency=linspace(1,20,100); % this can be changed to just 1 value instead of 100, to create a single run and plot it in detail
allU=nan(ceil(maxgen/100),length(matingefficiency));
allR=allU; allF=allU; allM=allU;

    for me=1:length(matingefficiency)

        % index for which column means which trait; first the females
        pf=1:2; rf=3:4; pmf=5:6; F=rand([6 N]); % pf denotes p as expressed in a female, pmf denotes p as expressed in a male but currently residing in a female genome
        
        % then the males
        pm=1; rm=2; pfm=3; M=rand([3 N]); % r of course is not expressed by males. pm denotes p as expressed in a male, pfm denotes p as expressed in a female but currently residing in a male genome
        %M(rm,:)=0.25*M(rm,:); % let's try starting with a low sex ratio

        % data will contain: u, r (as an average in the alleles in females), phenotypic male defence, phenotypic female defence
        data=nan([maxgen 4]);

        for g=1:maxgen % g stands for generations

            broods=size(F,2); % as many broods as there are females
            sexratio=size(M,2)/(size(M,2)+size(F,2)); % collect information on the proportion of males

            u=exp(-matingefficiency(me)*sexratio); % unmatedness as a function of sex ratio
            rdata=F(rf,:); pmdata=M(pm,:); pfdata=F(pf,:); % prepare data collection
            data(g,:)=[u mean(rdata(:),'omitnan') mean(pmdata(:),'omitnan') mean(pfdata(:),'omitnan')]; % collect data

            if (g-1)/100==floor((g-1)/100) % collect extra information every 100th generation
                g
                allU(floor(g/100)+1,me)=mean(data(max(1,g-4):g,1));
                allR(floor(g/100)+1,me)=mean(data(max(1,g-4):g,2));
                allM(floor(g/100)+1,me)=mean(data(max(1,g-4):g,3));
                allF(floor(g/100)+1,me)=mean(data(max(1,g-4):g,4));
            end

            % randomize for each female if she's unmated or mated
            unmated=rand([1 broods])<u;
            
            % each female creates a brood, where we need to know the number of sons produced, number of daughters produced, and the father's ID
            fecundity=round(B*(1-cF*mean(F(pf,:))));
            nof_sons=unmated.*fecundity+(1-unmated).*binornd(fecundity,mean(F(rf,:)));
            nof_daughters=fecundity-nof_sons;
            male_competitiveness=1-cM*M(pm,:); male_competitiveness(isnan(male_competitiveness))=0; % prepare data for choosing the sire
            sire=datasample(1:size(M,2),broods,'Weights',male_competitiveness);
            % now actually create the offspring
            m=nan([2 B broods]); % male offspring
            f=nan([4 B broods]); % female offspring
            survival=nan([1 broods]); % brood-specific survival will be collected here
            for i=1:broods
                if nof_sons(i)>0
                    % the next 3 lines create sons' genotypes; unidrnd takes care of Mendelian inheritance from mothers
                    m(pm,1:nof_sons(i),i)=F(pmf(1)+unidrnd(2,1,nof_sons(i))-1,i);
                    m(rm,1:nof_sons(i),i)=F(rf(1)+unidrnd(2,1,nof_sons(i))-1,i);
                    m(pfm,1:nof_sons(i),i)=F(pf(1)+unidrnd(2,1,nof_sons(i))-1,i);
                end
                if nof_daughters(i)>0
                    % the next 3 lines create daughters' genotypes; unidrnd takes care of Mendelian inheritance from mothers
                    f(pf(1),1:nof_daughters(i),i)=M(pfm,sire(i));
                    f(pf(2),1:nof_daughters(i),i)=F(pf(1)+unidrnd(2,1,nof_daughters(i))-1,i);
                    f(rf(1),1:nof_daughters(i),i)=M(rm,sire(i));
                    f(rf(2),1:nof_daughters(i),i)=F(rf(1)+unidrnd(2,1,nof_daughters(i))-1,i);
                    f(pmf(1),1:nof_daughters(i),i)=M(pm,sire(i));
                    f(pmf(2),1:nof_daughters(i),i)=F(pmf(1)+unidrnd(2,1,nof_daughters(i))-1,i);
                end
                % now that we know the brood, we can quantify its survival
                defence_sum=sum(m(pm,:,i),'omitnan')+sum(mean(f(pf,:,i)),'omitnan');
                survival(i)=double(rand(1)<0.1+0.8*(defence_sum/fecundity(i)));
            end
            % how many females are now in the next generation? If too many, we cull
            % (equivalent proportion in both male & female population)
            dd_survival=min(1,N/sum(nof_daughters.*survival));
            nsurvivormales=survival.*binornd(nof_sons,dd_survival);
            nsurvivorfemales=survival.*binornd(nof_daughters,dd_survival);
            M=nan([3 N]); indm=1;
            F=nan([6 N]); indf=1;

            % create adults based on survivors from the larval stage
            for i=1:broods
                if nsurvivormales(i)>0
                    M(:,indm:indm+nsurvivormales(i)-1)=m([pm rm pfm],1:nsurvivormales(i),i); indm=indm+nsurvivormales(i);
                end
                if nsurvivorfemales(i)>0
                    F(:,indf:indf+nsurvivorfemales(i)-1)=f([pf rf pmf],1:nsurvivorfemales(i),i); indf=indf+nsurvivorfemales(i);
                end
            end

            % mutations; we only make them now as they are in the germline
            z=log(M([pm rm pfm],:)./(1-M([pm rm pfm],:)))+0.1*randn(size(M([pm rm pfm],:)));
            M([pm rm pfm],:)=1./(1+exp(-z));
            z=log(F([pf rf pmf],:)./(1-F([pf rf pmf],:)))+0.1*randn(size(F([pf rf pmf],:)));
            F([pf rf pmf],:)=1./(1+exp(-z));

        end
        
        figure(1); 
        subplot(2,2,1); plot(matingefficiency,allU(end,:),'k.',matingefficiency,allR(end,:),'r.'); xlabel('mating efficiency');
        subplot(2,2,2); plot(matingefficiency,allM(end,:),'b.',matingefficiency,allF(end,:),'r.'); xlabel('mating efficiency');
        subplot(2,2,3); plot(matingefficiency,allU(end,:)-allU(end-1,:),'k.',matingefficiency,allR(end,:)-allR(end-1,:),'r.'); xlabel('mating efficiency');
        subplot(2,2,4); plot(matingefficiency,allM(end,:)-allM(end-1,:),'b.',matingefficiency,allF(end,:)-allF(end-1,:),'r.'); xlabel('mating efficiency');
        drawnow
        save suppl_data
    end
