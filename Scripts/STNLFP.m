%% Path
cd('H:\fromD\lingjianqiang')

%% Parameters
Fsample = 44000;

%% Preprocessing
LeftSTNFiles = dir('LT1D*.mat');

% Plot Raw signal
% Extract all depth information
for i = 1:length(LeftSTNFiles)
    LeftDepth(i,:) = str2num(cell2mat(extractBetween(LeftSTNFiles(i).name,'LT1D','F0001')));
end

% Extract all signal from all channels
for i = 1:length(LeftSTNFiles)
    load(LeftSTNFiles(i).name)
    LeftRaw{i,:} = CRAW_02;
end

clearvars -except LeftRaw LeftDepth LeftSTNFiles
% Sort the depth order
[LeftDepthSorted,SortedIndex] = sort(LeftDepth);
LeftRawSorted = LeftRaw(SortedIndex);

figure
for i = 1:length(LeftSTNFiles)
    subplot(8,8,i)
    plot(LeftRawSorted{i})
    axis tight
end


% HighPass filtering 1Hz
% Design filter           
d = designfilt('highpassiir','PassbandFrequency',1,'FilterOrder', 3, 'SampleRate',Fsample);
for i = 1:length(LeftSTNFiles)
    tempSignal = double(LeftRawSorted{i,:})';
    LeftRawSortedHighPass{i,:} = filtfilt(d,tempSignal);
end

figure
for i = 1:length(LeftSTNFiles)
    subplot(8,8,i);
    plot(LeftRawSortedHighPass{i})
    xticklabels = [];
    yticklabels = [];
    ylim([-150 150])
    title(num2str(LeftDepthSorted(i)))
    axis tight
end

% Spectrum analysis
[pxx,f] = pwelch(x,window,noverlap,f,fs);
FreqOfInteres = [0:0.5:200];
for i = 1:length(LeftSTNFiles)
    x = LeftRawSortedHighPass{i};
    [LeftRawSortedHighPassSpec(i,:),f] = pwelch(x,Fsample,Fsample/2,FreqOfInteres,Fsample);
end

figure
s = pcolor(LeftRawSortedHighPassSpec);
s.FaceColor = 'interp';
s.LineWidth = 0.1;
s.EdgeColor = [1 0.7 0.3 1];


BetaPower = mean(LeftRawSortedHighPassSpec(:,40:60),2);
figure
plot(BetaPower)
axis tight

% Interpolate bad channel
figure
s = pcolor(LeftRawSortedHighPassSpec);
BadChannelIndex = [5 14 18 32 41 55];
LeftRawSortedHighPassSpecReject = LeftRawSortedHighPassSpec;
LeftRawSortedHighPassSpecReject(BadChannelIndex,:) = [];
figure
pcolor(LeftRawSortedHighPassSpecReject);
caxis([0 5])

% Reject Index
counter = 0;
Threshold = 100;
RejectInd = [];
for i = 1:length(LeftSTNFiles)
    if max(LeftRawSortedHighPassSpec(i,:)) > Threshold
        counter = counter+1;
        RejectInd(counter) = i;
    end
end







