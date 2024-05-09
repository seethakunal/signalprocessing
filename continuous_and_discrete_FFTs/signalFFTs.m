
%% the signal

fs = 2000;
dt = 1/fs;
t = 0:dt:9;
signal = 3*exp(-.4.*t).*heaviside(t) + .6*cos(8*pi.*t);
figure(1)
plot(t, signal)
hold on
plot(1, signal(1))
title('3*exp(-.4.*t).*heaviside(t) + .6*cos(8*pi.*t)')
ylabel('Amplitude')
xlabel('Time (s)')


%% discrete and continuous fourier transforms of the signal

figure(2)
% row 1

% 9 secs Sampling Duration
subplot(2,3,1)
sgtitle('Fourier Transform of 3*exp(-.4.*t).*heaviside(t) + .6*cos(8*pi.*t)')
t = 0:dt:9;
signal = 3*exp(-.4.*t).*heaviside(t) + .6*cos(8*pi.*t);
t0 = 9;
[freqs, magnitudes] = continuousFFT(signal, fs, t0);
indices = isinf(magnitudes);
plot(freqs(~indices), magnitudes(~indices))
hold on
stem(freqs(indices), magnitudes(indices), '^', 'filled');
title('9 secs')
ylabel('Magnitude')
xlabel('Frequency (Rad/s)')
xlim([-50, 50])
ylim([0 60000])

% 45 secs Sampling Duration
subplot(2,3,2)
t = 0:dt:45;
signal = 3*exp(-.4.*t).*heaviside(t) + .6*cos(8*pi.*t);
t0 = 45;  
[freqs, magnitudes] = continuousFFT(signal, fs, t0);
indices = isinf(magnitudes);
plot(freqs(~indices), magnitudes(~indices))
hold on
stem(freqs(indices), magnitudes(indices), '^', 'filled');
title('45 secs')
ylabel('Magnitude')
xlabel('Frequency (Rad/s)')
xlim([-50, 50])
ylim([0 60000])

% 90 secs Sampling Duration
subplot(2,3,3)
t = 0:dt:90;
signal = 3*exp(-.4*t).*heaviside(t) + .6*cos(8*pi*t);
t0 = 90;  
[freqs, magnitudes] = continuousFFT(signal, fs, t0);
indices = isinf(magnitudes);
plot(freqs(~indices), magnitudes(~indices))
hold on
stem(freqs(indices), magnitudes(indices), '^', 'filled');
title('90 secs')
ylabel('Magnitude')
xlabel('Frequency (Rad/s)')
xlim([-50, 50])
ylim([0 60000])

% row 2

% 9 secs Sampling Duration
subplot(2,3,4)
t = 0:dt:9;
signal = 3*exp(-.4.*t).*heaviside(t) + .6*cos(8*pi.*t);
t0 = 9;
[freqs,magnitudes] = discreteFFT(signal, dt, fs, t0);
stem(freqs, magnitudes)
title('9 secs')
ylabel('Magnitude')
xlabel('Frequency (Rad/s)')
xlim([-50, 50])
ylim([0 30])



% 45 secs Sampling Duration
subplot(2,3,5)
t = 0:dt:45;
signal = 3*exp(-.4.*t).*heaviside(t) + .6*cos(8*pi.*t);
t0 = 45;  
[freqs, magnitudes] = discreteFFT(signal, dt, fs, t0);
stem(freqs, magnitudes)
title('45 secs')
ylabel('Magnitude')
xlabel('Frequency (Rad/s)')
xlim([-50, 50])
ylim([0 30])



% 90 secs Sampling Duration
subplot(2,3,6)
t = 0:dt:90;
signal = 3*exp(-.4*t).*heaviside(t) + .6*cos(8*pi*t);
t0 = 90;  
[freqs, magnitudes] = discreteFFT(signal, dt, fs, t0);
stem(freqs, magnitudes)
title('90 secs')
ylabel('Magnitude')
xlabel('Frequency (Rad/s)')
xlim([-50, 50])
ylim([0 30])

