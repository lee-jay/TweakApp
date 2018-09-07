%hook VoiceMessageViewModel
- (void)onMessageStopPlaying { 
	%log; 
	NSLog(@"开始执行 - (void)onMessageStopPlaying"); 
	%orig; 
	id delegate = nil;
	{
		SEL selector = NSSelectorFromString(@"delegate");
		IMP imp = [self methodForSelector:selector];
		delegate = imp(self, selector);
	}
	{
		SEL selector = NSSelectorFromString(@"onMessageStopPlaying:");
		IMP imp = [delegate methodForSelector:selector];
		imp(delegate, selector, self);
	}
	NSLog(@"结束执行 - (void)onMessageStopPlaying"); 
}
- (void)onMessageStartPlaying { %log; NSLog(@"开始执行 - (void)onMessageStartPlaying"); %orig; NSLog(@"结束执行 - (void)onMessageStartPlaying"); }
%end
