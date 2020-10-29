sig = load("ecg2x60.dat")
plot(sig)
xlabel('Samples');
ylabel('Electrical Activity');
title('ECG signal sampled at 100Hz,18BEC1178')
hold on
plot(sig,'ro')