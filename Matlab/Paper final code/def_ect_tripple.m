clc
clear
close all

%% ============================================================
%                    READ EXCEL DATA
% =============================================================

filename = 'Defect Tripple.xlsx';

T = readtable(filename);

disp('Excel data loaded successfully.');
disp(T);


%% ============================================================
%                    ORIGINAL EXCEL ORDER
%
% Column 1 = Nt of Cs2TiBr6   (bp1)
% Column 2 = Nt of MASnI3     (bp2)
% Column 3 = Nt of Cs3Bi2I9   (bp3)
% Column 4 = PCE
% Column 5 = Voc
% Column 6 = Jsc
% Column 7 = FF
%
% Rows are NOT changed.
% =============================================================

Nt_Cs2TiBr6 = T{:,1};
Nt_MASnI3   = T{:,2};
Nt_Cs3Bi2I9 = T{:,3};

PCE = T{:,4};
Voc = T{:,5};
Jsc = T{:,6};
FF  = T{:,7};


%% ============================================================
%                    REMOVE ONLY INVALID ROWS
% =============================================================

valid = isfinite(Nt_Cs2TiBr6) & ...
        isfinite(Nt_MASnI3) & ...
        isfinite(Nt_Cs3Bi2I9) & ...
        isfinite(PCE) & ...
        isfinite(Voc) & ...
        isfinite(Jsc) & ...
        isfinite(FF) & ...
        Nt_Cs2TiBr6 > 0 & ...
        Nt_MASnI3 > 0 & ...
        Nt_Cs3Bi2I9 > 0;

Nt_Cs2TiBr6 = Nt_Cs2TiBr6(valid);

Nt_MASnI3   = Nt_MASnI3(valid);

Nt_Cs3Bi2I9 = Nt_Cs3Bi2I9(valid);

PCE = PCE(valid);

Voc = Voc(valid);

Jsc = Jsc(valid);

FF  = FF(valid);


%% ============================================================
%                    FINAL AXIS ORDER
%
% X = Nt of MASnI3       = bp2
% Y = Nt of Cs2TiBr6     = bp1
% Z = Nt of Cs3Bi2I9     = bp3
% =============================================================

X = log10(Nt_MASnI3);

Y = log10(Nt_Cs2TiBr6);

Z = log10(Nt_Cs3Bi2I9);


%% ============================================================
%                    CHECK DATA
% =============================================================

fprintf('\n============================================\n');

fprintf('NUMBER OF VALID DATA POINTS = %d\n',length(PCE));

fprintf('============================================\n');

fprintf('PCE range : %.4f  to  %.4f %%\n', ...
    min(PCE),max(PCE));

fprintf('Voc range : %.4f  to  %.4f V\n', ...
    min(Voc),max(Voc));

fprintf('Jsc range : %.4f  to  %.4f mA/cm^2\n', ...
    min(Jsc),max(Jsc));

fprintf('FF range  : %.4f  to  %.4f %%\n', ...
    min(FF),max(FF));

fprintf('============================================\n');


%% ============================================================
%                    GENERAL SETTINGS
% =============================================================

fontName = 'Times New Roman';

markerSize = 45;

az = -40;

el = 25;


%% ============================================================
%                    AXIS LIMITS
%
% X: MASnI3       10^9 -> 10^18
% Y: Cs2TiBr6     10^18 -> 10^9  [REVERSED]
% Z: Cs3Bi2I9     10^9 -> 10^18
% =============================================================

xRange = [9 18];

yRange = [9 18];

zRange = [9 18];

logTicks = 9:18;


%% ============================================================
%                    AXIS TICK LABELS
% =============================================================

