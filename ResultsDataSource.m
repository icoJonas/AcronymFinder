//
//  ResultsDataSource.m
//  AcronymFinder
//
//  Created by Marin, Jonathan on 3/1/16.
//  Copyright © 2016 Luis Godoy. All rights reserved.
//

#import "ResultsDataSource.h"
#import "Result.h"

@implementation ResultsDataSource

-(instancetype)init{
    self = [super init];
    if (self) {
        restHelper = [[RESTHelper alloc] initWithDelegate:self];
    }
    return self;
}

#pragma mark - Public methods

-(void)searchAcronym:(NSString *)acronym{
    NSDictionary *headers = @{@"X-Mashape-Key": @"tC4NTccJIZmshct2T0b5inZuvE9Lp1AAB4RjsnbxBDySY0JScE"};
    [restHelper doRequest:[NSString stringWithFormat:@"https://daxeel-abbreviations-v1.p.mashape.com/all/%@", acronym] withParameters:nil andHeaders:headers andHTTPMethod:@"GET"];
}

#pragma mark - RESTHelperDelegate methods

-(void)webServiceCallError:(NSError *)error {
    [self.delegate noResultsFound];
}

-(void)webServiceCallFinished:(id)data {
    NSArray *array = (NSArray *)data;
    if (array.count > 0) {
        NSMutableArray *resultsArray = [NSMutableArray new];
        for (NSDictionary *dic in array) {
            Result *result = [[Result alloc] initWithDictionary:dic];
            [resultsArray addObject:result];
        }
        if (resultsArray.count > 0) {
            Result *firstResult = [resultsArray firstObject];
            if ([firstResult.fullform isEqualToString:@"Not found"] && resultsArray.count == 1) {
                [self.delegate noResultsFound];
            } else {
                [self.delegate resultsSyncronized:resultsArray];
            }
        } else {
            [self.delegate noResultsFound];
        }
    } else {
        [self.delegate noResultsFound];
    }
}

@end