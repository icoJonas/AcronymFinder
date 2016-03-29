//
//  ResultsDataSource.h
//  AcronymFinder
//
//  Created by Marin, Jonathan on 3/1/16.
//  Copyright © 2016 Luis Godoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RESTHelper.h"

@protocol ResultsDataSourceDelegate <NSObject>

-(void)resultsSyncronized:(NSArray *)results;
-(void)noResultsFound;

@end

@interface ResultsDataSource : NSObject <RESTHelperDelegate>{
    RESTHelper *restHelper;
}

@property (nonatomic, weak) id <ResultsDataSourceDelegate> delegate;

-(void)searchAcronym:(NSString *)acronym;

@end
