clc
clear
close all

%% ============================================================
%                    READ EXCEL DATA
% =============================================================

filename = 'Na,Nd(Tripple)1.xlsx';

T = readtable(filename);

disp('Excel data loaded successfully.');
disp(T);


%% ============================================================
%                    ORIGINAL EXCEL ORDER
%
% Column 1 = ND of Cs2TiBr6   (bp1)
% Column 2 = NA of MASnI3     (bp2)
% Column 3 = NA of Cs3Bi2I9   (bp3)
% Column 4 = PCE
% Column 5 = Voc
% Column 6 = Jsc
% Column 7 = FF
% =============================================================

ND_Cs2TiBr6 = T{:,1};
NA_MASnI3   = T{:,2};
NA_Cs3Bi2I9 = T{:,3};

PCE = T{:,4};
Voc = T{:,5};
Jsc = T{:,6};
FF  = T{:,7};


%% ============================================================
%                    REMOVE ONLY INVALID ROWS
% =============================================================

valid = isfinite(ND_Cs2TiBr6) & ...
        isfinite(NA_MASnI3) & ...
        isfinite(NA_Cs3Bi2I9) & ...
        isfinite(PCE) & ...
        isfinite(Voc) & ...
        isfinite(Jsc) & ...
        isfinite(FF) & ...
        ND_Cs2TiBr6 > 0 & ...
        NA_MASnI3 > 0 & ...
        NA_Cs3Bi2I9 > 0;

ND_Cs2TiBr6 = ND_Cs2TiBr6(valid);
NA_MASnI3   = NA_MASnI3(valid);
NA_Cs3Bi2I9 = NA_Cs3Bi2I9(valid);

PCE = PCE(valid);
Voc = Voc(valid);
Jsc = Jsc(valid);
FF  = FF(valid);


%% ============================================================
%                    FINAL AXIS ORDER
%
% X = NA of MASnI3
% Y = ND of Cs2TiBr6
% Z = NA of Cs3Bi2I9
% =============================================================

X = log10(NA_MASnI3);
Y = log10(ND_Cs2TiBr6);
Z = log10(NA_Cs3Bi2I9);


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

% ALL FIGURE TEXT = 15 PT
fontSize = 15;

markerSize = 45;

% 3D VIEW
az = -40;
el = 25;


%% ============================================================
%                    AXIS LIMITS
%
% X: NA of MASnI3       10^9 -> 10^18
% Y: ND of Cs2TiBr6     10^18 -> 10^9
% Z: NA of Cs3Bi2I9    10^9 -> 10^18
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
% EXACTLY 6 TICKS
% =============================================================

nTicks = 6;

PCEmin = min(PCE);
PCEmax = max(PCE);

Vocmin = min(Voc);
Vocmax = max(Voc);

Jscmin = min(Jsc);
Jscmax = max(Jsc);

FFmin = min(FF);
FFmax = max(FF);

PCEticks = linspace(PCEmin,PCEmax,nTicks);
Vocticks = linspace(Vocmin,Vocmax,nTicks);
Jscticks = linspace(Jscmin,Jscmax,nTicks);
FFticks  = linspace(FFmin,FFmax,nTicks);

PCEtickLabels = arrayfun(@(v) sprintf('%.2f',v), ...
    PCEticks,'UniformOutput',false);

VoctickLabels = arrayfun(@(v) sprintf('%.2f',v), ...
    Vocticks,'UniformOutput',false);

JsctickLabels = arrayfun(@(v) sprintf('%.2f',v), ...
    Jscticks,'UniformOutput',false);

FFtickLabels = arrayfun(@(v) sprintf('%.2f',v), ...
    FFticks,'UniformOutput',false);


%% ============================================================
%                    FIGURE
% =============================================================

fig = figure( ...
    'Color','white', ...
    'Units','pixels', ...
    'Position',[80 40 1250 800]);

colormap(fig,jet(256));


%% ============================================================
%                    LABEL SETTINGS
%
% IMPORTANT:
% These settings specifically correct the positions and
% rotations of:
%
% 1. ND of Cs2TiBr6
% 2. NA of MASnI3
% =============================================================

% ------------------------------------------------------------
% NA of MASnI3 — X AXIS
% ------------------------------------------------------------

xLabelRotation = 12;

% Move X label slightly upward and toward the center
xLabelOffset = [0 2.0 2.6];


% ------------------------------------------------------------
% ND of Cs2TiBr6 — Y AXIS
% ------------------------------------------------------------

yLabelRotation = -18;

