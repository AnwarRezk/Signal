function [out] = inputht


fs = input('Enter sampling frequecny : ');
tSh = input('Enter start of time scale for imulse response : ');
tEh = input('Enter end of time scale for impulse response : ');
%tT = tS:1/fs:tE; 
%-----------------------------------------------%
nh = input('Enter number of breakpoints of impulse response : ');

disp('--------------------------');

tTemph = 2*nh;
for i=1:1:nh
    tTemph(i) = input('Enter position of breakpoint  : ');
   if tTemph(i) < tSh
        tTemph(i) = tSh;
   end
    if tTemph(i) > tEh 
        tTemph(i) = tEh;
    end
end 
txh(1)=tSh;
txh(nh+2)=tEh;

for i=2:1:(nh+1)
   txh(i)=tTemph(i-1); 
end

disp('--------------------------');
ht = [];
tth = [];

for i=1:1:(nh+1) 
    %hold on;
    %type = menu('Available Signals','Impulse','DC','Ramp','Parabola','Exponential','Sinusoid','Triangular');
    type = input('Enter type of signal : ');
   
        %impulse
        if type == 1
            amp = input('Enter impulse amplitude : ');
            t = txh(i):1/fs:txh(i+1);
            t1 = linspace(txh(i),txh(i+1));
            s = input('Enter impulse shift : ');
            impulse = amp*(t1==s);
            %impulse = zeros(size(t1));
            %impulse(t1==s) = 1;
            %subplot(3,1,1);
            %stem(t1,impulse); 
            tth = [tth t1];
            ht = [ht impulse];
            hold on
            nfft = length(impulse);
            nfft2 = 2^nextpow2(nfft);
            ff = fft(impulse,nfft2);
            subplot(4,2,4);
            plot(fftshift(abs(ff)));
            hold on;
        %DC
        elseif type == 2
                 amp = input('Enter DC amplitude : ');
                 t = txh(i):1/fs:txh(i+1); 
                 t1 = linspace(txh(i),txh(i+1),400);
                 DC = amp*ones(1,length(t1));
                 %subplot(3,1,1);
                 %plot(t1,DC); 
                 tth = [tth,t1];
                 ht = [ht,DC];
                 grid on;
                 hold on;
                 nfft = length(DC);
                 nfft2 = 2^nextpow2(nfft);
                 ff = fft(DC,nfft2);
                 subplot(4,2,4);
                 plot(fftshift(abs(ff)));
                 grid on;
                 hold on;
         %Ramp        
         elseif type == 3
                s = input('Enter ramp slope : ');
                intercept = input('Enter ramp intercept : ');
                t = txh(i):1/fs:txh(i+1);
                t1 = linspace(txh(i),txh(i+1),400);
                ramp = s*t1 + intercept;
                %subplot(3,1,1);
                %plot(t1,ramp); 
                tth = [tth,t1];
                ht = [ht,ramp];
                grid on;
                hold on;
                nfft = length(ramp);
                nfft2 = 2^nextpow2(nfft);
                ff = fft(ramp,nfft2);
                subplot(4,2,4);
                plot(fftshift(abs(ff)));
                grid on;
                hold on;
        %Parabola        
        elseif type == 4
                 amp = input('Enter parabola amplitude : ');
                 t = txh(i):1/fs:txh(i+1);
                 t1 = linspace(txh(i),txh(i+1),400);
                 parabola= amp*t1.^2;
                 %subplot(3,1,1);
                 %plot(t1,parabola);
                 tth = [tth,t1];
                 ht = [ht,parabola];
                 grid on;
                 hold on;
                 nfft = length(parabola);
                 nfft2 = 2^nextpow2(nfft);
                 ff = fft(parabola,nfft2);
                 subplot(4,2,4);
                 plot(fftshift(abs(ff)));
                 grid on;
                 hold on;
        %Exponential         
        elseif type == 5
                  amp = input('Enter exponential amplitude : ');
                  alpha = input('Enter the exponent : ');
                  t = txh(i):1/fs:txh(i+1);
                  t1 = linspace(txh(i),txh(i+1),400);
                  exponential = amp*exp(alpha*t1);
                  %subplot(3,1,1);
                  %plot(t1,exponential);
                  tth = [tth,t1];
                  ht = [ht,exponential];
                  grid on;
                  hold on;
                  nfft = length(exponential);
                  nfft2 = 2^nextpow2(nfft);
                  ff = fft(exponential,nfft2);
                  subplot(4,2,4);
                  plot(fftshift(abs(ff)));
                  grid on;
                  hold on;
         %Sinusoid         
         elseif type == 6       
                  amp = input('Enter sinusoid amplitude : ');
                  f = input('Enter sinusoid frequency : ');
                  theta = input('Enter phase angle : ');
                  dcShift = input('Enter dc shift angle : ');
                  t = txh(i):1/fs:txh(i+1);
                  t1 = linspace(txh(i),txh(i+1),400);
                  sinusoid = amp*sin(2*pi*f*t1 + theta) + dcShift;
                  %subplot(3,1,1);
                  %plot(t1,sinusoid + dcShift);
                  tth = [tth,t1];
                  ht = [ht,sinusoid];
                  grid on;
                  hold on;
                  nfft = length(sinusoid);
                  nfft2 = 2^nextpow2(nfft);
                  ff = fft(sinusoid,nfft2);
                  subplot(4,2,4);
                  plot(fftshift(abs(ff)));
                  grid on;
                  hold on;
         %Triangular         
         elseif type == 7  
                  amp = input('Enter sawtooth amplitude : ');
                  f = input('Enter sawtooth frequency : ');
                  theta = input('Enter phase angle : ');
                  dcShift = input('Enter dc shift angle : ');
                  t = txh(i):1/fs:txh(i+1);
                  t1 = linspace(txh(i),txh(i+1),400);
                  triangular = amp*sawtooth(2*pi*f*t1 + theta) + dcShift;
                  %subplot(3,1,1);
                  %plot(t1,triangular + dcShift);
                  tth = [tth,t1];
                  ht = [ht,triangular];
                  grid on;
                  hold on;
                  nfft = length(triangular);
                  nfft2 = 2^nextpow2(nfft);
                  ff = fft(triangular,nfft2);
                  subplot(4,2,4);
                  plot(fftshift(abs(ff)));
                  grid on;
                  hold on;    
        else
            disp('Error');
        end
        
    disp('==================');
    %d1 = subplot(3,1,1);
    d2h = subplot(4,2,4);
    d3h = subplot(4,2,3);
    subplot(4,2,3);
    plot(tth,ht); %plot the concatenated signal
    grid on;
    %ylim(d1,[-50 50]);
    %xlabel(d1,'t')
    %ylabel(d1,'F(t)');
    %title(d1,'Time Domain Signal');
    xlabel(d2h,'s')
    ylabel(d2h,'H(s)');
    title(d2h,'Impulse response frequency Domain Signal');
    xlabel(d3h,'t')
    ylabel(d3h,'h(t)');
    title(d3h,'Impulse response Signal');
    set(gcf, 'units', 'normalized');
    set(gcf, 'Position', [0, 0.1, 1, 0.9])
end


out= ht;
end
