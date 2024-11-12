clear;
% created environment grid based
env = rlPredefinedEnv("BasicGridworld");


% created q table
obsInfo = getObservationInfo(env);
actInfo = getActionInfo(env);
qTable = rlTable(obsInfo,actInfo);

qFunction = rlQValueFunction(qTable,obsInfo,actInfo);

% Creating agent with options
agentOpts = rlQAgentOptions;
agentOpts.DiscountFactor = 1;
agentOpts.EpsilonGreedyExploration.Epsilon = 0.9;
agentOpts.CriticOptimizerOptions = rlOptimizerOptions(Algorithm="sgdm", LearnRate=0.1, L2RegularizationFactor=0);


qAgent = rlQAgent(qFunction, agentOpts);

% traning options
trainOpts = rlTrainingOptions;
trainOpts.MaxStepsPerEpisode = 50;
trainOpts.MaxEpisodes = 400;
trainOpts.StopTrainingCriteria = "none";
trainOpts.StopTrainingValue = "none";
trainOpts.ScoreAveragingWindowLength = 30;

trainingStats = train(qAgent,env,trainOpts);

plot(env);
env.Model.Viewer.ShowTrace = true;

env.Model.Viewer.clearTrace;
env.ResetFcn = @() 1;
sim(qAgent,env)