function [freqs,fourierTransform] = continuousFFT(signal,fs,t0)
fourierTransform = abs(fftshift(fft(signal)));
freqs = (-fs/2:1/t0:fs/2)*2*pi;
end

