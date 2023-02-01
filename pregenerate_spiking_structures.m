N_train = 20;     % number of training trials
N_test = 10;      % number of validation trials

f = filesep;
filename = ['.' f 'Input' f 'KernelStruct.mat'];

if ~exist(filename, 'file')
    error('KernelStruct.mat is not in the input folder')
end

KernelStruct = load(filename);
KernelStruct = KernelStruct.KernelStruct;

% load the whiskmat
filename = ['.' f 'Input' f 'whiskmat.mat'];

if ~exist(filename, 'file')
    error('whiskmat.mat is not in the input folder')
end

whiskmat = load(filename);
whiskmat = whiskmat.filtered_whiskmat;


file = load('trainable_trials');
trainable_trials = file.trainable_trials;
[train_trials, test_trials] = fixed_trial_selector(trainable_trials.prox_touch,...
    trainable_trials.dist_no_touch, N_train, N_test);

%% loop through trials
% SpikeTrainStruct 
for trial = 1:N_train

    if exist(['./Spiking structures/' num2str(train_trials(trial).spike_struct)], 'file') ~= 2

        trialId = train_trials(trial).trial;
    
        % get the trial session and create the spikingstruct
        session = train_trials(trial).session;
        SpikeTrainStruct = make_trial_spikes(session, trialId,...
            whiskmat, KernelStruct);
    
       save(['./Spiking structures/' num2str(train_trials(trial).spike_struct)], "SpikeTrainStruct")
    end
end
