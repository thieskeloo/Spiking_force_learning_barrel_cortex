function [] = pregenerate_spiking_structures(seed)

N_train = 600;     % number of training trials
N_test = 100;      % number of validation trials

addpath(genpath('Spiking structures'))
addpath(genpath('Helper data'))
addpath(genpath('Helper functions'))
addpath(genpath('Thalamus functions'))
addpath(genpath('Network functions'))
addpath(genpath('Parameter schemes'))
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


%% load trial data
file = load('trainable_trials');
trainable_trials = file.trainable_trials;
[train_trials, test_trials] = fixed_trial_selector(trainable_trials.prox_touch,...
    trainable_trials.dist_no_touch, N_train, N_test, seed);

%% loop through trials 
% for trial = 1:length(trainable_trials.dist_no_touch)
for trial = 1:length(train_trials)
train_trials(trial).spike_struct
    if exist(['./Spiking structures/' num2str(train_trials(trial).spike_struct)], 'file') ~= 2

        trialId = train_trials(trial).trial;
    
        % get the trial session and create the spikingstruct
        session = train_trials(trial).session;
        SpikeTrainStruct = make_trial_spikes(session, trialId,...
            whiskmat, KernelStruct);
    
       save(['./Spiking structures/' num2str(train_trials(trial).spike_struct)], "SpikeTrainStruct")
    end
end
