% MATLAB script to run CriticalSpacing.m
% Copyright 2015, Denis G. Pelli, denis.pelli@nyu.edu
clear o
% This script drives CriticalSpacing.m to measure four thresholds:
% threshold size (acuity) and critical spacing (of crowding), with single
% and repeated targets. The repeated targets have the virtue of being
% immune to eye movements. Pilot data indicate that normal adults (who
% presumably have good fixation) give practically the same thresholds with
% and without repeating of the target. We want to confirm that pilot result
% on more normals, and we want to discover the results in children and
% patient populations.
%
% A "run" is an uninterrupted series of trials, ending in threshold
% estimate(s). A presentation displays one or two targets, which require
% one or two responses. We count each response as a "trial".
%
% We use this parameter to test the observer with and without repeated
% targets. The repeated targets make the test immune to fixation errors,
% but we also want to test in the gold-standard condition, without
% repetition. Having both measures validates the new test in observers who
% fixate well. And assesses the effect of eye position errors in young
% children and patients.
% o.repeatedTargets=0; %
o.repeatedTargets=1; % Repeat target letters for immunity to fixation errors.

% The standard Sloan font has an aspect ratio of 1:1, which is too fat to
% measure the critical spacing of crowding in a normal adult fovea. The
% parameter o.targetHeightOverWidth squeezes the letters, to achieve the
% specified ratio of height to width. A value of 3 produces letters that
% seem easy to recognize. This is the default, but you can explicitly
% override it to get any ratio you like, including 1. It seems important
% that the Response page be printed with letters having the same aspect
% ratio.
o.setTargetHeightOverWidth=3;
o.setTargetHeightOverWidth=0;

% Selecting "spacing" measures the critical spacing of crowding. Selecting
% "size" measures letter acuity. We will test both, usually interleaved.
o.thresholdParameter='spacing';
% o.thresholdParameter='size';

% Each "trial" is one response. When testing with repeated targets, each
% presentation includes two targets, and demands two responses, so it
% counts as two trials. With nine possible letters, 20 trials per threshold
% results in a threshold estimate with an SD that is about 10% of the mean.
% (Reducing the number of letters to 5 doubles the SD.) Running this script
% measures 4 thresholds, one for each of 4 conditions. That takes about 10
% minutes with 20 trials per threshold. Doubling the nubmer of trials
% halves the standard deviation.
o.trials=20; % Number of trials (i.e. responses) for the threshold estimate.

% The viewing distance is set here. The program will try to use what you
% selected, otherwise it will abort and tell you the minimum viewing
% distance that you need. You must then modify this file to set the new
% viewing distance. And, of course, move the screen to that distance.
o.viewingDistanceCm=1000;

% MIRROR: In a small room, you can use a mirror to achieve a long viewing
% distance. This switch tells our software to display a mirror image, so
% that the observer looking in your mirror will see normally oriented
% letters.
o.flipScreenHorizontally=0; % Set to 1 when using a mirror.

% For normal adults we use the restricted standard Sloan alphabet
% (excluding C, which has been shown to be too similar to O).
o.alphabet='DHKNORSVZ'; % Sloan alphabet, excluding C
o.borderLetter='X';

% For children, past investigators, including Jan Atkinson's Cambridge
% Crowding Cards, have used symmetric letters HOTVX, so we provide that
% option too. However, pilot testing indicates that it takes more trials
% with 5 possible targets to get the same precision (SD) as with 9 possible
% targets. Time is paramount, so we're sticking with the 9 Sloan letters
% for the time being.
% o.alphabet='HOTVX'; % alphabet of Cambridge Crowding Cards
% o.borderLetter='N';

% Skinny letters are better for testing critical spacing.
% o.alphabet='7ij:()[]/|'; % bar-symbol alphabet
% o.validKeys = {'7&','i','j',';:','9(','0)','[{',']}','/?','\|'};
% o.borderLetter='!';

