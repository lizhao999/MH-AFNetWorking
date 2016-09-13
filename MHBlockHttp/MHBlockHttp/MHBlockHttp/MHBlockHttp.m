//
//  MHBlockHttp.m
//  MHBlockHttp
//
//  Created by 李钊 on 16/9/12.
//  Copyright © 2016年 Mmt. All rights reserved.
//

#import "MHBlockHttp.h"
#import "AFNetworking.h"
@implementation MHBlockHttp
+(MHBlockHttp *)blockHttp
{
    static MHBlockHttp *blockHttp = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        blockHttp = [[self alloc]init];
    });
    
    return blockHttp;
}

/*
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 ＊Get请求(异步,同步)
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 */
-(void)GetUrlStartA:(NSString *)url GetData:(NSDictionary *)data Successful:(void(^)(id data))Successful Failure:(void(^)(id error))failure Completion:(void(^)(id data))completion
{
    
    NSString *paramer = [self generateParameterString:data];
    NSString *httpurl=[NSString stringWithFormat:@"%@",url];
 
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];

    [session GET:httpurl parameters:paramer progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        Successful( responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);

    }];
    
}

/*
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 ＊拼接请求参数相关的方法
 ＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊
 */
- (NSMutableString *) generateParameterString:(NSDictionary *) parameter
{
    NSMutableString * result = [[NSMutableString alloc] init];
    int i = 0;
    for(NSString * key in parameter)
    {
        NSString * value = [parameter objectForKey:key];
        if(value != nil||[value isEqualToString:@""])
        {
            if(i == 0)
            {
                [result appendString:@"?"];
            }
            else
            {
                [result appendString:@"&"];
            }
            i++;
            [result appendFormat:@"%@=%@",key,value];
        }
    }
    return result;
}




-(void)PostUrlStartA:(NSString *)url PostData:(id)data Successful:(void (^)(NSDictionary *))Successful Failure:(void (^)(id))failure Completion:(void (^)(id))completion
{
    
    NSString *httpurl=[NSString stringWithFormat:@"%@",url];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//
//     session.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    
//    session.requestSerializer.timeoutInterval = 10;
//    
//    session.requestSerializer = [AFHTTPRequestSerializer serializer];
//    
//    session.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [session.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    
////    [session.requestSerializer setValue:[self getHelpToken] forHTTPHeaderField:@"Authorization"];
//    
////  请求超时和接受类型
//    session.requestSerializer.timeoutInterval = 10;
//    
//    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain", nil];

    
    [session POST:httpurl parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"progress:%lld----%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *data_dic=[[NSMutableDictionary alloc]initWithDictionary:responseObject];
        
        Successful(data_dic);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure( error);

    }];
}

-(void)PostUrlStartA:(NSString *)url PostData:(NSDictionary *)data Image:(NSDictionary *)image  dataimage:(NSArray *)_arrayimage Successful:(void(^)(NSDictionary *data))Successful Failure:(void(^)(id error))failure Completion:(void(^)(id data))completion
{
    NSString *httpurl=[NSString stringWithFormat:@"%@",url];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session POST:httpurl parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSString *str in image.allKeys) {
            [formData appendPartWithFileData:[image objectForKey:str]  name:str fileName:[NSString stringWithFormat:@"%@.jpg",str] mimeType:@"image/jpg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"progress:%lld----%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *data_dic=[[NSMutableDictionary alloc]initWithDictionary:responseObject];
         Successful(data_dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure( error);

    }];
 
}


 

-(void)PostUrlStartA:(NSString *)url PostData:(NSDictionary *)data Voice:(NSDictionary *)voice  datavoice:(NSArray *)_arrayvoice Successful:(void(^)(id data))Successful Failure:(void(^)(id error))failure Completion:(void(^)(id data))completion
{
    NSString *httpurl=[NSString stringWithFormat:@"%@",url];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session POST:httpurl parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:[voice objectForKey:@"data"] name:[voice objectForKey:@"name"] fileName:[NSString stringWithFormat:@"%@.wav",[voice objectForKey:@"name"] ] mimeType:@"voice/wav"];

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *data_dic=[[NSMutableDictionary alloc]initWithDictionary:responseObject];
        Successful(data_dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure( error);
        
    }];
  
}

@end
