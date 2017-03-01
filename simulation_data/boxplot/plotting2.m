clc;clear

filePattern = fullfile(pwd,'*.mat');
simulationData = dir(filePattern);
for k = 1:length(simulationData)
    baseFileName = simulationData(k).name;
    baseFileName = baseFileName(1:end-4);
    data = load(baseFileName);
    v = genvarname(baseFileName, who);
    eval([v '= data.gospa_vals;']);
end

x = '_30_75';
glmb = eval(strcat('glmb',x));
glmb_joint = eval(strcat('glmb_joint',x));
lmb = eval(strcat('lmb',x));
pmbm = eval(strcat('pmbm',x));
pmbm_recycle = eval(strcat('pmbm_recycle',x));
pmb_lbp = eval(strcat('pmb_lbp',x));
pmb_lbp_recycle = eval(strcat('pmb_lbp_recycle',x));
pmb_murty = eval(strcat('pmb_murty',x));
pmb_murty_recycle = eval(strcat('pmb_murty_recycle',x));

figure
for i = 1:4
    g = subplot(2,2,i);
    p = get(g,'position');
    p(4) = p(4)*1.10;
    p(3) = p(3)*1.10;
    set(g, 'position', p);
    load('/Users/xiayuxuan/Documents/MATLAB/Master thesis/v1.2/simulation_data/30_75');
    case_a = extractData(i,glmb,glmb_joint,lmb,pmbm,pmbm_recycle,...
        pmb_lbp_recycle,pmb_murty_recycle);
    boxplot(case_a,'position',x([1,2,3,4,5,7,9]),'ColorGroup',...
        {'y','m','c','r','g','b','k'},'PlotStyle','compact')
    switch i
        case 1 
            ylabel('MGOSPA (Total)')
        case 2
            ylabel('MGOSPA (Loc)')
        case 3
            ylabel('MGOSPA (Missed)')
        case 4
            ylabel('MGOSPA (False)')
    end
    xlabel('time (s)')
    grid on
    set(gca,'XScale', 'log','XTickLabel',{' '},'XTickMode','auto',...
        'XTickLabelMode','auto','XLimMode','auto' )
end


function case_a = extractData(i,glmb,glmb_joint,lmb,pmbm,pmbm_recycle,...
    pmb_lbp_recycle,pmb_murty_recycle)
case_a = zeros(200,7);
case_a(:,1) = squeeze(mean(glmb(:,i,:),1));
case_a(:,2) = squeeze(mean(glmb_joint(:,i,:),1));
case_a(:,3) = squeeze(mean(lmb(:,i,:),1));
case_a(:,4) = squeeze(mean(pmbm(:,i,:),1));
case_a(:,5) = squeeze(mean(pmbm_recycle(:,i,:),1));
% case_a(:,6) = squeeze(mean(pmb_lbp(:,1,:),1));
case_a(:,6) = squeeze(mean(pmb_lbp_recycle(:,i,:),1));
% case_a(:,8) = squeeze(mean(pmb_murty(:,1,:),1));
case_a(:,7) = squeeze(mean(pmb_murty_recycle(:,i,:),1));
end

