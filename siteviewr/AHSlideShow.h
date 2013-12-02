//
//  AHSlideShow.h
//  siteviewr
//
//  Created by Ali Hasan on 11/11/13.
//  Copyright (c) 2013 Ali Hasan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AHSlideShow : UIView
@property(nonatomic, strong) UIScrollView *scroll;
- (id)initWithFrame:(CGRect)frame withPages:(NSUInteger)pages images:(NSArray *)imageArray blurbs:(NSArray *)blurbArray;
@end
