//
//  RESTHelper.h
//  AcronymFinder
//
//  Created by Marin, Jonathan on 3/1/16.
//  Copyright © 2016 Luis Godoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RESTHelperDelegate

-(void)webServiceCallFinished:(id)data;
-(void)webServiceCallError:(NSError *)error;

@end

@interface RESTHelper : NSObject
{
    
    id<RESTHelperDelegate> delegate;
}

-(id)initWithDelegate:(id <RESTHelperDelegate>)del;

-(void)doRequest:(NSString *)urlSite withParameters:(NSDictionary *)parameters andHeaders:(NSDictionary *)headers andHTTPMethod:(NSString *)method;

@end
