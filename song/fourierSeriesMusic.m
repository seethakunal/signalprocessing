clc, clear, clf

set(gcf, 'color', 'w');

%% READ SONG

filename = 'Coldplay - A Sky Full Of Stars (Official Video).mp3';
disp('Reading music file...');
[song.data, Fs] = audioread(filename);
clipLen = 30; % clip length in seconds
clipStart = 62; % clip start time in seconds
startSample = round(clipStart*Fs); % get sample number of t0=62 seconds
song.data = song.data(startSample:startSample+Fs*clipLen-1,:); % Here i just take a short 23 second clip of the song
song.time = 1/Fs : 1/Fs: length(song.data)/Fs; % time vector
song.player = audioplayer(song.data,Fs); % register audioplayer with song
disp('Done reading music file...');

%% PLOT and PLAY SONG

disp('Playing music clip...');
subplot(7,1,1);

pause(0.5)
plotDownSample = 5; % just used to reduce the number of points plotted
plot(song.time(1:plotDownSample:end), song.data(1:plotDownSample:end,1));
xlabel('Time (s)', 'fontsize', 14)
ylabel('Signal Amplitude (V)', 'fontsize', 14);
title('Clip of Original Song', 'fontsize', 16);
set(gca,'linewidth', 2, 'box', 'off', 'fontsize', 12)
ylim([-1.1 1.1])
play(song.player)  % play song
while song.player.isplaying
    currSamp = round(song.player.CurrentSample/song.player.TotalSamples * length(song.time));
    xlim([song.time(currSamp)-5 song.time(currSamp)])
    pause(0.15)
end
xlim([0 clipLen]);
pause(0.5);
disp('Done');

%% CALCULATE FOURIER SERIES

numComponents = 5000; % number of sinusoids to add together

T0 = 1; % interval [t1 t2] length in seconds - limited due to computer memory
T0samps = T0 * Fs; % interval [t1 t2] length in samples
w0 = 2*pi / T0; % note that we calculate the series over a specified interval t1 to t2, and hence w0 is calculated with respect to that interval

for n = 0:numComponents
    
    % initialize sine and cosine component vectors to zeros
    sinComp = zeros(length(song.time), 1);
    cosComp = sinComp;
    
    if mod(n, 1000) == 1
        subplot(7,1,ceil(n/1000+1));
        text(0.5,0.5,'Calculating the next 1000 components...','horizontalalignment', 'center','fontsize', 20);
        axis off
        pause(0.1)
        disp('Calculating the next 1000 components...');
    end
    
    for startIDX = 1:T0samps:length(song.time)
        idx1 = startIDX;
        idx2 = min(idx1 + T0samps - 1, length(song.time));
        t1 = idx1/Fs;
        t2 = idx2/Fs;
        currSignal = song.data(idx1:idx2); % only take windowed portion of song (on interval t1 to t2)
        
        % find coefficient for cosine component
        t = linspace(t1,t2,length(currSignal)); % current time vector
        basisSignal = cos(n * w0 * t)'; % create basis signal for cosine
        innerProduct = sum(currSignal' .* basisSignal); % inner product: with discrete signals, the integral is equivalent to a sum
        basisEnergy = sum(basisSignal.^2); % energy of cos(n * w0 * t)
        an = innerProduct / basisEnergy;
        cosComp(idx1:idx2) = an * basisSignal;
        
        % find coefficient for sine component
        basisSignal = sin(n * w0 * t)';  % create basis signal for sine
        innerProduct = sum(currSignal' .* basisSignal); % inner product
        basisEnergy = sum(basisSignal.^2); % energy of sin(n * w0 * t)
        bn = innerProduct / basisEnergy;
        sinComp(idx1:idx2) = bn * basisSignal;
    end
    
    if n == 0
        songApprox = cosComp;
    else
        songApprox = songApprox + sinComp + cosComp;
    end
    
    if n == 2000
        songApproxHighFreq = cosComp;
    elseif n > 2000
        songApproxHighFreq = songApproxHighFreq + sinComp + cosComp;
    end
    
    
    % plot and play
    if ~mod(n, 1000) && n > 0
        subplot(7,1,(n/1000+1)); cla
        plot(song.time(1:plotDownSample:end), songApprox(1:plotDownSample:end));
        xlabel('Time (s)', 'fontsize', 14)
        ylabel('Signal Amplitude (V)', 'fontsize', 14);
        title(['First ' int2str(n) ' sine and cosine harmonics'], 'fontsize', 16);
        set(gca,'linewidth', 2, 'box', 'off', 'fontsize', 12)
        ylim([-1.1 1.1])
        song.playerApprox = audioplayer(songApprox,Fs);
        play(song.playerApprox)  % play song
        while song.playerApprox.isplaying
            currSamp = round(song.playerApprox.CurrentSample/song.playerApprox.TotalSamples * length(songApprox));
            xlim([song.time(currSamp)-5 song.time(currSamp)])
            pause(0.15)
        end
        xlim([0 clipLen]);
        pause(0.5);
        disp('Done');
    end
end

% Play LAST 3000 harmonics
subplot(7,1,(n/1000+2)); cla
plot(song.time(1:plotDownSample:end), songApproxHighFreq(1:plotDownSample:end));
xlabel('Time (s)', 'fontsize', 14)
ylabel('Signal Amplitude (V)', 'fontsize', 14);
title(['2000-5000 sine and cosine harmonics'], 'fontsize', 16);
set(gca,'linewidth', 2, 'box', 'off', 'fontsize', 12)
ylim([-1.1 1.1])
song.playerApprox = audioplayer(songApproxHighFreq,Fs);
play(song.playerApprox)  % play song
while song.playerApprox.isplaying
    currSamp = round(song.playerApprox.CurrentSample/song.playerApprox.TotalSamples * length(songApproxHighFreq));
    xlim([song.time(currSamp)-5 song.time(currSamp)])
    pause(0.15)
end
xlim([0 clipLen]);