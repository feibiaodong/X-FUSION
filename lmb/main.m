clc;clear
dbstop if error

K = 101;
numTrial = 200;

model= gen_model2(0.98,10);
load('truth2_10_98');
load('meas2_10_98');
% GOSPA parameters
gospa_p = 1;
gospa_c = 100;
gospa_alpha = 2;
gospa_vals = zeros(K,4,numTrial);

% time = zeros(numTrial,1);

parfor trial = 1:numTrial
%     truth = gen_truth(model);
%     meas = gen_meas(model,truth);
%     tic
    est = run_filter(model,meas{trial});
%     time(trial) = toc;
    
    for k=1:K
        [gospa_vals(k,:,trial)] = gospa_dist(get_comps(truth{trial}.X{k},[1 3]),...
            get_comps(est.X{k},[1 3]),gospa_c,gospa_p,gospa_alpha);
    end
end

averGospa = mean(gospa_vals,3);
mean(averGospa)