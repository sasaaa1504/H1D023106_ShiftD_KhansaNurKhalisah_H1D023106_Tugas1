%---------------------------------
%Jaringan Syaraf Tiruan
%untuk operasi OR dengan Mathlab
%---------------------------------

clear;
clc;

fb = fopen('HasilPerceptron.m','w');

% Input
P=[0 0 1 1;0 1 0 1];
[m n] = size(P);
fprintf(fb,'Data Input (P):\n');
for i=1:n,
    fprintf(fb, ' %1d %1d\n',P(:,i));
end;

%Target
T=[0 1 1 1];
fprintf(fb,'Target (T):\n');
fprintf(fb,' %1d\n',T);
plotpv (P,T);

%Bentuk jaringan syaraf dengan Perceptron
net=newp (minmax(P),1);
plotpv(P,T);
linehandle=plotpc (net.IW{1},net.b{1});

% Set error awal E=1
E=1;

% Kembalikan nilai bobot sesuai inisialisasi fungsinya
net=init(net);

fprintf(fb,'Bobot Input Awal (W) : %4.2f %4.2f\n',net.IW{1,1});
fprintf(fb,'Bobot Bias Awal (b) : %4.2f\n',net.b{1});
linehandle=plotpc(net.IW{1},net.b{1});
Epoh = 0;
MaxEpoh = 100;

% Pembelajaran: kerjakan sampai sum square error (SSE) = 0 atau Epoh > MaxEpoh
while (sse(E) & (Epoh<MaxEpoh))
    fprintf(fb,'\n');
    Epoh=Epoh+1;
    fprintf(fb,'Epoh ke-%1d\n',Epoh);
    [net,Y,E] = adapt(net,P,T);
    fprintf(fb,'Output Jaringan (Y) :');
    for i=1:n,
        fprintf(fb,' %1d ',Y(i));
    end;
    fprintf(fb,'\n');
    fprintf(fb,'Error Pelatihan (E) :');
    for i=1:n,
        fprintf(fb,' %1d ',E(i));
    end;
    fprintf(fb,'\n');
    fprintf(fb,'Bobot Input Baru (W) : %4.2f %4.2f\n',net.IW{1,1});
    fprintf(fb,'Bobot Bias Baru (b) : %4.2f\n',net.b{1});
    fprintf(fb,'Sum Square Error (SSE) : %4.2f\n',sse(E));
    linehandle=plotpc(net.IW{1},net.b{1},linehandle);
    drawnow;
    Y
    E
    pause;
end;
fprintf(fb,'\n\n');
fprintf(fb,'Bobot Input Akhir (W) : %4.2f %4.2f\n',net.IW{1,1});
fprintf(fb,'Bobot Bias Akhir (b) : %4.2f\n',net.b{1}); fprintf(fb,'\n');

% Vektor yang akan disimulasikan
p=[0.5 0.1 0.7 -0.2 1.2; 0.5 0.1 0.1 0.5 -0.2];
fprintf(fb,'Data Simulasi (p) :\n');
for i=1:size(p,2),
    fprintf(fb,'     %4.1f    %4.1f\n',p(:,i));
end;

% Simulasi
a = sim(net,p)
fprintf(fb,'Hasil Simulasi (a):\n');
fprintf(fb,' %1d\n',a);

plotpv (p,a);
ThePoint=findobj(gca,'type','line');
set(ThePoint, 'Color','red');
pause (2);
hold on;
plotpv(P,T);
plotpc (net.IW{1},net.b{1});
hold off;
fclose(fb);