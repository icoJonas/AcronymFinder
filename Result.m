//
//  Result.m
//  AcronymFinder
//
//  Created by Marin, Jonathan on 3/1/16.
//  Copyright © 2016 Luis Godoy. All rights reserved.
//

#import "Result.h"

@implementation Result

-(id)initWithDictionary:(NSDictionary *)resultDict {
    self = [super init];
    
    if (self)
    {
        //Configure the result object from the dictionary
        self.fullform = [resultDict objectForKey:@"fullform"];
        self.meaning = [resultDict objectForKey:@"meaning"];
    }
    
    return self;
}

@end
