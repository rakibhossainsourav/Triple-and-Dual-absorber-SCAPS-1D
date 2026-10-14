clc
clear
close all

%% ============================================================
%                     READ EXCEL DATA
% ============================================================

filename = 'Defect dual.xlsx';

data = readtable(filename);

% ------------------------------------------------------------
% EXCEL COLUMN ARRANGEMENT
% ------------------------------------------------------------
% Column 1 = Nt of MASnI3
% Column 2 = Nt of Cs3Bi2I9
% Column 3 = PCE
% Column 4 = Voc
% Column 5 = Jsc
% Column 6 = FF
% ------------------------------------------------------------

MASnI3   = data{:,1};
Cs3Bi2I9 = data{:,2};

PCE = data{:,3};
Voc = data{:,4};
Jsc = data{:,5};
FF  = data{:,6};


%% ============================================================
%                     LOG10 TRANSFORMATION
% ============================================================

Xdata = log10(MASnI3);
Ydata = log10(Cs3Bi2I9);


%% ============================================================
%                     UNIQUE VALUES
% ============================================================

xUnique = unique(Xdata);
yUnique = unique(Ydata);

[X,Y] = meshgrid(xUnique,yUnique);


%% ============================================================
%                     CREATE Z MATRICES
% ============================================================

PCEZ = nan(length(yUnique),length(xUnique));
VocZ = nan(length(yUnique),length(xUnique));
JscZ = nan(length(yUnique),length(xUnique));
FFZ  = nan(length(yUnique),length(xUnique));

for k = 1:length(Xdata)

    [~,ix] = min(abs(xUnique - Xdata(k)));
    [~,iy] = min(abs(yUnique - Ydata(k)));

    PCEZ(iy,ix) = PCE(k);
    VocZ(iy,ix) = Voc(k);
    JscZ(iy,ix) = Jsc(k);
    FFZ(iy,ix)  = FF(k);

end


%% ============================================================
%                     FILL MISSING VALUES
% ============================================================

PCEZ = fillmissing(PCEZ,'linear',2);
PCEZ = fillmissing(PCEZ,'linear',1);

VocZ = fillmissing(VocZ,'linear',2);
VocZ = fillmissing(VocZ,'linear',1);

JscZ = fillmissing(JscZ,'linear',2);
JscZ = fillmissing(JscZ,'linear',1);

FFZ = fillmissing(FFZ,'linear',2);
FFZ = fillmissing(FFZ,'linear',1);


%% ============================================================
%                     GENERAL SETTINGS
% ============================================================

fontName = 'Times New Roman';

ticks = 9:1:18;


%% ============================================================
%                 BOLD TICK LABELS
% ============================================================
%
% IMPORTANT:
% Use LaTeX \mathbf so that 10^9 ... 10^18 are actually BOLD.
%
% ============================================================

tickLabels = { ...
    '$\mathbf{10^{9}}$', ...
    '$\mathbf{10^{10}}$', ...
    '$\mathbf{10^{11}}$', ...
    '$\mathbf{10^{12}}$', ...
    '$\mathbf{10^{13}}$', ...
    '$\mathbf{10^{14}}$', ...
    '$\mathbf{10^{15}}$', ...
    '$\mathbf{10^{16}}$', ...
    '$\mathbf{10^{17}}$', ...
    '$\mathbf{10^{18}}$'};


%% ============================================================
%                 MANUAL Nt LABEL CONTROL
%
%      ONE SET OF VALUES CONTROLS ALL FOUR PLOTS
% ============================================================

% ------------------------------------------------------------
% Nt of MASnI3
% ------------------------------------------------------------

NtX_Rotation = 14;

NtX_X = -0.30;
NtX_Y =  0.65;


% ------------------------------------------------------------
% Nt of Cs3Bi2I9
% ------------------------------------------------------------

NtY_Rotation = -13;

NtY_X = 0.3;
NtY_Y = 1.3;


% ------------------------------------------------------------
% Z position
% ------------------------------------------------------------

Nt_Z = 0;


%% ============================================================
%                 PANEL LABEL SETTINGS
% ============================================================

PanelX = 0;
PanelY = 1.02;


%% ============================================================
%                     CREATE FIGURE
% ============================================================

figure( ...
    'Color','white', ...
    'Position',[30 20 1500 950], ...
    'Renderer','opengl');

colormap(jet);


