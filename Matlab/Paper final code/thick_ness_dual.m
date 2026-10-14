clc; 
clear; 
close all; 
 
%% ============================================================ 
% GENERAL 6-COLUMN EXCEL → 4 CYLINDER PLOTS 
% 
% COLUMN 1 = X = MASnI3 thickness 
% COLUMN 2 = Y = Cs3Bi2I9 thickness 
% COLUMN 3 = PCE 
% COLUMN 4 = Voc 
% COLUMN 5 = Jsc 
% COLUMN 6 = FF 
% 
% AXIS LABELS NOW ALIGN PARALLEL TO BOX EDGES 
% ============================================================ 
 
%% ============================================================ 
% SELECT EXCEL FILE 
%% ============================================================ 
 
filename = 'thickness(Double).xlsx'; 
 
T = readtable(filename); 
 
disp('Excel data loaded successfully.'); 
disp(T); 
 
%% ============================================================ 
% READ EXCEL DATA 
%% ============================================================ 
 
data = readmatrix(filename); 
 
%% ============================================================ 
% REMOVE EMPTY ROWS 
%% ============================================================ 
 
data = data(all(~isnan(data(:,1:6)),2),:); 
 
%% ============================================================ 
% ASSIGN COLUMNS 
%% ============================================================ 
 
Xdata = data(:,1);       
Ydata = data(:,2);       
 
PCEdata = data(:,3);     
Vocdata = data(:,4);     
Jscdata = data(:,5);     
FFdata  = data(:,6);     
 
%% ============================================================ 
% UNIQUE X AND Y VALUES 
%% ============================================================ 
 
Xvalues = unique(Xdata,'sorted'); 
Yvalues = unique(Ydata,'sorted'); 
 
Nx = length(Xvalues); 
Ny = length(Yvalues); 
 
%% ============================================================ 
% CREATE MATRICES 
%% ============================================================ 
 
PCE = nan(Ny,Nx); 
Voc = nan(Ny,Nx); 
Jsc = nan(Ny,Nx); 
FF  = nan(Ny,Nx); 
 
for j = 1:Ny 
 
    for i = 1:Nx 
 
        index = ... 
            Xdata == Xvalues(i) & ... 
            Ydata == Yvalues(j); 
 
        if any(index) 
 
            PCE(j,i) = PCEdata(find(index,1)); 
            Voc(j,i) = Vocdata(find(index,1)); 
            Jsc(j,i) = Jscdata(find(index,1)); 
            FF(j,i)  = FFdata(find(index,1)); 
 
        end 
 
    end 
 
end 
 
%% ============================================================ 
% COLORS 
%% ============================================================ 
 
colors = [ 
 
    1.00 0.00 0.00       
    0.00 0.80 0.00       
    0.00 0.00 1.00       
    0.00 0.75 0.85       
    1.00 0.00 1.00       
 
]; 
 
%% ============================================================ 
% CREATE FIGURE 
%% ============================================================ 
 
fig = figure( ... 
    'Color','white',... 
    'Units','pixels',... 
    'Position',[80 40 1150 760]); 
 
%% ============================================================ 
% PANEL (a) PCE 
%% ============================================================ 
 
ax1 = subplot(2,2,1); 
 
makeCylinderPlot( ... 
    ax1,... 
    PCE,... 
    Xvalues,... 
    Yvalues,... 
    colors,... 
    'PCE (%)',... 
    'MASnI_3 Thickness (\mum)',... 
    'Cs_3Bi_2I_9 Thickness (\mum)',... 
    'a'); 
 
%% ============================================================ 
% PANEL (b) VOC 
%% ============================================================ 
 
ax2 = subplot(2,2,2); 
 
makeCylinderPlot( ... 
    ax2,... 
    Voc,... 
    Xvalues,... 
    Yvalues,... 
    colors,... 
    'V_{OC} (V)',... 
    'MASnI_3 Thickness (\mum)',... 
    'Cs_3Bi_2I_9 Thickness (\mum)',... 
    'b'); 
 
%% ============================================================ 
% PANEL (c) JSC 
%% ============================================================ 
 
ax3 = subplot(2,2,3); 
 
