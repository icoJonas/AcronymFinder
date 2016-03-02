//
//  RESTHelper.m
//  AcronymFinder
//
//  Created by Marin, Jonathan on 3/1/16.
//  Copyright © 2016 Luis Godoy. All rights reserved.
//

#import "RESTHelper.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"

@implementation RESTHelper

#pragma mark
#pragma mark  Initialization Methods

-(id)initWithDelegate:(id <RESTHelperDelegate>)del
{
    self = [super init];
    if(self)
    {
        delegate = del;
    }
    return self;
}

#pragma mark - Public Methods

-(void)doRequest:(NSString *)urlSite withParameters:(NSDictionary *)parameters andHeaders:(NSDictionary *)headers andHTTPMethod:(NSString *)method {
    AFHTTPSessionManager *man = [AFHTTPSessionManager new];
    man.requestSerializer = [AFHTTPRequestSerializer new];
    man.responseSerializer = [AFJSONResponseSerializer new];
    man.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html"]];
    [self setupHTTPHeaders:headers forSerializer:man.requestSerializer];
    [man GET:[self escapeCharactersFromURL:urlSite] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [delegate webServiceCallFinished:responseObject];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [delegate webServiceCallError:error];
    }];
}

-(void)setupHTTPHeaders:(NSDictionary *)headers forSerializer:(AFHTTPRequestSerializer *)serializer {
    for (NSString *key in headers.allKeys)
    {
        [serializer setValue:[headers objectForKey:key] forHTTPHeaderField:key];
    }
}

-(NSString *)escapeCharactersFromURL:(NSString *)unescapedString
{
    NSString* escapedUrlString =
    [unescapedString stringByAddingPercentEscapesUsingEncoding:
     NSASCIIStringEncoding];
    return escapedUrlString;
}

@end