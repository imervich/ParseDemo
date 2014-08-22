//
//  MMViewController.m
//  parseDemo
//
//  Created by Kevin McQuown on 8/18/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "MMViewController.h"

@interface MMViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *persons;

@end

@implementation MMViewController


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.persons.count;
}
- (IBAction)addButtonTapped:(id)sender {
	PFObject *person = [PFObject objectWithClassName:@"Person"];
	person[@"name"] = @"Basel";
	person[@"age"] = @45;
	[person saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
		if (error) {
			NSLog(@"%@", [error userInfo]);
		} else {
			[self refreshDisplay];
		}
	}];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCell"];
	PFObject *person = self.persons[indexPath.row];
	cell.textLabel.text = person[@"name"];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{

}

- (void) refreshDisplay
{
	PFQuery *query = [PFQuery queryWithClassName:@"Person"];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
		if (error) {
			NSLog(@"%@", [error userInfo]);
		} else {
			self.persons = objects;
			[self.tableView reloadData];
		}
	}];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshDisplay];

}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
