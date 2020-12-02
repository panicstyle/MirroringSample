//
//  CustomScrollView.m
//  Test1
//
//  Created by dykim on 2020/10/29.
//

#import "CustomScrollView.h"
#import "AppDelegate.h"

@implementation CustomScrollView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    AppDelegate *appDelegate = [NSApplication sharedApplication].delegate;
    NSRect scrollViewRect = [self frame];
    
    NSScroller *verticalScroller = [self verticalScroller];
    NSRect verticalScrollerFrame = [verticalScroller frame];

    NSClipView *clipView = [self contentView];
    NSRect clipViewFrame = [clipView frame];

    if (appDelegate.isLayoutMode) {
        verticalScrollerFrame.origin.x = scrollViewRect.size.width - verticalScrollerFrame.size.width - 1;
        clipViewFrame.origin.x = 1.0;
        NSLog(@"CustomScrollView isLeftToRight");
    } else {
        verticalScrollerFrame.origin.x = 1.0;
        /*
         OS 일반설정에서 스크롤 막대 보기 설정에 따라 "항상"이 아닌 경우에는 스크롤 width 가 전체 width 에 공간을 차지하지 않는다.
         설정값을 확인하는 방법은 스크롤이 hidden 되지 않았을 때 scrollView의 width와 clipView의 width 가 2보다 크면 "항상"으로 설정된 것임
         차이값 2는 border 가 차지하는 것으로 보임
         */
        NSLog(@"scrollView width=%f, clipView width=%f", scrollViewRect.size.width, clipViewFrame.size.width);
        if (!verticalScroller.isHidden && (scrollViewRect.size.width - clipViewFrame.size.width) > 2) {
            clipViewFrame.origin.x = verticalScrollerFrame.size.width + 1;
        }
        NSLog(@"CustomScrollView isRightToLeft");
    }

    [verticalScroller setFrame:verticalScrollerFrame];

    [clipView setFrame:clipViewFrame];
    [self setVerticalScroller:verticalScroller];
}

@end
