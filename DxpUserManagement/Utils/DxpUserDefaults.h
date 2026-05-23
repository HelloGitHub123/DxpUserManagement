//
//  DxpUserDefaults.h
//  DxpUser
//
//  Created by 李标 on 2026/5/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 基于 [NSUserDefaults standardUserDefaults] 的通用 key-value 存取工具。
 * 所有方法均为类方法，key 为空时不执行读写操作。
 */
@interface DxpUserDefaults : NSObject

#pragma mark - 通用

/**
 * 保存任意支持的对象到本地。
 * @param value 待保存的值，传 nil 时等同于删除该 key
 * @param key   存储键名
 */
+ (void)setValue:(nullable id)value forKey:(NSString *)key;

/**
 * 读取指定 key 对应的对象。
 * @param key 存储键名
 * @return 已保存的对象，不存在或 key 为空时返回 nil
 */
+ (nullable id)valueForKey:(NSString *)key;

/**
 * 删除指定 key 对应的本地数据。
 * @param key 存储键名
 */
+ (void)removeObjectForKey:(NSString *)key;

/**
 * 判断指定 key 是否已存在有效值。
 * @param key 存储键名
 * @return key 非空且已存值时返回 YES，否则返回 NO
 */
+ (BOOL)containsObjectForKey:(NSString *)key;

#pragma mark - 常用类型

/**
 * 保存字符串。
 * @param value 字符串，传 nil 时删除该 key
 * @param key   存储键名
 */
+ (void)setString:(nullable NSString *)value forKey:(NSString *)key;

/**
 * 读取字符串。
 * @param key 存储键名
 * @return 字符串；若存的是其他类型则返回其 description；不存在时返回 nil
 */
+ (nullable NSString *)stringForKey:(NSString *)key;

/**
 * 保存布尔值。
 * @param value 布尔值
 * @param key   存储键名
 */
+ (void)setBool:(BOOL)value forKey:(NSString *)key;

/**
 * 读取布尔值，未设置时默认为 NO。
 * @param key 存储键名
 */
+ (BOOL)boolForKey:(NSString *)key;

/**
 * 读取布尔值，未设置时返回指定默认值。
 * @param key          存储键名
 * @param defaultValue key 不存在时的默认返回值
 */
+ (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;

/**
 * 保存整型数值。
 * @param value 整型值
 * @param key   存储键名
 */
+ (void)setInteger:(NSInteger)value forKey:(NSString *)key;

/**
 * 读取整型数值，未设置时默认为 0。
 * @param key 存储键名
 */
+ (NSInteger)integerForKey:(NSString *)key;

/**
 * 读取整型数值，未设置时返回指定默认值。
 * @param key          存储键名
 * @param defaultValue key 不存在时的默认返回值
 */
+ (NSInteger)integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;

/**
 * 保存双精度浮点数。
 * @param value 浮点值
 * @param key   存储键名
 */
+ (void)setDouble:(double)value forKey:(NSString *)key;

/**
 * 读取双精度浮点数，未设置时默认为 0。
 * @param key 存储键名
 */
+ (double)doubleForKey:(NSString *)key;

/**
 * 读取双精度浮点数，未设置时返回指定默认值。
 * @param key          存储键名
 * @param defaultValue key 不存在时的默认返回值
 */
+ (double)doubleForKey:(NSString *)key defaultValue:(double)defaultValue;

/**
 * 保存二进制数据。
 * @param value NSData，传 nil 时删除该 key
 * @param key   存储键名
 */
+ (void)setData:(nullable NSData *)value forKey:(NSString *)key;

/**
 * 读取二进制数据。
 * @param key 存储键名
 * @return NSData，类型不匹配或不存在时返回 nil
 */
+ (nullable NSData *)dataForKey:(NSString *)key;

/**
 * 保存字典。
 * @param value 字典，传 nil 时删除该 key
 * @param key   存储键名
 */
+ (void)setDictionary:(nullable NSDictionary *)value forKey:(NSString *)key;

/**
 * 读取字典。
 * @param key 存储键名
 * @return NSDictionary，类型不匹配或不存在时返回 nil
 */
+ (nullable NSDictionary *)dictionaryForKey:(NSString *)key;

/**
 * 保存数组。
 * @param value 数组，传 nil 时删除该 key
 * @param key   存储键名
 */
+ (void)setArray:(nullable NSArray *)value forKey:(NSString *)key;

/**
 * 读取数组。
 * @param key 存储键名
 * @return NSArray，类型不匹配或不存在时返回 nil
 */
+ (nullable NSArray *)arrayForKey:(NSString *)key;

#pragma mark - 同步

/**
 * 立即将内存中的修改同步到磁盘。
 * 一般情况下系统会自动同步，仅在需要确保立刻落盘时调用。
 */
+ (void)synchronize;

@end

NS_ASSUME_NONNULL_END
