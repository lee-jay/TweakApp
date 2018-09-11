#import "TweakUtils.h"

%hook BaseMsgContentViewController

- (void)startVoiceAnimatingAtNodeId:(unsigned int)arg1 { %log; NSLog(@"开始执行 - (void)startVoiceAnimatingAtNodeId:(unsigned int)arg1"); %orig; NSLog(@"结束执行 - (void)startVoiceAnimatingAtNodeId:(unsigned int)arg1"); }
- (void)StartPlayingNodeView:(unsigned int)arg1 { %log; NSLog(@"开始执行 - (void)StartPlayingNodeView:(unsigned int)arg1"); %orig; NSLog(@"结束执行 - (void)StartPlayingNodeView:(unsigned int)arg1"); }
- (void)updateMessageNodeStatus:(id)arg1 { %log; NSLog(@"开始执行 - (void)updateMessageNodeStatus:(id)arg1"); %orig; NSLog(@"结束执行 - (void)updateMessageNodeStatus:(id)arg1"); }

%new(onMessageStopPlaying:)
- (void)onMessageStopPlaying:(id)model { 
	%log; 
	[self performSelector:@selector(playNextAfterModel:) withObject:model afterDelay:1.0f];
	NSLog(@"结束执行 new method at runtime: - (void)onMessageStopPlaying"); 
}

%new(playNextAfterModel:)
- (void)playNextAfterModel:(id)model { 
	if (model == nil) { return; }
	NSLog(@"开始执行 new method at runtime: - (void)onMessageStopPlaying"); 
	NSArray *list = [self execute:@"GetMessagesWrapArray"];
    //{
     //   SEL selector = NSSelectorFromString(@"GetMessagesWrapArray");
    //    IMP imp = [self methodForSelector:selector];
    //    list = imp(self, selector);
    //}
    id messageWrap = [model execute:@"messageWrap"]; //CMessageWrap
    //{
    //    SEL selector = NSSelectorFromString(@"messageWrap");
    //    IMP imp = [model methodForSelector:selector];
    //    messageWrap = imp(model, selector);
    //}
    long long n64MesSvrID = (long long)[messageWrap execute:@"m_n64MesSvrID"];
    NSLog(@"n64MesSvrID=%lld", n64MesSvrID);
    BOOL findNext = NO;
    for (id item in list) {
    	NSLog(@"class=%@, item=%@", NSStringFromClass([item class]), [item description]);
    	long long iterSvrID = (long long)[item execute:@"m_n64MesSvrID"];
    	//{
        //	SEL selector = NSSelectorFromString(@"m_n64MesSvrID");
        //	IMP imp = [item methodForSelector:selector];
        //	iterSvrID = (long long)imp(item, selector);
    	//}
    	if (iterSvrID == n64MesSvrID) { findNext = YES; continue; }
    	if (findNext) {
    		int uiMessageType = (int)(long long)[item execute:@"m_uiMessageType"];
    		//{
        	//	SEL selector = NSSelectorFromString(@"m_uiMessageType");
        	//	IMP imp = [item methodForSelector:selector];
        	//	uiMessageType = (int)(long long)imp(item, selector);
    		//}
    		NSLog(@"uiMessageType=%d", uiMessageType);
    		if (uiMessageType == 34) {
    			int uiMesLocalID = (int)(long long)[item execute:@"m_uiMesLocalID"];
    			//{
        		//	SEL selector = NSSelectorFromString(@"m_uiMesLocalID");
        		//	IMP imp = [item methodForSelector:selector];
        		//	uiMesLocalID = (int)(long long)imp(item, selector);
    			//}
    			NSLog(@"uiMesLocalID=%d", uiMesLocalID);
    			[self run:@"startVoiceAnimatingAtNodeId:" intV:uiMesLocalID];
    			//{
    			//	SEL selector = NSSelectorFromString(@"startVoiceAnimatingAtNodeId:");
    			//	IMP imp = [self methodForSelector:selector];
    			//	imp(self, selector, uiMesLocalID);
    			//}
    			[self run:@"StartPlayingNodeView:" intV:uiMesLocalID];
    			//{
    			//	SEL selector = NSSelectorFromString(@"StartPlayingNodeView:");
    			//	IMP imp = [self methodForSelector:selector];
    			//	imp(self, selector, uiMesLocalID);
    			//}
    			[self run:@"updateMessageNodeStatus:" objV:item];
    			//{
    			//	SEL selector = NSSelectorFromString(@"updateMessageNodeStatus:");
    			//	IMP imp = [self methodForSelector:selector];
    			//	imp(self, selector, item);
    			//}
    			break;
    		}
    	}
    }
}
%end