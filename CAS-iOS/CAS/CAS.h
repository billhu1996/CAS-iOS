//
//  CAS.h
//  CAS-iOS
//
//  Created by Bill Hu on 2017/6/21.
//  Copyright © 2017年 ifLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CAS : NSObject


typedef void (^CASCallbackBlock)(NSString *_Nullable, NSError *_Nullable);

@property (nonatomic, strong) NSString *_Nullable casServer;
@property (nonatomic, strong) NSString *_Nullable path;
@property (nonatomic, strong) NSString *_Nullable urlWithTGT;
@property (nonatomic, strong) NSString *_Nullable st;

+ (CAS *_Nullable)defaultCAS;

- (instancetype _Nullable )initWithCasServer:(NSString *_Nullable)casServer
                                        path:(NSString *_Nullable)path;

- (void)requestTGTWithUsername:(NSString *_Nonnull)user
                      password:(NSString *_Nonnull)pass
                 callBackBlock:(CASCallbackBlock _Nonnull)callBackBlock;

- (void)requestSTForService:(NSString *_Nonnull)service
              callBackBlock:(CASCallbackBlock _Nonnull)callBackBlock;

- (void)sendrequestWithRequest:(NSURLRequest *_Nonnull)request
                 callBackBlock:(void (^_Nonnull)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))callBackBlock;
@end
