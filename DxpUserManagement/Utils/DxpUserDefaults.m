//
//  DxpUserDefaults.m
//  DxpUser
//
//  Created by 李标 on 2026/5/23.
//

#import "DxpUserDefaults.h"

@implementation DxpUserDefaults

/// 底层存储实例
+ (NSUserDefaults *)store {
	return [NSUserDefaults standardUserDefaults];
}

#pragma mark - 通用

+ (void)setValue:(id)value forKey:(NSString *)key {
	if (key.length == 0) {
		return;
	}
	if (value == nil) {
		[[self store] removeObjectForKey:key];
		return;
	}
	[[self store] setObject:value forKey:key];
}

+ (id)valueForKey:(NSString *)key {
	if (key.length == 0) {
		return nil;
	}
	return [[self store] objectForKey:key];
}

+ (void)removeObjectForKey:(NSString *)key {
	if (key.length == 0) {
		return;
	}
	[[self store] removeObjectForKey:key];
}

+ (BOOL)containsObjectForKey:(NSString *)key {
	if (key.length == 0) {
		return NO;
	}
	return [[self store] objectForKey:key] != nil;
}

#pragma mark - 常用类型

+ (void)setString:(NSString *)value forKey:(NSString *)key {
	[self setValue:value forKey:key];
}

+ (NSString *)stringForKey:(NSString *)key {
	id value = [self valueForKey:key];
	if ([value isKindOfClass:[NSString class]]) {
		return (NSString *)value;
	}
	if (value != nil) {
		return [value description];
	}
	return nil;
}

+ (void)setBool:(BOOL)value forKey:(NSString *)key {
	if (key.length == 0) {
		return;
	}
	[[self store] setBool:value forKey:key];
}

+ (BOOL)boolForKey:(NSString *)key {
	return [self boolForKey:key defaultValue:NO];
}

+ (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue {
	if (key.length == 0) {
		return defaultValue;
	}
	if (![self containsObjectForKey:key]) {
		return defaultValue;
	}
	return [[self store] boolForKey:key];
}

+ (void)setInteger:(NSInteger)value forKey:(NSString *)key {
	if (key.length == 0) {
		return;
	}
	[[self store] setInteger:value forKey:key];
}

+ (NSInteger)integerForKey:(NSString *)key {
	return [self integerForKey:key defaultValue:0];
}

+ (NSInteger)integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue {
	if (key.length == 0) {
		return defaultValue;
	}
	if (![self containsObjectForKey:key]) {
		return defaultValue;
	}
	return [[self store] integerForKey:key];
}

+ (void)setDouble:(double)value forKey:(NSString *)key {
	if (key.length == 0) {
		return;
	}
	[[self store] setDouble:value forKey:key];
}

+ (double)doubleForKey:(NSString *)key {
	return [self doubleForKey:key defaultValue:0];
}

+ (double)doubleForKey:(NSString *)key defaultValue:(double)defaultValue {
	if (key.length == 0) {
		return defaultValue;
	}
	if (![self containsObjectForKey:key]) {
		return defaultValue;
	}
	return [[self store] doubleForKey:key];
}

+ (void)setData:(NSData *)value forKey:(NSString *)key {
	[self setValue:value forKey:key];
}

+ (NSData *)dataForKey:(NSString *)key {
	id value = [self valueForKey:key];
	return [value isKindOfClass:[NSData class]] ? (NSData *)value : nil;
}

+ (void)setDictionary:(NSDictionary *)value forKey:(NSString *)key {
	[self setValue:value forKey:key];
}

+ (NSDictionary *)dictionaryForKey:(NSString *)key {
	id value = [self valueForKey:key];
	return [value isKindOfClass:[NSDictionary class]] ? (NSDictionary *)value : nil;
}

+ (void)setArray:(NSArray *)value forKey:(NSString *)key {
	[self setValue:value forKey:key];
}

+ (NSArray *)arrayForKey:(NSString *)key {
	id value = [self valueForKey:key];
	return [value isKindOfClass:[NSArray class]] ? (NSArray *)value : nil;
}

#pragma mark - 同步

+ (void)synchronize {
	[[self store] synchronize];
}

@end
