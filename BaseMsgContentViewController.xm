#import "TweakUtils.h"

%hook BaseMsgContentViewController

- (void)startVoiceAnimatingAtNodeId:(unsigned int)arg1 { %log; NSLog(@"开始执行 - (void)startVoiceAnimatingAtNodeId:(unsigned int)arg1"); %orig; NSLog(@"结束执行 - (void)startVoiceAnimatingAtNodeId:(unsigned int)arg1"); }
- (void)StartPlayingNodeView:(unsigned int)arg1 { %log; NSLog(@"开始执行 - (void)StartPlayingNodeView:(unsigned int)arg1"); %orig; NSLog(@"结束执行 - (void)StartPlayingNodeView:(unsigned int)arg1"); }
- (void)updateMessageNodeStatus:(id)arg1 { %log; NSLog(@"开始执行 - (void)updateMessageNodeStatus:(id)arg1"); %orig; NSLog(@"结束执行 - (void)updateMessageNodeStatus:(id)arg1"); }
- (void)lockerTimesup { %log; NSLog(@"开始执行 - (void)lockerTimesup"); %orig; NSLog(@"结束执行 - (void)lockerTimesup"); }
- (void)beginLockerTimer { %log; NSLog(@"开始执行 - (void)beginLockerTimer"); %orig; NSLog(@"结束执行 - (void)beginLockerTimer"); }
- (void)stopLockerTimesup { %log; NSLog(@"开始执行 - (void)stopLockerTimesup"); %orig; NSLog(@"结束执行 - (void)stopLockerTimesup"); }
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2 { %log; NSLog(@"开始执行 - (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2"); %orig; NSLog(@"结束执行 - (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2"); }

- (id)findNodeViewByLocalId:(unsigned int)arg1 { 
	%log; 
	NSLog(@"开始执行 - (id)findNodeViewByLocalId:(unsigned int)arg1"); 
	id r = %orig; NSLog(@"- (id)findNodeViewByLocalId:(unsigned int)arg1 的返回值 = %@", r); 
	NSLog(@"结束执行 - (id)findNodeViewByLocalId:(unsigned int)arg1"); 
	return r; 
}

- (void)StopPlayingNodeView:(unsigned int)arg1 { 
 	%log;
 	NSLog(@"开始执行 - (void)StopPlayingNodeView:(unsigned int)arg1");
 	%orig;
 	id model = [self execute:@"findNodeDataByLocalId:" intV:arg1];
 	[self performSelector:@selector(onMessageStopPlaying:) withObject:model afterDelay:1.0f];
 	NSLog(@"结束执行 - (void)StopPlayingNodeView:(unsigned int)arg1");
 }

/*
 %new(onMessageStopPlaying:)
- (void)onMessageStopPlaying:(id)model { 
	%log; 
	if (model == nil) { return; }
	NSLog(@"开始执行 new method at runtime: - (void)onMessageStopPlaying"); 
	[self run:@"beginLockerTimer"];
	NSArray *list = [self execute:@"GetMessageNodeDataArray"];
	NSLog(@"list=%@", [list description]);
    BOOL findNext = NO;
    for (id item in list) {
    	NSLog(@"class=%@, item=%@", NSStringFromClass([item class]), [item description]);
    	if (item == model) { findNext = YES; continue; }
    	if (findNext) {
    		if ([NSStringFromClass([item class]) isEqualToString:@"VoiceMessageViewModel"]) {
    			NSInteger index = [list indexOfObject:item];
    			NSLog(@"index=%ld", (long)index);
    			if (index < 0 || index >= list.count) { return; }
    			NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    			UITableView *tableView = [self valueForKeyPath:@"m_tableView"];
    			NSLog(@"indexPath=%@", indexPath);
				//[tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
				[self tableView:tableView didSelectRowAtIndexPath:indexPath];
    			break;
    		}
    	}
    }
	NSLog(@"结束执行 new method at runtime: - (void)onMessageStopPlaying"); 
}
*/


%new(onMessageStopPlaying:)
- (void)onMessageStopPlaying:(id)model { 
	%log; 
	if (model == nil) { return; }
	NSLog(@"开始执行 new method at runtime: - (void)onMessageStopPlaying"); 
	NSArray *list = [self execute:@"GetMessagesWrapArray"];
	NSLog(@"list=%@", [list description]);
    id messageWrap = [model execute:@"messageWrap"]; //CMessageWrap
    long long n64MesSvrID = (long long)[messageWrap execute:@"m_n64MesSvrID"];
    NSLog(@"n64MesSvrID=%lld", n64MesSvrID);
    BOOL findNext = NO;
    for (id item in list) {
    	NSLog(@"class=%@, item=%@", NSStringFromClass([item class]), [item description]);
    	long long iterSvrID = (long long)[item execute:@"m_n64MesSvrID"];
    	if (iterSvrID == n64MesSvrID) { findNext = YES; continue; }
    	if (findNext) {
    		int uiMessageType = (int)(long long)[item execute:@"m_uiMessageType"];
    		NSLog(@"uiMessageType=%d", uiMessageType);
    		if (uiMessageType == 34) {
    			[self run:@"BeginPlaying:FromTouch:" objV:item boolV:YES];
    			/*
    			int uiMesLocalID = (int)(long long)[item execute:@"m_uiMesLocalID"];
    			UITableViewCell *cell = [self execute:@"findNodeViewByLocalId:" intV:uiMesLocalID];
    			UITableView *tableView = [self valueForKeyPath:@"m_tableView"];
    			NSIndexPath *indexPath = [tableView indexPathForCell:cell];
    			NSLog(@"cell=%@, tableView=%@, indexPath=%@", cell, tableView, indexPath);
    			if (indexPath) {
    				[tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    			}
    			//[self run:@"startVoiceAnimatingAtNodeId:" intV:uiMesLocalID];
    			[self run:@"StartPlayingNodeView:" intV:uiMesLocalID];
    			//[self run:@"updateMessageNodeStatus:" objV:item];
    			*/
    			break;
    		}
    	}
    }
	NSLog(@"结束执行 new method at runtime: - (void)onMessageStopPlaying"); 
}

%end