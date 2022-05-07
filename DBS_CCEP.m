%% Path
cd('D:\DBS_CCEP_data\001_PD_yinhengyue\Prec\Micro')

%% Data Processing 
% Micro stimulation depth 1.667
load RT1D1.667F0001.mat
clearvars -except CRAW_01 CECOG_LF_2___02 CECOG_LF_2___03 CECOG_LF_2___04 CECOG_LF_2___05 CECOG_LF_2___06 CECOG_LF_2___07 CECOG_LF_2___08

fsMER  = 44000;
fsECoG = 1375;
timeLMER  = length(CRAW_01)./fsMER;
timeLECoG = length(CECOG_LF_2___02)./fsECoG;
assert(abs(timeLMER - timeLECoG) < 0.01)

tMER = 0:1/fsMER:(timeLMER- 1/fsMER);
figure
plot(tMER,CRAW_01) % Stim Channel

timeOfinterest = [15 86]; % in seconds

% Epoch the data
spRangeMER = timeOfinterest(1) .* fsMER : timeOfinterest(2) .* fsMER;
MER        = highpass(double(CRAW_01(spRangeMER)),300,fsMER);
figure
plot(tMER(spRangeMER),MER) % Stim Channel

% Recording ECoG
ECoG.C12 = CECOG_LF_2___02;
ECoG.C23 = CECOG_LF_2___02 - CECOG_LF_2___03;
ECoG.C34 = CECOG_LF_2___03 - CECOG_LF_2___04;
ECoG.C45 = CECOG_LF_2___04 - CECOG_LF_2___05;
ECoG.C56 = CECOG_LF_2___05 - CECOG_LF_2___06;
ECoG.C67 = CECOG_LF_2___06 - CECOG_LF_2___07;
ECoG.C78 = CECOG_LF_2___07 - CECOG_LF_2___08;

timeOfinterest = [25 86]; % in seconds

% Epoch the data
spRangeMER = timeOfinterest(1) .* fsMER : timeOfinterest(2) .* fsMER;

MER        = abs(double(CRAW_01(spRangeMER)));
Peakthreshold = max(MER)./3;

[~,locs] = findpeaks(MER,'MinPeakDistance',fsMER,'MinPeakHeight',Peakthreshold);

% figure
% findpeaks(MER,'MinPeakDistance',fsMER,'MinPeakHeight',Peakthreshold);
timeStamps = locs./fsMER + timeOfinterest(1);
% Plot the averaged epoched potentials
chanLabels = fieldnames(ECoG);
PreSample  = 550;  % - 0.4 seconds
PostSample = 1100; % 0.8 seconds
ECoGEpoch = [];
for i = 1:length(chanLabels)
    tempData = ECoG.(chanLabels{i});
    for j = 1:length(timeStamps)
        tempTimeSample = [];
        tempTimeSample = round(timeStamps(j) .* fsECoG);
        ECoGEpoch(i,:,j) = tempData((tempTimeSample - PreSample):(tempTimeSample + PostSample)) - mean(tempData((tempTimeSample - PreSample):tempTimeSample));
    end
end

mkdir('RT1667')
cd('RT1667')
tECoG = -0.4:1/fsECoG:0.8;
for i = 1:7
    tempDataTrial = squeeze(ECoGEpoch(i,:,:));
    figure
    plot(tECoG,tempDataTrial,'Color',[0.5 0.5 0.5])
    hold on
    plot(tECoG,mean(tempDataTrial,2),'Color','b','LineWidth',2)
    axis tight
    line([0 0],[min(tempDataTrial,[],'all'),max(tempDataTrial,[],'all')],'LineWidth',2)
    title(['CCEP: ',chanLabels{i}])
    print(['CCEP-',chanLabels{i}],'-dpng','-r600')
    close
end

cd ..
%%
load RT1D2.069F0001.mat
clearvars -except CRAW_01 CECOG_LF_2___02 CECOG_LF_2___03 CECOG_LF_2___04 CECOG_LF_2___05 CECOG_LF_2___06 CECOG_LF_2___07 CECOG_LF_2___08

