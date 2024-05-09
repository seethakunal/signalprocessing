%% Filter types
% Butterworth filtering
Wc = 30; % cutoff frequency of 30 rad/sec
% butter command; sacrifice rolloff steepness for monotonicity in the pass-
% and stopbands, cannot separate 2 freqs that are very close together,
% signal is smooth (consistent amplitude)
[num_1,denom_1] = butter(1,Wc,"low",'s'); % returns transfer function coeffs. of 1st order lowpass filter
my_filter_1 = tf(num_1,denom_1);
[num_3,denom_3] = butter(3,Wc,"low",'s');
my_filter_3 = tf(num_3,denom_3);
[num_6,denom_6] = butter(6,Wc,"low",'s');
my_filter_6 = tf(num_6,denom_6);
% Bode plots over freq. range 1mHz to 18Hz
figure(1)
subplot(3,3,1)
bp_1 = bodeplot(my_filter_1);
grid on
opts = getoptions(bp_1);
opts.FreqScale = 'linear';
opts.MagUnits = 'abs';
opts.FreqUnits = 'Hz';
opts.XLim = ([0.001 18]);
setoptions(bp_1,opts);
subplot(3,3,4)
bp_3 = bodeplot(my_filter_3);
grid on
opts = getoptions(bp_3);
opts.FreqScale = 'linear';
opts.MagUnits = 'abs';
opts.FreqUnits = 'Hz';
opts.XLim = ([0.001 18]);
setoptions(bp_3,opts);
subplot(3,3,7)
bp_6 = bodeplot(my_filter_6);
grid on
opts = getoptions(bp_6);
opts.FreqScale = 'linear';
opts.MagUnits = 'abs';
opts.FreqUnits = 'Hz';
opts.XLim = ([0.001 18]);
setoptions(bp_6,opts);
% Chebyshev filtering
Wp = 30; % rad/s, passband frequency
Rp = 0.75; % dB, passband ripple
% equiripple in the passband and monotonic in the stopband, type I filters
% roll off faster than type II filters, but at the expense of greater
% deviation from unity in the passband
[num_1,denom_1] = cheby1(1,Rp,Wp,'low','s'); 
my_filter_1 = tf(num_1,denom_1);
[num_3,denom_3] = cheby1(3,Rp,Wp,'low','s');
my_filter_3 = tf(num_3,denom_3);
[num_6,denom_6] = cheby1(6,Rp,Wp,'low','s');
my_filter_6 = tf(num_6,denom_6);
subplot(3,3,2)
bp_1 = bodeplot(my_filter_1);
grid on
opts = getoptions(bp_1);
opts.FreqScale = 'linear';
opts.MagUnits = 'abs';
opts.FreqUnits = 'Hz';
opts.XLim = ([0.001 18]);
setoptions(bp_1,opts);
subplot(3,3,5)
bp_3 = bodeplot(my_filter_3);
grid on
opts = getoptions(bp_3);
opts.FreqScale = 'linear';
opts.MagUnits = 'abs';
opts.FreqUnits = 'Hz';
opts.XLim = ([0.001 18]);
setoptions(bp_3,opts);
subplot(3,3,8)
bp_6 = bodeplot(my_filter_6);
grid on
opts = getoptions(bp_6);
opts.FreqScale = 'linear';
opts.MagUnits = 'abs';
opts.FreqUnits = 'Hz';
opts.XLim = ([0.001 18]);
setoptions(bp_6,opts);
% Elliptic filter
Wp = 30; % rad/s, passband frequency
Rp = 0.75; % dB, passband ripple
Rs = 30; % dB, stopband ripple
[num_1,denom_1] = ellip(1,Rp,Rs,Wp,'low','s');
my_filter_1 = tf(num_1,denom_1);
[num_3,denom_3] = ellip(3,Rp,Rs,Wp,'low','s');
my_filter_3 = tf(num_3,denom_3);
[num_6,denom_6] = ellip(6,Rp,Rs,Wp,'low','s');
my_filter_6 = tf(num_6,denom_6);
subplot(3,3,3)
bp_1 = bodeplot(my_filter_1);
grid on
opts = getoptions(bp_1);
opts.FreqScale = 'linear';
opts.MagUnits = 'abs';
opts.FreqUnits = 'Hz';
opts.XLim = ([0.001 18]);
setoptions(bp_1,opts);
subplot(3,3,6)
bp_3 = bodeplot(my_filter_3);
grid on
opts = getoptions(bp_3);
opts.FreqScale = 'linear';
opts.MagUnits = 'abs';
opts.FreqUnits = 'Hz';
opts.XLim = ([0.001 18]);
setoptions(bp_3,opts);
subplot(3,3,9)
bp_6 = bodeplot(my_filter_6);
grid on
opts = getoptions(bp_6);
opts.FreqScale = 'linear';
opts.MagUnits = 'abs';
opts.FreqUnits = 'Hz';
opts.XLim = ([0.001 18]);
setoptions(bp_6,opts);
%% Filtering random signal
T0 = 10; % sec long, sampling time
Fs = 1000; % sampling rate in Hz
t = 0:1/Fs:T0; % Time vector

