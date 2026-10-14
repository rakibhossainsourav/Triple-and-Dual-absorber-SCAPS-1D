clc
clear
close all

%% ============================================================
% READ EXCEL DATA
% ============================================================

filename = 'batch thickness (Tripple).xlsx';

data = readtable(filename);

% ============================================================
% EXCEL COLUMN ARRANGEMENT
% ============================================================
% Column 1 = Thickness of Cs2TiBr6 (um)
% Column 2 = Thickness of MASnI3 (um)
% Column 3 = Thickness of Cs3Bi2I9 (um)
% Column 4 = PCE (%)
% Column 5 = Voc (V)
% Column 6 = Jsc (mA/cm^2)
% Column 7 = FF (%)
% ============================================================

Cs2TiBr6 = data{:,1};
MASnI3   = data{:,2};
Cs3Bi2I9 = data{:,3};

PCE = data{:,4};
Voc = data{:,5};
Jsc = data{:,6};
FF  = data{:,7};


%% ============================================================
% GENERAL JOURNAL SETTINGS
% ============================================================

fontName = 'Times New Roman';

% ------------------------------------------------------------
% BUBBLE SIZE
% ------------------------------------------------------------

markerSize = 45;


% ------------------------------------------------------------
% VIEWING ANGLE
% ------------------------------------------------------------

az = -40;
el = 25;


% ------------------------------------------------------------
% AXIS LIMITS
% ------------------------------------------------------------

xRange = [0 1.5];
yRange = [0 1.5];
zRange = [0 1.6];


% ------------------------------------------------------------
% AXIS TICKS
% ------------------------------------------------------------

xyTicks = [0 0.5 1.0 1.5];
zTicks  = [0 0.5 1.0 1.5];


% ------------------------------------------------------------
% AXIS LABEL ROTATION / POSITION (SAME FOR ALL PANELS,
% since all panels share the same view angle & box geometry)
% ------------------------------------------------------------

xLabelRotation = 15;
yLabelRotation = -18;
zLabelRotation = 90;

xLabelOffset = [0.2 .05 0.18];
yLabelOffset = [0 0.15 0.38];


%% ============================================================
% CREATE FIGURE
% ============================================================

figure( ...
    'Color','white', ...
    'Units','pixels', ...
    'Position',[100 50 1050 650]);


%% ============================================================
% COLORMAP
% ============================================================

colormap(jet);


%% ============================================================
% ============================================================
%                         (e) PCE
% ============================================================
% ============================================================

ax1 = axes( ...
    'Position',[0.075 0.555 0.315 0.355]);


scatter3( ...
    Cs2TiBr6, ...
    MASnI3, ...
    Cs3Bi2I9, ...
    markerSize, ...
    PCE, ...
    'filled', ...
    'MarkerEdgeColor','none', ...
    'MarkerFaceAlpha',1);


%% VIEW

view(az,el);


%% LIMITS

xlim(xRange);
ylim(yRange);
zlim(zRange);


%% BOX AND GRID

grid on
box on


%% AXIS FORMAT

ax = gca;

ax.FontName = fontName;
ax.FontSize = 10;
ax.FontWeight = 'bold';

ax.LineWidth = 1.0;

ax.XColor = 'black';
ax.YColor = 'black';
ax.ZColor = 'black';

ax.Color = 'white';


%% GRID FORMAT

ax.GridLineStyle = '--';
ax.GridColor = [0.72 0.72 0.72];
ax.GridAlpha = 0.30;


%% TICKS

ax.XTick = xyTicks;
ax.YTick = xyTicks;
ax.ZTick = zTicks;


%% ================= AXIS LABELS =================

hx = xlabel('Thickness of Cs_2TiBr_6(\mum)', ...
    'FontName',fontName, ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'Color','black');

hy = ylabel('Thickness of MASnI_3(\mum)', ...
    'FontName',fontName, ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'Color','black');

hz = zlabel('Thickness of Cs_3Bi_2I_9(\mum)', ...
    'FontName',fontName, ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'Color','black');


%% ALIGN LABELS WITH THE VISIBLE 3D BOX EDGES

hx.Rotation = xLabelRotation;
hy.Rotation = yLabelRotation;
hz.Rotation = zLabelRotation;

hx.Position = hx.Position + xLabelOffset;
hy.Position = hy.Position + yLabelOffset;


%% PANEL LABEL

% ===================== (e) =====================
t = title(ax1,'(e)', ...
    'FontName',fontName, ...
    'FontSize',15, ...
    'FontWeight','bold', ...
    'Color','black');

t.Units = 'normalized';
t.Position = [0 1.0 0];
t.HorizontalAlignment = 'left';


%% COLORBAR