% Move Y label slightly left and upward
yLabelOffset = [-0.20 -0.65 3.1];


% ------------------------------------------------------------
% NA of Cs3Bi2I9 — Z AXIS
% ------------------------------------------------------------

zLabelRotation = 90;

zLabelOffset = [0.10 0 0];


%% ============================================================
%                         (e) PCE
% =============================================================

ax1 = axes( ...
    'Parent',fig, ...
    'Position',[0.080 0.550 0.310 0.335]);

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


%% AXIS APPEARANCE

ax1.FontName = fontName;
ax1.FontSize = fontSize;
ax1.FontWeight = 'bold';
ax1.LineWidth = 1.0;

ax1.XColor = 'black';
ax1.YColor = 'black';
ax1.ZColor = 'black';
ax1.Color = 'white';

ax1.GridLineStyle = '--';
ax1.GridColor = [0.72 0.72 0.72];
ax1.GridAlpha = 0.30;


%% AXIS TICKS

ax1.XTick = logTicks;
ax1.YTick = logTicks;
ax1.ZTick = logTicks;

ax1.XTickLabel = logTickLabels;
ax1.YTickLabel = logTickLabels;
ax1.ZTickLabel = logTickLabels;

ax1.XDir = 'normal';
ax1.YDir = 'reverse';
ax1.ZDir = 'normal';


%% AXIS LABELS

hx = xlabel(ax1,...
    'N_A of MASnI_3 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',fontSize,...
    'FontWeight','bold',...
    'Color','black');

hy = ylabel(ax1,...
    'N_D of Cs_2TiBr_6 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',fontSize,...
    'FontWeight','bold',...
    'Color','black');

hz = zlabel(ax1,...
    'N_A of Cs_3Bi_2I_9 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',fontSize,...
    'FontWeight','bold',...
    'Color','black');


%% APPLY CORRECTED ROTATIONS

hx.Rotation = xLabelRotation;
hy.Rotation = yLabelRotation;
hz.Rotation = zLabelRotation;


%% APPLY CORRECTED POSITIONS

hx.Position = hx.Position + xLabelOffset;
hy.Position = hy.Position + yLabelOffset;
hz.Position = hz.Position + zLabelOffset;


hx.HorizontalAlignment = 'center';
hy.HorizontalAlignment = 'center';
hz.HorizontalAlignment = 'center';


%% PANEL LABEL

t = title(ax1,'(e)', ...
    'FontName',fontName, ...
    'FontSize',fontSize, ...
    'FontWeight','bold', ...
    'Color','black');

t.Units = 'normalized';
t.Position = [0 1.0 0];
t.HorizontalAlignment = 'left';


%% COLORBAR

clim(ax1,[PCEmin PCEmax]);

cb1 = colorbar(ax1);

cb1.Position = [0.405 0.605 0.014 0.225];

cb1.Ticks = PCEticks;
cb1.TickLabels = PCEtickLabels;

cb1.FontName = fontName;
cb1.FontSize = fontSize;
cb1.FontWeight = 'bold';
cb1.Color = 'black';

cb1.Title.String = 'PCE(%)';
cb1.Title.FontName = fontName;
cb1.Title.FontSize = fontSize;
cb1.Title.FontWeight = 'bold';
cb1.Title.Color = 'black';


%% ============================================================
%                         (f) Voc
% =============================================================

ax2 = axes( ...
    'Parent',fig, ...
    'Position',[0.54 0.550 0.310 0.335]);

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


%% AXIS APPEARANCE

ax2.FontName = fontName;
ax2.FontSize = fontSize;
ax2.FontWeight = 'bold';
ax2.LineWidth = 1.0;

ax2.XColor = 'black';
ax2.YColor = 'black';
ax2.ZColor = 'black';
ax2.Color = 'white';

ax2.GridLineStyle = '--';
ax2.GridColor = [0.72 0.72 0.72];
ax2.GridAlpha = 0.30;


%% AXIS TICKS

ax2.XTick = logTicks;
ax2.YTick = logTicks;
ax2.ZTick = logTicks;

ax2.XTickLabel = logTickLabels;
ax2.YTickLabel = logTickLabels;
ax2.ZTickLabel = logTickLabels;

ax2.XDir = 'normal';
ax2.YDir = 'reverse';
ax2.ZDir = 'normal';


%% AXIS LABELS

hx = xlabel(ax2,...
    'N_A of MASnI_3 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',fontSize,...
    'FontWeight','bold',...
    'Color','black');

