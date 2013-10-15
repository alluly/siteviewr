//
//  AHFlipsideViewController.h
//  siteviewr
//
//  Created by Ali Hasan on 10/14/13.
//  Copyright (c) 2013 Ali Hasan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AHFlipsideViewController;

@protocol AHFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(AHFlipsideViewController *)controller;
@end

@interface AHFlipsideViewController : UIViewController

@property (weak, nonatomic) id <AHFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
