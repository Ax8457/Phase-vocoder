%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                          PHASE VOCODEUR
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%                              Signal                                  %%
%--------------------------------%
 %[y,Fs]=audioread('D');   
% [y,Fs]=audioread('');  
% [y,Fs]=audioread('');   %
%--------------------------------%

%Time Vector---------------------%
N=length(y)
t = [0:N-1]/Fs;
%--------------------------------%

%--------------------------------%
% Stereo signal => working with a single track
y = y(:,1);
%--------------------------------%

%%                              Graph                                   %%
figure(1)
subplot(411),plot(t,y),grid, xlabel('Signal original')
title('Signal Temporel')

subplot(413),spectrogram(y,128,120,128,Fs,'yaxis');
title('Spectrogramme')

[Y,f] = cpsd(y,y,[],[],[],Fs,'twosided');
subplot(412),plot(f-Fs/2,fftshift(Y)),grid
title('DSP')



%--------------------------------%
%%              Speed 
%--------------------------------%
rapp = 2/3;   
ylent = PVoc(y,rapp,1024); 

%Time Vector---------------------% 
N20=length(ylent)
tlent = [0:N20-1]/Fs;
%--------------------------------%
%soundsc(ylent,Fs)

figure(2)
subplot(411),plot(tlent,ylent),grid, xlabel('Signal original')
title('Signal Temporel après modification de la vitesse')

subplot(413),spectrogram(ylent,128,120,128,Fs,'yaxis');
title('Spectrogramme après modification de la vitesse')

[Ylent,f] = cpsd(ylent,ylent,[],[],[],Fs,'twosided');
subplot(412),plot(f-Fs/2,fftshift(Ylent)),grid
title('DSP après modification de la vitesse')

rapp2 = 4/2;   %peut être modifié
yrapide = PVoc(y,rapp2,1024); 

N2=length(yrapide)
trap = [0:N2-1]/Fs;
 
soundsc(yrapide,Fs)

figure(3)
subplot(411),plot(trap,yrapide),grid, xlabel('Signal original')
title('Signal Temporel après modification de la vitesse')

subplot(413),spectrogram(yrapide,128,120,128,Fs,'yaxis');
title('Spectrogramme après modification de la vitesse')

[Yrap,f] = cpsd(yrapide,yrapide,[],[],[],Fs,'twosided');
subplot(412),plot(f-Fs/2,fftshift(Yrap)),grid
title('DSP après modification de la vitesse')


% %---------------------------------%
%%              Pitch                                                   %%
% %---------------------------------%

% % Number of points for FFT/IFFT
Nfft = 256;
% % window of hanning length
Nwind = Nfft;

% % Augmentation 
a = 2;  b = 3;  
yvoc1 = PVoc(y, a/b,Nfft,Nwind);

%%resampling in order to avoid modifying speed
y_rsple = resample(yvoc1,a,b);
soundsc(y_rsple,Fs)
 
a1 = 3;  b1 = 2;   
yvoc2 = PVoc(y, a1/b1,Nfft,Nwind); 


y_rsple2 = resample(yvoc2,a,b);

%time vector
N5=length(y_rsple)
tpitch = [0:N5-1]/Fs;

figure(4)
subplot(411),plot(tpitch,y_rsple),grid, xlabel('Signal original')
title('Signal Temporel après modification du pitch')

subplot(413),spectrogram(y_rsple,128,120,128,Fs,'yaxis');
title('Spectrogramme après modification du pitch')

[Yres,f] = cpsd(y_rsple,y_rsple,[],[],[],Fs,'twosided');
subplot(412),plot(f-Fs/2,fftshift(Yres)),grid
title('DSP après modification du pitch')


%-----------------------------------%
%%              SUM                                                     %%
%-----------------------------------%

y_resampled = resample(y, length(y_rsple), length(y));
y_sum = y_resampled + y_rsple;

soundsc(y_sum,Fs)

%time vector
N6=length(y_sum)
tsum= [0:N6-1]/Fs;

figure(2)
subplot(411),plot(tsum,y_sum),grid, xlabel('Signal original')
title('Superposition du signal original avec le signal dont le  pitch est modifié')

subplot(413),spectrogram(y_sum,128,120,128,Fs,'yaxis');
title('Spectrogramme après superposition du signal original avec le signal dont le  pitch est modifié')

[Ysum,f] = cpsd(y_sum,y_sum,[],[],[],Fs,'twosided');
subplot(412),plot(f-Fs/2,fftshift(Ysum)),grid
title('DSP après superposition du signal original avec le signal dont le  pitch est modifié')


% %----------------------------
%%          ROBOT EFFECT
% %-----------------------------

%carrier frequency
Fc = 500;  
yrob = rob(y,Fc,Fs);

soundsc(yrob,Fs);

N3=length(yrob)
trob = [0:N3-1]/Fs;

figure(5)
subplot(411),plot(trob,yrob),grid, xlabel('Signal original')
title('Signal Temporel après robotisation')

subplot(413),spectrogram(yrob,128,120,128,Fs,'yaxis');
title('Spectrogramme après robotisation')

[Yrob,f] = cpsd(yrob,yrob,[],[],[],Fs,'twosided');
subplot(412),plot(f-Fs/2,fftshift(Yrob)),grid
title('DSP après robotisation')


%------------------------------%
%%         REVERB  EFFECT
% %----------------------------%
% decay : decreasing factor
%decay = 0.2; 
decay = 0.8; 
y_reverb = reverb(y, Fs, decay)
soundsc(y_reverb,Fs);

%time vector
N4=length(y_reverb)
trev = [0:N4-1]/Fs;

figure(6)
subplot(411),plot(trev,y_reverb),grid, xlabel('Signal original')
title('Signal Temporel après reverb')

subplot(413),spectrogram(y_reverb,128,120,128,Fs,'yaxis');
title('Spectrogramme après reverb')

[Yrev,f] = cpsd(y_reverb,y_reverb,[],[],[],Fs,'twosided');
subplot(412),plot(f-Fs/2,fftshift(Yrev)),grid
title('DSP après reverb')

