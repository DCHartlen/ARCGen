fclose all;
close all;
clear;
clc;

smfact = 1;

% %% Generate corridors without magnitude normalization
% % NOTE: you need to up nResample and corridorRes because the lack of
% % normalization prevents the ellipse from touching. 
% nResample = 200;
% xlimits = [0,2.0];
% ylimits = [0,160];
% % Load data
% load('Data/Lessley Parabolas/Lessley_Parabola_Processed.mat')
% % remove the outlier curve for now
% invalidCurves = [4];
% validIndices = not([1:length(responseCurves)]==invalidCurves);
% responseCurves = responseCurves(validIndices);
% 
% [charAvgNoNorm, innCorrNoNorm, outCorrNoNorm,proCurveDataNoNorm] = ...
%     ARCGen_Ellipsoidal(responseCurves,...
%     'Diagnostics', 'off',...
%     'nResamplePoints', nResample,...
%     'NormalizeCurves', 'off',...
%     'handleOutliers', 'off',...
%     'CorridorRes', 200,...
%     'EllipseKFact', 1.0);
% 
% figure('Name','No Normalization');
% hold on;
% for iPlot = 1:length(proCurveDataNoNorm)
%     pExp = plot(proCurveDataNoNorm(iPlot).data(:,1),...
%         proCurveDataNoNorm(iPlot).data(:,2),...
%         'DisplayName','Exp.',...
%         'LineWidth',1,'Color',0.7.*[1,1,1]);
% end
% 
% pAvg = plot(charAvgNoNorm(:,1),charAvgNoNorm(:,2),'.-',...
%     'DisplayName','Char. Avg. - ARCGen','MarkerSize',16,...
%     'LineWidth',2.5,'Color',[0,0,0]);
% pCorr = plot(innCorrNoNorm(:,1),innCorrNoNorm(:,2),'.-','MarkerSize',16,...
%     'DisplayName','Corridors - ARCGen',...
%     'LineWidth',2.0,'Color',[255, 213, 79]./255);
% p = plot(outCorrNoNorm(:,1),outCorrNoNorm(:,2),'.-','MarkerSize',16,...
%     'DisplayName','Outer',...
%     'LineWidth',2.0,'Color',[196, 147, 0]./255);
% 
% legend([pExp,pAvg,pCorr], 'Location', 'Best')
% xlim(xlimits)
% ylim(ylimits)
% grid on
% xlabel('X-Comp')
% ylabel('Y-Comp')

%% Generate corridors with magnitude normalization
nResample = 100;
xlimits = [0,2.0];
ylimits = [0,160];
% Load data
load('Data/Lessley Parabolas/Lessley_Parabola_Processed.mat')
% remove the outlier curve for now
invalidCurves = [4];
validIndices = not([1:length(responseCurves)]==invalidCurves);
responseCurves = responseCurves(validIndices);

[charAvgNorm, innCorrNorm, outCorrNorm,proCurveDataNorm] = ...
    ARCGen_Ellipsoidal(responseCurves,...
    'Diagnostics', 'on',...
    'nResamplePoints', nResample,...
    'NormalizeCurves', 'on',...
    'handleOutliers', 'off',...
    'CorridorRes', 100,...
    'EllipseKFact', 1.0);

figure('Name','Normalization');
hold on;
for iPlot = 1:length(proCurveDataNorm)
    pExp = plot(proCurveDataNorm(iPlot).data(:,1),...
        proCurveDataNorm(iPlot).data(:,2),...
        'DisplayName','Exp.',...
        'LineWidth',1,'Color',0.7.*[1,1,1]);
end

pAvg = plot(charAvgNorm(:,1),charAvgNorm(:,2),'.-',...
    'DisplayName','Char. Avg. - ARCGen','MarkerSize',16,...
    'LineWidth',2.5,'Color',[0,0,0]);
pCorr = plot(innCorrNorm(:,1),innCorrNorm(:,2),'.-','MarkerSize',16,...
    'DisplayName','Corridors - ARCGen',...
    'LineWidth',2.0,'Color',[255, 213, 79]./255);
p = plot(outCorrNorm(:,1),outCorrNorm(:,2),'.-','MarkerSize',16,...
    'DisplayName','Outer',...
    'LineWidth',2.0,'Color',[196, 147, 0]./255);

legend([pExp,pAvg,pCorr], 'Location', 'Best')
xlim(xlimits)
ylim(ylimits)
grid on
xlabel('X-Comp')
ylabel('Y-Comp')

% %% Generate corridors, including outlier
% nResample = 100;
% xlimits = [0,2.5];
% ylimits = [0,480];
% % Load data
% load('Data/Lessley Parabolas/Lessley_Parabola_Processed.mat')
% 
% [charAvgOutlier, innCorrOutlier, outCorrOutlier,proCurveDataOutlier] = ...
%     ARCGen_Ellipsoidal(responseCurves,...
%     'Diagnostics', 'off',...
%     'nResamplePoints', nResample,...
%     'NormalizeCurves', 'on',...
%     'handleOutliers', 'off',...
%     'CorridorRes', 100,...
%     'EllipseKFact', 1.0);
% 
% figure('Name','Normalization with Outlier');
% hold on;
% for iPlot = 1:length(proCurveDataOutlier)
%     pExp = plot(proCurveDataOutlier(iPlot).data(:,1),...
%         proCurveDataOutlier(iPlot).data(:,2),...
%         'DisplayName','Exp.',...
%         'LineWidth',1,'Color',0.7.*[1,1,1]);
% end
% 
% pAvg = plot(charAvgOutlier(:,1),charAvgOutlier(:,2),'.-',...
%     'DisplayName','Char. Avg. - ARCGen','MarkerSize',16,...
%     'LineWidth',2.5,'Color',[0,0,0]);
% pCorr = plot(innCorrOutlier(:,1),innCorrOutlier(:,2),'.-','MarkerSize',16,...
%     'DisplayName','Corridors - ARCGen',...
%     'LineWidth',2.0,'Color',[255, 213, 79]./255);
% p = plot(outCorrOutlier(:,1),outCorrOutlier(:,2),'.-','MarkerSize',16,...
%     'DisplayName','Outer',...
%     'LineWidth',2.0,'Color',[196, 147, 0]./255);
% 
% legend([pExp,pAvg,pCorr], 'Location', 'Best')
% xlim(xlimits)
% ylim(ylimits)
% grid on
% xlabel('X-Comp')
% ylabel('Y-Comp')
