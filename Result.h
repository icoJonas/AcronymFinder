//
//  Result.h
//  AcronymFinder
//
//  Created by Marin, Jonathan on 3/1/16.
//  Copyright © 2016 Luis Godoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Result : NSObject

@property (strong, nonatomic) NSString * fullform;
@property (strong, nonatomic) NSString * meaning;

-(id)initWithDictionary:(NSDictionary *)resultDict;

@end