caxis([8 18]);

cb1 = colorbar;

cb1.Position = [0.4 0.620 0.014 0.25];

cb1.Ticks = 8:2:18;

cb1.FontName = fontName;
cb1.FontSize = 10;
cb1.FontWeight = 'normal';

cb1.Color = 'black';
cb1.LineWidth = 0.8;

cb1.Title.String = 'PCE(%)';
cb1.Title.FontName = fontName;
cb1.Title.FontSize = 12;
cb1.Title.FontWeight = 'bold';
cb1.Title.Color = 'black';


%% ============================================================
% ============================================================
%                         (f) Voc
% ============================================================
% ============================================================

ax2 = axes( ...
    'Position',[0.50 0.555 0.315 0.355]);


scatter3( ...
    Cs2TiBr6, ...
    MASnI3, ...
    Cs3Bi2I9, ...
    markerSize, ...
    Voc, ...
    'filled', ...
    'MarkerEdgeColor','none', ...
    'MarkerFaceAlpha',1);


%% VIEW

view(az,el);


%% LIMITS

xlim(xRange);
ylim(yRange);
zlim(zRange);


%% BOX AND GRID

grid on
box on


%% AXIS FORMAT

ax = gca;

ax.FontName = fontName;
ax.FontSize = 10;
ax.FontWeight = 'bold';

ax.LineWidth = 1.0;

ax.XColor = 'black';
ax.YColor = 'black';
ax.ZColor = 'black';

ax.Color = 'white';


%% GRID

ax.GridLineStyle = '--';
ax.GridColor = [0.72 0.72 0.72];
ax.GridAlpha = 0.30;


%% TICKS

ax.XTick = xyTicks;
ax.YTick = xyTicks;
ax.ZTick = zTicks;


%% AXIS LABELS

hx = xlabel('Thickness of Cs_2TiBr_6(\mum)', ...
    'FontName',fontName, ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'Color','black');

hy = ylabel('Thickness of MASnI_3(\mum)', ...
    'FontName',fontName, ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'Color','black');

hz = zlabel('Thickness of Cs_3Bi_2I_9(\mum)', ...
    'FontName',fontName, ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'Color','black');


%% ALIGN LABELS WITH THE VISIBLE 3D BOX EDGES

hx.Rotation = xLabelRotation;
hy.Rotation = yLabelRotation;
hz.Rotation = zLabelRotation;

hx.Position = hx.Position + xLabelOffset;
hy.Position = hy.Position + yLabelOffset;


%% PANEL LABEL

% ===================== (f) =====================
t = title(ax2,'(f)', ...
    'FontName',fontName, ...
    'FontSize',15, ...
    'FontWeight','bold', ...
    'Color','black');

t.Units = 'normalized';
t.Position = [0 1.0 0];
t.HorizontalAlignment = 'left';

%% COLORBAR

caxis([0.835 0.86]);

cb2 = colorbar;

cb2.Position = [0.825 0.62 0.014 0.25];

cb2.Ticks = [0.835 0.84 0.845 0.85 0.855 0.86];

cb2.FontName = fontName;
cb2.FontSize = 10;
cb2.FontWeight = 'normal';

cb2.Color = 'black';

cb2.LineWidth = 0.8;

cb2.Title.String = 'V_{OC}(V)';
cb2.Title.FontName = fontName;
cb2.Title.FontSize = 12;
cb2.Title.FontWeight = 'bold';
cb2.Title.Color = 'black';


%% ============================================================
% ============================================================
%                         (g) Jsc
% ============================================================
% ============================================================

ax3 = axes( ...
    'Position',[0.075 0.075 0.315 0.355]);


scatter3( ...
    Cs2TiBr6, ...
    MASnI3, ...
    Cs3Bi2I9, ...
    markerSize, ...
    Jsc, ...
    'filled', ...
    'MarkerEdgeColor','none', ...
    'MarkerFaceAlpha',1);


%% VIEW

view(az,el);


%% LIMITS

xlim(xRange);
ylim(yRange);
zlim(zRange);


%% BOX AND GRID

grid on
box on


%% AXIS FORMAT

ax = gca;

ax.FontName = fontName;
ax.FontSize = 10;
ax.FontWeight = 'bold';

ax.LineWidth = 1.0;

ax.XColor = 'black';
ax.YColor = 'black';
ax.ZColor = 'black';

ax.Color = 'white';


%% GRID

ax.GridLineStyle = '--';
ax.GridColor = [0.72 0.72 0.72];
ax.GridAlpha = 0.30;


%% TICKS

ax.XTick = xyTicks;
ax.YTick = xyTicks;
ax.ZTick = zTicks;


%% AXIS LABELS

