//
//  DSNSAppDelegate.h
//  DSNS Preferences Panel
//
//  Created by Ksenofontov Misha on 01/04/14.
//  Copyright (c) 2014 ___DSNS___. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DSNSAppDelegate : NSObject <NSApplicationDelegate, NSTableViewDelegate, NSTableViewDataSource, NSToolbarDelegate> {
     int currentViewTag;
    CGFloat _tableColumnWidth;
	bool isRunning;
    long tag;
    IBOutlet NSWindow *window;
    IBOutlet NSView *generalView;
    IBOutlet NSView *hostView;
    IBOutlet NSView *buildView;
    IBOutlet NSView *filtersView;
    IBOutlet NSView *icloudView;
    IBOutlet NSView *dataView;
    IBOutlet NSView *sqliteView;
    IBOutlet NSView *syncView;
    IBOutlet NSView *botView;
    IBOutlet NSView *micView;
    IBOutlet NSView *docView;
    IBOutlet NSView *labView;
    IBOutlet NSView *logsView;
    IBOutlet NSView *toolbarView;
    IBOutlet NSView *wizView;
    IBOutlet NSToolbar *bar;
    __unsafe_unretained id _target;
    SEL action;

}
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:(id)sender;

@end
