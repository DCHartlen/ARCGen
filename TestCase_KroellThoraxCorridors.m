fclose all;
close all;
clear;
clc;

%% Three parabolas used in paper
% Load data
load('Data/Kroell 1971 Thorax Response/KroellThoraxResponse_1971.mat')

figure();
hold on;
cmap = cbrewer2('Paired',length(responseCurves));
for iPlot = 1:length(responseCurves)
    pExp = plot(responseCurves(iPlot).data(:,1),...
        responseCurves(iPlot).data(:,2),...
        'DisplayName','Exp.',...
        'LineWidth',1,'Color',0.7.*[1,1,1]);
end

load('Data/Kroell 1971 Thorax Response/KroellThoraxCorridors.mat')
pAvg = plot(charAvg(:,1),charAvg(:,2),'-',...
    'DisplayName','Char. Avg. - ARCGen','MarkerSize',16,...
    'LineWidth',2.5,'Color',0.0.*[1,1,1]);
pArc = plot(innerCorr(:,1),innerCorr(:,2),'-','MarkerSize',16,...
    'DisplayName','Corridors  - ARCGen',...
    'LineWidth',2.0,'Color',[255, 213, 79]./255);
pOuter = plot(outerCorr(:,1),outerCorr(:,2),'-','MarkerSize',16,...
    'DisplayName','Outer - ARCGen',...
    'LineWidth',2.0,'Color',[255, 213, 79]./255);

Lobdell = readmatrix('Data/Kroell 1971 Thorax Response/Lobdell 16mph Corridors.csv');

pLobdell = plot(Lobdell(:,1)+0.5,Lobdell(:,2)-150,'',...
    'LineWidth',2.5,'Color',[55,126,184]./255,...
    'DisplayName','Char. Avg. - Lobdell 1975');
pLobCorr = plot(Lobdell(:,3)+0.5,Lobdell(:,4)-150,'o--',...
    'LineWidth',2,'Color',[55,126,184]./255,...
    'DisplayName','Corridors - Lobdell 1975');
plot(Lobdell(:,5)+0.5,Lobdell(:,6)-150,'o--',...
    'LineWidth',2,'Color',[55,126,184]./255,...
    'DisplayName','Outer. - Lobdell 1975');

legend([pExp,pAvg,pArc,pLobdell,pLobCorr],'Location','best')
xlim([0,4.5])
ylim([0,1200])

title('Kroell et al (1971) 16 MPH Thorax Impact')