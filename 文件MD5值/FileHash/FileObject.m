//
//  FileObject.m
//  文件MD5值
//
//  Created by macmini2 on 16/7/4.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import "FileObject.h"

@implementation FileObject

+(FileTypeEnum)typeOfFileName:(NSString *)fileName{
    NSString* extension = [[fileName pathExtension] lowercaseString];
    
    if ([self isMatchedByRegularWith:extension WithSuffix:@"jpg|png|bmp|jpeg|ico"]) {
        return FileTypeImage;
    }
    else if ([self isMatchedByRegularWith:extension WithSuffix:@"doc|docx"]) {
        return FileTypeDoc;
    }
    else if ([self isMatchedByRegularWith:extension WithSuffix:@"xls|xlsx"]) {
        return FileTypeXls;
    }
    else if ([self isMatchedByRegularWith:extension WithSuffix:@"ppt|pptx"]) {
        return FileTypePpt;
    }
    else if ([self isMatchedByRegularWith:extension WithSuffix:@"zip|rar|7z"]) {
        return FileTypeZip;
    }
    else if ([self isMatchedByRegularWith:extension WithSuffix:@"txt"]) {
        return FileTypeTxt;
    }
    else if ([self isMatchedByRegularWith:extension WithSuffix:@"mp4|rmvb|avi|wma|flv"]) {
        return FileTypeVideo;
    }
    else if ([self isMatchedByRegularWith:extension WithSuffix:@"mp3"]) {
        return FileTypeAudio;
    }
    else if ([self isMatchedByRegularWith:extension WithSuffix:@"amr"]) {
        return FileTypeAmr;
    }
    else if ([self isMatchedByRegularWith:extension WithSuffix:@"pdf"]) {
        return FileTypePdf;
    }
    else {
        return FileTypeUnkown;
    }

}

//是否包含
+(BOOL)isMatchedByRegularWith:(NSString*)fileName WithSuffix:(NSString*)suffixString{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@",suffixString] evaluateWithObject:fileName];
}



+ (NSString *)checkData1OfFile:(NSString *)filePath
{
    NSFileManager *file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:filePath]) {
        NSDictionary *dic = [file attributesOfItemAtPath:filePath error:nil];
        if (dic) {
            unsigned long long size = [[dic objectForKey:NSFileSize] unsignedLongLongValue];
            unsigned long long position = 0;
            if (size % 3 == 0) {
                position = size / 3;
            } else {
                position = size / 3 + 1;
            }
            return [[self class] dataInFile:filePath atPosition:position length:10];
        }
    }
    return nil;
}

+(NSString *)dataInFile:(NSString *)filePath atPosition:(unsigned long long)position length:(NSUInteger)length
{
    NSFileHandle *file = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if (!file) {
        return nil;
    } else {
        [file seekToFileOffset:position];
        NSData *data = [file readDataOfLength:length];
        return [[self class] hexString:data];
    }
}


+ (NSString *)hexString:(NSData*)data
{
    size_t length = 0;
    length = [data length];
    if (!length)
        return nil;
    
    NSMutableString *hexString;
    const unsigned char *bytes;
    size_t i = 0;
    
    bytes = [data bytes];
    hexString = [NSMutableString stringWithCapacity:length * 2];
    for(i = 0; i < length; ++i)
        [hexString appendFormat:@"%02x", *(bytes + i)];
    
    return [NSString stringWithString:hexString];
}





- (BOOL)is64bit
{
#if defined(__LP64__) && __LP64__
    return YES;
#else
    return NO;
#endif
}

- (BOOL)is32bit
{
#if defined(__LP64__) && __LP64__
    return NO;
#else
    return YES;
#endif
}


@end
