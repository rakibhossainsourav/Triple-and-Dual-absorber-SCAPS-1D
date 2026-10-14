%% ============================================================
%  2D PARAMETER MAPPING
%  Cs3Bi2I9 vs MASnI3
%  PCE, Voc, Jsc and FF
%% ============================================================

clear;
clc;
close all;


%% ============================================================
% READ EXCEL FILE
%% ============================================================

filename = 'Na(Dual).xlsx';

T = readtable(filename);

disp(T);


%% ============================================================
% EXTRACT DATA
%% ============================================================

% Column 1 = Cs3Bi2I9
% Column 2 = MASnI3
% Column 3 = PCE
% Column 4 = Voc
% Column 5 = Jsc
% Column 6 = FF

x   = T{:,1};
y   = T{:,2};

PCE = T{:,3};
Voc = T{:,4};
Jsc = T{:,5};
FF  = T{:,6};


%% ============================================================
% REMOVE INVALID DATA
%% ============================================================

valid = isfinite(x) & isfinite(y) & ...
        isfinite(PCE) & isfinite(Voc) & ...
        isfinite(Jsc) & isfinite(FF);

x   = x(valid);
y   = y(valid);

PCE = PCE(valid);
Voc = Voc(valid);
Jsc = Jsc(valid);
FF  = FF(valid);


%% ============================================================
% CONVERT TO LOG10 SPACE
%% ============================================================

X = log10(x);
Y = log10(y);


%% ============================================================
% CREATE FINE GRID
%% ============================================================

xq = linspace(9,18,400);
yq = linspace(9,18,400);

[Xq,Yq] = meshgrid(xq,yq);


%% ============================================================
% INTERPOLATION
%% ============================================================

PCEq = griddata(X,Y,PCE,Xq,Yq,'natural');
Vocq = griddata(X,Y,Voc,Xq,Yq,'natural');
Jscq = griddata(X,Y,Jsc,Xq,Yq,'natural');
FFq  = griddata(X,Y,FF,Xq,Yq,'natural');


%% ============================================================
% FIGURE
%% ============================================================

fig = figure( ...
    'Color','white',...
    'Units','pixels',...
    'Position',[100 50 932 686]);


%% ============================================================
% COLORMAP
%% ==========================================================
colormap(fig,jet(256));

%% ============================================================
% FONT SETTINGS
%% ============================================================

fontName = 'Times New Roman';

tickSize    = 10;
labelSize   = 10;
cbTickSize  = 10;
cbLabelSize = 12;
panelSize   = 15;


%% ============================================================
% COMMON TICK LABELS
%% ============================================================

tickLabels = { ...
    '10^9',...
    '10^{10}',...
    '10^{11}',...
    '10^{12}',...
    '10^{13}',...
    '10^{14}',...
    '10^{15}',...
    '10^{16}',...
    '10^{17}',...
    '10^{18}'};


%% ============================================================
%                         (a) PCE
%% ============================================================

ax1 = axes( ...
    'Parent',fig,...
    'Position',[0.067 0.550 0.301 0.350]);

contourf(ax1,...
    Xq,Yq,PCEq,...
    100,...
    'LineColor','none');

caxis(ax1,[11 17.9]);

xlim(ax1,[9 18]);
ylim(ax1,[9 18]);

xticks(ax1,9:18);
yticks(ax1,9:18);

xticklabels(ax1,tickLabels);
yticklabels(ax1,tickLabels);

set(ax1,...
    'FontName',fontName,...
    'FontSize',tickSize,...
    'FontWeight','bold',...
    'XColor','black',...
    'YColor','black',...
    'LineWidth',1,...
    'TickDir','out',...
    'Box','on');


%% X LABEL

xlabel(ax1,...
    'N_A of Cs_3Bi_2I_9 (cm^{-3})',...
    'Interpreter','tex',...
    'FontName',fontName,...
    'FontSize',labelSize,...
    'FontWeight','bold',...
    'Color','black');


%% Y LABEL

ylabel(ax1,...
    'N_A of MASnI_3 (cm^{-3})',...
    'Interpreter','tex',...
    'FontName',fontName,...
    'FontSize',labelSize,...
    'FontWeight','bold',...
    'Color','black');


%% PANEL LABEL

text(ax1,...
    0.02,1.045,'(a)',...
    'Units','normalized',...
    'FontName',fontName,...
    'FontSize',panelSize,...
    'FontWeight','bold',...
    'Color','black',...
    'HorizontalAlignment','left',...
    'VerticalAlignment','bottom');


%% COLORBAR

cb1 = colorbar(ax1);

cb1.Position = [0.392 0.550 0.015 0.350];

cb1.FontName = fontName;
cb1.FontSize = cbTickSize;
cb1.FontWeight = 'bold';
cb1.Color = 'black';
cb1.LineWidth = 0.8;

cb1.Limits = [11 17.9];

% EXACTLY 6 EQUALLY SPACED TICKS
cb1.Ticks = linspace(11,17.9,6);

cb1.TickLabels = { ...
    '11.0',...
    '12.38',...
    '13.76',...
    '15.14',...
    '16.52',...
    '17.9'};