%% ============================================================
%                         (a) PCE
% ============================================================

ax1 = subplot(2,2,1);

surf(ax1,X,Y,PCEZ,'EdgeColor','none');

shading(ax1,'interp');

view(ax1,-135,25);

grid(ax1,'on');
box(ax1,'on');

ax1.Color = 'white';

ax1.XColor = 'black';
ax1.YColor = 'black';
ax1.ZColor = 'black';

ax1.LineWidth = 1.1;

ax1.FontName = fontName;
ax1.FontSize = 15;
ax1.FontWeight = 'bold';

% ------------------------------------------------------------
% LIMITS
% ------------------------------------------------------------

ax1.XLim = [9 18];
ax1.YLim = [9 18];

% ------------------------------------------------------------
% TICKS
% ------------------------------------------------------------

ax1.XTick = ticks;
ax1.YTick = ticks;

ax1.XTickLabel = tickLabels;
ax1.YTickLabel = tickLabels;

ax1.TickLabelInterpreter = 'latex';

ax1.XAxis.Exponent = 0;
ax1.YAxis.Exponent = 0;

% ------------------------------------------------------------
% GRID
% ------------------------------------------------------------

ax1.XGrid = 'on';
ax1.YGrid = 'on';
ax1.ZGrid = 'on';

ax1.GridLineStyle = '--';
ax1.GridColor = [0.65 0.65 0.65];
ax1.GridAlpha = 0.22;

% ------------------------------------------------------------
% LABELS
% ------------------------------------------------------------

xlabel(ax1,...
    'N_t of MASnI_3 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',15,...
    'FontWeight','bold',...
    'Interpreter','tex');

ylabel(ax1,...
    'N_t of Cs_3Bi_2I_9 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',15,...
    'FontWeight','bold',...
    'Interpreter','tex');

zlabel(ax1,...
    'PCE (%)',...
    'FontName',fontName,...
    'FontSize',15,...
    'FontWeight','bold',...
    'Interpreter','tex');

% ------------------------------------------------------------
% PANEL LABEL
% ------------------------------------------------------------

t1 = title(ax1,'(a)',...
    'FontName',fontName,...
    'FontSize',15,...
    'FontWeight','bold',...
    'Color','black');

t1.Units = 'normalized';
t1.Position = [PanelX PanelY 0];
t1.HorizontalAlignment = 'left';


%% ============================================================
%                         (b) VOC
% ============================================================

ax2 = subplot(2,2,2);

surf(ax2,X,Y,VocZ,'EdgeColor','none');

shading(ax2,'interp');

view(ax2,-135,25);

grid(ax2,'on');
box(ax2,'on');

ax2.Color = 'white';

ax2.XColor = 'black';
ax2.YColor = 'black';
ax2.ZColor = 'black';

ax2.LineWidth = 1.1;

ax2.FontName = fontName;
ax2.FontSize = 15;
ax2.FontWeight = 'bold';

% ------------------------------------------------------------
% LIMITS
% ------------------------------------------------------------

ax2.XLim = [9 18];
ax2.YLim = [9 18];

% ------------------------------------------------------------
% TICKS
% ------------------------------------------------------------

ax2.XTick = ticks;
ax2.YTick = ticks;

ax2.XTickLabel = tickLabels;
ax2.YTickLabel = tickLabels;

ax2.TickLabelInterpreter = 'latex';

ax2.XAxis.Exponent = 0;
ax2.YAxis.Exponent = 0;

% ------------------------------------------------------------
% GRID
% ------------------------------------------------------------

ax2.XGrid = 'on';
ax2.YGrid = 'on';
ax2.ZGrid = 'on';

ax2.GridLineStyle = '--';
ax2.GridColor = [0.65 0.65 0.65];
ax2.GridAlpha = 0.22;

% ------------------------------------------------------------
% LABELS
% ------------------------------------------------------------

xlabel(ax2,...
    'N_t of MASnI_3 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',15,...
    'FontWeight','bold',...
    'Interpreter','tex');

ylabel(ax2,...
    'N_t of Cs_3Bi_2I_9 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',15,...
    'FontWeight','bold',...
    'Interpreter','tex');

zlabel(ax2,...
    'V_{OC} (V)',...
    'FontName',fontName,...
    'FontSize',15,...
    'FontWeight','bold',...
    'Interpreter','tex');