logTickLabels = { ...
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
%                    COLORBAR SETTINGS
%
% EXACTLY 6 TICKS FOR EACH COLORBAR
% 2 DECIMAL PLACES
% =============================================================

nTicks = 6;

decPlaces = 2;


%% ---------------- PCE ----------------

PCEmin = min(PCE);

PCEmax = max(PCE);

PCEticks = linspace(PCEmin,PCEmax,nTicks);


%% ---------------- Voc ----------------

Vocmin = min(Voc);

Vocmax = max(Voc);

Vocticks = linspace(Vocmin,Vocmax,nTicks);


%% ---------------- Jsc ----------------

Jscmin = min(Jsc);

Jscmax = max(Jsc);

Jscticks = linspace(Jscmin,Jscmax,nTicks);


%% ---------------- FF ----------------

FFmin = min(FF);

FFmax = max(FF);

FFticks = linspace(FFmin,FFmax,nTicks);


%% ============================================================
%                    COLORBAR LABEL FORMAT
% =============================================================

fmtStr = ['%.' num2str(decPlaces) 'f'];


PCEtickLabels = arrayfun( ...
    @(v) sprintf(fmtStr,v), ...
    PCEticks, ...
    'UniformOutput',false);


VoctickLabels = arrayfun( ...
    @(v) sprintf(fmtStr,v), ...
    Vocticks, ...
    'UniformOutput',false);


JsctickLabels = arrayfun( ...
    @(v) sprintf(fmtStr,v), ...
    Jscticks, ...
    'UniformOutput',false);


FFtickLabels = arrayfun( ...
    @(v) sprintf(fmtStr,v), ...
    FFticks, ...
    'UniformOutput',false);


%% ============================================================
%                    FIGURE
% =============================================================

fig = figure( ...
    'Color','white', ...
    'Units','pixels', ...
    'Position',[100 50 1150 750]);


%% ============================================================
%                    COLORMAP
% =============================================================

colormap(fig,jet(256));


%% ============================================================
%                    LABEL SETTINGS
% =============================================================

xLabelRotation = 15;

yLabelRotation = -18;

zLabelRotation = 90;


% Position offsets

xLabelOffset = [0 2.5 2.8];

yLabelOffset = [0 -0.4 2.7];

zLabelOffset = [0.16 0 0];


%% ============================================================
%                         (e) PCE
% =============================================================

ax1 = axes( ...
    'Parent',fig, ...
    'Position',[0.075 0.555 0.315 0.355]);


scatter3(ax1,...
    X,Y,Z,...
    markerSize,...
    PCE,...
    'filled',...
    'MarkerEdgeColor','none',...
    'MarkerFaceAlpha',1);


view(ax1,az,el);

xlim(ax1,xRange);

ylim(ax1,yRange);

zlim(ax1,zRange);

grid(ax1,'on');

box(ax1,'on');


%% AXIS FORMAT

ax1.FontName = fontName;

ax1.FontSize = 10;

ax1.FontWeight = 'bold';

ax1.LineWidth = 1.0;

ax1.XColor = 'black';

ax1.YColor = 'black';

ax1.ZColor = 'black';

ax1.Color = 'white';


%% GRID

ax1.GridLineStyle = '--';

ax1.GridColor = [0.72 0.72 0.72];

ax1.GridAlpha = 0.30;


%% TICKS

ax1.XTick = logTicks;

ax1.YTick = logTicks;

ax1.ZTick = logTicks;

ax1.XTickLabel = logTickLabels;

ax1.YTickLabel = logTickLabels;

ax1.ZTickLabel = logTickLabels;


%% AXIS DIRECTIONS

ax1.XDir = 'normal';

ax1.YDir = 'reverse';

ax1.ZDir = 'normal';


%% ============================================================
%                    AXIS LABELS
% =============================================================

hx = xlabel(ax1,...
    'N_t of MASnI_3 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',10,...
    'FontWeight','bold',...
    'Color','black');


hy = ylabel(ax1,...
    'N_t of Cs_2TiBr_6 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',10,...
    'FontWeight','bold',...
    'Color','black');


hz = zlabel(ax1,...
    'N_t of Cs_3Bi_2I_9 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',10,...
    'FontWeight','bold',...
    'Color','black');


%% LABEL ROTATION

hx.Rotation = xLabelRotation;

hy.Rotation = yLabelRotation;

hz.Rotation = zLabelRotation;


%% LABEL POSITION

hx.Position = hx.Position + xLabelOffset;

hy.Position = hy.Position + yLabelOffset;

hz.Position = hz.Position + zLabelOffset;


hx.HorizontalAlignment = 'center';

hy.HorizontalAlignment = 'center';

hz.HorizontalAlignment = 'center';


%% ============================================================
%                    PANEL TITLE
% =============================================================

%% PANEL TITLES

% ===================== (e) =====================
t = title(ax1,'(e)', ...
    'FontName',fontName, ...
    'FontSize',15, ...
    'FontWeight','bold', ...
    'Color','black');

t.Units = 'normalized';
t.Position = [0 1.0 0];
t.HorizontalAlignment = 'left';


%% ============================================================
%                    PCE COLORBAR
% =============================================================

clim(ax1,[PCEmin PCEmax]);


cb1 = colorbar(ax1);


cb1.Position = [0.400 0.620 0.014 0.250];


cb1.Ticks = PCEticks;


cb1.TickLabels = PCEtickLabels;


cb1.FontName = fontName;

cb1.FontSize = 10;

cb1.Color = 'black';


cb1.Title.String = 'PCE(%)';

cb1.Title.FontName = fontName;

cb1.Title.FontSize = 12;

cb1.Title.FontWeight = 'bold';

cb1.Title.Color = 'black';


%% ============================================================
%                         (f) Voc
% =============================================================

ax2 = axes( ...
    'Parent',fig, ...
    'Position',[0.500 0.555 0.315 0.355]);


scatter3(ax2,...
    X,Y,Z,...
    markerSize,...
    Voc,...
    'filled',...
    'MarkerEdgeColor','none',...
    'MarkerFaceAlpha',1);


view(ax2,az,el);

xlim(ax2,xRange);

ylim(ax2,yRange);

zlim(ax2,zRange);

grid(ax2,'on');

box(ax2,'on');


%% AXIS FORMAT

ax2.FontName = fontName;

ax2.FontSize = 10;

ax2.FontWeight = 'bold';

ax2.LineWidth = 1.0;

ax2.XColor = 'black';

ax2.YColor = 'black';

ax2.ZColor = 'black';

ax2.Color = 'white';


%% GRID

ax2.GridLineStyle = '--';

ax2.GridColor = [0.72 0.72 0.72];

ax2.GridAlpha = 0.30;


%% TICKS

ax2.XTick = logTicks;

ax2.YTick = logTicks;

ax2.ZTick = logTicks;

ax2.XTickLabel = logTickLabels;

ax2.YTickLabel = logTickLabels;

ax2.ZTickLabel = logTickLabels;


%% AXIS DIRECTIONS

ax2.XDir = 'normal';

ax2.YDir = 'reverse';

ax2.ZDir = 'normal';


%% ============================================================
%                    AXIS LABELS
% =============================================================

hx = xlabel(ax2,...
    'N_t of MASnI_3 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',10,...
    'FontWeight','bold',...
    'Color','black');


hy = ylabel(ax2,...
    'N_t of Cs_2TiBr_6 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',10,...
    'FontWeight','bold',...
    'Color','black');


hz = zlabel(ax2,...
    'N_t of Cs_3Bi_2I_9 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',10,...
    'FontWeight','bold',...
    'Color','black');


%% LABEL ROTATION

hx.Rotation = xLabelRotation;

hy.Rotation = yLabelRotation;

hz.Rotation = zLabelRotation;


%% LABEL POSITION

hx.Position = hx.Position + xLabelOffset;

hy.Position = hy.Position + yLabelOffset;

hz.Position = hz.Position + zLabelOffset;


hx.HorizontalAlignment = 'center';

hy.HorizontalAlignment = 'center';

hz.HorizontalAlignment = 'center';


%% ============================================================
%                    PANEL TITLE
% =============================================================

% ===================== (f) =====================
t = title(ax2,'(f)', ...
    'FontName',fontName, ...
    'FontSize',15, ...
    'FontWeight','bold', ...
    'Color','black');

t.Units = 'normalized';
t.Position = [0 1.0 0];
t.HorizontalAlignment = 'left';


%% ============================================================
%                    Voc COLORBAR
% =============================================================

clim(ax2,[Vocmin Vocmax]);


cb2 = colorbar(ax2);


cb2.Position = [0.825 0.620 0.014 0.250];


cb2.Ticks = Vocticks;


cb2.TickLabels = VoctickLabels;


cb2.FontName = fontName;

cb2.FontSize = 10;

cb2.Color = 'black';


cb2.Title.String = 'V_{OC}(V)';

cb2.Title.FontName = fontName;

cb2.Title.FontSize = 12;

cb2.Title.FontWeight = 'bold';

cb2.Title.Color = 'black';


%% ============================================================
%                         (g) Jsc
% =============================================================

ax3 = axes( ...
    'Parent',fig, ...
    'Position',[0.075 0.095 0.315 0.355]);


scatter3(ax3,...
    X,Y,Z,...
    markerSize,...
    Jsc,...
    'filled',...
    'MarkerEdgeColor','none',...
    'MarkerFaceAlpha',1);


view(ax3,az,el);

xlim(ax3,xRange);

ylim(ax3,yRange);

zlim(ax3,zRange);

grid(ax3,'on');

box(ax3,'on');


%% AXIS FORMAT

ax3.FontName = fontName;

ax3.FontSize = 10;

ax3.FontWeight = 'bold';

ax3.LineWidth = 1.0;

ax3.XColor = 'black';

ax3.YColor = 'black';

ax3.ZColor = 'black';

ax3.Color = 'white';


%% GRID

ax3.GridLineStyle = '--';

ax3.GridColor = [0.72 0.72 0.72];

ax3.GridAlpha = 0.30;


%% TICKS

ax3.XTick = logTicks;

ax3.YTick = logTicks;

ax3.ZTick = logTicks;

ax3.XTickLabel = logTickLabels;

ax3.YTickLabel = logTickLabels;

ax3.ZTickLabel = logTickLabels;


%% AXIS DIRECTIONS

ax3.XDir = 'normal';

ax3.YDir = 'reverse';

ax3.ZDir = 'normal';


%% ============================================================
%                    AXIS LABELS
% =============================================================

hx = xlabel(ax3,...
    'N_t of MASnI_3 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',10,...
    'FontWeight','bold',...
    'Color','black');


hy = ylabel(ax3,...
    'N_t of Cs_2TiBr_6 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',10,...
    'FontWeight','bold',...
    'Color','black');


hz = zlabel(ax3,...
    'N_t of Cs_3Bi_2I_9 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',10,...
    'FontWeight','bold',...
    'Color','black');


%% LABEL ROTATION

hx.Rotation = xLabelRotation;

hy.Rotation = yLabelRotation;

hz.Rotation = zLabelRotation;


%% LABEL POSITION

hx.Position = hx.Position + xLabelOffset;

hy.Position = hy.Position + yLabelOffset;

hz.Position = hz.Position + zLabelOffset;


hx.HorizontalAlignment = 'center';

hy.HorizontalAlignment = 'center';

hz.HorizontalAlignment = 'center';


%% ============================================================
%                    PANEL TITLE
% =============================================================
% ===================== (g) =====================
t = title(ax3,'(g)', ...
    'FontName',fontName, ...
    'FontSize',15, ...
    'FontWeight','bold', ...
    'Color','black');

t.Units = 'normalized';
t.Position = [0 1.0 0];
t.HorizontalAlignment = 'left';


%% ============================================================
%                    Jsc COLORBAR
% =============================================================

clim(ax3,[Jscmin Jscmax]);


cb3 = colorbar(ax3);


cb3.Position = [0.400 0.160 0.014 0.250];


cb3.Ticks = Jscticks;


cb3.TickLabels = JsctickLabels;


cb3.FontName = fontName;

cb3.FontSize = 10;

cb3.Color = 'black';


cb3.Title.String = 'J_{SC}(mA/cm^2)';

cb3.Title.FontName = fontName;

cb3.Title.FontSize = 12;

cb3.Title.FontWeight = 'bold';

cb3.Title.Color = 'black';


%% ============================================================
%                         (h) FF
% =============================================================

ax4 = axes( ...
    'Parent',fig, ...
    'Position',[0.500 0.095 0.315 0.355]);


scatter3(ax4,...
    X,Y,Z,...
    markerSize,...
    FF,...
    'filled',...
    'MarkerEdgeColor','none',...
    'MarkerFaceAlpha',1);


view(ax4,az,el);

xlim(ax4,xRange);

ylim(ax4,yRange);

zlim(ax4,zRange);

grid(ax4,'on');

box(ax4,'on');


%% AXIS FORMAT

ax4.FontName = fontName;

ax4.FontSize = 10;

ax4.FontWeight = 'bold';

ax4.LineWidth = 1.0;

ax4.XColor = 'black';

ax4.YColor = 'black';

ax4.ZColor = 'black';

ax4.Color = 'white';


%% GRID

ax4.GridLineStyle = '--';

ax4.GridColor = [0.72 0.72 0.72];

ax4.GridAlpha = 0.30;


%% TICKS

ax4.XTick = logTicks;

ax4.YTick = logTicks;

ax4.ZTick = logTicks;

ax4.XTickLabel = logTickLabels;

ax4.YTickLabel = logTickLabels;

ax4.ZTickLabel = logTickLabels;


%% AXIS DIRECTIONS

ax4.XDir = 'normal';

ax4.YDir = 'reverse';

ax4.ZDir = 'normal';


%% ============================================================
%                    AXIS LABELS
% =============================================================

hx = xlabel(ax4,...
    'N_t of MASnI_3 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',10,...
    'FontWeight','bold',...
    'Color','black');


hy = ylabel(ax4,...
    'N_t of Cs_2TiBr_6 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',10,...
    'FontWeight','bold',...
    'Color','black');


hz = zlabel(ax4,...
    'N_t of Cs_3Bi_2I_9 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',10,...
    'FontWeight','bold',...
    'Color','black');


%% LABEL ROTATION

hx.Rotation = xLabelRotation;

hy.Rotation = yLabelRotation;

hz.Rotation = zLabelRotation;


%% LABEL POSITION

hx.Position = hx.Position + xLabelOffset;

hy.Position = hy.Position + yLabelOffset;

hz.Position = hz.Position + zLabelOffset;


hx.HorizontalAlignment = 'center';

hy.HorizontalAlignment = 'center';

hz.HorizontalAlignment = 'center';


%% ============================================================
%                    PANEL TITLE
% =============================================================

% ===================== (h) =====================
t = title(ax4,'(h)', ...
    'FontName',fontName, ...
    'FontSize',15, ...
    'FontWeight','bold', ...
    'Color','black');

t.Units = 'normalized';
t.Position = [0 1.0 0];
t.HorizontalAlignment = 'left';

%% ============================================================
%                    FF COLORBAR
% =============================================================

clim(ax4,[FFmin FFmax]);


cb4 = colorbar(ax4);


cb4.Position = [0.825 0.160 0.014 0.250];


cb4.Ticks = FFticks;


cb4.TickLabels = FFtickLabels;


cb4.FontName = fontName;

cb4.FontSize = 10;

cb4.Color = 'black';


cb4.Title.String = 'FF(%)';

cb4.Title.FontName = fontName;

cb4.Title.FontSize = 12;

cb4.Title.FontWeight = 'bold';

cb4.Title.Color = 'black';


%% ============================================================
%                    RENDERING
% =============================================================

set(fig,'Renderer','opengl');


%% ============================================================
%                    SAVE FIGURE
% =============================================================

exportgraphics( ...
    fig,...
    'Defect_3D_Mapping_MASnI3_Cs2TiBr6_Cs3Bi2I9.png',...
    'Resolution',600);


%% ============================================================
%                    FINAL CHECK
% =============================================================

fprintf('\n============================================\n');

fprintf('FINAL AXIS ORDER:\n');

fprintf('X = Nt of MASnI3       : 10^9 -> 10^18\n');

fprintf('Y = Nt of Cs2TiBr6     : 10^18 -> 10^9\n');

fprintf('Z = Nt of Cs3Bi2I9     : 10^9 -> 10^18\n');

fprintf('============================================\n');

fprintf('PCE colorbar ticks = %d\n',length(cb1.Ticks));

fprintf('Voc colorbar ticks = %d\n',length(cb2.Ticks));

fprintf('Jsc colorbar ticks = %d\n',length(cb3.Ticks));

fprintf('FF  colorbar ticks = %d\n',length(cb4.Ticks));

fprintf('============================================\n');

fprintf('ALL VALID EXCEL DATA USED.\n');

fprintf('NO PERFORMANCE DATA CLIPPED.\n');

fprintf('============================================\n');