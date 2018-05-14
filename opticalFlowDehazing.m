%% Group 11

%%
% For this part, we are trying to see if the optical flow for hazed images
% are different than their respective haze-free images

%% Dehazing and Optical Flow
obj = VideoReader('./Haze.mp4');
frames = 300;

HazedOF = opticalFlowFarneback;
DehazedOF = opticalFlowFarneback;

for i = 1:frames    
   hazed_image = readFrame(obj);
   dehazed_image = imreducehaze(hazed_image);
  
   hazed_flow = estimateFlow(HazedOF, rgb2gray(hazed_image));
   dehazed_flow = estimateFlow(DehazedOF, rgb2gray(dehazed_image));
  
   imshow(hazed_image);
   hold on
   plot(hazed_flow,'DecimationFactor',[10 10],'ScaleFactor',10)
   hold off 
   
   saveas(gcf, sprintf('./Hazed/%d.jpg', i));
   
   imshow(dehazed_image);
   hold on
   plot(dehazed_flow,'DecimationFactor',[10 10],'ScaleFactor',10)
   hold off 
   
   saveas(gcf, sprintf('./Dehazed/%d.jpg', i));
end

%% Optical Flow Videos

% Hazed Images
HazedVideo = VideoWriter('Hazed'); 

open(HazedVideo); 

for i = 1:frames 
  writeVideo(HazedVideo, imread(sprintf('./Hazed/%d.jpg', i))); 
end

close(HazedVideo); 

% Dehazed Images
DehazedVideo = VideoWriter('Dehazed'); 


open(DehazedVideo); 

for i = 1:frames 
  writeVideo(DehazedVideo, imread(sprintf('./Dehazed/%d.jpg', i))); 
end

close(DehazedVideo); 
