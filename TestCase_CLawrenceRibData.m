fclose all;
close all;
clear;
clc;

load('Data/Lawrence Rib Data/CLawrence_RibData_Compiled_20210528.mat')

smFact = 10;
nResamp = 200;
nCorrPts = 200;

% Correct for negative displacement and plot
cmap = cbrewer2('paired',16);
lStyles = {'-','--',':','-.'}';
lStyles = repelem(lStyles,round(size(responseCurves,2)/4));

figure('Name','ExperimentalData'); hold on;
for iCurve = 1:size(responseCurves,2)
    responseCurves(iCurve).data = responseCurves(iCurve).data.*[-1,1];
    responseCurves(iCurve).data = ...
        [smooth(responseCurves(iCurve).data(:,1),smFact),...
         smooth(responseCurves(iCurve).data(:,2),smFact)];
     
    plot(responseCurves(iCurve).data(:,1),...
        responseCurves(iCurve).data(:,2),...
        'DisplayName',responseCurves(iCurve).specId,...
        'LineWidth',1.5,...
        'Color',cmap(iCurve,:),...
        'LineStyle',lStyles{iCurve});
end
xlabel('Displacement')
ylabel('Force')
legend('Location','EastOutside')
xlim([0,50])
ylim([0,140])
grid on

%% Execute ARCGen
[charAvg, innerCorr, outerCorr, processedData] = ...
    ARCGen_Ellipsoidal(responseCurves,...
    'Diagnostics',     'on',...
    'nResamplePoints',  nResamp,...
    'NormalizeCurves', 'on',...
    'CorridorRes',      nCorrPts,....
    'EllipseKFact',     1);

% Plot responses, corridors, and averages
figure()
hold on;
for iCurve = 1:size(responseCurves,2)
    pExp = plot(responseCurves(iCurve).data(:,1),...
        responseCurves(iCurve).data(:,2),...
        'DisplayName',responseCurves(iCurve).specId,...
        'LineWidth',0.75,...
        'Color',0.8*[1,1,1]);
end

pAvg = plot(charAvg(:,1),charAvg(:,2),'.-',...
    'DisplayName','Char. Avg. - ARCGen','MarkerSize',16,...
    'LineWidth',2.5,'Color',[0,0,0]);
pInn = plot(innerCorr(:,1),innerCorr(:,2),'.-','MarkerSize',16,...
    'DisplayName','Corridors - ARCGen',...
    'LineWidth',2.0,'Color',[255, 213, 79]./255);
pOut = plot(outerCorr(:,1),outerCorr(:,2),'.-','MarkerSize',16,...
    'DisplayName','Outer',...
    'LineWidth',2.0,'Color',[196, 147, 0]./255);

xlabel('Displacement')
ylabel('Force')
legend([pExp,pAvg,pInn,pOut],...
    {'Input Curves','Char. Average','Inner Corridor \pm 1\sigma',...
    'Outer Corridor \pm 1\sigma'},...
    'Location','SouthEast')
xlim([0,50])
ylim([0,140])
grid on