cb1.Label.String = 'PCE(%)';
cb1.Label.FontName = fontName;
cb1.Label.FontSize = cbLabelSize;
cb1.Label.FontWeight = 'bold';
cb1.Label.Color = 'black';


%% ============================================================
%                         (b) VOC
%% ============================================================

ax2 = axes( ...
    'Parent',fig,...
    'Position',[0.54 0.550 0.301 0.350]);

contourf(ax2,...
    Xq,Yq,Vocq,...
    100,...
    'LineColor','none');

caxis(ax2,[0.825 1.080]);

xlim(ax2,[9 18]);
ylim(ax2,[9 18]);

xticks(ax2,9:18);
yticks(ax2,9:18);

xticklabels(ax2,tickLabels);
yticklabels(ax2,tickLabels);

set(ax2,...
    'FontName',fontName,...
    'FontSize',tickSize,...
    'FontWeight','bold',...
    'XColor','black',...
    'YColor','black',...
    'LineWidth',1,...
    'TickDir','out',...
    'Box','on');


%% X LABEL

xlabel(ax2,...
    'N_A of Cs_3Bi_2I_9 (cm^{-3})',...
    'Interpreter','tex',...
    'FontName',fontName,...
    'FontSize',labelSize,...
    'FontWeight','bold',...
    'Color','black');


%% Y LABEL

ylabel(ax2,...
    'N_A of MASnI_3 (cm^{-3})',...
    'Interpreter','tex',...
    'FontName',fontName,...
    'FontSize',labelSize,...
    'FontWeight','bold',...
    'Color','black');


%% PANEL LABEL

text(ax2,...
    0.02,1.045,'(b)',...
    'Units','normalized',...
    'FontName',fontName,...
    'FontSize',panelSize,...
    'FontWeight','bold',...
    'Color','black',...
    'HorizontalAlignment','left',...
    'VerticalAlignment','bottom');


%% COLORBAR

cb2 = colorbar(ax2);

cb2.Position = [0.855 0.550 0.015 0.350];

cb2.FontName = fontName;
cb2.FontSize = cbTickSize;
cb2.FontWeight = 'bold';
cb2.Color = 'black';
cb2.LineWidth = 0.8;

cb2.Limits = [0.825 1.080];

% EXACTLY 6 EQUALLY SPACED TICKS
cb2.Ticks = linspace(0.825,1.080,6);

cb2.TickLabels = { ...
    '0.825',...
    '0.876',...
    '0.927',...
    '0.978',...
    '1.029',...
    '1.080'};

cb2.Label.String = 'V_{OC}(V)';
cb2.Label.FontName = fontName;
cb2.Label.FontSize = cbLabelSize;
cb2.Label.FontWeight = 'bold';
cb2.Label.Color = 'black';


%% ============================================================
%                         (c) JSC
%% ============================================================

ax3 = axes( ...
    'Parent',fig,...
    'Position',[0.067 0.095 0.301 0.350]);

contourf(ax3,...
    Xq,Yq,Jscq,...
    100,...
    'LineColor','none');

caxis(ax3,[19.1 21.2]);

xlim(ax3,[9 18]);
ylim(ax3,[9 18]);

xticks(ax3,9:18);
yticks(ax3,9:18);

xticklabels(ax3,tickLabels);
yticklabels(ax3,tickLabels);

set(ax3,...
    'FontName',fontName,...
    'FontSize',tickSize,...
    'FontWeight','bold',...
    'XColor','black',...
    'YColor','black',...
    'LineWidth',1,...
    'TickDir','out',...
    'Box','on');


%% X LABEL

xlabel(ax3,...
    'N_A of Cs_3Bi_2I_9 (cm^{-3})',...
    'Interpreter','tex',...
    'FontName',fontName,...
    'FontSize',labelSize,...
    'FontWeight','bold',...
    'Color','black');


%% Y LABEL

ylabel(ax3,...
    'N_A of MASnI_3 (cm^{-3})',...
    'Interpreter','tex',...
    'FontName',fontName,...
    'FontSize',labelSize,...
    'FontWeight','bold',...
    'Color','black');


%% PANEL LABEL

text(ax3,...
    0.02,1.025,'(c)',...
    'Units','normalized',...
    'FontName',fontName,...
    'FontSize',panelSize,...
    'FontWeight','bold',...
    'Color','black',...
    'HorizontalAlignment','left',...
    'VerticalAlignment','bottom');


%% COLORBAR

cb3 = colorbar(ax3);

cb3.Position = [0.392 0.095 0.015 0.350];

cb3.FontName = fontName;
cb3.FontSize = cbTickSize;
cb3.FontWeight = 'bold';
cb3.Color = 'black';
cb3.LineWidth = 0.8;

cb3.Limits = [19.1 21.2];

% EXACTLY 6 EQUALLY SPACED TICKS
cb3.Ticks = linspace(19.1,21.2,6);

cb3.TickLabels = { ...
    '19.10',...
    '19.52',...
    '19.94',...
    '20.36',...
    '20.78',...
    '21.20'};

