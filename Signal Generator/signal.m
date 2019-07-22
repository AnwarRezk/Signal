
fn=inputfn;
ht=inputht;

yy = subplot(4,2,5);
yys = subplot(4,2,6);
yt = conv(fn,ht);
sigma = input('Enter the value of sigma : ');
zt = sigma*randn(1,length(yt));
yt = yt + zt;
subplot(4,2,5);
plot(yt);
xlabel(yy,'t')
ylabel(yy,'y(t)');
title(yy,'Output Signal');
nfft = length(yt);
nfft2 = 2^nextpow2(nfft);
ff = fft(yt,nfft2);
subplot(4,2,6);
plot(fftshift(abs(ff)));
grid on;
hold on;
ylim(yys,[0 5]);

if ht(1) == 0
    ht(1) = 1;
end

[q,r] = deconv(yt,ht);
dec=subplot(4,2,7);
subplot(4,2,7);
plot(q);
xlabel(dec,'t')
ylabel(dec,'F(t)');
title(dec,'Deconvoluted input Signal');
xlabel(yys,'s')
ylabel(yys,'F(s)');
title(yys,'Frequency domain of output Signal');
%xlim(dec,[tS,tE+10]);
%END