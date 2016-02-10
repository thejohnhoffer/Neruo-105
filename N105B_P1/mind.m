classdef mind
    % A mind with a body of perceptrons and optional fluidity allowing for
    % application of the learning rule as defined in the percy class. The
    % mind assembles its perceptrons based on a parameter structure, and it
    % teaches fluid perceptrons, ultimately showing the results for one of
    % several types of plots. The plot method allows all the individual
    % perceptrons to dram themselves. The plotall method draws a heatmap of
    % the outputs of all perceptrons over all possible inputs. The ploterr
    % method calls the plotall method for a range of samples for a range of 
    % parameter values, ultimately aggregating the results into a chart.
    properties
        perps
        fluid = 1;
    end
    methods
        % Construct a mind
        function o = mind(parm)
            parm = parm.mat;
            plist = repmat(struct(),0);
            perPar = repmat(struct(),size(parm.y,1),0);
            plist(end+1).p = percy.empty(0,1);
            % Set testing values
            plist(end).X = parm.X;
            % For all the perceptrons
            for i = 1:size(parm.y,1)
                % Defaults
                perPar(i).t = parm.X;
                perPar(i).y = parm.y(i,:);
                perPar(i).w = size(parm.X,2);
                perPar(i).p = size(parm.X,1);
                perPar(i).px = perPar(i).w;
                if parm.px
                    perPar(i).px = parm.px(i);
                end
                if parm.nu
                    if numel(parm.nu) < i
                        perPar(i).p = parm.nu(1);
                    else
                        perPar(i).p = parm.nu(i);
                    end
                end
                if parm.ws
                    perPar(i).ws = parm.ws(i,:);
                    perPar(i).th = parm.th(i);
                    o.fluid = 0;
                end
                % Make perceptrons within brain
                plist(end).p(i) = percy(perPar(i));
            end 
            % Start the perceptrons
            o.perps = plist.p;
            % Teach and show trials
            o = o.teach().show();
        end
        % All perceptrons taught training
        function o = teach(o)
            if o.fluid
                for i = 1:length(o.perps)
                    o.perps(i) = o.perps(i).learn();
                end
            end
        end
        % All perceptrons shown all trials
        function o = show(o)
            for i = 1:length(o.perps)
                o.perps(i) = o.perps(i).see();
            end
        end
         % Plot perceptron guess
        function [] = plot(o,parm)
            figure(parm.n);
            for i = 1:length(o.perps)
                parm.i = i;
                subplot(length(o.perps),1,i);
                o.perps(i).draw(parm);
            end
        end
         % Plot all perceptron guesses
        function [] = plotall(o,parm)
            figure(parm.n);
            pic = zeros(length(o.perps),length(o.perps(1).vals));
            for i = 1:length(o.perps)
                train = o.perps(i).train;
                p  = train == o.perps(i).vals;
                % Color all incorrect guesses red
                pic(i,:) = o.perps(i).vals.*p;
            end
            imagesc(pic); caxis([-1,1]);
            colormap([1 1 1; 1 0.2 0.5; 0.5 0.7 1 ]);
            title({'All perceptrons for all trials'});
            if parm.xt
                if ~isnumeric(parm.yt)
                    parm.xt = strsplit(parm.xt);
                end
                set(gca,'xticklabel',parm.xt);
            end
            if parm.yt
                if ~isnumeric(parm.yt)
                    parm.yt = strsplit(parm.yt);
                end
                set(gca,'yticklabel',parm.yt); 
            end
            if parm.yi
                ylabel(parm.yi);
            end
            if isfield(parm,'ti')
                title(parm.ti);
            end
            set(gca,'FontSize',25); set(gca,'box','off');
            if isnumeric(parm.xt)
                tmp = round(size(pic,2)/length(parm.xt));
                set(gca,'xtick',1:tmp:size(pic,2));
            end
            set(gca,'ytick',1:size(pic,1));
            xlabel('Trials');
            drawnow;
        end
        % Plot average error from many tests
        function [] = ploterr(o,parm)
            figure(parm.n);
            v = zeros(1,length(o.perps));
            total = 20; sums = v; parm.xt = 1:10:o.perps(1).reps;
            usage = struct('testi','trials taught','pixi','pixels');
            parm.yi = usage.(parm.type);
            for j = 1:total
                for i = 1:length(o.perps)
                    [o.perps(i),tmp] = o.perps(i).test(parm);
                    sums(i) = length(o.perps(i).testi);
                    v(i) = v(i) + tmp;
                end
                pcent = 100*j/total;
                parm.ti = sprintf('Part %d is %d%% ready',parm.n, pcent);
                o.plotall(parm);
            end
            v = 100*v./(total.*sums);
            bar(parm.yt,v,'FaceColor',[0 0 .5]);
            ylabel('Sample error (%)'); set(gca,'box','off');
            xlabel(sprintf('Number of %s',parm.yi));
            title(sprintf('Varied %s',parm.yi));
            drawnow;
        end
    end
end