fsMER  = 44000;
fsECoG = 1375;
timeLMER  = length(CRAW_01)./fsMER;
timeLECoG = length(CECOG_LF_2___02)./fsECoG;
assert(abs(timeLMER - timeLECoG) < 0.01)

tMER = 0:1/fsMER:(timeLMER- 1/fsMER);
figure
plot(tMER,CRAW_01) % Stim Channel

% Recording ECoG
ECoG.C12 = CECOG_LF_2___02;
ECoG.C23 = CECOG_LF_2___02 - CECOG_LF_2___03;
ECoG.C34 = CECOG_LF_2___03 - CECOG_LF_2___04;
ECoG.C45 = CECOG_LF_2___04 - CECOG_LF_2___05;
ECoG.C56 = CECOG_LF_2___05 - CECOG_LF_2___06;
ECoG.C67 = CECOG_LF_2___06 - CECOG_LF_2___07;
ECoG.C78 = CECOG_LF_2___07 - CECOG_LF_2___08;

timeOfinterest = [4 65]; % in seconds

% Epoch the data
spRangeMER = timeOfinterest(1) .* fsMER : timeOfinterest(2) .* fsMER;

MER        = abs(double(CRAW_01(spRangeMER)));
Peakthreshold = max(MER)./3;

[~,locs] = findpeaks(MER,'MinPeakDistance',fsMER,'MinPeakHeight',Peakthreshold);

figure
findpeaks(MER,'MinPeakDistance',fsMER,'MinPeakHeight',Peakthreshold);
timeStamps = locs./fsMER + timeOfinterest(1);
% Plot the averaged epoched potentials
chanLabels = fieldnames(ECoG);
PreSample  = 550;  % - 0.4 seconds
PostSample = 1100; % 0.8 seconds
ECoGEpoch = [];
for i = 1:length(chanLabels)
    tempData = ECoG.(chanLabels{i});
    for j = 1:length(timeStamps)
        tempTimeSample = [];
        tempTimeSample = round(timeStamps(j) .* fsECoG);
        ECoGEpoch(i,:,j) = tempData((tempTimeSample - PreSample):(tempTimeSample + PostSample)) - mean(tempData((tempTimeSample - PreSample):tempTimeSample));
    end
end

mkdir('RT2069')
cd('RT2069')
tECoG = -0.4:1/fsECoG:0.8;
for i = 1:7
    tempDataTrial = squeeze(ECoGEpoch(i,:,:));
    figure
    plot(tECoG,tempDataTrial,'Color',[0.5 0.5 0.5])
    hold on
    plot(tECoG,mean(tempDataTrial,2),'Color','b','LineWidth',2)
    axis tight
    line([0 0],[min(tempDataTrial,[],'all'),max(tempDataTrial,[],'all')],'LineWidth',2)
    title(['CCEP: ',chanLabels{i}])
    print(['CCEP-',chanLabels{i}],'-dpng','-r600')
    close
end

cd ..
%%
clear
load RT1D3.945F0001.mat
clearvars -except CRAW_01 CECOG_LF_2___02 CECOG_LF_2___03 CECOG_LF_2___04 CECOG_LF_2___05 CECOG_LF_2___06 CECOG_LF_2___07 CECOG_LF_2___08

fsMER  = 44000;
fsECoG = 1375;
timeLMER  = length(CRAW_01)./fsMER;
timeLECoG = length(CECOG_LF_2___02)./fsECoG;
assert(abs(timeLMER - timeLECoG) < 0.01)

tMER = 0:1/fsMER:(timeLMER- 1/fsMER);
figure
plot(tMER,CRAW_01) % Stim Channel

% Recording ECoG
ECoG.C12 = CECOG_LF_2___02;
ECoG.C23 = CECOG_LF_2___02 - CECOG_LF_2___03;
ECoG.C34 = CECOG_LF_2___03 - CECOG_LF_2___04;
ECoG.C45 = CECOG_LF_2___04 - CECOG_LF_2___05;
ECoG.C56 = CECOG_LF_2___05 - CECOG_LF_2___06;
ECoG.C67 = CECOG_LF_2___06 - CECOG_LF_2___07;
ECoG.C78 = CECOG_LF_2___07 - CECOG_LF_2___08;

