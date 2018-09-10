%hook BaseMsgContentViewController
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
	NSArray *list = nil;
    {
        SEL selector = NSSelectorFromString(@"GetMessagesWrapArray");
        IMP imp = [self methodForSelector:selector];
        list = imp(self, selector);
    }
    id messageWrap = nil; //CMessageWrap
    {
        SEL selector = NSSelectorFromString(@"messageWrap");
        IMP imp = [model methodForSelector:selector];
        messageWrap = imp(model, selector);
    }
    long long n64MesSvrID = 0;
    {
        SEL selector = NSSelectorFromString(@"m_n64MesSvrID");
        IMP imp = [messageWrap methodForSelector:selector];
        n64MesSvrID = (long long)imp(messageWrap, selector);
    }
    NSLog(@"n64MesSvrID=%lld", n64MesSvrID);
    BOOL findNext = NO;
    NSInteger index = 0;
    for (id item in list) {
    	NSLog(@"class=%@, item=%@", NSStringFromClass([item class]), [item description]);
    	long long iterSvrID = 0;
    	{
        	SEL selector = NSSelectorFromString(@"m_n64MesSvrID");
        	IMP imp = [item methodForSelector:selector];
        	iterSvrID = (long long)imp(item, selector);
    	}
    	if (iterSvrID == n64MesSvrID) { findNext = YES; continue; }
    	if (findNext) {
    		int uiMessageType = 0;
    		{
        		SEL selector = NSSelectorFromString(@"m_uiMessageType");
        		IMP imp = [item methodForSelector:selector];
        		uiMessageType = (int)(long long)imp(item, selector);
    		}
    		NSLog(@"uiMessageType=%d", uiMessageType);
    		if (uiMessageType == 34) {
    			int uiMesLocalID = 0;
    			{
        			SEL selector = NSSelectorFromString(@"m_uiMesLocalID");
        			IMP imp = [item methodForSelector:selector];
        			uiMesLocalID = (int)(long long)imp(item, selector);
    			}
    			NSLog(@"index=%ld, uiMesLocalID=%d", (long)index, uiMesLocalID);
    			{
    				SEL selector = NSSelectorFromString(@"startVoiceAnimatingAtNodeId:");
    				IMP imp = [self methodForSelector:selector];
    				imp(self, selector, uiMesLocalID);
    			}
    			{
    				SEL selector = NSSelectorFromString(@"StartPlayingNodeView:");
    				IMP imp = [self methodForSelector:selector];
    				imp(self, selector, uiMesLocalID);
    			}
    			{
    				SEL selector = NSSelectorFromString(@"updateMessageNodeStatus:");
    				IMP imp = [self methodForSelector:selector];
    				imp(self, selector, item);
    			}
    			break;
    		}
    	}
    	index ++;
    }
}
%end