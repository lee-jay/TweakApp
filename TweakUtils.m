//
//  TweakUtils.m
//  TweakApp
//
//  Created by Jay Lee on 2018/8/24.
//  Copyright © 2018 MMC.com. All rights reserved.
//

#import "TweakUtils.h"

@implementation NSObject(Runtime)

- (void)run:(NSString *)func intV:(int)v {
    SEL selector = NSSelectorFromString(func);
    IMP imp = [self methodForSelector:selector];
    ((void(*)(id, SEL, int))imp)(self, selector, v);
}

- (void)run:(NSString *)func objV:(id)v {
    SEL selector = NSSelectorFromString(func);
    IMP imp = [self methodForSelector:selector];
    ((void(*)(id, SEL, id))imp)(self, selector, v);
}

- (void)run:(NSString *)func objV:(id)ov boolV:(BOOL)bv {
    SEL selector = NSSelectorFromString(func);
    IMP imp = [self methodForSelector:selector];
    ((void(*)(id, SEL, id, BOOL))imp)(self, selector, ov, bv);
}

- (id)execute:(NSString *)func intV:(int)v {
    SEL selector = NSSelectorFromString(func);
    IMP imp = [self methodForSelector:selector];
    return ((id(*)(id, SEL, int))imp)(self, selector, v);
}

- (id)execute:(NSString *)func objV:(id)v {
    SEL selector = NSSelectorFromString(func);
    IMP imp = [self methodForSelector:selector];
    return ((id(*)(id, SEL, id))imp)(self, selector, v);
}

- (void)run:(NSString *)func, ... {
    SEL selector = NSSelectorFromString(func);
    IMP imp = [self methodForSelector:selector];
    va_list args;
    va_start(args, func);
    imp(self, selector, args);
    va_end(args);
}

- (id)execute:(NSString *)func, ... {
    SEL selector = NSSelectorFromString(func);
    IMP imp = [self methodForSelector:selector];
    va_list args;
    va_start(args, func);
    id r = imp(self, selector, args);
    va_end(args);
    return r;
}

@end


