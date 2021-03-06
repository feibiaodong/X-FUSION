clc;clear
dbstop if error

numTrial = 200;
K = 101;
% GOSPA parameters
gospa_p= 1;
gospa_c= 100;
gospa_alpha= 2;
gospa_vals= zeros(K,4,numTrial);

model= gen_model2(0.75,30);
load('truth2_30_75');
load('meas2_30_75');

% time = zeros(numTrial,1);


parfor trial = 1:numTrial
    
%     truth= gen_truth(model);
%     meas=  gen_meas(model,truth);
%     tic
    est= run_filter(model,meas{trial});
%     time(trial) = toc;
    
    for k=1:K
        [gospa_vals(k,:,trial)] = ...
            gospa_dist(get_comps(truth{trial}.X{k},[1 3]),get_comps(est.X{k},[1 3])...
            ,gospa_c,gospa_p,gospa_alpha);
    end
end
averGospa = mean(gospa_vals,3);
mean(averGospa)
