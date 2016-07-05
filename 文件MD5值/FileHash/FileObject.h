//
//  FileType.h
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

@interface FileType : NSObject
+(FileTypeEnum)typeOfFileName:(NSString*)fileName;

@end
