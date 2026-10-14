%% ============================================================
%  3D CYLINDRICAL BAR PLOT  (Q1-journal style)
%  Interface T.xlsx  ->  (a) PCE  (b) Voc  (c) Jsc  (d) FF
%  All text: Times New Roman, bold, 15 pt
%
%  AXIS LABELS:
%  MASn3/Cs2TiBr6  Nt (cm^-3)  -> ONE LINE
%  Cs3Bi2I9/MASnI3 Nt (cm^-3)  -> ONE LINE
% ============================================================

clear; clc; close all force;

%% ---------- USER SETTINGS ----------
filename = 'Interface T.xlsx';

fontName = 'Times New Roman';
fs       = 15;                  % ONE font size for everything

cmapName = 'parula';            % 'parula' | 'turbo' | 'summer' | 'cool' | 'winter'

radius   = 0.30;

viewAng  = [42 28];             % [azimuth elevation]

pba      = [1.15 1.00 0.85];    % plot box aspect ratio

rotTweak = [0 0];               % fine tune label rotation [x y]


% ------------------------------------------------------------
% LABEL POSITIONS
% ------------------------------------------------------------
% [horizontal position, vertical position]
%
% X-axis label:
%   MASn3/Cs2TiBr6  Nt (cm^-3)
%
% Y-axis label:
%   Cs3Bi2I9/MASnI3  Nt (cm^-3)
% ------------------------------------------------------------

xLab = [0.25 -0.015];
yLab = [0.850 0];


% Colour map
cmap = feval(cmapName,256);


%% ---------- READ DATA ----------
T = readtable(filename);

bp1 = T{:,1};                   % Cs3Bi2I9 / MASnI3
bp2 = T{:,2};                   % MASnI3 / Cs2TiBr6

data = {T{:,3}, T{:,4}, T{:,5}, T{:,6}};


%% ---------- LOG TRANSFORMATION ----------
x = log10(bp2);
y = log10(bp1);

xv = unique(x);
yv = unique(y);

nx = numel(xv);
ny = numel(yv);


%% ---------- CREATE DATA MATRICES ----------
mats = cell(1,4);

for m = 1:4

    M = nan(ny,nx);

    for k = 1:numel(x)

        iy = find(yv == y(k),1);
        ix = find(xv == x(k),1);

        M(iy,ix) = data{m}(k);

    end

    mats{m} = M;

end


%% ---------- PANEL DEFINITIONS ----------

zlab = { ...
    'PCE (%)', ...
    'V_{OC} (V)', ...
    'J_{SC} (mA/cm^{2})', ...
    'FF (%)'};


zlims = { ...
    [0 22], ...
    [0 1.1], ...
    [0 25], ...
    [0 90]};


ztick = { ...
    0:5:20, ...
    0:0.2:1.0, ...
    0:5:25, ...
    0:20:80};


panel = {'(a)','(b)','(c)','(d)'};


%% ---------- PANEL LAYOUT ----------

W = 0.37;
H = 0.34;

pos = { ...
    [0.09 0.585 W H], ...
    [0.50 0.585 W H], ...
    [0.09 0.145 W H], ...
    [0.50 0.145 W H]};


%% ---------- LABEL ROTATION ----------

az = viewAng(1);
el = viewAng(2);

rotX = -atand(tand(az)*sind(el)) + rotTweak(1);

rotY =  atand(sind(el)/tand(az)) + rotTweak(2);


%% ---------- FIGURE ----------

fig = figure( ...
    'Color','w', ...
    'Units','centimeters', ...
    'Position',[1 1 30 28], ...
    'Name','Interface Analysis', ...
    'NumberTitle','off');


%% ============================================================
%  DRAW FOUR PANELS
% ============================================================

for m = 1:4

    ax = axes( ...
        'Parent',fig, ...
        'Position',pos{m});


    %% ----- DATA -----

    Z = mats{m};


    %% ----- COLOUR LIMIT -----

    cLim = [min(Z(:)) max(Z(:))];


    %% ----- DRAW CYLINDERS -----

    drawCylinders( ...
        ax, ...
        xv, ...
        yv, ...
        Z, ...
        cmap, ...
        cLim, ...
        radius);


    %% ----- AXIS LIMITS -----

    xlim(ax,[min(xv)-0.6 max(xv)+0.6]);

    ylim(ax,[min(yv)-0.6 max(yv)+0.6]);

    zlim(ax,zlims{m});


    %% ----- Z TICKS -----

    zticks(ax,ztick{m});


    %% ----- X / Y TICKS -----

    xticks(ax,xv);

    yticks(ax,yv);


    %% ----- X / Y TICK LABELS -----

    xticklabels(ax,compose('10^{%d}',xv));

    yticklabels(ax,compose('10^{%d}',yv));

    ax.TickLabelInterpreter = 'tex';


    %% ----- 3D VIEW -----

    view(ax,viewAng);

    pbaspect(ax,pba);


    %% ----- AXIS APPEARANCE -----

    set(ax, ...
        'FontName',fontName, ...
        'FontSize',fs, ...
        'FontWeight','bold', ...
        'XColor','k', ...
        'YColor','k', ...
        'ZColor','k', ...
        'LineWidth',1, ...
        'Box','on', ...
        'Color','w', ...
        'GridColor',[0.6 0.6 0.6], ...
        'GridAlpha',0.3, ...
        'Clipping','off');


    %% ----- GRID -----

    grid(ax,'on');


    %% ----- Z LABEL -----

    zl = zlabel(ax,zlab{m});

    set(zl, ...
        'FontName',fontName, ...
        'FontSize',fs, ...
        'FontWeight','bold');


    %% ----- LIGHTING -----

    camlight(ax,'headlight');

    lighting(ax,'gouraud');


    %% ----- PANEL LETTER -----

    annotation( ...
        fig, ...
        'textbox', ...
        [pos{m}(1)-0.07, ...
         pos{m}(2)+H-0.02, ...
         0.07, ...
         0.05], ...
        'String',panel{m}, ...
        'EdgeColor','none', ...
        'FontName',fontName, ...
        'FontSize',fs, ...
        'FontWeight','bold', ...
        'HorizontalAlignment','left', ...
        'VerticalAlignment','top');

