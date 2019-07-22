function [out] = inputfn


%Signal Generator%

%clear all ; 
close all ; 
clc ; 

fs = input('Enter sampling frequecny : ');
tS = input('Enter start of time scale for input signal : ');
tE = input('Enter end of time scale for input signal : ');
%tT = tS:1/fs:tE; 
%-----------------------------------------------%
n = input('Enter number of breakpoints of input signal : ');

disp('--------------------------');

tTemp = 2*n;
for i=1:1:n
    tTemp(i) = input('Enter position of breakpoint  : ');
   if tTemp(i) < tS
        tTemp(i) = tS;
   end
    if tTemp(i) > tE 
        tTemp(i) = tE;
    end
end 
tx(1)=tS;
tx(n+2)=tE;

for i=2:1:(n+1)
    
   tx(i)=tTemp(i-1); 
end

disp('--------------------------');
fn = [];
tt = [];

for i=1:1:(n+1) 
    %hold on;
    %type = menu('Available Signals','Impulse','DC','Ramp','Parabola','Exponential','Sinusoid','Triangular');
    type = input('Enter type of signal : ');
   
        %impulse
        if type == 1
            amp = input('Enter impulse amplitude : ');
            t = tx(i):1/fs:tx(i+1);
            t1 = linspace(tx(i),tx(i+1));
            s = input('Enter impulse shift : ');
            impulse = amp*(t1==s);
            %impulse = zeros(size(t1));
            %impulse(t1==s) = 1;
            %subplot(3,2,1);
            %stem(t1,impulse); 
            tt = [tt t1];
            fn = [fn impulse];
            hold on
            nfft = length(impulse);
            nfft2 = 2^nextpow2(nfft);
            ff = fft(impulse,nfft2);
            subplot(4,2,2);
            plot(abs(ff));
            hold on;
        %DC
        elseif type == 2
                 amp = input('Enter DC amplitude : ');
                 t = tx(i):1/fs:tx(i+1); 
                 t1 = linspace(tx(i),tx(i+1),400);
                 DC = amp*ones(1,length(t1));
                 %subplot(3,2,1);
                 %plot(t1,DC); 
                 tt = [tt,t1];
                 fn = [fn,DC];
                 grid on;
                 hold on;
                 nfft = length(DC);
                 nfft2 = 2^nextpow2(nfft);
                 ff = fft(DC,nfft2);
                 subplot(4,2,2);
                 plot(abs(ff));
                 grid on;
                 hold on;
         %Ramp        
         elseif type == 3
                s = input('Enter ramp slope : ');
                intercept = input('Enter ramp intercept : ');
                t = tx(i):1/fs:tx(i+1);
                t1 = linspace(tx(i),tx(i+1),400);
                ramp = s*t1 + intercept;
                %subplot(3,2,1);
                %plot(t1,ramp); 
                tt = [tt,t1];
                fn = [fn,ramp];
                grid on;
                hold on;
                nfft = length(ramp);
                nfft2 = 2^nextpow2(nfft);
                ff = fft(ramp,nfft2);
                subplot(4,2,2);
                plot(fftshift(abs(ff)));
                grid on;
                hold on;
        %Parabola        
        elseif type == 4
                 amp = input('Enter parabola amplitude : ');
                 t = tx(i):1/fs:tx(i+1);
                 t1 = linspace(tx(i),tx(i+1),400);
                 parabola= amp*t1.^2;
                 %subplot(3,2,1);
                 %plot(t1,parabola);
                 tt = [tt,t1];
                 fn = [fn,parabola];
                 grid on;
                 hold on;
                 nfft = length(parabola);
                 nfft2 = 2^nextpow2(nfft);
                 ff = fft(parabola,nfft2);
                 subplot(4,2,2);
                 plot(fftshift(abs(ff)));
                 grid on;
                 hold on;
        %Exponential         
        elseif type == 5
                  amp = input('Enter exponential amplitude : ');
                  alpha = input('Enter the exponent : ');
                  t = tx(i):1/fs:tx(i+1);
                  t1 = linspace(tx(i),tx(i+1),100);
                  exponential = amp*exp(alpha*t1);
                  %subplot(3,2,1);
                  %plot(t1,exponential);
                  tt = [tt,t1];
                  fn = [fn,exponential];
                  grid on;
                  hold on;
                  nfft = length(exponential);
                  nfft2 = 2^nextpow2(nfft);
                  ff = fft(exponential,nfft2);
                  subplot(4,2,2);
                  plot(fftshift(abs(ff)));
                  grid on;
                  hold on;
         %Sinusoid         
         elseif type == 6       
                  amp = input('Enter sinusoid amplitude : ');
                  f = input('Enter sinusoid frequency : ');
                  theta = input('Enter phase angle : ');
                  dcShift = input('Enter dc shift angle : ');
                  t = tx(i):1/fs:tx(i+1);
                  t1 = linspace(tx(i),tx(i+1),400);
                  sinusoid = amp*sin(2*pi*f*t1 + theta) + dcShift;
                  %subplot(3,2,1);
                  %plot(t1,sinusoid + dcShift);
                  tt = [tt,t1];
                  fn = [fn,sinusoid];
                  grid on;
                  hold on;
                  nfft = length(sinusoid);
                  nfft2 = 2^nextpow2(nfft);
                  ff = fft(sinusoid,nfft2);
                  subplot(4,2,2);
                  plot(fftshift(abs(ff)));
                  grid on;
                  hold on;
         %Triangular         
         elseif type == 7  
                  amp = input('Enter sawtooth amplitude : ');
                  f = input('Enter sawtooth frequency : ');
                  theta = input('Enter phase angle : ');
                  dcShift = input('Enter dc shift angle : ');
                  t = tx(i):1/fs:tx(i+1);
                  t1 = linspace(tx(i),tx(i+1),400);
                  triangular = amp*sawtooth(2*pi*f*t1 + theta) + dcShift;
                  %subplot(3,2,1);
                  %plot(t1,triangular + dcShift);
                  tt = [tt,t1];
                  fn = [fn,triangular];
                  grid on;
                  hold on;
                  nfft = length(triangular);
                  nfft2 = 2^nextpow2(nfft);
                  ff = fft(triangular,nfft2);
                  subplot(4,2,2);
                  plot(fftshift(abs(ff)));
                  grid on;
                  hold on;    
        else
            disp('Error');
        end
        
    disp('==================');
    %d1 = subplot(3,2,1);
    d2 = subplot(4,2,2);
    d3 = subplot(4,2,1);
    subplot(4,2,1);
    plot(tt,fn); %plot the concatenated signal
    grid on;
    %ylim(d1,[-50 50]);
    %xlabel(d1,'t')
    %ylabel(d1,'F(t)');
    %title(d1,'Time Domain Signal');
    xlabel(d2,'f')
    ylabel(d2,'F(s)');
    title(d2,'Frequency Domain Signal');
    xlabel(d3,'t')
    ylabel(d3,'F(t)');
    title(d3,'Time domain Signal');
    set(gcf, 'units', 'normalized');
    set(gcf, 'Position', [0, 0.1, 1, 0.9])
end




out=fn;
end