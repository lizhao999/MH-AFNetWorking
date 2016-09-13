//
//  MHBlockHttp.h
//  MHBlockHttp
//
//  Created by 李钊 on 16/9/12.
//  Copyright © 2016年 Mmt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHBlockHttp : NSObject

+(MHBlockHttp *)blockHttp;

/**
 *	@brief	Get(异步请求)
 *
 *  @param  url  请求URL
 *  @param  GetData  请求参数集合
 *  @param  Successful  成功
 *  @param  Failure  失败
 *  @param  Completion  请求完
 */
-(void)GetUrlStartA:(NSString *)url GetData:(NSDictionary *)data Successful:(void(^)(id data))Successful Failure:(void(^)(id error))failure
         Completion:(void(^)(id data))completion;


/**
 *	@brief	POST(异步请求)
 *
 *  @param  url  请求URL
 *  @param  PostData  请求参数集合
 *  @param  Successful  成功
 *  @param  Failure  失败
 *  @param  Completion  请求完
 */
-(void)PostUrlStartA:(NSString *)url PostData:(id)data Successful:(void(^)(NSDictionary *data))Successful Failure:(void(^)(id error))failure
          Completion:(void(^)(id data))completion;



-(void)PostUrlStartA:(NSString *)url PostData:(id)data progress:(void(^)(NSProgress * uploadProgress))progress Successful:(void(^)(NSDictionary *data))Successful Failure:(void(^)(id error))failure
          Completion:(void(^)(id data))completion;

/**
 *	@brief	POST(异步请求)
 *  图片
 *  @param  url  请求URL
 *  @param  PostData  请求参数集合
 *  @param  Successful  成功
 *  @param  Failure  失败
 *  @param  Completion  请求完
 */

-(void)PostUrlStartA:(NSString *)url PostData:(NSDictionary *)data Image:(NSDictionary *)image  dataimage:(NSArray *)_arrayimage Successful:(void(^)(NSDictionary *data))Successful Failure:(void(^)(id error))failure Completion:(void(^)(id data))completion;

/**
 *	@brief	POST(异步请求)
 *  音频
 *  @param  url  请求URL
 *  @param  PostData  请求参数集合
 *  @param  Successful  成功
 *  @param  Failure  失败
 *  @param  Completion  请求完voice/wav
 */

-(void)PostUrlStartA:(NSString *)url PostData:(NSDictionary *)data Voice:(NSDictionary *)voice  datavoice:(NSArray *)_arrayvoice Successful:(void(^)(id data))Successful Failure:(void(^)(id error))failure Completion:(void(^)(id data))completion;





@end
