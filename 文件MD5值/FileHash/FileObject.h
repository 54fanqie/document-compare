//
//  FileObject.h
//  文件MD5值
//
//  Created by macmini2 on 16/7/4.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    FileTypeUnkown,
    FileTypeImage,
    FileTypeDoc,
    FileTypeXls,
    FileTypePpt,
    FileTypeZip,
    FileTypeTxt,
    FileTypeVideo,
    FileTypeAudio,
    FileTypeAmr,
    FileTypePdf
} FileTypeEnum;

@interface FileObject : NSObject
/*
判断文件类型
 */
+(FileTypeEnum)typeOfFileName:(NSString*)fileName;
/*
  上传文件之前如何判断服务器上面是否有相同的文件存在
 */
+(NSString *)checkData1OfFile:(NSString *)filePath;
@end
