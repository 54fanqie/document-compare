//
//  SandboxFile.h
//  文件MD5值
//
//  Created by macmini2 on 16/7/1.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SandboxFile : NSObject
+ (NSString *)appPath;		// 程序目录，不能存任何东西
+ (NSString *)docPath;		// 文档目录，需要ITUNES同步备份的数据存这里
+ (NSString *)libraryPath;
+ (NSString *)libPrefPath;	// 配置目录，配置文件存这里
+ (NSString *)libCachePath;	// 缓存目录，系统永远不会删除这里的文件，ITUNES会删除

//同上一样获取路径(也可直接返回URL)
+ (NSString *)appPathWithURL;
+ (NSString *)docPathWithURL;
+ (NSString *)libraryPathWithURL;
+ (NSString *)libPrefPathWithURL;
+ (NSString *)libCachePathWithURL;




+ (NSString *)tmpPath;		// 缓存目录，APP退出后，系统可能会删除这里的内容
+ (BOOL)directoryInExists:(NSString *)path; //判断是否有文件

@end
