
%s-c1 cooparation
%s-c2 resr
%s-c3-alone
%s - c4 - end ?
%s c5 ?


%s1 783        5951
%s2 3537        8263
%s3  2351        4878        7323
%s4  1714        2970        4468        5497        6882        7942        9195       12194
%s5 9856


%srate 7.6125
%two minutes= 913
%one minute 456%sub1 child, sub2 - mom

load('MCARE_d39_02a_preproc_002.mat')
%1,2,4,6,8:10,12:16

s = data_preproc.sub1.s
c1= s(:,1)
c2= s(:,2)
c3= s(:,3)
c4= s(:,4)
c5= s(:,5)
c1ind = find(c1')
c2ind =find(c2')
c3ind =find(c3')
c4ind =find(c4')
c5ind =find(c5')
r1 =c1ind(1):c4ind(1) %coo
r2 =c3ind(1):c4ind(2)  %rest
r3 =c2ind(1):c4ind(3)  %comp
r4 = c3ind(2):c4ind(4)  %rest2


 hb1coopsub1 = data_preproc.sub1.hbo(r1,[1:8,11,14:16]);
 hb1compsub1 = data_preproc.sub1.hbo(r3,[1:8,11,14:16]);
 hb1coopsub2 = data_preproc.sub2.hbo(r1,[1:8,11,14:16]);
 hb1compsub2 = data_preproc.sub2.hbo(r3,[1:8,11,14:16]);
% 
 DYAD39_coop(:,1:12) = hb1coopsub1;
 DYAD39_coop(:,13:24) = hb1coopsub2;
% 
 DYAD39_comp(:,1:12) = hb1compsub1;
DYAD39_comp(:,13:24) = hb1compsub2;
rcoop = rpearson(DYAD39_coop);
rcomp = rpearson(DYAD39_comp);

rsqcoop = WTC_nan(DYAD39_coop);
rsqcomp = WTC_nan(DYAD39_comp);
rsqdiff = rsqcoop-rsqcomp;

%hold on;

rdiff = rcoop-rcomp;
%figure;

subplot(1,2,1);

imagesc(rdiff); 
set(gca, 'CLim', [-1 1])

colorbar; 
title('pearson diff Matrix');
xlabel('Channel'); 
ylabel('Channel');

subplot(1,2,2);
imagesc(rsqdiff);
set(gca, 'CLim', [-1 1])

colorbar; 
title('WTC diff Matrix');
xlabel('Channel'); 
ylabel('Channel');
% %figure;
% 
[s_pcoop,s_pcomp,s_wtccoop,s_wtccomp] =cmpgmeasurs(rcoop,rcomp,rsqcoop,rsqcomp)
%xlswtite('sout','%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f',s_pcoop(1),s_pcoop(2),s_pcoop(3),s_pcoop(4),s_pcoop(5),s_pcoop(6),s_pcoop(7),s_pcoop(8),s_pcoop(9),s_pcoop(10),s_pcoop(11),s_pcoop(12),s_pcoop(13),s_pcoop(14),s_pcoop(15),s_pcoop(16),s_pcoop(17),s_pcoop(18),s_pcoop(19),s_pcoop(20),s_pcoop(21),s_pcoop(22),s_pcoop(23),s_pcoop(24))
%xlswrite('sout',s_pcoop)
%xlswrite('sout',s_pcomp)
%xlswrite('sout',s_wtccoop)
%xlswrite('sout',s_wtccomp)