makeCylinderPlot( ... 
    ax3,... 
    Jsc,... 
    Xvalues,... 
    Yvalues,... 
    colors,... 
    'J_{SC} (mA/cm^2)',... 
    'MASnI_3 Thickness (\mum)',... 
    'Cs_3Bi_2I_9 Thickness (\mum)',... 
    'c'); 
 
%% ============================================================ 
% PANEL (d) FF 
%% ============================================================ 
 
ax4 = subplot(2,2,4); 
 
makeCylinderPlot( ... 
    ax4,... 
    FF,... 
    Xvalues,... 
    Yvalues,... 
    colors,... 
    'FF (%)',... 
    'MASnI_3 Thickness (\mum)',... 
    'Cs_3Bi_2I_9 Thickness (\mum)',... 
    'd'); 
 
set(ax1,'Position',[0.055 0.545 0.415 0.390]); 
set(ax2,'Position',[0.545 0.545 0.415 0.390]); 
 
set(ax3,'Position',[0.055 0.080 0.415 0.390]); 
set(ax4,'Position',[0.545 0.080 0.415 0.390]); 
 
%% ============================================================ 
% SAVE 600 DPI 
%% ============================================================ 
 
[~,name,~] = fileparts(filename); 
 
exportgraphics( ... 
    fig,... 
    [name '_Final_3D_Cylinders.png'],... 
    'Resolution',600); 
 
%% ============================================================ 
% FUNCTION 
%% ============================================================ 
 
