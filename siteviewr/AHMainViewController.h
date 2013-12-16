//
//  AHMainViewController.h
//  siteviewr
//
//  Created by Ali Hasan on 10/14/13.
//  Copyright (c) 2013 Ali Hasan. All rights reserved.
//

#import "AHFlipsideViewController.h"

@class DBRestClient;

@interface AHMainViewController : UIViewController <AHFlipsideViewControllerDelegate>
{
    DBRestClient *restClient;
    NSString *hash;
}
@property(nonatomic, strong) IBOutlet UIButton *refresh;
@end
