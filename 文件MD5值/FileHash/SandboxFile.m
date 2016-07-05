//
//  SandboxFile.m
//  文件MD5值
//
//  Created by macmini2 on 16/7/1.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import "SandboxFile.h"

@implementation SandboxFile

+(NSString*)appPath{
    NSArray * paths  = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}

#pragma mark  Documents
+(NSString *)docPath{
    NSArray * paths  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}
#pragma mark  Library
+ (NSString *)libraryPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)libPrefPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preferences"];
}

+ (NSString *)libCachePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}




#pragma mark 同上一样获取路径
+ (NSString *)appPathWithURL{
    NSURL * appURL = [[[NSFileManager defaultManager] URLsForDirectory:NSApplicationDirectory inDomains:NSUserDomainMask] lastObject];
    return [appURL path];
}
+ (NSString *)docPathWithURL
{
    NSURL * docURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return [docURL path];
}

+ (NSString *)libraryPathWithURL
{
    NSURL * libraryURL = [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
    return [libraryURL path];
}



+ (NSString *)libPrefPathWithURL{
    NSURL * libPrefPathURL = [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
    return [[libPrefPathURL URLByAppendingPathComponent:@"Preferences"] path];
}


+ (NSString *)libCachePathWithURL{
    NSURL * libCachePathURL = [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
    return [libCachePathURL path];
}





#pragma mark  tmp
+ (NSString *)tmpPath
{
    NSString * tmpDir = NSTemporaryDirectory();
    return tmpDir;
}

+ (BOOL)directoryInExists:(NSString *)path
{
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:path] )
    {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:NULL];
    }
    return YES;
}
@end