cb3.Label.String = 'J_{SC}(mA/cm^2)';
cb3.Label.FontName = fontName;
cb3.Label.FontSize = cbLabelSize;
cb3.Label.FontWeight = 'bold';
cb3.Label.Color = 'black';


%% ============================================================
%                         (d) FF
%% ============================================================

ax4 = axes( ...
    'Parent',fig,...
    'Position',[0.54 0.095 0.301 0.350]);

contourf(ax4,...
    Xq,Yq,FFq,...
    100,...
    'LineColor','none');

caxis(ax4,[62.3 83.9]);

xlim(ax4,[9 18]);
ylim(ax4,[9 18]);

xticks(ax4,9:18);
yticks(ax4,9:18);

xticklabels(ax4,tickLabels);
yticklabels(ax4,tickLabels);

set(ax4,...
    'FontName',fontName,...
    'FontSize',tickSize,...
    'FontWeight','bold',...
    'XColor','black',...
    'YColor','black',...
    'LineWidth',1,...
    'TickDir','out',...
    'Box','on');


%% X LABEL

xlabel(ax4,...
    'N_A of Cs_3Bi_2I_9 (cm^{-3})',...
    'Interpreter','tex',...
    'FontName',fontName,...
    'FontSize',labelSize,...
    'FontWeight','bold',...
    'Color','black');


%% Y LABEL

ylabel(ax4,...
    'N_A of MASnI_3 (cm^{-3})',...
    'Interpreter','tex',...
    'FontName',fontName,...
    'FontSize',labelSize,...
    'FontWeight','bold',...
    'Color','black');


%% PANEL LABEL

text(ax4,...
    0.02,1.025,'(d)',...
    'Units','normalized',...
    'FontName',fontName,...
    'FontSize',panelSize,...
    'FontWeight','bold',...
    'Color','black',...
    'HorizontalAlignment','left',...
    'VerticalAlignment','bottom');


%% COLORBAR

cb4 = colorbar(ax4);

cb4.Position = [0.855 0.095 0.015 0.350];

cb4.FontName = fontName;
cb4.FontSize = cbTickSize;
cb4.FontWeight = 'bold';
cb4.Color = 'black';
cb4.LineWidth = 0.8;

cb4.Limits = [62.3 83.9];

% EXACTLY 6 EQUALLY SPACED TICKS
cb4.Ticks = linspace(62.3,83.9,6);

cb4.TickLabels = { ...
    '62.3',...
    '66.6',...
    '70.9',...
    '75.3',...
    '79.6',...
    '83.9'};

cb4.Label.String = 'FF(%)';
cb4.Label.FontName = fontName;
cb4.Label.FontSize = cbLabelSize;
cb4.Label.FontWeight = 'bold';
cb4.Label.Color = 'black';


%% ============================================================
% FINAL AXIS FORMATTING
%% ============================================================

axesList = [ax1 ax2 ax3 ax4];

for k = 1:4

    ax = axesList(k);

    ax.FontName = 'Times New Roman';
    ax.FontSize = 10;
    ax.FontWeight = 'bold';

    ax.XColor = [0 0 0];
    ax.YColor = [0 0 0];

    ax.LineWidth = 1;
    ax.TickDir = 'out';
    ax.Box = 'on';

    ax.XLabel.FontName = 'Times New Roman';
    ax.XLabel.FontSize = 10;
    ax.XLabel.FontWeight = 'bold';
    ax.XLabel.Color = [0 0 0];

    ax.YLabel.FontName = 'Times New Roman';
    ax.YLabel.FontSize = 10;
    ax.YLabel.FontWeight = 'bold';
    ax.YLabel.Color = [0 0 0];

end


%% ============================================================
% FINAL COLORBAR FORMATTING
%% ============================================================

cbList = [cb1 cb2 cb3 cb4];

for k = 1:4

    cb = cbList(k);

    cb.FontName = 'Times New Roman';
    cb.FontSize = 10;
    cb.FontWeight = 'bold';

    cb.Color = [0 0 0];

    cb.LineWidth = 0.8;

    cb.Label.FontName = 'Times New Roman';
    cb.Label.FontSize = 12;
    cb.Label.FontWeight = 'bold';
    cb.Label.Color = [0 0 0];

end


%% ============================================================
% FINAL PANEL LABEL FORMATTING
%% ============================================================

panelLabels = findall(fig,'Type','text');

for k = 1:length(panelLabels)

    str = string(panelLabels(k).String);

    if any(str == ["(a)","(b)","(c)","(d)"])

        panelLabels(k).FontName = 'Times New Roman';
        panelLabels(k).FontSize = 15;
        panelLabels(k).FontWeight = 'bold';
        panelLabels(k).Color = [0 0 0];

    end

end


%% ============================================================
% FIGURE BACKGROUND
%% ============================================================

set(fig,'Color','white');


%% ============================================================
% RENDERER
%% ============================================================

set(fig,'Renderer','opengl');


%% ============================================================
% SAVE HIGH-RESOLUTION IMAGE
%% ============================================================

exportgraphics(fig,...
    'Cs3Bi2I9_MASnI3_2D_Mapping.png',...
    'Resolution',600);

disp('Figure saved successfully.');