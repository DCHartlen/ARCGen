fclose all;
% close all;
clear;
clc;
addpath('ThirdPartyFunctions')

nResample = 500;
smfact = 1;

xlimits = [0,4.5];
ylimits = [0,1200];

lobdellCorrs = readmatrix('Data/Kroell 1971 Thorax Response/Lobdell 16mph Corridors.csv');
charAvgLobdell = lobdellCorrs(:,1:2);
charAvgLobdell = [charAvgLobdell(:,1)+0.5, charAvgLobdell(:,2)-150];
innCorrLobdell = lobdellCorrs(~isnan(lobdellCorrs(:,3)),3:4);
innCorrLobdell = [innCorrLobdell(:,1)+0.5, innCorrLobdell(:,2)-150];
outCorrLobdell = lobdellCorrs(~isnan(lobdellCorrs(:,5)),5:6);
outCorrLobdell = [outCorrLobdell(:,1)+0.5, outCorrLobdell(:,2)-150];

%% Plot just the Kroell data and corridors
load('Data/Kroell 1971 Thorax Response/KroellThoraxResponse_1971.mat')
figure('Name','No Normalization');
hold on;
cmap = cbrewer2('Paired',length(responseCurves));
for iPlot = 1:length(responseCurves)
    plot(responseCurves(iPlot).data(:,1),...
        responseCurves(iPlot).data(:,2),...
        'DisplayName',responseCurves(iPlot).specId,...
        'LineWidth',1,'Color',cmap(iPlot,:));
end

legend('Location', 'Best')
xlim(xlimits)
ylim(ylimits)
grid on
xlabel('Deflection (in)')
ylabel('Force (lb)')


%% Generate corridors without magnitude normalization
% Load data
load('Data/Kroell 1971 Thorax Response/KroellThoraxResponse_1971.mat')

[charAvgNoNorm, innCorrNoNorm, outCorrNoNorm,proCurveDataNoNorm] = ...
    ARCGen_Ellipse(responseCurves,...
    'Diagnostics', 'off',...
    'nResamplePoints', nResample,...
    'NormalizeCurves', 'off',...
    'handleOutliers', 'off',...
    'CorridorRes', 100,...
    'EllipseKFact', 1.00);

figure('Name','No Normalization');
hold on;
for iPlot = 1:length(responseCurves)
    pExp = plot(responseCurves(iPlot).data(:,1),...
        responseCurves(iPlot).data(:,2),...
        'DisplayName','Exp.',...
        'LineWidth',1,'Color',0.7.*[1,1,1]);
end

pAvgLob = plot(charAvgLobdell(:,1),charAvgLobdell(:,2),'-',...
    'DisplayName','Char. Avg. - Lobdell','MarkerSize',16,...
    'LineWidth',2.0,'Color',[55,126,184]./255);
pCorrLob = plot(innCorrLobdell(:,1),innCorrLobdell(:,2),'o-','MarkerSize',6,...
    'DisplayName','Corridors - Lobdell',...
    'LineWidth',1.0,'Color',[55,126,184]./255);
p = plot(outCorrLobdell(:,1),outCorrLobdell(:,2),'o-','MarkerSize',6,...
    'DisplayName','Outer',...
    'LineWidth',1.0,'Color',[55,126,184]./255);

pAvg = plot(charAvgNoNorm(:,1),charAvgNoNorm(:,2),'.-',...
    'DisplayName','Char. Avg. - ARCGen','MarkerSize',16,...
    'LineWidth',2.5,'Color',[0,0,0]);
pCorr = plot(innCorrNoNorm(:,1),innCorrNoNorm(:,2),'.-','MarkerSize',16,...
    'DisplayName','Corridors - ARCGen',...
    'LineWidth',2.0,'Color',[255, 213, 79]./255);
p = plot(outCorrNoNorm(:,1),outCorrNoNorm(:,2),'.-','MarkerSize',16,...
    'DisplayName','Outer',...
    'LineWidth',2.0,'Color',[196, 147, 0]./255);

legend([pExp,pAvg,pCorr,pAvgLob,pCorrLob], 'Location', 'Best')
xlim(xlimits)
ylim(ylimits)
grid on
xlabel('Deflection (in)')
ylabel('Force (lb)')

%% Generate corridors with magnitude normalization
% Load data
load('Data/Kroell 1971 Thorax Response/KroellThoraxResponse_1971.mat')

[charAvgNorm, innCorrNorm, outCorrNorm ,proCurveDataNorm] = ...
    ARCGen_Ellipse(responseCurves,...
    'Diagnostics', 'on',...
    'nResamplePoints', nResample,...
    'NormalizeCurves', 'on',...
    'handleOutliers', 'off',...
    'CorridorRes', 500,...
    'EllipseKFact', 1.00,...
    'nWarpCtrlPts', 2,...
    'warpingPenalty', 1e-2);

figure('Name','Normalization');
hold on;
for iPlot = 1:length(responseCurves)
    pExp = plot(responseCurves(iPlot).data(:,1),...
        responseCurves(iPlot).data(:,2),...
        'DisplayName','Exp.',...
        'LineWidth',1,'Color',0.7.*[1,1,1]);
end

pAvgLob = plot(charAvgLobdell(:,1),charAvgLobdell(:,2),'-',...
    'DisplayName','Char. Avg. - Lobdell','MarkerSize',16,...
    'LineWidth',2.0,'Color',[55,126,184]./255);
pCorrLob = plot(innCorrLobdell(:,1),innCorrLobdell(:,2),'o-','MarkerSize',6,...
    'DisplayName','Corridors - Lobdell',...
    'LineWidth',1.0,'Color',[55,126,184]./255);
p = plot(outCorrLobdell(:,1),outCorrLobdell(:,2),'o-','MarkerSize',6,...
    'DisplayName','Outer',...
    'LineWidth',1.0,'Color',[55,126,184]./255);

pAvg = plot(charAvgNorm(:,1),charAvgNorm(:,2),'.-',...
    'DisplayName','Char. Avg.','MarkerSize',16,...
    'LineWidth',2.5,'Color',[0,0,0]);
pCorr = plot(innCorrNorm(:,1),innCorrNorm(:,2),'.-','MarkerSize',16,...
    'DisplayName','Corridors',...
    'LineWidth',2.0,'Color',[255, 213, 79]./255);
p = plot(outCorrNorm(:,1),outCorrNorm(:,2),'.-','MarkerSize',16,...
    'DisplayName','Outer',...
    'LineWidth',2.0,'Color',[196, 147, 0]./255);

legend([pExp,pAvg,pCorr,pAvgLob,pCorrLob], 'Location', 'Best')
xlim(xlimits)
ylim(ylimits)
grid on
xlabel('Deflection (in)')
ylabel('Force (lb)')