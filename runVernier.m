% MATLAB script to run CriticalSpacing.m
% Copyright 2015, 2016, 2017 Denis G. Pelli, denis.pelli@nyu.edu

% We recommend leaving the boilerplate header alone, and customizing by
% copying lines from the boilerplate to your customized section at the
% bottom and modifying it there. This facilitates comparison of scripts.

%% BOILERPLATE HEADER
clear o

% PROCEDURE
o.easyBoost=0.3; % Increase the log threshold parameter of easy trials by this much.
o.experimenter=''; % Put name here to skip the runtime question.
o.flipScreenHorizontally=0; % Set to 1 when using a mirror.
o.fractionEasyTrials=0;
o.observer=''; % Put name here to skip the runtime question.
o.permissionToChangeResolution=0; % Works for main screen only, due to Psychtoolbox bug.
o.getAlphabetFromDisk=1; % 1 makes the program more portable.
o.secsBeforeSkipCausesGuess=8;
o.takeSnapshot=0; % To illustrate your talk or paper.
o.task='identify';
o.textFont='Arial';
o.textSizeDeg=0.4;
o.thresholdParameter='spacing'; % 'spacing' or 'size'
o.trialsDesired=20; % Number of trials (i.e. responses) for the threshold estimate.
o.viewingDistanceCm=400; % Default for runtime question.

% SOUND & FEEDBACK
o.beepNegativeFeedback=0;
o.beepPositiveFeedback=1;
o.showProgressBar=1;
o.speakEachLetter=1;
o.speakEncouragement=0;
o.speakViewingDistance=0;
o.usePurring=0;
o.useSpeech=1;

% VISUAL STIMULUS
o.durationSec=inf; % duration of display of target and flankers
o.eccentricityXYDeg=[0 0]; % Distance of target from fixation.
% o.fixedSpacingOverSize=0; % Disconnect size & spacing.
o.fixedSpacingOverSize=1.4; % Requests size proportional to spacing, horizontally and vertically.
o.fourFlankers=0;
o.targetSizeIsHeight=nan; % depends on parameter
o.minimumTargetPix=6; % Minimum viewing distance depends soley on this & pixPerCm.
% o.flankingDirection='tangential'; % vertically arranged flankers for single target
o.flankingDirection='radial'; % horizontally arranged flankers for single target
o.repeatedTargets=1; % Repeat targets for immunity to fixation errors.
o.maxFixationErrorXYDeg=[3 3]; % Repeat enough to cope with this.
o.practicePresentations=3;
o.setTargetHeightOverWidth=0; % Stretch font to achieve a particular aspect ratio.
o.spacingDeg=nan;
o.targetDeg=nan;

% TARGET FONT
% o.targetFont='Sloan';
% o.alphabet='DHKNORSVZ'; % Sloan alphabet, excluding C
% o.borderLetter='X';
% o.alphabet='HOTVX'; % alphabet of Cambridge Crowding Cards
% o.borderLetter='$';
o.targetFont='Pelli';
o.alphabet='123456789';
o.borderLetter='$';
% o.targetFont='ClearviewText';
% o.targetFont='Gotham Cond SSm XLight';
% o.targetFont='Gotham Cond SSm Light';
% o.targetFont='Gotham Cond SSm Medium';
% o.targetFont='Gotham Cond SSm Book';
% o.targetFont='Gotham Cond SSm Bold';
% o.targetFont='Gotham Cond SSm Black';
% o.targetFont='Arouet';
% o.targetFont='Pelli';
% o.targetFont='Retina Micro';

% FIXATION
o.fixationCrossBlankedNearTarget=1;
o.fixationCrossDeg=inf; % 0, 3, and inf are a typical values.
o.fixationLineWeightDeg=0.02;
o.nearPointXYInUnitSquare=[0.5 0.5];
o.markTargetLocation=false; % 1 to mark target location

