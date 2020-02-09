%Simulation and analysis of Direct Sequence Spread Signal with 
%Single Tone Jamming function through QPSK modulation
%Author: Toufiqur Rahman Chowdhury
%Modified from originally code written by JC (2005) and Bob Gess (2008)
%Course: ELEG-442, Digital Communication
%April,2014

% In this simulation BER plot of DSSS over QPSK modulation  
% for different Jamming Amplitude

% Here we have two debug mode, Mode-0 and Mode-1. Using Mode 0, we find
% the BER plot and using Mode-1, we get the different plots explaining input
% signal and separated signal for I channel and Q channel for QPSK modulation,
% PN sequencing and Spreading. Other plots for the QPSK modulation,
% simulation of AWGN with std noise and Single Tone Jamming noise, QPSK
% demodulation at receiver and despread signal

% Future work: Multitone Jamming Implementation Testing

clc; clear
N=128                % Number of data bits(bit rate)
noise_offset=10      % How far away (in Hz) jamming signal is from center frequency
chip_rate = 20000    % Chip rate
fcarr=20000          % Carrier frequency in Hz (0 to 40kHz)
jam_amp=[.1,1,2,3,4,5,6,7,8,9];

BER_qpsk=[zeros(1,10)];
BER_ss=[zeros(1,10)];

debub_mod=[zeros(1,14)];    %Mode-0
%debub_mod=[ones(1,14)];    %Mode-1

if sum(debub_mod)==0
    for i=1:10
        [qpsk_bit_errs,qpsk_ber,ss_bit_errors,ss_ber]=DSSS_QPSK_Jamming(N,noise_offset,chip_rate,fcarr,jam_amp(i),debub_mod);
        BER_qpsk(i)=qpsk_ber
        BER_ss(i)=ss_ber
    end
    
    n=1:10;    
    plot(n,BER_qpsk,'r-',n,BER_ss,'b--','Linewidth',3);
    legend('BER for QPSK Modulation','BER for DSSS');
    fx=xlabel('Bit Error Rate');
    fy=ylabel('');
    set(fx,'fontSize',11); set(fy,'Fontsize',11);grid on
    title('DSSS with QPSK BER comparison');
    
else
    [qpsk_bit_errs,qpsk_ber,ss_bit_errors,ss_ber]=DSSS_QPSK_Jamming(N,noise_offset,chip_rate,fcarr,jam_amp(5),debub_mod)
    BER_qpsk=qpsk_ber;
    BER_ss=ss_ber;
end



