%Signal Generator%

%clear all ; 
close all ; 
clc ; 

fs = input('Enter sampling frequecny : ');
tS = input('Enter start of time scale : ');
tE = input('Enter end of time scale : ');
%tT = tS:1/fs:tE; 
%-----------------------------------------------%
n = input('Enter number of breakpoints : ');

disp('--------------------------');

tx = 1*(2*n);%array for time(rows x columns) 
for i=1:1:(2*n-(n-2))
    tx(i) = input('Enter position of breakpoint  : ');
   if tx(i) < tS
        tx(i) = tS;
   end
    if tx(i) > tE 
        tx(i) = tE;
    end
end 

disp('--------------------------');
fn = [];
tt = [];

for i=1:1:(n+1) 
    %hold on;
  %  typex = menu('Available Signals','impulse','DC','ramp','parabola','exp','sinusoid','triang');
    type = input('Enter type of signal : ');
        %impulse
        if type == 1
            amp = input('Enter impulse amplitude : ');
            t = tx(i):1/fs:tx(i+1);
            t1 = linspace(tx(i),tx(i+1));
            impulse = (t1-(tx(i+1)\2))==0;
            subplot(3,1,1);
            stem(t1,impulse); 
            tt = [tt t1];
            fn = [fn impulse];
            hold on
            nfft = length(impulse);
            nfft2 = 2^nextpow2(nfft);
            ff = fft(impulse,nfft2);
            subplot(3,1,2);
            plot(abs(ff));
            hold on;
        %DC
        elseif type == 2
                 amp = input('Enter DC amplitude : ');
                 t = tx(i):1/fs:tx(i+1); 
                 t1 = linspace(tx(i),tx(i+1),400);
                 DC = amp*ones(1,length(t1));
                 subplot(3,1,1);
                 plot(t1,DC); 
                 tt = [tt,t1];
                 fn = [fn,DC];
                 grid on;
                 hold on;
                 nfft = length(DC);
                 nfft2 = 2^nextpow2(nfft);
                 ff = fft(step,nfft2);
                 subplot(3,1,2);
                 plot(abs(ff));
                 grid on;
                 hold on;
         %Ramp        
         elseif type == 3
                s = input('Enter ramp slope : ');
                t = tx(i):1/fs:tx(i+1);
                t1 = linspace(tx(i),tx(i+1),400);
                ramp = s*t1;
                subplot(3,1,1);
                plot(t1,ramp); 
                tt = [tt,t1];
                fn = [fn,ramp];
                grid on;
                hold on;
                nfft = length(ramp);
                nfft2 = 2^nextpow2(nfft);
                ff = fft(ramp,nfft2);
                subplot(3,1,2);
                plot(abs(ff));
                grid on;
                hold on;
        %Parabola        
        elseif type == 4
                 amp = input('Enter parabola amplitude : ');
                 t = tx(i):1/fs:tx(i+1);
                 t1 = linspace(tx(i),tx(i+1),400);
                 parabola= amp*t1.^2;
                 subplot(3,1,1);
                 plot(t1,parabola);
                 tt = [tt,t1];
                 fn = [fn,parabola];
                 grid on;
                 hold on;
                 nfft = length(parabola);
                 nfft2 = 2^nextpow2(nfft);
                 ff = fft(parabola,nfft2);
                 subplot(3,1,2);
                 plot(abs(ff));
                 grid on;
                 hold on;
        %Exponential         
        elseif type == 5
                  amp = input('Enter exponential amplitude : ');
                  alpha = input('Enter the exponent : ');
                  t = tx(i):1/fs:tx(i+1);
                  t1 = linspace(tx(i),tx(i+1),400);
                  exponential = amp*exp(alpha*t1);
                  subplot(3,1,1);
                  plot(t1,exponential);
                  tt = [tt,t1];
                  fn = [fn,exponential];
                  grid on;
                  hold on;
                  nfft = length(exponential);
                  nfft2 = 2^nextpow2(nfft);
                  ff = fft(exponential,nfft2);
                  subplot(3,1,2);
                  plot(abs(ff));
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
                  subplot(3,1,1);
                  plot(t1,sinusoid + dcShift);
                  tt = [tt,t1];
                  fn = [fn,sinusoid];
                  grid on;
                  hold on;
                  nfft = length(sinusoid);
                  nfft2 = 2^nextpow2(nfft);
                  ff = fft(sinusoid,nfft2);
                  subplot(3,1,2);
                  plot(abs(ff));
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
                  subplot(3,1,1);
                  plot(t1,triangular + dcShift);
                  tt = [tt,t1];
                  fn = [fn,triangular];
                  grid on;
                  hold on;
                  nfft = length(triangular);
                  nfft2 = 2^nextpow2(nfft);
                  ff = fft(triangular,nfft2);
                  subplot(3,1,2);
                  plot(abs(ff));
                  grid on;
                  hold on;    
        else
            disp('Error');
        end
        
    d1 = subplot(3,1,1);
    d2 = subplot(3,1,2);
    d3 = subplot(3,1,3);
    subplot(3,1,3);
    plot(tt,fn); %plot the concatenated signal
    grid on;
    ylim(d1,[-50 50]);
    xlabel(d1,'t')
    ylabel(d1,'F(t)');
    title(d1,'Time Domain Signal');
    xlabel(d2,'f')
    ylabel(d2,'F(s)');
    title(d2,'Frequency Domain Signal');
    xlabel(d3,'t')
    ylabel(d3,'F(t)');
    title(d3,'Final Concatenated Signal');
    set(gcf, 'units', 'normalized');
    set(gcf, 'Position', [0, 0.1, 1, 0.9])
end
disp('full signal');
%END
