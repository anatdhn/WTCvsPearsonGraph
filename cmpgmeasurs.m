
function [s_pcoop,s_pcomp,s_wtccoop,s_wtccomp] = cmpgmeasurs(pcoop,pcomp,wtccoop,wtccomp)
s_pcoop = strengths_und(pcoop)
s_pcomp = strengths_und(pcomp)
s_wtccoop = strengths_und(wtccoop)
s_wtccomp = strengths_und(wtccomp)

pleffcoop = efficiency_wei(pcoop,2)
pleffcomp = efficiency_wei(pcomp,2)
wtcleffcoop = efficiency_wei(wtccoop,2)
wtcleffcomp = efficiency_wei(wtccomp,2)


%plefficiency = efficiency_wei(rMed,2);
%wtclefficiency = efficiency_wei(rSqureMed,2);
geff_pcoop = efficiency_wei(pcoop);
geff_pcomp = efficiency_wei(pcomp);
geff_wtccoop = efficiency_wei(wtccoop);
geff_wtccomp = efficiency_wei(wtccomp);
%wtcgefficiency = efficiency_wei(rSqureMed);

% figure
% 
% subplot(1,2,1)
% stem(plefficiency,'b')
% ylim([0 0.6])
% title('pearson local effciency')
% xlabel('channel')
% ylabel('local effciency')
% subplot(1,2,2)
% stem(wtclefficiency,'r')
% ylim([0 0.6])
% title('wtc local effciency')
% xlabel('channel')
% ylabel('local effciency')
% figure

%figure
subplot(1,2,1)
stem(s_pcoop,'b')
%ylim([0 2])
ylim([0 14])
title('pearson coop node strength')
xlabel('channel')
ylabel('node strength')
subplot(1,2,2)
stem(s_pcomp,'r')
%ylim([0 2])
ylim([0 14])
title('pearson comp node strength')
xlabel('channel')
ylabel('node strength')
figure

subplot(1,2,1)
stem(s_wtccoop,'b')
%ylim([0 2])
ylim([0 14])
title('WTC coop node strength')
xlabel('channel')
ylabel('node strength')
subplot(1,2,2)
stem(s_wtccomp,'r')
%ylim([0 2])
ylim([0 14])
title('WTC comp node strength')
xlabel('channel')
ylabel('node strength')
%figure
%figure
% subplot(1,2,2)
% figure
% stem(s_wtccoop,'b')
% 
% %ylim([0 12])
% title('wtc coop node strength')
% xlabel('channel')
% ylabel('node strength')
% subplot(1,2,1)
% stem(s_wtccoop,'b')
% %ylim([0 12])
% title('wtc comp node strength')
% xlabel('channel')
% ylabel('node strength')
% subplot(1,2,2)
% stem(s_wtccomp,'r')
%figure
%figure


% x = categorical(["pearson coop" "pearson comp"])
% y = [geff_pcoop geff_pcomp];
% ylim([0 0.6])
% bar(x,y)
% %xlabel('peason   wtc')
% ylabel('global efficiency')
% title('global efficiency')

figure
title('global efficiency')
x = categorical(["pearson" "wtc"])
y = [geff_pcoop geff_pcomp;geff_wtccoop geff_wtccomp]
y
%ylim([0 0.6])
%c = b.FaceColor

bar(x,y)
%b.FaceColor = [0 0.5]
%xlabel('peason   wtc')
ylabel('global efficiency')






%figure
%geffvalls = [geff_wtccoop geff_wtccomp]