% QUEST threshold estimation
o.beta=nan;
o.measureBeta=0;
o.pThreshold=nan;
o.tGuess=nan;
o.tGuessSd=nan;
o.useQuest=1; % true(1) or false(0)

% DEBUGGING AIDS
o.frameTheTarget=0;
o.printScreenResolution=0;
o.printSizeAndSpacing=0;
o.showAlphabet=0;
o.showBounds=0;
o.showLineOfLetters=0;
o.speakSizeAndSpacing=0;
o.useFractionOfScreenToDebug=0;

% TO MEASURE BETA
% o.measureBeta=0;
% o.offsetToMeasureBeta=-0.4:0.1:0.2; % offset of t, i.e. log signal intensity
% o.trialsDesired=200;

% TO HELP CHILDREN
% o.fractionEasyTrials=0.2; % 0.2 adds 20% easy trials. 0 adds none.
% o.speakEncouragement=1; % 1 to say "good," "very good," or "nice" after every trial.

%% CUSTOM CODE
% RUN (measure two thresholds, interleaved)
% o.useFractionOfScreenToDebug=0.3;
o.nearPointXYInUnitSquare=[0.5 0.5];
o.targetFont='VernierH';
o.alphabet='12'; % Vernier alphabet
o.borderLetter='0';
o.repeatedTargets=0;
o.thresholdParameter='size';
o.flankingDirection='tangential'; % horizontally arranged flankers for single target
o.eccentricityXYDeg=[30 0];
o.durationSec=0.2;
o.fourFlankers=0;
o.trialsDesired=40; % Number of trials (i.e. responses) for the threshold estimate.
o.fixationCrossDeg=3; % 0, 3, and inf are a typical values.
% o.useFractionOfScreenToDebug=0.2;

% TEST FOVEA
% o.thresholdParameter='size'; % 'spacing' or 'size'
% o.targetFont='Sloan';
% o.alphabet='DHKNORSVZ';
% o.borderLetter='X';
o.targetSizeIsHeight=1;
o.flankingDirection='radial'; % horizontally arranged flankers for single target
o.nearPointXYInUnitSquare=[0.5 0.5];
o.fixationCrossBlankedNearTarget=1;
o.fixedSpacingOverSize=1.4; % Requests size proportional to spacing, horizontally and vertically.
o.viewingDistanceCm=300; % Default for runtime question.
o.eccentricityXYDeg=[0 0];
o.spacingDeg=100;
o.practicePresentations=0;
o=CriticalSpacing(o);
 
% % TEST ALL ECCENTRICITIES
% ori=90; % re straight up.
% o.nearPointXYInUnitSquare=0.5-0.4*[sind(ori) cosd(ori)];
% o.fixedSpacingOverSize=1.4; % Requests size proportional to spacing, horizontally and vertically.
% o.viewingDistanceCm=25; % Default for runtime question.
% for ecc=[3 10 30 60]
%    o.viewingDistanceCm=2*round(0.5*25*30/ecc);
%    o.viewingDistanceCm=min(60,o.viewingDistanceCm);
%    Speak(sprintf('Viewing distance %d centimeters.',o.viewingDistanceCm));
%    for one=0:1
%       o.oneFlanker=one;
%       o.eccentricitXYyDeg=ecc*[sind(ori) cosd(ori)];
%       o=CriticalSpacing(o);
%       if o.quitExperiment
%          break;
%       end
%    end
%    if o.quitExperiment
%       break;
%    end
% end

% TEST ALL MERIDIANS
% o.oneFlanker=0;
% o.fixedSpacingOverSize=1.4; % Requests size proportional to spacing, horizontally and vertically.
% for i=1:2
%    for ori=0:30:360 % re straight up.
%       o.nearPointXYInUnitSquare=0.5-0.4*[sind(ori) cosd(ori)];
%       o.eccentricitXYyDeg=ecc*[sind(ori) cosd(ori)];
%       o=CriticalSpacing(o);
%    end
% end

% Results are printed in MATLAB's Command Window and saved in the
% CriticalSpacing/data/ folder.