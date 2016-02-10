classdef percy
    % A Perceptron with training signals, trials, a training and testing
    % subset of the trials, a subset of dimensions, outputs for each trial,
    % number of total trials, weights, threshold, speed, and number of
    % trials tested. The perceptron iteratively improves and sees its own
    % progress as it applies a learning rule to alter properties based on 
    % difference from training signals and a linerar / nonlinear filter
    % based on its properties to measure difference from training signals.
    properties
        train
        trials
        traini
        testi
        pixi
        vals
        reps
        ws
        th = 0;
        a = 1/2;
        p
    end
    methods
        % Construct a perceptron
        function o = percy(parm)
            % Weights and Threshold
            o.ws = zeros(1,parm.w);
            if isfield(parm,'ws')
                o.ws = parm.ws;
                o.th = parm.th;
            end
            o.p = parm.p;
            o.trials = parm.t;
            o.train = double(parm.y);
            o.reps = size(o.trials,1);
            o.vals = zeros(1,o.reps);
            % Permutation for training
            o.testi = randperm(o.reps);
            o.traini = o.testi(1:o.p);
            o.testi = o.testi(o.p+1:end);
            % Random combination of pixels
            o.pixi = sort(randperm(parm.w,parm.px));
        end
        % Integrate and fire one trial
        function o = fire(o,t)
            o.vals(t) = 2*(dot(o.ws(o.pixi),o.trials(t,o.pixi)) >= o.th)-1;
        end
        % Evaluate given trials
        function o = see(o,range)
            if ~exist('range','var')
                range = 'reps';
            end
            for t = 1:o.(range)
                o = o.fire(t);
            end
        end
        % Change weights, theta
        function o = improve(o,t)
            err = o.train(t) - o.vals(t);
            o.ws(o.pixi) = o.ws(o.pixi) + o.a*err*o.trials(t,o.pixi);
            o.th = o.th - o.a*err;
            if err
                o = o.see('testi');
            end
        end
         % Train some trials
        function o = learn(o)
            for t = o.traini
                o = o.improve(t);
            end
        end
        % Test untrained trials
        function [o,v] = test(o,parm)
            % Reset
            o.vals = zeros(1,o.reps);
            o.ws = zeros(size(o.ws));
            o.th = 0;
            if strcmp(parm.type,'pixi')
                o.pixi  = randperm(length(o.ws),length(o.pixi));
            else
                tmp = randperm(o.reps);
                o.traini = tmp(1:o.p);
                o.testi = tmp(o.p+1:end);
            end
            % learn and observe
            o = o.learn().see();
            % Test single perceptron for all test values
            v = sum(o.vals(o.testi) ~= o.train(o.testi));
        end
        function [] = draw(o,parm)
            nums = {'one','','zero'};
            ti = struct('vals','Perceptron field','pic','Image','ws','');
            if iscell(parm.type)
                parm.type = parm.type{parm.i};
            end
            pic = o.(parm.type);
            if strcmp(parm.type,'ws')
                if numel(o.testi>0)
                    if ~parm.pic
                        parm.pic = 1;
                    end
                    tmp = o.testi(parm.pic);
                    pic = o.trials(tmp,:).*o.ws;
                    in = nums{o.train(tmp)+2}; out = nums{o.vals(tmp)+2};
                    nseen = sprintf('With %d seen',length(o.traini));
                    ti.ws = sprintf('%s, a %s is a %s',nseen,in,out);
                end
            end
            % Normalize and color picture
            pic = (pic - min(pic))/(max(pic)-min(pic)).*255;
            pic = reshape(pic,ceil(sqrt(length(pic))),[]);
            cm = gray(256)+repmat([0 0 0.5],256,1);
            cm(cm>1)=1; colormap(cm); ax = gca;
            if isnumeric(parm.xt) && isnumeric(parm.yt)
                image(parm.xt,parm.yt,pic);
            else 
                image(pic);
            end
            title(ti.(parm.type));
            set(ax,'box','off');
            ax.YDir = 'normal';
            set(ax,'FontSize',25);
            drawnow;
        end
    end
end