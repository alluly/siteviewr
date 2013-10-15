//
//  AHFlipsideViewController.m
//  siteviewr
//
//  Created by Ali Hasan on 10/14/13.
//  Copyright (c) 2013 Ali Hasan. All rights reserved.
//

#import "AHFlipsideViewController.h"

@interface AHFlipsideViewController ()

@end

@implementation AHFlipsideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
