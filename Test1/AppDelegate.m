//
//  AppDelegate.m
//  Test1
//
//  Created by dykim on 2020/10/20.
//

#import "AppDelegate.h"

@interface AppDelegate ()


@end

@implementation AppDelegate

- (id)init
{
    self = [super init];
    if (self)
    {
        self.isLayoutMode = false;
    }
    
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
    NSLog(@"AppDelegate isLayoutMode = %d", self.isLayoutMode);
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
