
classdef mohrCircleApp_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure              matlab.ui.Figure
        ExportButton          matlab.ui.control.Button
        HelpButton            matlab.ui.control.Button
        xyEditField           matlab.ui.control.NumericEditField
        yEditField            matlab.ui.control.NumericEditField
        xEditField            matlab.ui.control.NumericEditField
        Image3                matlab.ui.control.Image
        AnimationSwitchLabel  matlab.ui.control.Label
        AnimationSwitch       matlab.ui.control.Switch
        Image                 matlab.ui.control.Image
        PlotButton            matlab.ui.control.Button
        xyLabel               matlab.ui.control.Label
        yEditFieldLabel       matlab.ui.control.Label
        maxLabel              matlab.ui.control.Label
        Label                 matlab.ui.control.Label
        minLabel              matlab.ui.control.Label
        Label_2               matlab.ui.control.Label
        maxLabel_2            matlab.ui.control.Label
        Label_3               matlab.ui.control.Label
        minLabel_2            matlab.ui.control.Label
        Label_4               matlab.ui.control.Label
        Label_9               matlab.ui.control.Label
        Label_5               matlab.ui.control.Label
        Label_8               matlab.ui.control.Label
        Label_6               matlab.ui.control.Label
        ResetButton           matlab.ui.control.Button
        MohrsCIrcleLabel      matlab.ui.control.Label
        xEditFieldLabel       matlab.ui.control.Label
        MPaLabel              matlab.ui.control.Label
        MPaLabel_2            matlab.ui.control.Label
        MPaLabel_3            matlab.ui.control.Label
        feedbackBar           matlab.ui.control.Label
        UIAxes                matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
    end
    
    methods (Access = private)
        
        function [sigma_x,sigma_y,tau_xy] = takeInput(app)
            % == Takes inputs from user ==
            sigma_x = app.xEditField.Value;
            sigma_y = app.yEditField.Value;
            tau_xy = app.xyEditField.Value; 
            app.ResetButton.Enable = 'off';
            
        end
        
        function plotCircle(app,center_x,center_y, radius)
            % == Plotting a circle and marking extreme points ==
            app.feedbackBar.Text = "Plotting Circle. [1/6]";
            if(app.AnimationSwitch.Value == "On") %Only show animation if the animation toggle is on
            pause(0.1)
            end
            app.feedbackBar.Text = "Plotting Circle.. [2/6]";
            if(app.AnimationSwitch.Value == "On")
            pause(0.1)
            end
            app.feedbackBar.Text = "Plotting Circle... [2/6]";
            theta = 0:0.01:2*pi;
            
            % Using parametric equation of circle
            x = center_x + radius*cos(theta); 
            y = center_y + radius*sin(theta);
            plot(app.UIAxes,x,y,'linewidth', 2, 'Color', '#ef476f');
            axis(app.UIAxes,[-1.2*radius 1.2*radius, -1.2*radius 1.1*radius])
            axis(app.UIAxes,'equal'); % Makes aspect ratio = 1 to avoid showing ellipse when resizing
            grid(app.UIAxes, 'on')
            if(app.AnimationSwitch.Value == "On")
            pause(1)
            end
            hold(app.UIAxes, 'on');
        end
        
        function connectAndMark(app, sigma_x, ~, tau_xy, sigma_1, sigma_2, center_x, center_y, tau_max, tau_min, ~, ~)
            if(app.AnimationSwitch.Value == "On")
            pause(0.5)
            end
            app.feedbackBar.Text = "Marking Points... [3/6]";
            plot(app.UIAxes,[sigma_1 sigma_2], [0 0],'Color','#5387d5','linewidth', 1.2,'LineStyle', '--'); % connects sigma_1 and sigma_2 by
            % the x-values in one vector and the y-values in another vector
            plot(app.UIAxes,[center_x center_x],[tau_max tau_min], 'Color','#5387d5','linewidth', 2,'LineStyle', '--') % connects tau_max and tau_min         % plot(center_x, center_y, 'g*'); % marks center of the circle
            if(app.AnimationSwitch.Value == "On")
            pause(1)
            end
            text(app.UIAxes,center_x, center_y, "C(" + center_x + ", 0)", 'FontSize', 15,'FontWeight', 'bold'); %Marks C
            if(app.AnimationSwitch.Value == "On")
            pause(1)
            end
            text(app.UIAxes,sigma_1, 0, "\sigma_{1}(" + sigma_1 + ",0)" , 'FontSize', 18,'FontWeight', 'bold'); %Marks sigma_1
            text(app.UIAxes,sigma_2, 0, "\sigma_{2}(" + sigma_2 + ",0)" , 'FontSize', 18,'FontWeight', 'bold'); %Marks sigma_2
            if(app.AnimationSwitch.Value == "On")
            pause(1)
            end
            text(app.UIAxes,center_x, tau_max, "\tau_{max}(" + center_x + ", " + tau_max + ")", 'FontSize', 18,'FontWeight', 'bold'); %Marks tau_max
            text(app.UIAxes,center_x, tau_min, "\tau_{min}(" + center_x + ", " + tau_min + ")", 'FontSize', 18,'FontWeight', 'bold'); %Marks tau_min
            
            if(app.AnimationSwitch.Value == "On")
            pause(1)
            end
            % Marking point, A
            text(app.UIAxes,sigma_x,tau_xy, "A(" + sigma_x + ", " + tau_xy + ")", 'FontSize', 16,'FontWeight', 'bold') ;
            app.feedbackBar.Text = "Connecting relevant points... [4/6]";
            plot(app.UIAxes,[center_x sigma_x], [0 tau_xy],'linewidth', 2, 'Color','#118ab2');
            if(app.AnimationSwitch.Value == "On")
            pause(1)
            end
            plot(app.UIAxes,[sigma_1 sigma_x], [0 tau_xy],'Color','#06d6a0','linewidth', 2); % connects sigma_1 and A;
            if(app.AnimationSwitch.Value == "On")
            pause(1)
            end
            plot(app.UIAxes,[center_x sigma_x], [tau_min tau_xy],'Color', '#ffd166','linewidth', 2); % connects tau_min and A
            if(app.AnimationSwitch.Value == "On")
            pause(2)
            end
            app.feedbackBar.Text = "Adding legends [5/6]";
            legend(app.UIAxes,'','','','Line Connecting given point','Principal Plane','Maximum Shear Plane','fontsize',10, 'Location','southeast','FontWeight', 'bold');
            if(app.AnimationSwitch.Value == "On")
            pause(1)
            end
            app.feedbackBar.BackgroundColor = "#d4edda";
            app.feedbackBar.Text = "Complete!";
            if(app.AnimationSwitch.Value == "On")
            pause(1.5)
            end
            app.feedbackBar.Visible = 'off';
            app.Image3.Visible = 'off';
            hold (app.UIAxes, 'off')
            app.ResetButton.Enable = 'on';
            app.PlotButton.Enable = 'off';

            
        end
        
        function displayOutput(app, sigma_1, sigma_2, tau_max, tau_min,theta_p_f, theta_s_f)
            app.Label.Text = string(round(sigma_1,2)) + " MPa";
            app.Label_2.Text = string(round(sigma_2,2)) + " MPa";
            app.Label_3.Text = string(round(tau_max,2)) + " MPa";
            app.Label_4.Text = string(round(tau_min,2)) + " MPa";
            app.Label_5.Text = string(theta_p_f) + "°";
            app.Label_6.Text = string(theta_s_f)+ "°";

        end
        
        
