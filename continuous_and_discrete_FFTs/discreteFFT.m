function [freqs,fourierTransform] = discreteFFT(signal,dt,fs,t0)
fourierTransform = abs(fftshift(fft(signal*dt)));
freqs = (-fs/2:1/t0:fs/2)*2*pi;
end