% ------------------------------------------------------------
% PANEL LABEL
% ------------------------------------------------------------

t2 = title(ax2,'(b)',...
    'FontName',fontName,...
    'FontSize',15,...
    'FontWeight','bold',...
    'Color','black');

t2.Units = 'normalized';
t2.Position = [PanelX PanelY 0];
t2.HorizontalAlignment = 'left';


%% ============================================================
%                         (c) JSC
% ============================================================

ax3 = subplot(2,2,3);

surf(ax3,X,Y,JscZ,'EdgeColor','none');

shading(ax3,'interp');

view(ax3,-135,25);

grid(ax3,'on');
box(ax3,'on');

ax3.Color = 'white';

ax3.XColor = 'black';
ax3.YColor = 'black';
ax3.ZColor = 'black';

ax3.LineWidth = 1.1;

ax3.FontName = fontName;
ax3.FontSize = 15;
ax3.FontWeight = 'bold';

% ------------------------------------------------------------
% LIMITS
% ------------------------------------------------------------

ax3.XLim = [9 18];
ax3.YLim = [9 18];

% ------------------------------------------------------------
% TICKS
% ------------------------------------------------------------

ax3.XTick = ticks;
ax3.YTick = ticks;

ax3.XTickLabel = tickLabels;
ax3.YTickLabel = tickLabels;

ax3.TickLabelInterpreter = 'latex';

ax3.XAxis.Exponent = 0;
ax3.YAxis.Exponent = 0;

% ------------------------------------------------------------
% GRID
% ------------------------------------------------------------

ax3.XGrid = 'on';
ax3.YGrid = 'on';
ax3.ZGrid = 'on';

ax3.GridLineStyle = '--';
ax3.GridColor = [0.65 0.65 0.65];
ax3.GridAlpha = 0.22;

% ------------------------------------------------------------
% LABELS
% ------------------------------------------------------------

xlabel(ax3,...
    'N_t of MASnI_3 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',15,...
    'FontWeight','bold',...
    'Interpreter','tex');

ylabel(ax3,...
    'N_t of Cs_3Bi_2I_9 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',15,...
    'FontWeight','bold',...
    'Interpreter','tex');

zlabel(ax3,...
    'J_{SC} (mA/cm^2)',...
    'FontName',fontName,...
    'FontSize',15,...
    'FontWeight','bold',...
    'Interpreter','tex');

% ------------------------------------------------------------
% PANEL LABEL
% ------------------------------------------------------------

t3 = title(ax3,'(c)',...
    'FontName',fontName,...
    'FontSize',15,...
    'FontWeight','bold',...
    'Color','black');

t3.Units = 'normalized';
t3.Position = [PanelX PanelY 0];
t3.HorizontalAlignment = 'left';


%% ============================================================
%                         (d) FF
% ============================================================

ax4 = subplot(2,2,4);

surf(ax4,X,Y,FFZ,'EdgeColor','none');

shading(ax4,'interp');

view(ax4,-135,25);

grid(ax4,'on');
box(ax4,'on');

ax4.Color = 'white';

ax4.XColor = 'black';
ax4.YColor = 'black';
ax4.ZColor = 'black';

ax4.LineWidth = 1.1;

ax4.FontName = fontName;
ax4.FontSize = 15;
ax4.FontWeight = 'bold';

% ------------------------------------------------------------
% LIMITS
% ------------------------------------------------------------

ax4.XLim = [9 18];
ax4.YLim = [9 18];

% ------------------------------------------------------------
% TICKS
% ------------------------------------------------------------

ax4.XTick = ticks;
ax4.YTick = ticks;

ax4.XTickLabel = tickLabels;
ax4.YTickLabel = tickLabels;

ax4.TickLabelInterpreter = 'latex';

ax4.XAxis.Exponent = 0;
ax4.YAxis.Exponent = 0;

% ------------------------------------------------------------
% GRID
% ------------------------------------------------------------

ax4.XGrid = 'on';
ax4.YGrid = 'on';
ax4.ZGrid = 'on';

ax4.GridLineStyle = '--';
ax4.GridColor = [0.65 0.65 0.65];
ax4.GridAlpha = 0.22;

% ------------------------------------------------------------
% LABELS
% ------------------------------------------------------------

xlabel(ax4,...
    'N_t of MASnI_3 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',15,...
    'FontWeight','bold',...
    'Interpreter','tex');