f1 = 2*sin(2*pi*30*t);
f2 = 4*sin(2*pi*15*t);
f3 = 8*sin(2*pi*10*t);
f4 = 16*sin(2*pi*5*t);
f5 = 10*sin(2*pi*t);
f6 = 5*randn(size(t));
ft = f1 + f2 + f3 + f4 + f5 + f6;

% 5th order butterworth low pass filter with a cutoff freq. of 3.5 Hz
Wc = 3.5; % Hz, cutoff frequency
[butterworth_num, butterworth_denom] = butter(5, Wc*2*pi, 'low', 's');
my_butterworth = tf(butterworth_num, butterworth_denom);

figure(2)
plot(t, ft)
title('unfiltered')

% 5th order butterworth
figure(3)
bp_5 = bodeplot(my_butterworth);
grid on
opts = getoptions(bp_5);
opts.FreqScale = 'linear';
opts.MagUnits = 'abs';
opts.FreqUnits = 'Hz';
opts.XLim = ([0.001 18]);
setoptions(bp_5, opts);
title('5th order butterworth')

% 5th order chebyshev low pass filter with passband ripple of 0.25 dB and passband freq. of 3.5 Hz
Rp = 0.25; % dB, passband ripple
Wp = 3.5; % Hz, passband frequency
[chebyshev_num, chebyshev_denom] = cheby1(5, Rp, Wp*2*pi, 'low', 's');
my_chebyshev = tf(chebyshev_num, chebyshev_denom);

figure(4)
bp_5 = bodeplot(my_chebyshev);
grid on
opts = getoptions(bp_5);
opts.FreqScale = 'linear';
opts.MagUnits = 'abs';
opts.FreqUnits = 'Hz';
opts.XLim = ([0.001 18]);
setoptions(bp_5, opts);
title('5th order chebyshev')

% 5th order elliptic filter
elliptic_order = 5;
passband_ripple_elliptic = 0.25;
stopband_ripple_elliptic = 30;
[elliptic_num, elliptic_denom] = ellip(elliptic_order, passband_ripple_elliptic, stopband_ripple_elliptic, Wc*2*pi, 'low','s');
my_elliptic = tf(elliptic_num, elliptic_denom);

figure(5)
bp_5 = bodeplot(my_elliptic);
grid on
opts = getoptions(bp_5);
opts.FreqScale = 'linear';
opts.MagUnits = 'abs';
opts.FreqUnits = 'Hz';
opts.XLim = ([0.001 18]);
setoptions(bp_5, opts);
title('5th order elliptic')
% [DCn,DCd] = bilinear(Cnum,Cdenom,Fs);
[DCn,DCd] = bilinear(butterworth_num,butterworth_denom,Fs);
filtered_butterworth = filter(DCn, DCd, ft);
[DCn,DCd] = bilinear(chebyshev_num,chebyshev_denom,Fs);
filtered_chebyshev = filter(DCn, DCd, ft);
[DCn,DCd] = bilinear(elliptic_num,elliptic_denom,Fs);
filtered_elliptic = filter(DCn, DCd, ft);

figure(6)
subplot(4,1,1)
plot(t, ft)
hold on
subplot(4,1,2)
plot(t, filtered_butterworth)
hold on
subplot(4,1,3)
plot(t, filtered_chebyshev)
hold on
subplot(4,1,4)
plot(t, filtered_elliptic)

