//
//  ViewController.m
//  文件MD5值
//
//  Created by macmini2 on 16/7/1.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import "ViewController.h"
#import "SandboxFile.h"
#import "FileObject.h"
#import "FileHash.h"
@interface ViewController ()
@property (nonatomic,strong) NSArray * files;
@property (nonatomic,strong) NSString * subPath;
@property (weak, nonatomic) IBOutlet UITextField *textFD;
@property (weak, nonatomic) IBOutlet UITextField *numDoc;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSFileManager * manager =[NSFileManager defaultManager];
    _subPath = [[SandboxFile docPath] stringByAppendingString:@"/WenJian"];
    
    if(![manager fileExistsAtPath:_subPath]){
        //先判断是否有 WenJian这个文件夹的 没有就要先创建
        BOOL  isCreat=[manager createDirectoryAtPath:_subPath withIntermediateDirectories:YES attributes:nil error:nil];
        if (!isCreat) {
            NSLog(@"创建失败");
            return;
        }
    }
    
    
    
    self.files = [manager subpathsOfDirectoryAtPath:_subPath error:nil];
    
    
    
    
    
    //因为封装的是读取本地的文件方法,比对本地文件,所以初次运行Document里面是没有文件的,所以就把bundle资源写进去方便操作比对
    if (!self.files || self.files.count==0) {//只运行一次
        NSString * bundlePath = [[[NSBundle mainBundle] pathForResource:@"Resources" ofType:@"bundle"] stringByAppendingString:@"/WenJian"] ;
        self.files = [manager subpathsOfDirectoryAtPath:bundlePath   error:nil];
        for (NSString * docName  in self.files) {
            //读取bundle
            NSString *  pathfiles  =  [bundlePath stringByAppendingString:[NSString stringWithFormat:@"/%@",docName]];
            NSData * data =[NSData dataWithContentsOfFile:pathfiles];
            //存储到本地
            BOOL  isSuccess = [data writeToFile:[_subPath stringByAppendingString:[NSString stringWithFormat:@"/%@",docName]] atomically:YES];
            NSLog(@"%d----%@",isSuccess,[_subPath stringByAppendingString:[NSString stringWithFormat:@"/%@",docName]]);
        }
        
    }
    
    
}

//这是对文件的写入，你可以修改文件内容，测试比对文件
- (IBAction)writeTmp:(id)sender {
    [self textFD];
    NSString * text =self.textFD.text;
    NSInteger num = [self.numDoc.text integerValue];
    
    if (text.length==0 || num == 0 || num > self.files.count) {
        return;
    }
    
    //判断文件类型 图片就展示 文件就读取
    if ([FileObject typeOfFileName:self.files[num]] == FileTypeImage) {
        NSString * path = [[[NSURL URLWithString:_subPath] URLByAppendingPathComponent:self.files[num]] path];
        self.imageView.image = [UIImage imageWithContentsOfFile:path];
        [self altView];
        return;
    }
    
    NSString * path = [[[NSURL URLWithString:_subPath] URLByAppendingPathComponent:self.files[num]] path];
    NSData * dataStr = [text dataUsingEncoding:NSUTF8StringEncoding];
    [dataStr writeToFile:path atomically:YES];
}






- (IBAction)compareDoc:(id)sender {
    [self textFD];
    NSInteger num = [self.numDoc.text integerValue];
    
    if (num>self.files.count) {
        return;
    }
    //读取文件
    //    NSData * data =[NSData dataWithContentsOfFile:self.files[num]];
    //    NSString * string =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //    NSLog(@"查看文件内容：%@",string);
    
    
    
    //比较文件是否相同，哪怕修改一个字符即使名字相同，也能判断出区别 （只有这部分是对文件的的比较）
    for (NSString * docName  in self.files) {
        NSString *  pathfiles  =  [[[NSURL URLWithString:self.subPath] URLByAppendingPathComponent:docName] path];
        
        NSString * num = [FileObject checkData1OfFile:pathfiles];
        NSString * num2 =[FileHash md5HashOfFileAtPath:pathfiles];
        NSString * num3 =[FileHash sha1HashOfFileAtPath:pathfiles];
        NSString * num4 =[FileHash sha512HashOfFileAtPath:pathfiles];
        NSLog(@"MD5值:\n %@   \n %@  \n %@   \n %@    \n docName : %@ ",num,num2,num3,num4,docName);
    }
}




-(void)altView{
    UIAlertController * altVC = [UIAlertController alertControllerWithTitle:@"惊喜" message:@"给你养养眼！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"爽了" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [altVC addAction:defaultAction];
    [self presentViewController:altVC animated:YES completion:nil];
}


-(void)textFiled{
    [self.textFD resignFirstResponder];
    [self.numDoc resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