end


%% ============================================================
%  X / Y AXIS LABELS
%
%  BOTH LABELS ARE NOW SINGLE-LINE LABELS
% ============================================================

ov = axes( ...
    'Parent',fig, ...
    'Position',[0 0 1 1], ...
    'Visible','off', ...
    'XLim',[0 1], ...
    'YLim',[0 1], ...
    'HitTest','off');


for m = 1:4

    p = pos{m};


    %% --------------------------------------------------------
    % X-AXIS LABEL
    %
    % ONE LINE:
    % MASn3/Cs2TiBr6  Nt (cm^-3)
    % ---------------------------------------------------------

    text( ...
        ov, ...
        p(1)+xLab(1)*W, ...
        p(2)+xLab(2)*H, ...
        'MASn_3/Cs_2TiBr_6  N_i_t (cm^{-2})', ...
        'Rotation',rotX, ...
        'HorizontalAlignment','center', ...
        'VerticalAlignment','middle', ...
        'Interpreter','tex', ...
        'FontName',fontName, ...
        'FontSize',fs, ...
        'FontWeight','bold');


    %% --------------------------------------------------------
    % Y-AXIS LABEL
    %
    % ONE LINE:
    % Cs3Bi2I9/MASnI3  Nt (cm^-3)
    % ---------------------------------------------------------

    text( ...
        ov, ...
        p(1)+yLab(1)*W, ...
        p(2)+yLab(2)*H, ...
        'Cs_3Bi_2I_9/MASnI_3  N_i_t (cm^{-2})', ...
        'Rotation',rotY, ...
        'HorizontalAlignment','center', ...
        'VerticalAlignment','middle', ...
        'Interpreter','tex', ...
        'FontName',fontName, ...
        'FontSize',fs, ...
        'FontWeight','bold');

end


%% ---------- UPDATE FIGURE ----------

drawnow;


%% ============================================================
%  EXPORT
% ============================================================

% Uncomment when you want to save the figure.

% exportgraphics(fig, ...
%     'Fig_interface_3D.png', ...
%     'Resolution',600);

% exportgraphics(fig, ...
%     'Fig_interface_3D.pdf', ...
%     'ContentType','vector');


%% ============================================================
%  FUNCTION: DRAW CYLINDERS
% ============================================================

function drawCylinders(ax,xv,yv,Z,cmap,cLim,radius)

    hold(ax,'on');


    %% ----- MATRIX SIZE -----

    [ny,nx] = size(Z);


    %% ----- CYLINDER RESOLUTION -----

    nTheta = 48;

    theta = linspace(0,2*pi,nTheta);


    %% ----- COLOUR MAP SIZE -----

    nC = size(cmap,1);


    %% ========================================================
    %  LOOP THROUGH ALL DATA POINTS
    % ========================================================

    for iy = 1:ny

        for ix = 1:nx

            h = Z(iy,ix);


            %% ----- SKIP NaN VALUES -----

            if isnan(h)

                continue;

            end


            %% ------------------------------------------------
            % NORMALIZED HEIGHT FOR COLOUR
            % -------------------------------------------------

            f = (h-cLim(1)) / ...
                max(cLim(2)-cLim(1),eps);


            %% ------------------------------------------------
            % COLOUR INDEX
            % -------------------------------------------------

            idx = round(1 + f*(nC-1));

            idx = min(nC,max(1,idx));


            %% ----- BAR COLOUR -----

            col = cmap(idx,:);


            %% ------------------------------------------------
            % CYLINDER X / Y COORDINATES
            % -------------------------------------------------

            X = xv(ix) + radius*cos(theta);

            Y = yv(iy) + radius*sin(theta);


            %% ------------------------------------------------
            % CYLINDER SIDE
            % -------------------------------------------------

            surf( ...
                ax, ...
                [X;X], ...
                [Y;Y], ...
                [zeros(1,nTheta); ...
                 h*ones(1,nTheta)], ...
                'FaceColor',col, ...
                'EdgeColor','none', ...
                'FaceLighting','gouraud', ...
                'AmbientStrength',0.55, ...
                'DiffuseStrength',0.65, ...
                'SpecularStrength',0.05);


            %% ------------------------------------------------
            % CYLINDER TOP
            % -------------------------------------------------

            fill3( ...
                ax, ...
                X, ...
                Y, ...
                h*ones(size(X)), ...
                col, ...
                'EdgeColor',col*0.6, ...
                'LineWidth',0.4, ...
                'FaceLighting','none');

        end

    end


    hold(ax,'off');

end