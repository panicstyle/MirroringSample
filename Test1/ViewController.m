//
//  ViewController.m
//  Test
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
{
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"ViewDidLoad");

}

    
- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (IBAction)btnClicked:(id)sender {

    AppDelegate *appDelegate = [NSApplication sharedApplication].delegate;
    NSUserInterfaceLayoutDirection direction;
    if (appDelegate.isLayoutMode) {
        direction = NSUserInterfaceLayoutDirectionLeftToRight;
    } else {
        direction = NSUserInterfaceLayoutDirectionRightToLeft;
    }
    self.view.userInterfaceLayoutDirection = direction;
    
    [self setDirection:self.view withDirection:direction];

    appDelegate.isLayoutMode = !appDelegate.isLayoutMode;
    
    NSView *parent = self.view.superview;
    [self.view removeFromSuperview];
    [parent addSubview:self.view]; //reloads the view from the nib//
}

- (void)setDirection:(NSView *)view withDirection:(NSUserInterfaceLayoutDirection)direction
{
    NSArray *subviews = [view subviews];
    for (NSView *subview in subviews) {
        subview.userInterfaceLayoutDirection = direction;
        if ([subview isKindOfClass:[NSTextField class]]) {
            NSLog(@"NSTextField");
            NSTextField *textField = (NSTextField *)subview;
            textField.alignment = !textField.alignment;
        } else if ([subview isKindOfClass:[NSImageView class]]) {
            NSLog(@"NSImageView");
            NSImageView *imageView = (NSImageView *)subview;
            NSImage *image = imageView.image;
            imageView.image = [self flipImageHorizontally:image];
        }
        [self setDirection:subview withDirection:direction];
    }
}

- (NSImage *)flipImageHorizontally:(NSImage *)inputImage {

    NSImage *tmpImage;
    NSAffineTransform *transform = [NSAffineTransform transform];

    NSSize dimensions = [inputImage size];
    NSAffineTransformStruct flip = {-1.0, 0.0, 0.0, 1.0,
        dimensions.width, 0.0 };
    tmpImage = [[NSImage alloc] initWithSize:dimensions];
    [tmpImage lockFocus];
    [transform setTransformStruct:flip];
    [transform concat];
    [inputImage drawAtPoint:NSMakePoint(0,0)
                         fromRect:NSMakeRect(0,0, dimensions.width, dimensions.height)
                  operation:NSCompositingOperationCopy fraction:1.0];
    [tmpImage unlockFocus];

    return tmpImage;

}

- (NSArray *)numbers {
    if (!_numbers) {
        _numbers = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    }
    return _numbers;
}
- (NSArray *)letters {
    if (!_letters) {
        _letters = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j"];
    }
    return _letters;
}

// NSTableViewDataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.numbers.count;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *identifier = tableColumn.identifier;
    NSTableCellView *cell = [tableView makeViewWithIdentifier:identifier owner:self];
    if ([identifier isEqualToString:@"numbers"]) {
        cell.textField.stringValue = [self.numbers objectAtIndex:row];
    } else {
        cell.textField.stringValue = [self.letters objectAtIndex:row];
    }
    return cell;
}
@end
