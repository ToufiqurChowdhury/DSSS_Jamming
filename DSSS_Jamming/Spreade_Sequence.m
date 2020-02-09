%Toufiqur Rahman Chowdhury
%Modified from originally code by written by JC (2005) and Bob Gess (2008)

%This module spreads the data by the PRN sequence generated previously

%The plots are scaled by the data rate.  If you have a high ratio between
%the chip rate and the data rate, some of the plots become unintelligible.

function [sig1,sig2]=Spreade_Sequence(Isymbols,Qsymbols,seq1,seq2,N,debub_mod)


%N=1e3;		        % Number of data bits(bit rate)
fs=40*2e3;		    % Sampling frequency
Fn=fs/2;            % Nyquist frequency
Ts=1/fs;	        % Sampling time = 1/fs
T=1/N;		        % Bit time
randn('state',0);   % Keeps PRBS from changing on reruns
td=[0:Ts:(N*T)-Ts]';% Time vector(data)(transpose)

tiq = [0:Ts*2:(N*T)-Ts]';% Time vector for I and Q symbols(transpose)

%Spreading data by prn sequences
sig1=Isymbols.*seq1;
sig2=Qsymbols.*seq2;

%=====================================================================
%Plots
%======================================================================
if debub_mod(2)~= 0
figure(2)
subplot(2,1,1)
plot(tiq,sig1)
axis([0 5/N -2 2]);
grid on
xlabel('                                                          Time')
ylabel('Amplitude')
title('I Channel(one bit/symbol(phase)) Data')

subplot(2,1,2)
plot(tiq,sig2)
axis([0 5/N -2 2]);
grid on
xlabel('                                                          Time')
ylabel('Amplitude')
title('Q Channel(one bit/symbol(phase)) Data')
end

end
