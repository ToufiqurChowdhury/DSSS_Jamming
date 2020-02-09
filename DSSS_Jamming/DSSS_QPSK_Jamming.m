%Toufiqur Rahman Chowdhury on April, 2014
%Modified from originally code by written by JC(2005) and Bob Gess(2008)

function [qpsk_bit_errs,qpsk_ber,ss_bit_errors,ss_ber]=DSSS_QPSK_Jamming(N,noise_offset,chip_rate,fcarr,jam_amp,debub_mod)

[data,data2,Isymbols,Qsymbols]=QPSK_IQ_input_data(N,debub_mod);
Isymbols=Isymbols';
Qsymbols=Qsymbols';

[seq1,seq2]=PN_sequence(chip_rate);
%Debug code
%seq1
%seq2

[sig1,sig2]=Spreade_Sequence(Isymbols,Qsymbols,seq1,seq2,N,debub_mod);
%Debug code
%sig1
%sig2

[msumiq,sumiq,cs_t,sn_t,tiq]=QPSK_Modulation(sig1,sig2,Isymbols,Qsymbols,N,fcarr,debub_mod);
%transmitted signal at this point

[rnd_noise,nb_noise]=JammingAndStdNoise(sumiq,tiq,N,noise_offset,jam_amp,debub_mod);

no_noise_sumiq=sumiq;sumiq=sumiq+nb_noise;
no_noise_msumiq=msumiq;msumiq=msumiq+nb_noise;

%Received signal
[bit_errs_qpsk,bitout1,bitout2,ycfo1,ycfo2]=QPSK_Demodulation(msumiq,cs_t,sn_t,tiq,data,N,fcarr,debub_mod);

qpsk_bit_errs=sum(bit_errs_qpsk);
qpsk_ber=qpsk_bit_errs/N;


[bit_errs_ss,i_out,q_out]=Despreade_Sequence(tiq,sumiq,cs_t,sn_t,seq1,seq2,data,N,fcarr,debub_mod);

ss_bit_errors=sum(bit_errs_ss);
ss_ber=ss_bit_errors/N;

end



