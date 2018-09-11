#import "TweakUtils.h"

%hook BaseMsgContentViewController

- (void)StopPlayingNodeView:(unsigned int)arg1 { 
 	%log;
 	NSLog(@"开始执行 - (void)StopPlayingNodeView:(unsigned int)arg1");
 	%orig;
 	id model = [self execute:@"findNodeDataByLocalId:" intV:arg1];
 	[self performSelector:@selector(onMessageStopPlaying:) withObject:model afterDelay:1.0f];
 	NSLog(@"结束执行 - (void)StopPlayingNodeView:(unsigned int)arg1");
}

%new(onMessageStopPlaying:)
- (void)onMessageStopPlaying:(id)model { 
	%log; 
	if (model == nil) { return; }
	NSLog(@"开始执行 new method at runtime: - (void)onMessageStopPlaying"); 
	NSArray *list = [self execute:@"GetMessagesWrapArray"];
    id messageWrap = [model execute:@"messageWrap"]; //CMessageWrap
    long long n64MesSvrID = (long long)[messageWrap execute:@"m_n64MesSvrID"];
    BOOL findNext = NO;
    for (id item in list) {
    	long long iterSvrID = (long long)[item execute:@"m_n64MesSvrID"];
    	if (iterSvrID == n64MesSvrID) { findNext = YES; continue; }
    	if (findNext) {
    		int uiMessageType = (int)(long long)[item execute:@"m_uiMessageType"];
    		if (uiMessageType == 34) {
    			[self run:@"BeginPlaying:FromTouch:" objV:item boolV:YES];
    			break;
    		}
    	}
    }
	NSLog(@"结束执行 new method at runtime: - (void)onMessageStopPlaying"); 
}

%end