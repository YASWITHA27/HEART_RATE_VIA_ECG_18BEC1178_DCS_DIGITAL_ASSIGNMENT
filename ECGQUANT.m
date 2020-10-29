clc
clear all
close all 
syms x
[f,l]=plotATM('08730_01m')
sin=l(1,:)
clf
fs = 128;
f0 =25.29;
Q = 35;
% [h,w]=freqz(b,a,128,fs);
% out_put = filter(b,a,sin);
% m=20*log10(abs(h));
% an=angle(h);
T = 1/fs;
N = length(sin);
k=0:N-1;
t=k*T;


% Sampling
n = input('Enter number of samples per cycle: ');
x = plotATM('08730_01m');
sig_1 = 2*x;
figure(1);
hold on
plot(x, sig_1);
title('ECG SIGNAL 18BEC1178');
xlabel('t--->');
ylabel('amplitude');
hold off
figure(2);
hold on
stem(sig_1);
title('Sampled Signal 18BEC1178');
xlabel('t--->');
ylabel('amplitude');
hold off

% Quantization
m = input('Enter the number of bits per sample: ');
L = 2^m;
xmax = 2;
xmin = -2;
del = (xmax - xmin)/L;
part = xmin:del:xmax; 
codebook = xmin - del/2 : del : xmax + del/2;
[index, quants] = quantiz(sig_1, part, codebook);
figure(3);
hold on
stem(quants);
title('Quantized Signal 18BEC1178');
xlabel('t--->');
ylabel('amplitude');
hold off;

% Normalization
l1 = length(index);
for i=1:l1
if index(i)~=0
index(i) = index(i)-1;
end
end
l2 = length(quants);
for i=1:l2
if quants(i)==xmin-del/2
quants(i) = xmin+del/2;
end
if quants(i)==xmax+del/2
quants(i) = xmax-del/2;
end
end

% Encoding
code = de2bi(index, 'left-msb');
k = 1;
for i=1:l1
for j=1:m
coded(k) = code(i, j);
j = j+1;
k = k+1;
end
i = i+1;
end

% Plot Digital Signal
figure(4);
hold on
stairs(coded);
axis([0 200 -2 2])
title('Digital Signal 18BEC1178');
xlabel('t--->');
ylabel('amplitude');
hold off

% Demodulation
code1 = reshape(coded, m, (length(coded)/m));
index1 = bi2de(code1, 'left-msb');
resignal = del*index+xmin+del/2;
figure(5);
hold on
plot(resignal);
title('Demodulated Signal 18BEC1178');
xlabel('t--->');
ylabel('amplitude');
hold off
