//
//  ApiManager.h
//  Good Old Reader 2
//
//  Created by András Somogyi on 14/09/15.
//  Copyright (c) 2015 András Somogyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FeedTableViewData;

@interface ApiManager : NSObject

NS_ASSUME_NONNULL_BEGIN

- (void)fetchStreamWithCompletion:(nullable void(^)(FeedTableViewData *viewData))completion withError:(nullable void(^)(NSError *error))errorBlock;
- (void)markArticleRead:(NSString *)articleId withCompletion:(nullable void(^)(NSData *response))completion withError:(nullable void(^)(NSError *error))errorBlock;
- (void)getTokenWithCompletion:(nullable void(^)(NSData *token))completion withError:(nullable void(^)(NSError *error))errorBlock;
- (void)logoutWithCompletion:(nullable void(^)(NSData *data))completion withError:(nullable void(^)(NSError *error))errorBlock;
- (void)loginUser:(NSString *)username withPassword:(NSString *)password completion:(nullable void(^)(NSData *data))completion error:(void(^)(NSError *error))errorBlock;

NS_ASSUME_NONNULL_END

@end