hx = xlabel('Thickness of Cs_2TiBr_6(\mum)', ...
    'FontName',fontName, ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'Color','black');

hy = ylabel('Thickness of MASnI_3(\mum)', ...
    'FontName',fontName, ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'Color','black');

hz = zlabel('Thickness of Cs_3Bi_2I_9(\mum)', ...
    'FontName',fontName, ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'Color','black');


%% ALIGN LABELS WITH THE VISIBLE 3D BOX EDGES

hx.Rotation = xLabelRotation;
hy.Rotation = yLabelRotation;
hz.Rotation = zLabelRotation;

hx.Position = hx.Position + xLabelOffset;
hy.Position = hy.Position + yLabelOffset;


%% PANEL LABEL

t = title(ax3,'(g)', ...
    'FontName',fontName, ...
    'FontSize',15, ...
    'FontWeight','bold', ...
    'Color','black');

t.Units = 'normalized';
t.Position = [0 1.0 0];
t.HorizontalAlignment = 'left';

%% COLORBAR

caxis([12 26]);

cb3 = colorbar;

cb3.Position = [0.4 0.14 0.014 0.25];

cb3.Ticks = 12:2:26;

cb3.FontName = fontName;
cb3.FontSize = 10;
cb3.FontWeight = 'normal';

cb3.Color = 'black';

cb3.LineWidth = 0.8;

cb3.Title.String = 'J_{SC}(mA/cm^2)';
cb3.Title.FontName = fontName;
cb3.Title.FontSize = 12;
cb3.Title.FontWeight = 'bold';
cb3.Title.Color = 'black';


%% ============================================================
% ============================================================
%                          (h) FF
% ============================================================
% ============================================================

ax4 = axes( ...
    'Position',[0.50 0.075 0.315 0.355]);


scatter3( ...
    Cs2TiBr6, ...
    MASnI3, ...
    Cs3Bi2I9, ...
    markerSize, ...
    FF, ...
    'filled', ...
    'MarkerEdgeColor','none', ...
    'MarkerFaceAlpha',1);


%% VIEW

view(az,el);


%% LIMITS

xlim(xRange);
ylim(yRange);
zlim(zRange);


%% BOX AND GRID

grid on
box on


%% AXIS FORMAT

ax = gca;

ax.FontName = fontName;
ax.FontSize = 10;
ax.FontWeight = 'bold';

ax.LineWidth = 1.0;

ax.XColor = 'black';
ax.YColor = 'black';
ax.ZColor = 'black';

ax.Color = 'white';


%% GRID

ax.GridLineStyle = '--';
ax.GridColor = [0.72 0.72 0.72];
ax.GridAlpha = 0.30;


%% TICKS

ax.XTick = xyTicks;
ax.YTick = xyTicks;
ax.ZTick = zTicks;


%% AXIS LABELS

hx = xlabel('Thickness of Cs_2TiBr_6(\mum)', ...
    'FontName',fontName, ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'Color','black');

hy = ylabel('Thickness of MASnI_3(\mum)', ...
    'FontName',fontName, ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'Color','black');

hz = zlabel('Thickness of Cs_3Bi_2I_9(\mum)', ...
    'FontName',fontName, ...
    'FontSize',10, ...
    'FontWeight','bold', ...
    'Color','black');


%% ALIGN LABELS WITH THE VISIBLE 3D BOX EDGES

hx.Rotation = xLabelRotation;
hy.Rotation = yLabelRotation;
hz.Rotation = zLabelRotation;

hx.Position = hx.Position + xLabelOffset;
hy.Position = hy.Position + yLabelOffset;


%% PANEL LABEL

t = title(ax4,'(h)', ...
    'FontName',fontName, ...
    'FontSize',15, ...
    'FontWeight','bold', ...
    'Color','black');

t.Units = 'normalized';
t.Position = [0 1.0 0];
t.HorizontalAlignment = 'left';


%% COLORBAR

caxis([79 82.5]);

cb4 = colorbar;

% ONLY THIS POSITION WAS CHANGED
cb4.Position = [0.825 0.14 0.014 0.25];

cb4.Ticks = [79 79.5 80 80.5 81 81.5 82 82.5];

cb4.FontName = fontName;
cb4.FontSize = 10;
cb4.FontWeight = 'normal';

cb4.Color = 'black';

cb4.LineWidth = 0.8;

cb4.Title.String = 'FF(%)';
cb4.Title.FontName = fontName;
cb4.Title.FontSize = 12;
cb4.Title.FontWeight = 'bold';
cb4.Title.Color = 'black';


%% ============================================================
% FINAL RENDERING
% ============================================================

set(gcf,'Renderer','opengl');
set(gcf,'Color','white');