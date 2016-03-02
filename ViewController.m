//
//  ViewController.m
//  AcronymFinder
//
//  Created by Marin, Jonathan on 3/1/16.
//  Copyright © 2016 Luis Godoy. All rights reserved.
//

#import "ViewController.h"
#import "Result.h"
#import "MBProgressHUD.h"

@interface ViewController ()

@end

NSMutableArray *resultsArray;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    resultsArray = [NSMutableArray new];
    dataSource = [ResultsDataSource new];
    dataSource.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

-(void)searchAnAcronym {
    //Dismiss the keyboard
    [self.entryTextField resignFirstResponder];
    if (![self.entryTextField.text isEqualToString:@""]) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [dataSource searchAcronym:self.entryTextField.text];
    }
}

#pragma mark - User interaction methods

- (IBAction)search:(id)sender {
    [self searchAnAcronym];
}

#pragma mark - Text field delegate methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchAnAcronym];
    return YES;
}

#pragma mark - UITableViewDataSource methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Result *result = [resultsArray objectAtIndex:indexPath.section];
    cell.textLabel.text = result.meaning;
    [cell sizeToFit];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return resultsArray.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    Result *result = [resultsArray objectAtIndex:section];
    return result.fullform;
}

#pragma mark - UITableViewDelegate methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Result *result = [resultsArray objectAtIndex:indexPath.section];
    CGRect r = [result.meaning boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0)  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]} context:nil];
    
    //Return the yielded rects height plus 100 to provided some white space between cells.
    return r.size.height + 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    Result *result = [resultsArray objectAtIndex:section];
    CGRect r = [result.fullform boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0)  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16.0f]} context:nil];
    
    return r.size.height + 50;
}

#pragma mark - ResultsDataSourceDelegate methods

-(void)noResultsFound{
    self.searchTitleLabel.text = [NSString stringWithFormat:@"NO COINCIDENCES FOUND FOR\n%@", self.entryTextField.text];
    self.resultsTableView.hidden = true;
    self.searchTitleLabel.hidden = false;
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)resultsSyncronized:(NSArray *)results{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [resultsArray removeAllObjects];
        [resultsArray addObjectsFromArray:results];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.searchTitleLabel.hidden = false;
            self.resultsTableView.hidden = false;
            self.searchTitleLabel.text = [[NSString stringWithFormat:@"%@", self.entryTextField.text] uppercaseString];
            [self.resultsTableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

@end
