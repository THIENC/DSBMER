%% Group level correlation
% baseline normalization of the depth frequency matrix
% Paramters

% Visual search for the entry depth of STN 
% Make the plot
%% Data
load('sub32L2.mat')


%% Preprocessing
Fsample = 44000;

% Bandpass to 300 to 9000Hz
PassBand = [300 9000];
% Filter for each depth
Mask = ones(length(LeftDepthSorted),1);
Mask(BadChannelIndex) = 0;
LeftRawADSortedHighPassRej = LeftRawADSortedHighPass;
LeftRawADSortedHighPassRej(BadChannelIndex) = [];

LeftDepthSortedRej = LeftDepthSorted;
LeftDepthSortedRej(BadChannelIndex) = [];

for i = 1:length(LeftRawADSortedHighPassRej)
   tempSPKtrace = LeftRawADSortedHighPassRej{i};
   tempSPKtrace = bandpass(tempSPKtrace,PassBand,Fsample);
   SPK{i} = tempSPKtrace;
end

% Plot for manual inspection
Interval = 150;
TimeWin = 10;

figure
for i = 1:length(LeftRawADSortedHighPassRej)
   hold on
   plot(SPK{i} + Interval*i)
    
end
yticks([0:Interval:length(LeftRawADSortedHighPassRej) * Interval]);
xlim([0 TimeWin * Fsample])
ylim([-Interval length(LeftRawADSortedHighPassRej) * Interval])
clearvars yticklabels
yticklabels(LeftDepthSortedRej)
set(gcf,'Position',[0 0 1920 1080])

%% 
figure
imagesc(10*log10(LeftRawADSortedHighPassSpecReject))
axis xy
caxis([-20 10])

%%

% Set the baseline depth
BaselineDepth = [6 7.3];
BaselineIndx = and(LeftDepthSortedRej >= BaselineDepth(1), LeftDepthSortedRej <= BaselineDepth(2));

SpectrumBaseline = mean(LeftRawADSortedHighPassSpecReject(BaselineIndx,:));
LeftRawADSortedHighPassSpecRejectNormalize = LeftRawADSortedHighPassSpecReject./SpectrumBaseline;

% Reset the 0 depth
DepthCenter = 5.8;
DepthAdj    = LeftDepthSortedRej - DepthCenter;
ForPlotData = 10*log10(LeftRawADSortedHighPassSpecRejectNormalize);
% Smooth the data
ForPlotDataSM = imgaussfilt(ForPlotData,[1 2]);
figure
imagesc(ForPlotDataSM)
caxis([1 6])
colormap jet
axis xy
xticks(0:50:length(FreqOfInteres))
xticklabels(0:25:max(FreqOfInteres))
xlabel('Frequency')
ylabel('Depth')
yticks([1:length(DepthAdj)]);
clearvars yticklabels
yticklabels(DepthAdj)




% for i = 1:length(LeftRawADSortedHighPass)
%    hold on
%    RawRMS(i,:) = rms(SPK{i})
% end
% 
% baseLineRMS = mean(RawRMS(2:10));
% 
% NRMS = RawRMS./baseLineRMS














