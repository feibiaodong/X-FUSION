clc;clear
dbstop if error

K = 100;
numTrial = 100;
model = gen_model(pd,lambda);
% GOSPA parameters
gospa_p = 1;
gospa_c = 100;
gospa_alpha = 2;
gospa_vals = zeros(K,4,numTrial);

for trial = 1:numTrial
    truth = gen_truth(model);
    meas = gen_meas(model,truth);
    est = run_filter(model,meas);
    
    for k=1:K
        [gospa_vals(k,:,trial)] = gospa_dist(get_comps(truth.X{k},[1 3]),...
            get_comps(est.X{k},[1 3]),gospa_c,gospa_p,gospa_alpha);
    end
end

averGospa = mean(gospa_vals,3);
mean(averGospa)