% Song, Levi, and Pelli (2014) suggest a 1.4 ratio of spacing to size
% because it is large enough to avoid overlap masking and small enough to
% measure critical spacing that is a least 1.4x bigger than acuity. To
% prove that your measured critical spacing is independent of letter size,
% you might want to test with another value as well, e.g. 1.2 or 1.8.
o.fixedSpacingOverSize=1.4; % Requests size proportional to spacing.

% SPEAK ENCOURAGEMENT. This speaks an encouraging word after every trial,
% regardless of accuracy. I anticipate that young children will like this,
% whereas adults might not.
o.speakEncouragement=0; % Say "good," "very good," or "nice" after every trial.

% SPEAK EACH LETTER. For testing children, I think it helps to give
% auditory acknowledgement of each letter selected (typed). Adult
% participants who type the answers themselves may prefer silence. So this
% is optional.
o.speakEachLetter=1;

% SPEECH. Some environments require silence, and Octave (like MATLB) on
% Linux does not currently support the Psychtoolbox Speak.m command.
% Turning this off suppresses all speech (except for debugging).
% Positive-feedback beeps, which are not speech, are not affected.
o.useSpeech=1;

% I like getting a positive beep for right, and nothing for wrong. The
% current purring sound is not attractive enough, so I prefer silence.
o.beepPositiveFeedback=1;
o.beepNegativeFeedback=0;
o.usePurring=0;

% You don't need to change any of these parameters.
o.observer=''; % Ask for name at beginning of run, or
% o.observer='Shivam'; % enter observer name here.
o.readLettersFromDisk=0; % 1 makes the program more portable.
o.usePurring=0; % Play purring sound while awaiting user response.
% o.radialOrTangential='tangential'; % vertically arranged flankers for single target
o.radialOrTangential='radial'; % horizontally arranged flankers for single target
o.negativeFeedback=0;
o.fixationCrossDeg=0;
o.durationSec=inf; % duration of display of target and flankers
o.measureBeta=0;
o.task='identify';
o.minimumTargetPix=8; % Make sure the letters are well rendered.
o.targetFont='Sloan';
% o.targetFont='ClearviewText';
o.targetFont='Gotham Cond SSm Medium';
% o.targetFont='Gotham Cond SSm Book';
% o.targetFont='Retina Micro';
% o.targetFont='Calibri';
o.alphabet='123456789'; 
o.borderLetter='0';
o.validKeys = {'1!','2@','3#','4$','5%','6^','7&','8*','9('};

o.textFont='Calibri';
o.fixationLocation='center';

% DEBUGGING AIDS
o.showLineOfLetters=0;
o.showBounds=0;
o.speakSizeAndSpacing=0;
o.frameTheTarget=0; % For debugging.
o.useFractionOfScreen=0; % For debugging.
o.printSizeAndSpacing=0; % For debugging.
o.displayAlphabet=0; % For debugging.

% Set up for interleaved testing of size and spacing thresholds. In the
% first run we'll use repeated targets. In the second run we'll use single
% targets.

% FIRST RUN (measures two thresholds, interleaved)
o.repeatedTargets=1;
o.thresholdParameter='spacing';
o(2)=o(1); % Copy the condition
o(2).thresholdParameter='size';
% Test two conditions interleaved: 'spacing' and 'size', with repeated
% letters.
% oRepeated=CriticalSpacing(o); % dual targets, repeated indefinitely

% SECOND RUN (measures two thresholds, interleaved)
% We retain the observer name obtained during the first run for use in the
% second run.
o(1).repeatedTargets=0;
o(2).repeatedTargets=0;
% o(1).observer=oRepeated(1).observer;
% o(2).observer=oRepeated(2).observer;
% Test two conditions interleaved: 'spacing' and 'size', with single
% target.
oSingle=CriticalSpacing(o); % one target

% Results are printed in the command window and saved in the "data" folder
% within the folder that contains the CriticalSpacing.m program.
