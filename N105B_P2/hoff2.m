%% John Hoffer NB 105B Assignment 2
%  Alex Mathis Harvard University
%
% This is the main function for the first assignment. It is called with one
% optional parameter specifying the subset of the assingment questions to
% be displayed. Question 2, providing a textual answer, is always displayed 
% in the command window. All parameters for each of the five quantitative
% questions are specified in an array of options. The options are then
% bound to an array of minds, each containing an array of perceptrons.
%
function hoffer = hoff2(v)
    close all force;    
    if ~exist('v','var')
        v = 1:5;
    end
    % Global variables
    tmp = get(0,'MonitorPositions');
    set(0,'defaultfigurecolor',[1 1 1]);
    sizes = [0 0 .33 1; .33 .0 .33  .6; .33 .66 .33 .3; 
        .66 0 .33 .44; .66 .5 .33 .44];
    sizes = sizes.*repmat(tmp(3:4),size(sizes,1),2);
    hoffer = mind.empty(0,1);
    opt = option.empty(0,1);
    % Textual answer
    type('q2.txt');
    
    %% Learning with Perceptrons
    % Two binary inputs, four outputs
    tmp = 2; load('xb.mat'); load('yb.mat');
    X = 1-2*double(dec2bin(0:2^tmp-1)-'0');
    y = 1-2*double(dec2bin(0:2^tmp^tmp-1)-'0');
    xb = strjoin(xb); yb = strjoin(yb);
    opt(end+1) = option({'X','y'},{X,y},{'yi'},{'All operators'});
    opt(end) = opt(end).addp({'plot','xt','yt'},{'plotall',xb,yb});

    
    %% All questions answered
    % The assignment happens here
    for vi = v
        if vi < length(opt)+1
            set(0,'DefaultFigurePosition',sizes(vi,:));
            opt(vi) = opt(vi).addp({'n'},{vi});
            hoffer(end+1) = mind(opt(vi));
            opt(vi).plot(hoffer(end));
        end
    end
end