timeOfinterest = [133 194]; % in seconds

% Epoch the data
spRangeMER = timeOfinterest(1) .* fsMER : timeOfinterest(2) .* fsMER;

MER        = abs(double(CRAW_01(spRangeMER)));
Peakthreshold = max(MER)./3;

[~,locs] = findpeaks(MER,'MinPeakDistance',fsMER,'MinPeakHeight',Peakthreshold);

figure
findpeaks(MER,'MinPeakDistance',fsMER,'MinPeakHeight',Peakthreshold);
timeStamps = locs./fsMER + timeOfinterest(1);
% Plot the averaged epoched potentials
chanLabels = fieldnames(ECoG);
PreSample  = 550;  % - 0.4 seconds
PostSample = 1100; % 0.8 seconds
ECoGEpoch = [];
for i = 1:length(chanLabels)
    tempData = ECoG.(chanLabels{i});
    for j = 1:length(timeStamps)
        tempTimeSample = [];
        tempTimeSample = round(timeStamps(j) .* fsECoG);
        ECoGEpoch(i,:,j) = tempData((tempTimeSample - PreSample):(tempTimeSample + PostSample)) - mean(tempData((tempTimeSample - PreSample):tempTimeSample));
    end
end

mkdir('RT3945')
cd('RT3945')
tECoG = -0.4:1/fsECoG:0.8;
for i = 1:7
    tempDataTrial = squeeze(ECoGEpoch(i,:,:));
    figure
    plot(tECoG,tempDataTrial,'Color',[0.5 0.5 0.5])
    hold on
    plot(tECoG,mean(tempDataTrial,2),'Color','b','LineWidth',2)
    axis tight
    line([0 0],[min(tempDataTrial,[],'all'),max(tempDataTrial,[],'all')],'LineWidth',2)
    title(['CCEP: ',chanLabels{i}])
    print(['CCEP-',chanLabels{i}],'-dpng','-r600')
    close
end

cd ..
%%
cd('D:\DBS_CCEP_data\001_PD_yinhengyue\Prec\Macro')

%% Data Processing 
% Macro stimulation depth -0.001
load RT1D-0.100F0001.mat
clearvars -except CRAW_01 CECOG_LF_2___02 CECOG_LF_2___03 CECOG_LF_2___04 CECOG_LF_2___05 CECOG_LF_2___06 CECOG_LF_2___07 CECOG_LF_2___08

fsMER  = 44000;
fsECoG = 1375;
timeLMER  = length(CRAW_01)./fsMER;
timeLECoG = length(CECOG_LF_2___02)./fsECoG;
assert(abs(timeLMER - timeLECoG) < 0.01)

tMER = 0:1/fsMER:(timeLMER- 1/fsMER);
figure
plot(tMER,CRAW_01) % Stim Channel

% Recording ECoG
ECoG.C12 = CECOG_LF_2___02;
ECoG.C23 = CECOG_LF_2___02 - CECOG_LF_2___03;
ECoG.C34 = CECOG_LF_2___03 - CECOG_LF_2___04;
ECoG.C45 = CECOG_LF_2___04 - CECOG_LF_2___05;
ECoG.C56 = CECOG_LF_2___05 - CECOG_LF_2___06;
ECoG.C67 = CECOG_LF_2___06 - CECOG_LF_2___07;
ECoG.C78 = CECOG_LF_2___07 - CECOG_LF_2___08;

timeOfinterest = [237 297]; % in seconds

% Epoch the data
spRangeMER = timeOfinterest(1) .* fsMER : timeOfinterest(2) .* fsMER;

MER        = abs(double(CRAW_01(spRangeMER)));
Peakthreshold = max(MER)./3;

[~,locs] = findpeaks(MER,'MinPeakDistance',fsMER,'MinPeakHeight',Peakthreshold);

