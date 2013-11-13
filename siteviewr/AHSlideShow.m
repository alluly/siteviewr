//
//  AHSlideShow.m
//  siteviewr
//
//  Created by Ali Hasan on 11/11/13.
//  Copyright (c) 2013 Ali Hasan. All rights reserved.
//

#import "AHSlideShow.h"

@implementation AHSlideShow

- (id)initWithFrame:(CGRect)frame withPages:(NSUInteger)pages images:(NSArray *)imageArray blurbs:(NSArray *)blurbArray
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width * pages, frame.size.height)];
        _scroll.pagingEnabled = YES;
        
        for (int i = 0; i<=pages; i++) {
            UITextView *blurb = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            blurb.text = [blurbArray objectAtIndex:i];
            blurb.userInteractionEnabled = NO; 
            blurb.tag = i;
            [self addSubview:blurb];
            
            UIImageView *background = [[UIImageView alloc] initWithFrame:self.bounds];
            background.image = [imageArray objectAtIndex:i];
            background.tag = i;
            [self addSubview:background];
            
        }
        
        [self addSubview:_scroll];
    }
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
