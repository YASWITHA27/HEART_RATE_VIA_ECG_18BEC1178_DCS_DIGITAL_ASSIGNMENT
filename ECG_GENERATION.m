clc
clear all;
fs=500;%sapling frequency
in_file=fopen('ecg2x60.dat','r');%Opens the dat file that is saved in matlab drive
sin=fscanf(in_file,'%f'); %Scans the dat file
fclose(in_file); %Closes the specified file
T=1/fs; % sampling time period
N=length(sin); %Defining the length of the sequence 
k=0:N-1; % multification factor  
t=k*T; %Time period 
plot(t,sin) % Plotting of the ECG signal
set(gca,'FontSize',7,'FontWeight','bold')
xlabel('Time(s)','FontSize',7,'FontWeight','bold');
ylabel('Voltage(mv)','FontSize',7,'FontWeight',"bold");
title('ECG Signal 18BEC1178');
grid on 