figure
findpeaks(MER,'MinPeakDistance',fsMER,'MinPeakHeight',Peakthreshold);
timeStamps = locs./fsMER + timeOfinterest(1);
% Plot the averaged epoched potentials
chanLabels = fieldnames(ECoG);
PreSample  = 550;  % - 0.4 seconds
PostSample = 1100; % 0.8 seconds
ECoGEpoch = [];
for i = 1:length(chanLabels)
    tempData = ECoG.(chanLabels{i});
    for j = 1:length(timeStamps)
        tempTimeSample = [];
        tempTimeSample = round(timeStamps(j) .* fsECoG);
        ECoGEpoch(i,:,j) = tempData((tempTimeSample - PreSample):(tempTimeSample + PostSample)) - mean(tempData((tempTimeSample - PreSample):tempTimeSample));
    end
end

mkdir('RTneg0100')
cd('RTneg0100')
tECoG = -0.4:1/fsECoG:0.8;
for i = 1:7
    tempDataTrial = squeeze(ECoGEpoch(i,:,:));
    figure
    plot(tECoG,tempDataTrial,'Color',[0.5 0.5 0.5])
    hold on
    plot(tECoG,mean(tempDataTrial,2),'Color','b','LineWidth',2)
    axis tight
    line([0 0],[min(tempDataTrial,[],'all'),max(tempDataTrial,[],'all')],'LineWidth',2)
    title(['CCEP: ',chanLabels{i}])
    print(['CCEP-',chanLabels{i}],'-dpng','-r600')
    close
end

cd ..

%%
% Macro stimulation depth -1.011
clear
load RT1D-1.011F0001.mat
clearvars -except CRAW_01 CECOG_LF_2___02 CECOG_LF_2___03 CECOG_LF_2___04 CECOG_LF_2___05 CECOG_LF_2___06 CECOG_LF_2___07 CECOG_LF_2___08

fsMER  = 44000;
fsECoG = 1375;
timeLMER  = length(CRAW_01)./fsMER;
timeLECoG = length(CECOG_LF_2___02)./fsECoG;
assert(abs(timeLMER - timeLECoG) < 0.01)

tMER = 0:1/fsMER:(timeLMER- 1/fsMER);
figure
plot(tMER,CRAW_01) % Stim Channel

% Recording ECoG
ECoG.C12 = CECOG_LF_2___02;
ECoG.C23 = CECOG_LF_2___02 - CECOG_LF_2___03;
ECoG.C34 = CECOG_LF_2___03 - CECOG_LF_2___04;
ECoG.C45 = CECOG_LF_2___04 - CECOG_LF_2___05;
ECoG.C56 = CECOG_LF_2___05 - CECOG_LF_2___06;
ECoG.C67 = CECOG_LF_2___06 - CECOG_LF_2___07;
ECoG.C78 = CECOG_LF_2___07 - CECOG_LF_2___08;

timeOfinterest = [24 84]; % in seconds

% Epoch the data
spRangeMER = timeOfinterest(1) .* fsMER : timeOfinterest(2) .* fsMER;

MER        = abs(double(CRAW_01(spRangeMER)));
Peakthreshold = max(MER)./3;

[~,locs] = findpeaks(MER,'MinPeakDistance',fsMER,'MinPeakHeight',Peakthreshold);

figure
findpeaks(MER,'MinPeakDistance',fsMER,'MinPeakHeight',Peakthreshold);
timeStamps = locs./fsMER + timeOfinterest(1);
% Plot the averaged epoched potentials
chanLabels = fieldnames(ECoG);
PreSample  = 550;  % - 0.4 seconds
PostSample = 1100; % 0.8 seconds
ECoGEpoch = [];
for i = 1:length(chanLabels)
    tempData = ECoG.(chanLabels{i});
    for j = 1:length(timeStamps)
        tempTimeSample = [];
        tempTimeSample = round(timeStamps(j) .* fsECoG);
        ECoGEpoch(i,:,j) = tempData((tempTimeSample - PreSample):(tempTimeSample + PostSample)) - mean(tempData((tempTimeSample - PreSample):tempTimeSample));
    end
end

