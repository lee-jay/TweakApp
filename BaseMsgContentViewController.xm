
%hook BaseMsgContentViewController
- (id)GetMessageNodeDataArray { 
	%log; 
	NSLog(@"开始执行 - (id)GetMessageNodeDataArray"); 
	id r = %orig;
	NSArray *list = r;
    for (id item in list) {
        if ([NSStringFromClass([item class]) isEqualToString:@"VoiceMessageViewModel"]) {
            SEL selector = NSSelectorFromString(@"voiceTimeStirng");
    		IMP imp = [item methodForSelector:selector];
            NSLog(@"length=%@", imp(item, selector));
        }
    }
	NSLog(@"- (id)GetMessageNodeDataArray 的返回值 = %@", [r description]); 
	NSLog(@"结束执行 - (id)GetMessageNodeDataArray"); 
	return r; 
}

%new(onMessageStopPlaying)
- (void)onMessageStopPlaying { 
	%log; 
	NSLog(@"开始执行 new method at runtime: - (void)onMessageStopPlaying"); 
	
	NSLog(@"结束执行 new method at runtime: - (void)onMessageStopPlaying"); 
}
%end
