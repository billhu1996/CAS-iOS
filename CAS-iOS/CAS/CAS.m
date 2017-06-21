//
//  CAS.m
//  CAS-iOS
//
//  Created by Bill Hu on 2017/6/21.
//  Copyright © 2017年 ifLab. All rights reserved.
//

#import "CAS.h"

@implementation CAS

+ (CAS *_Nullable)defaultCAS {
    static dispatch_once_t ID = 0;
    static CAS *cas = nil;
    dispatch_once(&ID, ^{
        cas = [[CAS alloc] initWithCasServer:@"" path:@""];
    });
    return cas;
}


- (instancetype _Nullable )initWithCasServer:(NSString *_Nullable)casServer
                                        path:(NSString *_Nullable)path {
    self = [super init];
    if (self) {
        self.casServer = casServer;
        self.path = path;
    }
    return self;
}

- (void)requestTGTWithUsername:(NSString *_Nonnull)user
                      password:(NSString *_Nonnull)pass
                 callBackBlock:(CASCallbackBlock _Nonnull)callBackBlock {
    NSString *url = [NSString stringWithFormat:@"%@/%@", self.casServer, self.path];
    NSURL *URL = [NSURL URLWithString:url];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:URL];
    [req setHTTPMethod:@"POST"];
    [req setAllHTTPHeaderFields:@{@"Content-Type": @"application/x-www-form-urlencoded"}];
    NSData *body = [[NSString stringWithFormat:@"username=%@&password=%@", user, pass] dataUsingEncoding:NSUTF8StringEncoding];
    [req setHTTPBody:body];
    [self sendrequestWithRequest:req callBackBlock:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable err) {
        if (!err) {
            NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
            self.urlWithTGT = [[resp allHeaderFields] objectForKey:@"Location"];
            callBackBlock(self.urlWithTGT, err);
        } else {
            callBackBlock(nil, err);
        }
    }];
}


- (void)requestSTForService:(NSString *_Nonnull)service
              callBackBlock:(CASCallbackBlock _Nonnull)callBackBlock{
    NSURL *URL = [NSURL URLWithString:self.urlWithTGT];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:URL];
    [req setHTTPMethod:@"POST"];
    [req setAllHTTPHeaderFields:@{@"Content-Type": @"application/x-www-form-urlencoded"}];
    NSData *body = [[NSString stringWithFormat:@"service=%@", service] dataUsingEncoding:NSUTF8StringEncoding];
    [req setHTTPBody:body];
    [self sendrequestWithRequest:req callBackBlock:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable err) {
        if (!err) {
            NSString *st = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            callBackBlock(st, err);
        } else {
            callBackBlock(nil, err);
        }
    }];
}

- (void)sendrequestWithRequest:(NSURLRequest *)request
                 callBackBlock:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))callBackBlock {
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:callBackBlock] resume];
}

@end
