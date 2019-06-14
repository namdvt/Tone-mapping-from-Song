% clear all
folderList = {'D:\Paper\Journal\input\'};
outputFolder = 'D:\Paper\Journal\output_qingsong\10000\';
curveFolder = 'D:\Paper\Journal\output_qingsong\10000\curve\';

%% Execute algorithm
for f = 1:length(folderList)
    folderName = folderList{f};
    split = strsplit(folderName,'\');
    imageNameList = dir([folderName '*.dpx']);
    for img = 1: length(imageNameList)
        fileName = imageNameList(img).name; 
        fileAdress = strcat(folderName,fileName);
        imageName = strsplit(fileName,'.');
        imageName = imageName(1);
              
        in = dpxread(fileAdress);  
        in = max(in,1);

        curve = qingsong(in, 10000);
        out = uint16(curve(in));
        imwrite(uint16(double(out)/1023*65535),strcat(outputFolder,imageName{1},'.png'));
        dlmwrite(strcat(curveFolder,imageName{1}), curve);
    end
end