//
//  ViewController.h
//  Test
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, weak) IBOutlet NSTableView *tableView;

@property (nonatomic, weak) IBOutlet NSTextField *textField;
@property (nonatomic, weak) IBOutlet NSTextField *textField2;
@property (nonatomic, weak) IBOutlet NSView *mainView;
@property (nonatomic, weak) IBOutlet NSScrollView *scrollView;

@property (nonatomic, strong) NSArray *numbers;
@property (nonatomic, strong) NSArray *letters;

- (IBAction)btnClicked:(id)sender;

@end