%         function results = exportExcel(app, sigma_1, sigma_2)
%             Description = {"Maximum Normal Stress"; "Minimum Normal Stress"};
%             Value = {sigma_1, sigma_2};
%             Table = [Description, Value];
%             if app.ExportButtonPushed
%         end
    end
    
    
    methods (Access = private)
        
        function [radius, center_x, center_y, sigma_1, sigma_2, tau_max, tau_min] = calcValues(app, sigma_x, sigma_y,tau_xy) 
            % == Find radius and center point from input ==
            if(app.AnimationSwitch.Value == "On")
            pause(0.1)
            end
            app.feedbackBar.Text = "Calculating values";
            radius = round(sqrt(((sigma_x-sigma_y)/2)^2+(tau_xy)^2),2);
            center_x = round((sigma_x+sigma_y)/2,2);
            center_y = 0;
            sigma_1 = center_x + radius;
            sigma_2 = center_x - radius;
            tau_max = radius;
            tau_min = -radius;
%             exportExcel(sigma_1,sigma_2)


        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: PlotButton
        function PlotButtonPushed(app, event)
            
            [sigma_x,sigma_y,tau_xy] = takeInput(app); %takes input
            if (sigma_x == 0 && sigma_y==0 && tau_xy==0)
                app.feedbackBar.Visible = 'on';
                app.Image3.Visible = 'on';
                app.feedbackBar.BackgroundColor = "#FFC8D0";
                app.feedbackBar.Text = "Invalid Input"; % Input Validation
                pause(1);
                app.feedbackBar.BackgroundColor = "#cce5ff";
                app.feedbackBar.Text = "Enter Valid inputs" ;
                app.ResetButton.Enable = 'on';
                return
                
            end
            [radius, center_x, center_y, sigma_1, sigma_2, tau_max, tau_min] = calcValues(app, sigma_x, sigma_y, tau_xy); %Finds necessary values
            two_theta_p_f = round(atand(tau_xy/((sigma_x-sigma_y)/2)),2); % Twice Principal Plane angle from X axis
            if(two_theta_p_f < 0)
                two_theta_p_f = two_theta_p_f + 180; %Makes sure the angle is positive
            end
            theta_p_f = two_theta_p_f/2;
            theta_s_f = theta_p_f-45;
            displayOutput(app, sigma_1, sigma_2, tau_max, tau_min,theta_p_f, theta_s_f);
            plotCircle(app,center_x,center_y, radius); %Plots the circle
                
            connectAndMark(app, sigma_x, sigma_y, tau_xy, sigma_1, sigma_2, center_x, center_y, tau_max, tau_min,theta_p_f,theta_s_f );
 
            
        end

        % Button pushed function: ResetButton
        function ResetButtonPushed(app, event)

            app.feedbackBar.Visible = 'on';
            app.Image3.Visible = 'on';
            app.feedbackBar.Text = "Resetting";
            app.Label.Text = string(0);
            app.Label_2.Text = string(0);
            app.Label_3.Text = string(0);
            app.Label_4.Text = string(0);
            app.Label_5.Text = string(0);
            app.Label_6.Text = string(0);
            app.feedbackBar.BackgroundColor = "#fff3cd";
            app.feedbackBar.Text = "Reset Complete";
            pause(1)
            app.feedbackBar.BackgroundColor = "#cce5ff";
            app.feedbackBar.Text = "Input values again";
            legend(app.UIAxes,'hide');
            app.PlotButton.Enable = 'on';
            cla(app.UIAxes);

            
              
  
        end

        % Button pushed function: HelpButton
        function HelpButtonPushed(app, event)
            dos('explorer file:///C:\Users\tanvi\Documents\MATLAB\Examples\R2021a\matlab\Project\Mohr Circle\App\Help_File.pdf');
        end

        % Button pushed function: ExportButton
        function ExportButtonPushed(app, event)
                        
                        filePath = uigetdir;
                        filenName = '\MohrCircle' + string(now) + '.png'; %Appends timestamp after file name to make it unique
                        filPathwithName = append(filePath,filenName);
                        drawnow;
                        figure(app.UIFigure); %Prevents losing focus while exporting
                        exportgraphics(app.UIFigure, filPathwithName);
                        app.feedbackBar.Visible = 'on';
                        app.Image3.Visible = 'on';
                        app.feedbackBar.Text = "Exporting, Please Wait...";
                        pause(0.1);
                        app.feedbackBar.Text = "Export Complete";
                        pause(2);
                        app.feedbackBar.Visible = 'off';
                        app.Image3.Visible = 'off';
                        return

                        
                        
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.8863 0.8902 0.898];
            app.UIFigure.Position = [5 5 1360 700];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.WindowState = 'fullscreen';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            xlabel(app.UIAxes, 'Normal Stress, σ (Mpa)  →')
            ylabel(app.UIAxes, 'Shear Stress, σ (Mpa)  →')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.FontName = 'Segoe UI';
            app.UIAxes.Color = [0.9961 0.9961 0.9961];
            app.UIAxes.XGrid = 'on';
            app.UIAxes.YGrid = 'on';
            app.UIAxes.FontSize = 20;
            app.UIAxes.GridColor = [0 0 0];
            app.UIAxes.Position = [252 101 901 497];

            % Create feedbackBar
            app.feedbackBar = uilabel(app.UIFigure);
            app.feedbackBar.BackgroundColor = [0.851 0.9294 0.9686];
            app.feedbackBar.HorizontalAlignment = 'center';
            app.feedbackBar.WordWrap = 'on';
            app.feedbackBar.FontName = 'Candara Light';
            app.feedbackBar.FontSize = 20;
            app.feedbackBar.FontWeight = 'bold';
            app.feedbackBar.Position = [252 640 889 58];
            app.feedbackBar.Text = 'Please input values';

            % Create MPaLabel_3
            app.MPaLabel_3 = uilabel(app.UIFigure);
            app.MPaLabel_3.Position = [173 220 31 25];
            app.MPaLabel_3.Text = 'MPa';

            % Create MPaLabel_2
            app.MPaLabel_2 = uilabel(app.UIFigure);
            app.MPaLabel_2.Position = [173 276 31 25];
            app.MPaLabel_2.Text = 'MPa';

            % Create MPaLabel
            app.MPaLabel = uilabel(app.UIFigure);
            app.MPaLabel.Position = [173 322 31 25];
            app.MPaLabel.Text = 'MPa';

            % Create xEditFieldLabel
            app.xEditFieldLabel = uilabel(app.UIFigure);
            app.xEditFieldLabel.Interpreter = 'latex';
            app.xEditFieldLabel.HorizontalAlignment = 'right';
            app.xEditFieldLabel.FontSize = 20;
            app.xEditFieldLabel.Position = [90 321 32 26];
            app.xEditFieldLabel.Text = 'σx';

            % Create MohrsCIrcleLabel
            app.MohrsCIrcleLabel = uilabel(app.UIFigure);
            app.MohrsCIrcleLabel.HorizontalAlignment = 'center';
            app.MohrsCIrcleLabel.FontName = 'Helvetica-Narrow';
            app.MohrsCIrcleLabel.FontSize = 30;
            app.MohrsCIrcleLabel.FontWeight = 'bold';
            app.MohrsCIrcleLabel.FontColor = [0.3294 0.051 0.4314];
            app.MohrsCIrcleLabel.Position = [569 580 289 50];
            app.MohrsCIrcleLabel.Text = 'Mohr''s CIrcle';

            % Create ResetButton
            app.ResetButton = uibutton(app.UIFigure, 'push');
            app.ResetButton.ButtonPushedFcn = createCallbackFcn(app, @ResetButtonPushed, true);
            app.ResetButton.Icon = 'download.svg';
            app.ResetButton.BackgroundColor = [1 0 0];
            app.ResetButton.FontName = 'Segoe UI';
            app.ResetButton.FontSize = 20;
            app.ResetButton.FontColor = [1 1 1];
            app.ResetButton.Position = [1201 160 100 39];
            app.ResetButton.Text = 'Reset';

            % Create Label_6
            app.Label_6 = uilabel(app.UIFigure);
            app.Label_6.HorizontalAlignment = 'center';
            app.Label_6.FontSize = 20;
            app.Label_6.Position = [1244 225 111 40];
            app.Label_6.Text = '0';

            % Create Label_8
            app.Label_8 = uilabel(app.UIFigure);
            app.Label_8.Interpreter = 'latex';
            app.Label_8.HorizontalAlignment = 'center';
            app.Label_8.FontSize = 22;
            app.Label_8.Position = [1167 225 96 46];
            app.Label_8.Text = 'θₛ:';

            % Create Label_5
            app.Label_5 = uilabel(app.UIFigure);
            app.Label_5.HorizontalAlignment = 'center';
            app.Label_5.FontSize = 20;
            app.Label_5.Position = [1244 270 111 46];
            app.Label_5.Text = '0';

            % Create Label_9
            app.Label_9 = uilabel(app.UIFigure);
            app.Label_9.Interpreter = 'latex';
            app.Label_9.HorizontalAlignment = 'center';
            app.Label_9.FontSize = 22;
            app.Label_9.Position = [1116 271 200 46];
            app.Label_9.Text = 'θₚ';

            % Create Label_4
            app.Label_4 = uilabel(app.UIFigure);
            app.Label_4.HorizontalAlignment = 'center';
            app.Label_4.FontSize = 20;
            app.Label_4.Position = [1244 323 111 37];
            app.Label_4.Text = '0';

            % Create minLabel_2
            app.minLabel_2 = uilabel(app.UIFigure);
            app.minLabel_2.Interpreter = 'latex';
            app.minLabel_2.HorizontalAlignment = 'center';
            app.minLabel_2.FontSize = 20;
            app.minLabel_2.Position = [1149 321 96 46];
            app.minLabel_2.Text = 'τ_{min} :';

            % Create Label_3
            app.Label_3 = uilabel(app.UIFigure);
            app.Label_3.HorizontalAlignment = 'center';
            app.Label_3.FontSize = 20;
            app.Label_3.Position = [1244 365 111 47];
            app.Label_3.Text = '0';

            % Create maxLabel_2
            app.maxLabel_2 = uilabel(app.UIFigure);
            app.maxLabel_2.Interpreter = 'latex';
            app.maxLabel_2.HorizontalAlignment = 'center';
            app.maxLabel_2.FontSize = 20;
            app.maxLabel_2.Position = [1148 366 101 46];
            app.maxLabel_2.Text = 'τ_{max} :';

            % Create Label_2
            app.Label_2 = uilabel(app.UIFigure);
            app.Label_2.HorizontalAlignment = 'center';
            app.Label_2.FontSize = 20;
            app.Label_2.Position = [1244 417 111 46];
            app.Label_2.Text = '0';

            % Create minLabel
            app.minLabel = uilabel(app.UIFigure);
            app.minLabel.Interpreter = 'latex';
            app.minLabel.HorizontalAlignment = 'center';
            app.minLabel.FontSize = 20;
            app.minLabel.Position = [1149 417 98 46];
            app.minLabel.Text = 'σ_{min} :';

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.HorizontalAlignment = 'center';
            app.Label.FontSize = 20;
            app.Label.Position = [1244 468 111 46];
            app.Label.Text = '0';

            % Create maxLabel
            app.maxLabel = uilabel(app.UIFigure);
            app.maxLabel.Interpreter = 'latex';
            app.maxLabel.HorizontalAlignment = 'center';
            app.maxLabel.FontName = 'Segoe UI';
            app.maxLabel.FontSize = 20;
            app.maxLabel.Position = [1149 468 103 46];
            app.maxLabel.Text = 'σ_{max} :';

            % Create yEditFieldLabel
            app.yEditFieldLabel = uilabel(app.UIFigure);
            app.yEditFieldLabel.HorizontalAlignment = 'right';
            app.yEditFieldLabel.FontSize = 20;
            app.yEditFieldLabel.Position = [92 276 28 24];
            app.yEditFieldLabel.Text = 'σy';

            % Create xyLabel
            app.xyLabel = uilabel(app.UIFigure);
            app.xyLabel.HorizontalAlignment = 'right';
            app.xyLabel.FontSize = 20;
            app.xyLabel.Position = [90 225 33 24];
            app.xyLabel.Text = 'τxy';

            % Create PlotButton
            app.PlotButton = uibutton(app.UIFigure, 'push');
            app.PlotButton.ButtonPushedFcn = createCallbackFcn(app, @PlotButtonPushed, true);
            app.PlotButton.Icon = 'scatter-plot.png';
            app.PlotButton.BackgroundColor = [0.0745 0.6235 1];
            app.PlotButton.FontName = 'Segoe UI';
            app.PlotButton.FontSize = 25;
            app.PlotButton.FontColor = [0.9412 0.9412 0.9412];
            app.PlotButton.Position = [73 155 131 45];
            app.PlotButton.Text = 'Plot';

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Tooltip = {'Stress Block'};
            app.Image.Position = [19 353 237 246];
            app.Image.ImageSource = 'stress_block-removebg-preview.png';

            % Create AnimationSwitch
            app.AnimationSwitch = uiswitch(app.UIFigure, 'slider');
            app.AnimationSwitch.Tooltip = {'Animation Toggle'};
            app.AnimationSwitch.FontSize = 18;
            app.AnimationSwitch.Position = [107 99 45 20];
            app.AnimationSwitch.Value = 'On';

            % Create AnimationSwitchLabel
            app.AnimationSwitchLabel = uilabel(app.UIFigure);
            app.AnimationSwitchLabel.HorizontalAlignment = 'center';
            app.AnimationSwitchLabel.FontSize = 18;
            app.AnimationSwitchLabel.FontColor = [0.149 0.149 0.149];
            app.AnimationSwitchLabel.Position = [86 61 86 23];
            app.AnimationSwitchLabel.Text = 'Animation';

            % Create Image3
            app.Image3 = uiimage(app.UIFigure);
            app.Image3.Position = [253 644 62 53];
            app.Image3.ImageSource = 'infob.png';

            % Create xEditField
            app.xEditField = uieditfield(app.UIFigure, 'numeric');
            app.xEditField.HorizontalAlignment = 'center';
            app.xEditField.FontSize = 20;
            app.xEditField.Position = [129 322 39 25];

            % Create yEditField
            app.yEditField = uieditfield(app.UIFigure, 'numeric');
            app.yEditField.HorizontalAlignment = 'center';
            app.yEditField.FontSize = 20;
            app.yEditField.Position = [130 276 38 25];

            % Create xyEditField
            app.xyEditField = uieditfield(app.UIFigure, 'numeric');
            app.xyEditField.HorizontalAlignment = 'center';
            app.xyEditField.FontSize = 20;
            app.xyEditField.Position = [129 220 38 25];

            % Create HelpButton
            app.HelpButton = uibutton(app.UIFigure, 'push');
            app.HelpButton.ButtonPushedFcn = createCallbackFcn(app, @HelpButtonPushed, true);
            app.HelpButton.Icon = 'icons8-reset-64.png';
            app.HelpButton.BackgroundColor = [0.4784 0.2627 0.7137];
            app.HelpButton.FontName = 'Segoe UI';
            app.HelpButton.FontSize = 20;
            app.HelpButton.FontColor = [1 1 1];
            app.HelpButton.Position = [937 21 122 44];
            app.HelpButton.Text = 'Help';

            % Create ExportButton
            app.ExportButton = uibutton(app.UIFigure, 'push');
            app.ExportButton.ButtonPushedFcn = createCallbackFcn(app, @ExportButtonPushed, true);
            app.ExportButton.Icon = 'icons8-export-50.png';
            app.ExportButton.BackgroundColor = [0 0.7843 0.3176];
            app.ExportButton.FontSize = 20;
            app.ExportButton.FontColor = [1 1 1];
            app.ExportButton.Position = [749 22 122 42];
            app.ExportButton.Text = 'Export';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = mohrCircleApp_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end