//
//  AHSlideShow.m
//  siteviewr
//
//  Created by Ali Hasan on 11/11/13.
//  Copyright (c) 2013 Ali Hasan. All rights reserved.
//
#import "AHSlideShow.h"

#define kMarginBottom 15

@implementation AHSlideShow

- (id)initWithFrame:(CGRect)frame withPages:(NSUInteger)pages images:(NSArray *)imageArray blurbs:(NSArray *)blurbArray
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
        _scroll.delegate = self;
        _scroll.pagingEnabled = YES;
        _scroll.contentSize = CGSizeMake(frame.size.width * pages, frame.size.height);
        for (int i = 0; i<pages; i++) {
            UITextView *blurb = [[UITextView alloc] initWithFrame:CGRectMake(frame.size.width*i, frame.size.height-[[blurbArray objectAtIndex:i] sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Regular" size:18]}].height - kMarginBottom, frame.size.width, [[blurbArray objectAtIndex:i] sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Regular" size:18]}].height + kMarginBottom)];
            blurb.text = [blurbArray objectAtIndex:i];
            blurb.textAlignment = NSTextAlignmentCenter;
            blurb.font = [UIFont fontWithName:@"AvenirNext-Regular" size:18];
            blurb.userInteractionEnabled = NO;
            blurb.backgroundColor = [UIColor clearColor];
            blurb.textColor = [UIColor whiteColor];
            blurb.tag = i;
            
            UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width*i, 0, frame.size.width, frame.size.height)];
            background.image = [imageArray objectAtIndex:i];
            background.tag = i;
            [_scroll addSubview:background];
            [_scroll addSubview:blurb];

        }
        
        _dismiss = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _dismiss.hidden = YES;
        _dismiss.frame = CGRectMake(100, 300, 120, 30);
        [_dismiss setTitle:@"Dismiss" forState:UIControlStateNormal];
        [_dismiss addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_scroll];
        [self addSubview:_dismiss];
    }
    
    return self;
}

-(void)dismiss:(id)sender
{
    [self removeFromSuperview];
    
    [self.delegate slideShowDidDismiss];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ((scrollView.contentOffset.x - scrollView.frame.size.width)/scrollView.frame.size.width == 1) {
        //you're at the end, show the button
        _dismiss.hidden = NO;
    }
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
