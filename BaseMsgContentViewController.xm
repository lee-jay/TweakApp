
%hook BaseMsgContentViewController
%property(nonatomic, retain) NSMutableArray *voiceList;

- (id)GetMessageNodeDataArray { 
	%log; 
	NSLog(@"开始执行 - (id)GetMessageNodeDataArray"); 
	id r = %orig;
	NSArray *list = r;
	NSMutableArray *voices = [NSMutableArray arrayWithCapacity:0];
    for (id item in list) {
        if ([NSStringFromClass([item class]) isEqualToString:@"VoiceMessageViewModel"]) {
            [voices addObject:item];
        }
    }
    [self setValue:voices forKeyPath:@"voiceList"];
	NSLog(@"- (id)GetMessageNodeDataArray 的返回值 = %@", [r description]); 
	NSLog(@"结束执行 - (id)GetMessageNodeDataArray"); 
	return r; 
}

%new(onMessageStopPlaying:)
- (void)onMessageStopPlaying:(id)model { 
	%log; 
	NSLog(@"开始执行 new method at runtime: - (void)onMessageStopPlaying"); 
	NSArray *voices = [self valueForKeyPath:@"voiceList"];
	NSLog(@"voices=%@", voices);
	NSLog(@"model=%@", model);
	NSLog(@"结束执行 new method at runtime: - (void)onMessageStopPlaying"); 
}
%end