mkdir('RTneg1011')
cd('RTneg1011')
tECoG = -0.4:1/fsECoG:0.8;
for i = 1:7
    tempDataTrial = squeeze(ECoGEpoch(i,:,:));
    figure
    plot(tECoG,tempDataTrial,'Color',[0.5 0.5 0.5])
    hold on
    plot(tECoG,mean(tempDataTrial,2),'Color','b','LineWidth',2)
    axis tight
    line([0 0],[min(tempDataTrial,[],'all'),max(tempDataTrial,[],'all')],'LineWidth',2)
    title(['CCEP: ',chanLabels{i}])
    print(['CCEP-',chanLabels{i}],'-dpng','-r600')
    close
end

cd ..

%%
clear
load RT1D-1.508F0002.mat
clearvars -except CRAW_01 CECOG_LF_2___02 CECOG_LF_2___03 CECOG_LF_2___04 CECOG_LF_2___05 CECOG_LF_2___06 CECOG_LF_2___07 CECOG_LF_2___08

fsMER  = 44000;
fsECoG = 1375;
timeLMER  = length(CRAW_01)./fsMER;
timeLECoG = length(CECOG_LF_2___02)./fsECoG;
assert(abs(timeLMER - timeLECoG) < 0.01)

tMER = 0:1/fsMER:(timeLMER- 1/fsMER);
figure
plot(tMER,CRAW_01) % Stim Channel

% Recording ECoG
ECoG.C12 = CECOG_LF_2___02;
ECoG.C23 = CECOG_LF_2___02 - CECOG_LF_2___03;
ECoG.C34 = CECOG_LF_2___03 - CECOG_LF_2___04;
ECoG.C45 = CECOG_LF_2___04 - CECOG_LF_2___05;
ECoG.C56 = CECOG_LF_2___05 - CECOG_LF_2___06;
ECoG.C67 = CECOG_LF_2___06 - CECOG_LF_2___07;
ECoG.C78 = CECOG_LF_2___07 - CECOG_LF_2___08;

timeOfinterest = [6 66]; % in seconds


% Epoch the data
spRangeMER = timeOfinterest(1) .* fsMER : timeOfinterest(2) .* fsMER;

spRangeECoG = timeOfinterest(1) .* fsECoG : timeOfinterest(2) .* fsECoG;

MER        = abs(double(CRAW_01(spRangeMER)));
Peakthreshold = max(MER)./3;

[~,locs] = findpeaks(MER,'MinPeakDistance',fsMER,'MinPeakHeight',Peakthreshold);

figure
findpeaks(MER,'MinPeakDistance',fsMER,'MinPeakHeight',Peakthreshold);
timeStamps = locs./fsMER + timeOfinterest(1);

% timeStamps2 = locs./fsMER;
% figure
% plot(ECoG.C78(spRangeECoG))
% hold on
% for i = 1:length(timeStamps)
% line([timeStamps2(i).*fsECoG,timeStamps2(i).*fsECoG],[-200 200])
% end

% Plot the averaged epoched potentials
chanLabels = fieldnames(ECoG);
PreSample  = 550;  % - 0.4 seconds
PostSample = 1100; % 0.8 seconds
ECoGEpoch = [];
for i = 1:length(chanLabels)
    tempData = ECoG.(chanLabels{i});
    for j = 1:length(timeStamps)
        tempTimeSample = [];
        tempTimeSample = round(timeStamps(j) .* fsECoG);
        ECoGEpoch(i,:,j) = tempData((tempTimeSample - PreSample):(tempTimeSample + PostSample)) - mean(tempData((tempTimeSample - PreSample):tempTimeSample));
    end
end

mkdir('RTneg1508')
cd('RTneg1508')
tECoG = -0.4:1/fsECoG:0.8;
for i = 1:7
    tempDataTrial = squeeze(ECoGEpoch(i,:,:));
    figure
    plot(tECoG,tempDataTrial,'Color',[0.5 0.5 0.5])
    hold on
    plot(tECoG,mean(tempDataTrial,2),'Color','b','LineWidth',2)
    axis tight
    line([0 0],[min(tempDataTrial,[],'all'),max(tempDataTrial,[],'all')],'LineWidth',2)
    title(['CCEP: ',chanLabels{i}])
    print(['CCEP-',chanLabels{i}],'-dpng','-r600')
    close
end

cd ..
%%


