//
//  MemoryWarningView.m
//  TechStream
//
//  Created by Richard Moult on 15/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MemoryWarningView.h"



@interface MemoryWarningView() {
@private
    float oldX, oldY;
    BOOL dragging;
}

@end



static MemoryWarningView *_memoryWarningView = nil;


@implementation MemoryWarningView


+ (id)init {
    NSLog(@"--------------------------");
    NSLog(@"--------------------------");
    NSLog(@"DO NOT SHIP WITH THIS CODE");
    NSLog(@"--------------------------");
    NSLog(@"--------------------------");
    
    if (!_memoryWarningView)
        _memoryWarningView = [[MemoryWarningView alloc] initWithFrame:CGRectMake(0, 30, 100, 60)];
    return _memoryWarningView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        
        UILabel *text = [[[UILabel alloc] initWithFrame:CGRectMake(100-72, 0, 72, 60)] autorelease];
        text.text = @"memory warning generator";
        text.textColor = [UIColor whiteColor];
        text.numberOfLines = 3;
        text.textAlignment = UITextAlignmentCenter;
        text.backgroundColor = [UIColor clearColor];
        text.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:text];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        btn.frame = CGRectMake(5, frame.size.height/2-btn.frame.size.height/2, btn.frame.size.width, btn.frame.size.height);
        [btn addTarget:self action:@selector(fireMemoryWarning) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}


- (void)fireMemoryWarning {
    
    SEL memoryWarningSel = @selector(_performMemoryWarning);
    if ([[UIApplication sharedApplication] respondsToSelector:memoryWarningSel]) {
        [[UIApplication sharedApplication] performSelector:memoryWarningSel];
    }else {
        NSLog(@"Whoops UIApplication no loger responds to -_performMemoryWarning");
    }    
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.superview];
    
    if (CGRectContainsPoint(self.superview.frame, touchLocation)) {
        
        dragging = YES;
        oldX = touchLocation.x;
        oldY = touchLocation.y;
    }
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.superview];
    
    if (dragging) {
        
        CGRect frame = self.frame;
        frame.origin.x = self.frame.origin.x + touchLocation.x - oldX;
        frame.origin.y =  self.frame.origin.y + touchLocation.y - oldY;
        self.frame = frame;
    }
    
    oldX = touchLocation.x;
    oldY = touchLocation.y;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    dragging = NO;
}



@end