hy = ylabel(ax2,...
    'N_D of Cs_2TiBr_6 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',fontSize,...
    'FontWeight','bold',...
    'Color','black');

hz = zlabel(ax2,...
    'N_A of Cs_3Bi_2I_9 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',fontSize,...
    'FontWeight','bold',...
    'Color','black');


%% CORRECTED ROTATIONS

hx.Rotation = xLabelRotation;
hy.Rotation = yLabelRotation;
hz.Rotation = zLabelRotation;


%% CORRECTED POSITIONS

hx.Position = hx.Position + xLabelOffset;
hy.Position = hy.Position + yLabelOffset;
hz.Position = hz.Position + zLabelOffset;


hx.HorizontalAlignment = 'center';
hy.HorizontalAlignment = 'center';
hz.HorizontalAlignment = 'center';


%% PANEL LABEL

t = title(ax2,'(f)', ...
    'FontName',fontName, ...
    'FontSize',fontSize, ...
    'FontWeight','bold', ...
    'Color','black');

t.Units = 'normalized';
t.Position = [0 1.0 0];
t.HorizontalAlignment = 'left';


%% COLORBAR

clim(ax2,[Vocmin Vocmax]);

cb2 = colorbar(ax2);

cb2.Position = [0.865 0.605 0.014 0.225];

cb2.Ticks = Vocticks;
cb2.TickLabels = VoctickLabels;

cb2.FontName = fontName;
cb2.FontSize = fontSize;
cb2.FontWeight = 'bold';
cb2.Color = 'black';

cb2.Title.String = 'V_{OC}(V)';
cb2.Title.FontName = fontName;
cb2.Title.FontSize = fontSize;
cb2.Title.FontWeight = 'bold';
cb2.Title.Color = 'black';


%% ============================================================
%                         (g) Jsc
% =============================================================

ax3 = axes( ...
    'Parent',fig, ...
    'Position',[0.080 0.105 0.310 0.335]);

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


%% AXIS APPEARANCE

ax3.FontName = fontName;
ax3.FontSize = fontSize;
ax3.FontWeight = 'bold';
ax3.LineWidth = 1.0;

ax3.XColor = 'black';
ax3.YColor = 'black';
ax3.ZColor = 'black';
ax3.Color = 'white';

ax3.GridLineStyle = '--';
ax3.GridColor = [0.72 0.72 0.72];
ax3.GridAlpha = 0.30;


%% AXIS TICKS

ax3.XTick = logTicks;
ax3.YTick = logTicks;
ax3.ZTick = logTicks;

ax3.XTickLabel = logTickLabels;
ax3.YTickLabel = logTickLabels;
ax3.ZTickLabel = logTickLabels;

ax3.XDir = 'normal';
ax3.YDir = 'reverse';
ax3.ZDir = 'normal';


%% AXIS LABELS

hx = xlabel(ax3,...
    'N_A of MASnI_3 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',fontSize,...
    'FontWeight','bold',...
    'Color','black');

hy = ylabel(ax3,...
    'N_D of Cs_2TiBr_6 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',fontSize,...
    'FontWeight','bold',...
    'Color','black');

hz = zlabel(ax3,...
    'N_A of Cs_3Bi_2I_9 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',fontSize,...
    'FontWeight','bold',...
    'Color','black');


%% CORRECTED ROTATIONS

hx.Rotation = xLabelRotation;
hy.Rotation = yLabelRotation;
hz.Rotation = zLabelRotation;


%% CORRECTED POSITIONS

hx.Position = hx.Position + xLabelOffset;
hy.Position = hy.Position + yLabelOffset;
hz.Position = hz.Position + zLabelOffset;


hx.HorizontalAlignment = 'center';
hy.HorizontalAlignment = 'center';
hz.HorizontalAlignment = 'center';


%% PANEL LABEL

t = title(ax3,'(g)', ...
    'FontName',fontName, ...
    'FontSize',fontSize, ...
    'FontWeight','bold', ...
    'Color','black');

t.Units = 'normalized';
t.Position = [0 1.0 0];
t.HorizontalAlignment = 'left';


%% COLORBAR

clim(ax3,[Jscmin Jscmax]);

cb3 = colorbar(ax3);

cb3.Position = [0.405 0.160 0.014 0.225];

cb3.Ticks = Jscticks;
cb3.TickLabels = JsctickLabels;

cb3.FontName = fontName;
cb3.FontSize = fontSize;
cb3.FontWeight = 'bold';
cb3.Color = 'black';