function makeCylinderPlot( ... 
    ax,... 
    Z,... 
    Xvalues,... 
    Yvalues,... 
    colors,... 
    zLabelText,... 
    xLabelText,... 
    yLabelText,... 
    panelLetter) 
 
    axes(ax); 
 
    hold(ax,'on'); 
 
    %% ======================================================== 
    % CYLINDER PARAMETERS 
    %% ======================================================== 
 
    n = 16; 
 
    radius = 0.24; 
 
    %% ======================================================== 
    % NUMBER OF DATA POINTS 
    %% ======================================================== 
 
    Nx = length(Xvalues); 
 
    Ny = length(Yvalues); 
 
    %% ======================================================== 
    % DRAW CYLINDERS 
    %% ======================================================== 
 
    for j = 1:Ny 
 
        for i = 1:Nx 
 
            height = Z(j,i); 
 
            if isnan(height) 
 
                continue; 
 
            end 
 
            %% ------------------------------------------------ 
            % POSITION 
            %% ------------------------------------------------ 
 
            x0 = i; 
            y0 = j; 
 
            %% ------------------------------------------------ 
            % COLOR 
            %% ------------------------------------------------ 
 
            colorIndex = mod(i-1,size(colors,1))+1; 
 
            c = colors(colorIndex,:); 
 
            %% ------------------------------------------------ 
            % CYLINDER 
            %% ------------------------------------------------ 
 
            [Xc,Yc,Zc] = cylinder(radius,n); 
 
            Zc = Zc * height; 
 
            Xc = Xc + x0; 
 
            Yc = Yc + y0; 
 
            %% ------------------------------------------------ 
            % CYLINDER BODY 
            %% ------------------------------------------------ 
 
            surf( ... 
                ax,... 
                Xc,... 
                Yc,... 
                Zc,... 
                'FaceColor',c,... 
                'EdgeColor','black',... 
                'LineWidth',0.30,... 
                'FaceLighting','none'); 
 
            %% ------------------------------------------------ 
            % CYLINDER TOP 
            %% ------------------------------------------------ 
 
            theta = linspace(0,2*pi,n+1); 
 
            Xt = radius*cos(theta) + x0; 
            Yt = radius*sin(theta) + y0; 
            Zt = ones(size(theta))*height; 
 
            fill3( ... 
                ax,... 
                Xt,... 
                Yt,... 
                Zt,... 
                c,... 
                'EdgeColor','black',... 
                'LineWidth',0.30); 
 
        end 
 
    end 
 
    %% ======================================================== 
    % AUTOMATIC AXIS LIMITS 
    %% ======================================================== 
 
    xlim(ax,[0.5 Nx+0.5]); 
 
    ylim(ax,[0.5 Ny+0.5]); 
 
    %% ======================================================== 
    % AUTOMATIC Z LIMIT 
    %% ======================================================== 
 
    zmax = max(Z(:),[],'omitnan'); 
 
    zlim(ax,[0 zmax*1.05]); 
 
    %% ======================================================== 
    % AUTOMATIC TICK LEVELING 
    %% ======================================================== 
 
    xticks(ax,'auto'); 
    yticks(ax,'auto'); 
    zticks(ax,'auto'); 
 
    %% ======================================================== 
    % CONVERT INDEX TICKS → ACTUAL EXCEL VALUES 
    %% ======================================================== 
 
    xt = xticks(ax); 
 
    xt = xt(xt >= 1 & xt <= Nx); 
 
    xt = unique(round(xt)); 
 
    xticks(ax,xt); 
 
    xticklabels(ax,... 
        compose('%g',Xvalues(xt))); 
 
    yt = yticks(ax); 
 
    yt = yt(yt >= 1 & yt <= Ny); 
 
    yt = unique(round(yt)); 
 
    yticks(ax,yt); 
 
    yticklabels(ax,... 
        compose('%g',Yvalues(yt))); 
 
    %% ======================================================== 
    % TICK NUMBERS / BOX FORMAT 
    %% ======================================================== 
 
    set(ax,... 
        'FontName','Times New Roman',... 
        'FontSize',15,... 
        'FontWeight','bold',... 
        'LineWidth',0.9,... 
        'Box','on',... 
        'Color','white',... 
        'XColor','black',... 
        'YColor','black',... 
        'ZColor','black'); 
 
    %% ======================================================== 
    % GRID 
    %% ======================================================== 
 
    grid(ax,'on'); 
 
    ax.GridLineStyle = '--'; 
 
    ax.GridColor = [0.75 0.75 0.75]; 
 
    ax.GridAlpha = 0.30; 
 
    %% ======================================================== 
    % 3D AXIS ORIENTATION 
    %% ======================================================== 
 
    az = -55; 
    el = 25; 
 
    view(ax,az,el); 
 
    %% ======================================================== 
    % AXIS LABELS — PARALLEL TO BOX EDGES 
    %% ======================================================== 
 
    xLabelRotation = 22;   
    yLabelRotation = -9;  
    zLabelRotation = 90; 
 
    hx = xlabel(ax,... 
        xLabelText,... 
        'FontName','Times New Roman',... 
        'FontSize',15,... 
        'FontWeight','bold',... 
        'Interpreter','tex',... 
        'HorizontalAlignment','center'); 
 
    hy = ylabel(ax,... 
        yLabelText,... 
        'FontName','Times New Roman',... 
        'FontSize',15,... 
        'FontWeight','bold',... 
        'Interpreter','tex',... 
        'HorizontalAlignment','center'); 
 
    hz = zlabel(ax,... 
        zLabelText,... 
        'FontName','Times New Roman',... 
        'FontSize',15,... 
        'FontWeight','bold',... 
        'Interpreter','tex',... 
        'HorizontalAlignment','center'); 
 
    hx.Rotation = xLabelRotation; 
    hy.Rotation = yLabelRotation; 
    hz.Rotation = zLabelRotation; 
 
    %% ------------------------------------------------------------ 
    % OFFSET 
    %% ------------------------------------------------------------ 
 
    xSpan = diff(xlim(ax)); 
    ySpan = diff(ylim(ax)); 
    zSpan = diff(zlim(ax)); 
 
    hx.Position = hx.Position + [-1, -0.15*ySpan, 0.32*zSpan]; 
    hy.Position = hy.Position + [-2.8, -.08*ySpan, 0.37*zSpan]; 
    hz.Position = hz.Position + [0.05*xSpan, 0, 0]; 
 
    %% ======================================================== 
    % PANEL LETTER 
    %% ======================================================== 
 
    text( ... 
        ax,... 
        0.02,... 
        0.96,... 
        0,... 
        ['(' panelLetter ')'],... 
        'Units','normalized',... 
        'FontName','Times New Roman',... 
        'FontSize',15,... 
        'FontWeight','bold',... 
        'Color','black'); 
 
    %% ======================================================== 
    % NO MANUAL ASPECT RATIO 
    %% ======================================================== 
 
    hold(ax,'off'); 
 
end