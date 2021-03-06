% START FIGURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure - Temps, RHs, Conc
Fig = figure;  % A three window plot

hold on

grid on

DayForPlot = 21;

DayStr = int2str(DayForPlot);

Title1 = ['Regenerator Performance - July ' DayStr];

% Create textbox
% annotation(Fig,'textbox',...
%     'String',Title1,...
%     'FontSize',16,...
%     'FitBoxToText','off',...
%     'EdgeColor','none',...
%     'Position',[0.1 0.9 0.9 0.1]);


% set(Fig, 'Name','July 10')

% Load times
% Load first range of dates for data
% N = datenum(Y, M, D, H, MN, S)
Start = datenum(2008, 7, DayForPlot, 7, 10, 0);
End = datenum(2008, 7, DayForPlot, 17, 50, 0);
StartIndx = find(Hr.DT>=Start);
EndIndx = find(Hr.DT>=End);
Hr.Mask = StartIndx(1):(EndIndx(1)-1);

%datevec(Hr.DT(EndIndx(1)))
%datevec(Hr.DT(StartIndx(1)))
DateFormat1 = 15;

%datevec(Hr.DT)
% Start  sub plot plot
% temperatures; 
a1 = subplot(3,1,1);
p1 = plot(Hr.DT(Hr.Mask),...
        [...
        Hr.R.COP_Air(Hr.Mask), ...
        Hr.R.COP_Des(Hr.Mask) ...
        ]);
set(p1(1),'Marker','o','LineStyle',':');
set(p1(2),'Marker','s','LineStyle',':');
datetick('x',DateFormat1)
ylabel('COP [-]')
xlabel('Time')
ylim([0 1.5]);
title(Title1)
legend(...
    'Air COP','Des COP','Location','Best' ...
    )
%set(gca,'XTick',Hr.Ticks) % Doesn't work?
% End plot

% Start sub plot
% 3 temps; ambient, process, calibrated
a2 = subplot(3,1,2);
p1 = plot(Hr.DT(Hr.Mask),[...
    Hr.R.HW.Temp.In(Hr.Mask), ...
    Hr.R.HW.Temp.Out(Hr.Mask) ...    
    ]);
set(p1(1),'Marker','^','LineStyle','--');
set(p1(2),'Marker','s','LineStyle','--');
%set(gca,'XTick',[1,2,3,4,5,6]) % Doesn't work?
datetick('x',DateFormat1)
ylabel('Temperature [C]')
xlabel('Time')
 ylim([20 100]);
title('Temperatures')
legend(...
    'Hot water inlet','Hot water outlet','Location','Best' ...
    )
% End plot

% Start sub plot
% 3 absolute humidities; ambient, process, calibrated
a3 = subplot(3,1,3);
p1 = plot(Hr.DT(Hr.Mask),[...
        Hr.R.WR_Air(Hr.Mask), ...
        Hr.R.WR_Des(Hr.Mask), ...
    ]);
%set(gca,'XTick',[1,2,3,4,5,6]) % Doesn't work?
set(p1(1),'Marker','^','LineStyle','--');
set(p1(2),'Marker','s','LineStyle','--');
datetick('x',DateFormat1)
ylabel('Water Desoprtion Rate [kg/hr]')
xlabel('Time')
ylim([0 75]);
title('Water desorption from desiccant to scavenging air')
legend(...
    'Air WR','Des WR','Location','Best' ...
    )
% End plot

linkaxes([a1 a2 a3], 'x');


% xlim([Hr.DT(StartIndx(1)) Hr.DT(EndIndx(1)-1)]);

set(a1,'XGrid','on','YGrid','on');
set(a2,'XGrid','on','YGrid','on');
set(a3,'XGrid','on','YGrid','on');

% set(Fig,'PaperPositionMode', 'manual');

hold off
    
% End plot
% END FIGURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear a1 a2 a3 ;