ylabel(ax4,...
    'N_t of Cs_3Bi_2I_9 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',15,...
    'FontWeight','bold',...
    'Interpreter','tex');

zlabel(ax4,...
    'FF (%)',...
    'FontName',fontName,...
    'FontSize',15,...
    'FontWeight','bold',...
    'Interpreter','tex');

% ------------------------------------------------------------
% PANEL LABEL
% ------------------------------------------------------------

t4 = title(ax4,'(d)',...
    'FontName',fontName,...
    'FontSize',15,...
    'FontWeight','bold',...
    'Color','black');

t4.Units = 'normalized';
t4.Position = [PanelX PanelY 0];
t4.HorizontalAlignment = 'left';


%% ============================================================
%          APPLY Nt ROTATION + POSITION TO ALL FOUR
% ============================================================

axList = [ax1 ax2 ax3 ax4];

for i = 1:length(axList)

    ax = axList(i);

    % --------------------------------------------------------
    % Current axis ranges
    % --------------------------------------------------------

    xLim = ax.XLim;
    yLim = ax.YLim;
    zLim = ax.ZLim;

    xRange = xLim(2) - xLim(1);
    yRange = yLim(2) - yLim(1);
    zRange = zLim(2) - zLim(1);

    zLabelPos = zLim(1) + Nt_Z*zRange;


    % ========================================================
    % X-AXIS LABEL
    % ========================================================

    xLabelX = xLim(1) + NtX_X*xRange;
    xLabelY = yLim(1) + NtX_Y*yRange;

    ax.XLabel.Rotation = NtX_Rotation;

    ax.XLabel.Position = [ ...
        xLabelX ...
        xLabelY ...
        zLabelPos];


    % ========================================================
    % Y-AXIS LABEL
    % ========================================================

    yLabelX = xLim(1) + NtY_X*xRange;
    yLabelY = yLim(1) + NtY_Y*yRange;

    ax.YLabel.Rotation = NtY_Rotation;

    ax.YLabel.Position = [ ...
        yLabelX ...
        yLabelY ...
        zLabelPos];

end


%% ============================================================
%              FINAL 2x2 LAYOUT
%          PROPER GAP + NO CLIPPING
% ============================================================

% ------------------------------------------------------------
% TOP ROW
% ------------------------------------------------------------

ax1.Position = [0.046 0.535 0.425 0.360];

ax2.Position = [0.530 0.535 0.425 0.360];


% ------------------------------------------------------------
% BOTTOM ROW
% ------------------------------------------------------------

ax3.Position = [0.046 0.080 0.425 0.360];

ax4.Position = [0.530 0.080 0.425 0.360];


%% ============================================================
%              TURN OFF LABEL CLIPPING
% ============================================================

ax1.XLabel.Clipping = 'off';
ax1.YLabel.Clipping = 'off';
ax1.ZLabel.Clipping = 'off';

ax2.XLabel.Clipping = 'off';
ax2.YLabel.Clipping = 'off';
ax2.ZLabel.Clipping = 'off';

ax3.XLabel.Clipping = 'off';
ax3.YLabel.Clipping = 'off';
ax3.ZLabel.Clipping = 'off';

ax4.XLabel.Clipping = 'off';
ax4.YLabel.Clipping = 'off';
ax4.ZLabel.Clipping = 'off';


%% ============================================================
%                 FORCE ALL TICK NUMBERS BOLD
% ============================================================

axList = [ax1 ax2 ax3 ax4];

for i = 1:length(axList)

    ax = axList(i);

    % Axis tick numbers
    ax.FontName = fontName;
    ax.FontSize = 15;
    ax.FontWeight = 'bold';

    % Explicitly keep tick labels bold
    ax.XAxis.FontName = fontName;
    ax.XAxis.FontSize = 15;
    ax.XAxis.FontWeight = 'bold';

    ax.YAxis.FontName = fontName;
    ax.YAxis.FontSize = 15;
    ax.YAxis.FontWeight = 'bold';

    ax.ZAxis.FontName = fontName;
    ax.ZAxis.FontSize = 15;
    ax.ZAxis.FontWeight = 'bold';

    % Keep LaTeX tick interpreter
    ax.TickLabelInterpreter = 'latex';

end


%% ============================================================
%                     FINAL DRAW
% ============================================================

set(gcf,'Color','white');

drawnow;