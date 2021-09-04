function obj = getLoad(obj)

Files = dir('*.mat');
[indx,tf] = listdlg('ListString',{Files.name});

assert(tf,'Please select file in use')

obj.RawFiles = {Files(indx).name}';

end

