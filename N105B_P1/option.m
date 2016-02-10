classdef option
    % An option for the mathematical calculation and graphical plot of a
    % mind composed of an array of perceptrons. Parameters are added to the
    % math and plot structures in the form of a cell array containing the
    % field names followed by a corresponding cell array containing the
    % value names. They can be added on initialization for both strucutres,
    % or they can be added to either through individual methods. All the
    % parameters default to false.
    properties
        mat = struct('ws',0,'th',0,'X',0,'y',0,'nu',0,'px',0);
        plo = struct('plot',0,'yi',0,'xt',0,'yt',0,'n',0,'pic',0);
    end
    methods
        % Add given parameters to object
        function o = option(nm,vm,np,vp)
            o.plo.type = 'vals';
            if exist('vm','var')
                o = o.addm(nm,vm);
            end
            if exist('vp','var')
                o = o.addm(np,vp);
            end
        end
        function o = addm(o,names,values)
            for im = 1:length(names)
                tmp = char(names(im));
                o.mat.(tmp) = cell2mat(values(im)); 
            end
        end 
        function o = addp(o,names,values)
            for ip = 1:length(names)
                tmp = char(names(ip));
            	o.plo.(tmp) = cell2mat(values(ip)); 
            end
        end
        function [] = plot(o,m)
            m.(o.plo.plot)(o.plo);
        end
    end
end