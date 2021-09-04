clear
load('RT2D-3.522F0005.mat')
%% Parameters
f = 1:200; % frequency of interest
fs  = 44000; % sampling frequency
PwelchWin = 1; % in seconds
PwelchWinOlp = 0.5; % in seconds

t = 0:1/44000:(length(CRAW_01)-1)/44000;
%% Check the raw data

figure
subplot(4,1,1)
plot(t,CRAW_01)
axis tight
subplot(4,1,2)
plot(t,CRAW_02)
axis tight
subplot(4,1,3)
plot(t,CRAW_03)
axis tight
subplot(4,1,4)
plot(t,CRAW_04)
axis tight
xlabel('Time(seconds)')

%% Define time of interest
PreStim  = [50 100]; % in seconds
DurStim  = [130 160];
PostStim = [180 210];

%% Plot spectrum of each channel
% Take one channel for example
ChannelData  = CRAW_03;
PreStimData  = double(ChannelData(PreStim(1)*fs:PreStim(2)*fs));
DurStimData  = double(ChannelData(DurStim(1)*fs:DurStim(2)*fs));
PostStimData = double(ChannelData(PostStim(1)*fs:PostStim(2)*fs));

PreStimSpec  = pwelch(PreStimData,PwelchWin*fs,PwelchWinOlp*fs,f,fs);
DurStimSpec  = pwelch(DurStimData,PwelchWin*fs,PwelchWinOlp*fs,f,fs);
PostStimSpec = pwelch(PostStimData,PwelchWin*fs,PwelchWinOlp*fs,f,fs);

figure
subplot(1,3,1)
plot(10*log10(PreStimSpec))
title('PreStim')
grid on
xlabel('Frequency (Hz)')
subplot(1,3,2)
plot(10*log10(DurStimSpec))
title('During Stim')
grid on
xlabel('Frequency (Hz)')
subplot(1,3,3)
plot(10*log10(PostStimSpec))
title('Post Stim')
grid on
xlabel('Frequency (Hz)')


%% Try bipolar
ChannelData  = CRAW_03 - CRAW_02;
PreStimData  = double(ChannelData(PreStim(1)*fs:PreStim(2)*fs));
DurStimData  = double(ChannelData(DurStim(1)*fs:DurStim(2)*fs));
PostStimData = double(ChannelData(PostStim(1)*fs:PostStim(2)*fs));

PreStimSpec  = pwelch(PreStimData,PwelchWin*fs,PwelchWinOlp*fs,f,fs);
DurStimSpec  = pwelch(DurStimData,PwelchWin*fs,PwelchWinOlp*fs,f,fs);
PostStimSpec = pwelch(PostStimData,PwelchWin*fs,PwelchWinOlp*fs,f,fs);

figure
subplot(1,3,1)
plot(10*log10(PreStimSpec))
title('PreStim')
grid on
xlabel('Frequency (Hz)')
subplot(1,3,2)
plot(10*log10(DurStimSpec))
title('During Stim')
grid on
xlabel('Frequency (Hz)')
subplot(1,3,3)
plot(10*log10(PostStimSpec))
title('Post Stim')
grid on
xlabel('Frequency (Hz)')









