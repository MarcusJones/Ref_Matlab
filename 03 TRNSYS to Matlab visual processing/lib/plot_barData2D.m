%% Integrate the power column for each month, store in a n x 12 array
% The headers will be in one column array

function plot_barData2D(bDataPowerAll, trnTime)

[Y, M, D, H, MN, S] = datevec(trnTime.time(2) - trnTime.time(1));
Interval = H + MN/60 + S/3600;

powerMatrix = [];
powerConsumers = {};
powerMonths = {};
% Loop each power point;
for iPwrPoint = 1:length(bDataPowerAll);
    % Loop each month
    powerConsumers{iPwrPoint} = bDataPowerAll{iPwrPoint}.description;
    startDnum = datevec(trnTime.time(1));
    startYear = datevec(trnTime.time(1));
    startYear = startYear(1);
    for iMonth = 2:13
        currStartDnum = datenum(startYear,iMonth-1,0,0,0,0);
        currEndDnum = datenum(startYear,iMonth,0,0,0,0);
        powerMonths{iMonth-1} = datestr(currEndDnum,'mmm');
        %currEndDnum - currStartDnum
        currMask =((trnTime.time>=currStartDnum) & (trnTime.time<=currEndDnum));
        powerMatrix(iPwrPoint,iMonth-1) = sum(bDataPowerAll{iPwrPoint}.data(currMask))*Interval;
    end
end

% Sum all the monthly values
barDataTotal = sum(powerMatrix/1000,2);
barDataGrandTotal = sum(barDataTotal);


%barDataTotal = sort(barDataTotal,'descend');
%figure
%hold on
bar(barDataTotal);

set(gca,'XTickLabelMode','manual');
set(gca,'XTick',1:length(bDataPowerAll));
set(gca,'XTickLabel',powerConsumers);
ylabel('Energy [MWh]');
rotateticklabel(gca,90);

xAxisLimits = get(gca,'XLim');
yAxisLimits = get(gca,'YLim');

text(xAxisLimits(2)*0.7,yAxisLimits(2)*0.9,1,sprintf('Total energy consumption: %1.0f MWh',barDataGrandTotal),'FontName','Arial','FontWeight','Bold')





end