cb3.Title.String = 'J_{SC}(mA/cm^2)';
cb3.Title.FontName = fontName;
cb3.Title.FontSize = fontSize;
cb3.Title.FontWeight = 'bold';
cb3.Title.Color = 'black';


%% ============================================================
%                         (h) FF
% =============================================================

ax4 = axes( ...
    'Parent',fig, ...
    'Position',[0.54 0.105 0.310 0.335]);

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


%% AXIS APPEARANCE

ax4.FontName = fontName;
ax4.FontSize = fontSize;
ax4.FontWeight = 'bold';
ax4.LineWidth = 1.0;

ax4.XColor = 'black';
ax4.YColor = 'black';
ax4.ZColor = 'black';
ax4.Color = 'white';

ax4.GridLineStyle = '--';
ax4.GridColor = [0.72 0.72 0.72];
ax4.GridAlpha = 0.30;


%% AXIS TICKS

ax4.XTick = logTicks;
ax4.YTick = logTicks;
ax4.ZTick = logTicks;

ax4.XTickLabel = logTickLabels;
ax4.YTickLabel = logTickLabels;
ax4.ZTickLabel = logTickLabels;

ax4.XDir = 'normal';
ax4.YDir = 'reverse';
ax4.ZDir = 'normal';


%% AXIS LABELS

hx = xlabel(ax4,...
    'N_A of MASnI_3 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',fontSize,...
    'FontWeight','bold',...
    'Color','black');

hy = ylabel(ax4,...
    'N_D of Cs_2TiBr_6 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',fontSize,...
    'FontWeight','bold',...
    'Color','black');

hz = zlabel(ax4,...
    'N_A of Cs_3Bi_2I_9 (cm^{-3})',...
    'FontName',fontName,...
    'FontSize',fontSize,...
    'FontWeight','bold',...
    'Color','black');


%% CORRECTED ROTATIONS

hx.Rotation = xLabelRotation;
hy.Rotation = yLabelRotation;
hz.Rotation = zLabelRotation;


%% CORRECTED POSITIONS

hx.Position = hx.Position + xLabelOffset;
hy.Position = hy.Position + yLabelOffset;
hz.Position = hz.Position + zLabelOffset;


hx.HorizontalAlignment = 'center';
hy.HorizontalAlignment = 'center';
hz.HorizontalAlignment = 'center';


%% PANEL LABEL

t = title(ax4,'(h)', ...
    'FontName',fontName, ...
    'FontSize',fontSize, ...
    'FontWeight','bold', ...
    'Color','black');

t.Units = 'normalized';
t.Position = [0 1.0 0];
t.HorizontalAlignment = 'left';


%% COLORBAR

clim(ax4,[FFmin FFmax]);

cb4 = colorbar(ax4);

cb4.Position = [0.865 0.160 0.014 0.225];

cb4.Ticks = FFticks;
cb4.TickLabels = FFtickLabels;

cb4.FontName = fontName;
cb4.FontSize = fontSize;
cb4.FontWeight = 'bold';
cb4.Color = 'black';

cb4.Title.String = 'FF(%)';
cb4.Title.FontName = fontName;
cb4.Title.FontSize = fontSize;
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
    'Doping_3D_Mapping_MASnI3_Cs2TiBr6_Cs3Bi2I9.png',...
    'Resolution',600);


%% ============================================================
%                    FINAL CHECK
% =============================================================

fprintf('\n============================================\n');
fprintf('FINAL AXIS ORDER\n');
fprintf('============================================\n');

fprintf('X = NA of MASnI3       : 10^9 -> 10^18\n');
fprintf('Y = ND of Cs2TiBr6     : 10^18 -> 10^9\n');
fprintf('Z = NA of Cs3Bi2I9     : 10^9 -> 10^18\n');

fprintf('\n============================================\n');
fprintf('FONT SIZE = 15 pt\n');
fprintf('FONT = Times New Roman Bold\n');
fprintf('============================================\n');

fprintf('PCE colorbar ticks = %d\n',length(cb1.Ticks));
fprintf('Voc colorbar ticks = %d\n',length(cb2.Ticks));
fprintf('Jsc colorbar ticks = %d\n',length(cb3.Ticks));
fprintf('FF  colorbar ticks = %d\n',length(cb4.Ticks));

fprintf('\n============================================\n');
fprintf('ALL VALID EXCEL DATA USED.\n');
fprintf('NO PERFORMANCE DATA CLIPPED.\n');
fprintf('MODERATE PANEL SPACING APPLIED.\n');
fprintf('ND AND NA LABEL POSITIONS CORRECTED.\n');
fprintf('============================================\n');