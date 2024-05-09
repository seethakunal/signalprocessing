load ArtificialEEG.mat

Fs = 1000; % Sampling rate (spectral period)
T = 1/Fs; % Temporal Resolution
T0 = length(EEG)/Fs; % Signal length in time domain
F0 = 1/T0; % Spectral Resolution

% Plot EEG signal in the time domain
t = 0:T:T*(length(EEG)-1); % time axis
figure(3);
plot(t, EEG);
title('EEG Signal in Time domain');
xlabel('Time (sec)');
ylabel('Amplitude');

% Plot EEG amplitude spectrum
frequencies = -Fs/2+(0:(length(EEG)-1))*F0; % Shift frequency axis to center at 0 Hz 
EEG_amps = abs(fftshift(fft(EEG*T)));
figure(4);
plot(frequencies, EEG_amps);
xlim([0 100]);
title('EEG Amplitude Spectrum');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

% Plot EEG spectrogram
figure(5);
spectrogram(EEG, 1200, 1000, 0:Fs/2, Fs, 'yaxis');
colormap bone;
title('EEG Spectrogram');
xlabel('Time (minutes)');
ylabel('Frequency (Hz)');
ylim([0 110]);