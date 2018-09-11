//
//  TweakUtils.h
//  TweakApp
//
//  Created by Jay Lee on 2018/8/24.
//  Copyright © 2018 MMC.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSObject(Runtime)
- (void)run:(NSString *)func intV:(int)v;
- (void)run:(NSString *)func objV:(id)v;
- (void)run:(NSString *)func objV:(id)ov boolV:(BOOL)bv;
- (id)execute:(NSString *)func intV:(int)v;
- (id)execute:(NSString *)func objV:(id)v;

- (void)run:(NSString *)func, ...; // Cannot use
- (id)execute:(NSString *)func, ...; // Cannot use
@end
