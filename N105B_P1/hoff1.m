%% John Hoffer NB 105B Assignment 1
%  Alex Mathis Harvard University
%
% This is the main function for the first assignment. It is called with one
% optional parameter specifying the subset of the assingment questions to
% be displayed. Question 2, providing a textual answer, is always displayed 
% in the command window. All parameters for each of the five quantitative
% questions are specified in an array of options. The options are then
% bound to an array of minds, each containing an array of perceptrons.
%
function hoffer = hoff1(v)
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
    
    %% Of Lines and Half Spaces
    % Linear 2D space to evaluate
    tmp = [linspace(-1,2,100);linspace(-1,4,100)];
    X(:,:,1) = repmat(tmp(1,:),length(tmp(1,:)),1); 
    X(:,:,2) = repmat(tmp(2,:),length(tmp(2,:)),1); 
    X = cat(3,X(:,:,1),permute(X(:,:,2),[2 1]));
    X = reshape(X,[],size(X,ndims(X)));
    y = ones(2,numel(X(:,1)));
    opt(end+1) = option({'X','y','ws','th'},{X,y,[1 1; 2 1],[0; 3]});
    opt(end) =opt(end).addp({'plot','xt','yt'},{'plot',tmp(1,:),tmp(2,:)});
    
    %% Learning with Perceptrons
    % Two binary inputs, four outputs
    tmp = 2; load('xb.mat'); load('yb.mat');
    X = 2*double(dec2bin(0:2^tmp-1)-'0')-1;
    y = 2*double(dec2bin(0:2^tmp^tmp-1)-'0')-1;
    xb = strjoin(xb); yb = strjoin(yb);
    opt(end+1) = option({'X','y'},{X,y},{'yi'},{'All operators'});
    opt(end) = opt(end).addp({'plot','xt','yt'},{'plotall',xb,yb});

    %% Learning with Perceptrons
    % Load training and trial images
    load('y.mat','y'); load('X.mat','X');
    tmp = round(0.99*length(y));
    X = reshape(X,size(X,1),sqrt(size(X,2)),[]);
    X = reshape(flip(permute(X,[1 3 2]),2),size(X,1),[]);
    opt(end+1) = option({'X','y','nu'},{X,y,tmp});
    opt(end) = opt(end).addp({'plot','type','pic'},{'plot','ws',1});
    
    %% Learning with Perceptrons
    % numbers of trials taught
    tmp = [5, 10, 25, 50, 90];
    load('y.mat','y'); load('X.mat','X');
    y = repmat(double(y),length(tmp),1);
    opt(end+1) = option({'X','y','nu'},{X,y,tmp});
    opt(end) = opt(end).addp({'plot','type','yt'},{'ploterr','testi',tmp});

    %% Learning with Perceptrons
    % numbers of Pixels used
    tmp = [5, 10, 25, 50];
    load('y.mat','y'); load('X.mat','X');
    y = repmat(double(y),length(tmp),1);
    opt(end+1) = option({'X','y','nu','px'},{X,y,90,tmp});
    opt(end) = opt(end).addp({'plot','type','yt'},{'ploterr','pixi',tmp});
    
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

