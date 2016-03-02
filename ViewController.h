//
//  ViewController.h
//  AcronymFinder
//
//  Created by Marin, Jonathan on 3/1/16.
//  Copyright © 2016 Luis Godoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultsDataSource.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, ResultsDataSourceDelegate> {
    ResultsDataSource *dataSource;
}

@property (weak, nonatomic) IBOutlet UITextField *entryTextField;
@property (weak, nonatomic) IBOutlet UILabel *searchTitleLabel;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;

@end

