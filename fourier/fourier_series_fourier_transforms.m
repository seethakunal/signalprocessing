clear all;
clc;

% 10/18/2023
% Signal processing: Fourier series and transforms

time = linspace(-7,7,1000);

subplot(4,1,1)
y = periodicSquare(time,pi/2);
plot(time, y)
xlabel('time (s)')
title('pi/2')

subplot(4,1,2)
y = periodicSquare(time,pi);
plot(time, y)
xlabel('time (s)')
title('pi')

subplot(4,1,3)
y = periodicSquare(time,3*pi/2);
plot(time, y)
xlabel('time (s)')
title('3pi/2')

subplot(4,1,4)
y = periodicSquare(time,2*pi);
plot(time, y)
xlabel('time (s)')
title('2pi')

% tau is period that the signal is at 1 for the waveform, the overall
% period is 2*pi

figure;
subplot(3,1,1)
plot(time, nthExpFS(randi(5), time, 2*pi/3))
hold on
plot(time, nthExpFS(randi(5), time, 2*pi/3))
xlabel('time (s)')
legend('Random N 1', 'Random N 2')
ylabel('amplitude')
title("Fourier series for N between 1-5")

subplot(3,1,2)
plot(time, nthExpFS(randi([10,50]), time, 2*pi/3))
hold on
plot(time, nthExpFS(randi([10,50]), time, 2*pi/3))
xlabel('time (s)')
legend('Random N 1', 'Random N 2')
ylabel('amplitude')
title("Fourier series for N between 10-50")

subplot(3,1,3)
plot(time, nthExpFS(randi([100,500]), time, 2*pi/3))
hold on
plot(time, nthExpFS(randi([100,500]), time, 2*pi/3))
xlabel('time (s)')
legend('Random N 1', 'Random N 2')
ylabel('amplitude')

title("Fourier series for N between 100-500")

%{
In figure 1, a periodic square wave is generated for different tau values,
in figure 2, we applying a fourier transform to a consistent periodic
square wave with tau value 2pi/3, for the first subplot the N value is
random with range 1-5, for the second subplot the N value is randomized
between range 10-50, and for the third subplot the N value is randomized
between 100-500. Two different N values are plotted in order to visualize
the differences between the fourier series with different number of terms
within the given range. As the N value increases towards infinity the
signal looks more and more like the one periodic square wave for 2pi/3.
%}






