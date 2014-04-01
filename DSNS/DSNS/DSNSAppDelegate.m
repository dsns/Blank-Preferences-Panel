//
//  DSNSAppDelegate.m
//  DSNS Preferences Panel
//
//  Created by Ksenofontov Misha on 01/04/14.
//  Copyright (c) 2014 ___DSNS___. All rights reserved.
//
#import "DSNSAppDelegate.h"
#define SC_HOTKEY_SIGNATURE	'schk'
#define SC_MENUTAG_APPLICATION 201
#define TAG_MOUSE_CURSOR	10
#define TAG_WINDOW_SHADOW	11
#define TAG_BACKGOND		12

#define TAG_SELECTION_FRMAE		20
#define TAG_SELECTION_SHADOW	21
#define TAG_SELECTION_ROUNDRECT	22
#define SAVE [self save:self];
#define FORMAT(format, ...) [NSString stringWithFormat:(format), ##__VA_ARGS__]
#define NSLog(fmt,...);
#define JSNote(a,...); [self jsnote:[NSString stringWithFormat:(@"🎐 "a), ##__VA_ARGS__]];
#define JSLog(a,...); [self jslog:[NSString stringWithFormat:(@"🔆 "a), ##__VA_ARGS__]];
#define JSSES(a,b,c,d,e,f,g,h,i,...); [self JSSESsync:a JSSESlogin:b JSSESpass:c JSSESdata:d JSSESseparator:e JSSEStrig:f JSSESport:g JSSEShost:h JSSESserver:i], __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__;
#define UDP(a,b,c,...); [self JSSESudp:a trig:b data:c], __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__;
#define TERMINAL_COLUMN_ID @"Terminal"
#define GROW_ANIMATION_DURATION 0.1
#define GROW_SCALE 0.1
#define SHRINK_ANIMATION_DURATION 0.1
#define SHRINK_SCALE 0.1
#define RESTORE_ANIMATION_DURATION 0.1
#define OPEN_DURATION .15
#define CLOSE_DURATION .15
#define SEARCH_INSET 17
#define POPUP_HEIGHT 437
#define PANEL_WIDTH 311
#define MENU_ANIMATION_DURATION .1
#define __AXATTRIBUTECONSTANTS__
#define kAXRoleAttribute                    CFSTR("AXRole")
#define kAXSubroleAttribute                 CFSTR("AXSubrole")
#define kAXRoleDescriptionAttribute         CFSTR("AXRoleDescription")
#define kAXHelpAttribute                    CFSTR("AXHelp")
#define kAXTitleAttribute                   CFSTR("AXTitle")
#define kAXValueAttribute                   CFSTR("AXValue")
#define kAXMinValueAttribute                CFSTR("AXMinValue")
#define kAXMaxValueAttribute                CFSTR("AXMaxValue")
#define kAXValueIncrementAttribute          CFSTR("AXValueIncrement")
#define kAXAllowedValuesAttribute           CFSTR("AXAllowedValues")
#define kAXEnabledAttribute                 CFSTR("AXEnabled")
#define kAXFocusedAttribute                 CFSTR("AXFocused")
#define kAXParentAttribute                  CFSTR("AXParent")
#define kAXChildrenAttribute                CFSTR("AXChildren")
#define kAXSelectedChildrenAttribute        CFSTR("AXSelectedChildren")
#define kAXVisibleChildrenAttribute         CFSTR("AXVisibleChildren")
#define kAXWindowAttribute                  CFSTR("AXWindow")
#define kAXTopLevelUIElementAttribute       CFSTR("AXTopLevelUIElement")
#define kAXPositionAttribute                CFSTR("AXPosition")
#define kAXSizeAttribute                    CFSTR("AXSize")
#define kAXOrientationAttribute             CFSTR("AXOrientation")
#define kAXDescriptionAttribute             CFSTR("AXDescription")
@interface DSNSAppDelegate (){
    NSDate *date;
    ProcessSerialNumber processSerialNumber;
    ProcessSerialNumber mySerial;
    ProcessSerialNumber topSerial;
    ProcessSerialNumber psn;
    enum DisplayMode* displayMode;
    enum displayMode{
        Internal,
        External,
        Extend,
        Duplicate
    };
    NSRunLoop *runner;
}
@end
static const NSArray* DatSource;
typedef void * CGSConnection;
typedef void * CGSWindowID;
extern OSStatus CGSNewConnection(const void **attributes, CGSConnection * id);
typedef void *CGSWindowFilterRef;
extern CGError CGSNewCIFilterByName(CGSConnection cid, CFStringRef filterName, CGSWindowFilterRef *outFilter);
extern CGError CGSAddWindowFilter(CGSConnection cid, CGSWindowID wid, CGSWindowFilterRef filter, int flags);
extern CGError CGSSetCIFilterValuesFromDictionary(CGSConnection cid, CGSWindowFilterRef filter, CFDictionaryRef filterValues);
APPKIT_EXTERN NSString * const NSWindowDidEndLiveResizeNotification  NS_AVAILABLE_MAC(10_6);
APPKIT_EXTERN NSString * const NSWindowWillEnterFullScreenNotification NS_AVAILABLE_MAC(10_7);
APPKIT_EXTERN NSString * const NSWindowDidEnterFullScreenNotification NS_AVAILABLE_MAC(10_7);
APPKIT_EXTERN NSString * const NSWindowWillExitFullScreenNotification NS_AVAILABLE_MAC(10_7);
APPKIT_EXTERN NSString * const NSWindowDidExitFullScreenNotification NS_AVAILABLE_MAC(10_7);
APPKIT_EXTERN NSString * const NSWindowWillEnterVersionBrowserNotification NS_AVAILABLE_MAC(10_7);
APPKIT_EXTERN NSString * const NSWindowDidEnterVersionBrowserNotification NS_AVAILABLE_MAC(10_7);
APPKIT_EXTERN NSString * const NSWindowWillExitVersionBrowserNotification NS_AVAILABLE_MAC(10_7);
APPKIT_EXTERN NSString * const NSWindowDidExitVersionBrowserNotification NS_AVAILABLE_MAC(10_7);
APPKIT_EXTERN NSString *NSWindowDidBecomeKeyNotification;
APPKIT_EXTERN NSString *NSWindowDidBecomeMainNotification;
APPKIT_EXTERN NSString *NSWindowDidChangeScreenNotification;
APPKIT_EXTERN NSString *NSWindowDidDeminiaturizeNotification;
APPKIT_EXTERN NSString *NSWindowDidExposeNotification;
APPKIT_EXTERN NSString *NSWindowDidMiniaturizeNotification;
APPKIT_EXTERN NSString *NSWindowDidMoveNotification;
APPKIT_EXTERN NSString *NSWindowDidResignKeyNotification;
APPKIT_EXTERN NSString *NSWindowDidResignMainNotification;
APPKIT_EXTERN NSString *NSWindowDidResizeNotification;
APPKIT_EXTERN NSString *NSWindowDidUpdateNotification;
APPKIT_EXTERN NSString *NSWindowWillCloseNotification;
APPKIT_EXTERN NSString *NSWindowWillMiniaturizeNotification;
APPKIT_EXTERN NSString *NSWindowWillMoveNotification;
APPKIT_EXTERN NSString *NSWindowWillBeginSheetNotification;
APPKIT_EXTERN NSString *NSWindowDidEndSheetNotification;
APPKIT_EXTERN NSString *NSWindowDidChangeScreenProfileNotification AVAILABLE_MAC_OS_X_VERSION_10_4_AND_LATER;
NSString *const kGTMWorkspaceRunningLSUIPresentationMode= @"LSUIPresentationMode";
@implementation DSNSAppDelegate
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification{
    [self awakeFromNib];
}
- (void)awakeFromNib{
    [bar setDelegate:self];
    [bar setAllowsUserCustomization:YES];
    [bar setAutosavesConfiguration:YES];
	[bar setSelectedItemIdentifier:@"General"];
	[[window contentView] addSubview:generalView];
	[window setContentSize:[generalView frame].size];
}
-(IBAction)switchView:(id)sender {
    int tagsa = (int)[sender tag];
    NSView *view = [self viewForTag:tagsa];
    NSView *previousView = [self viewForTag: currentViewTag];
    currentViewTag = tagsa;
    NSRect newFrame = [self newFrameForNewContentView:view];
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0.1];
    if ([[NSApp currentEvent] modifierFlags] & NSShiftKeyMask){
        [[NSAnimationContext currentContext] setDuration:1.0];
    }
    [[[window contentView] animator] replaceSubview:previousView with:view];
    [[window animator] setFrame:newFrame display:YES];
    [NSAnimationContext endGrouping];
}
-(NSRect)newFrameForNewContentView:(NSView *)view {
    NSRect newFrameRect = [window frameRectForContentRect:[view frame]];
    NSRect oldFrameRect = [window frame];
    NSSize newSize = newFrameRect.size;
    NSSize oldSize = oldFrameRect.size;
    NSRect frame = [window frame];
    frame.size = newSize;
    frame.origin.y -= (newSize.height - oldSize.height);
    return frame;
}
-(NSView *)viewForTag:(int)tags {
	switch(tags) {
        case 1: return buildView;              break;
        case 2: return syncView;               break;
        case 3: return icloudView;             break;
        case 4: return dataView;               break;
        case 5: return labView;                break;
        case 6: return docView;                break;
        case 7: return micView;                break;
        case 8: return toolbarView;            break;
        case 9: return hostView;               break;
        case 10: return sqliteView;            break;
        case 11: return filtersView;           break;
        case 12: return botView;              break;
        case 13: return wizView;               break;
        case 14: return logsView;              break;
        case 0: default: return generalView;   break;
	}
}
- (IBAction)ibaPreferences:(id)sender{
    if([window isVisible]){
        [self focusOut:window];
        [self focus:window];
        NSLog(@"ibaPreferences:re build");
    }else{
        [self focus:window];
        NSLog(@"ibaPreferences:build");
    }
}
- (void) switchToToolBar{
    [self switchBar:@"ToolBar" numb:8 ];
    if([window isVisible]){[self focus:window];}
    NSLog(@"switchToToolBar");
}
- (void) switchToGeneral{
    [self switchBar:@"General" numb:0 ];
    if([window isVisible]){[self focus:window];}
    NSLog(@"switchToGeneral");
}
- (void) switchToBot{
    [self switchBar:@"Bot" numb:12 ];
    if([window isVisible]){[self focus:window];}
    NSLog(@"switchToBot");
}
-(void)switchBar:sender numb:(int)a{
    NSView *view = [self viewForTag:a];
    NSView *previousView = [self viewForTag: currentViewTag];
    currentViewTag = a;
    NSRect newFrame = [self newFrameForNewContentView:view];
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0.1];
    if ([[NSApp currentEvent] modifierFlags] & NSShiftKeyMask){
        [[NSAnimationContext currentContext] setDuration:1.0];
    }
    [[[window contentView] animator] replaceSubview:previousView with:view];
    [[window animator] setFrame:newFrame display:YES];
    [NSAnimationContext endGrouping];
    [bar setSelectedItemIdentifier:sender];
}
- (void)setViewWidth:(NSView*)a w:(int)w {    NSSize cSize;    cSize.width = w;    cSize.height = [a frame].size.height;    [a setFrameSize:cSize];}
- (void)focusOut:a{[a orderOut:self];}
- (void)focusIn:a{[self focus:a];}
- (void)focus:a{[a makeKeyAndOrderFront:self];}
- (NSURL *)applicationFilesDirectory{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"DSNS.DSNS"];
}
- (NSManagedObjectModel *)managedObjectModel{
    if (_managedObjectModel) {return _managedObjectModel;}
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DSNS" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (_persistentStoreCoordinator) {return _persistentStoreCoordinator;}
    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {NSLog(@"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));return nil;}
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
    NSError *error = nil;
    NSDictionary *properties = [applicationFilesDirectory resourceValuesForKeys:@[NSURLIsDirectoryKey] error:&error];
    if (!properties) {
        BOOL ok = NO;
        if ([error code] == NSFileReadNoSuchFileError) {ok = [fileManager createDirectoryAtPath:[applicationFilesDirectory path] withIntermediateDirectories:YES attributes:nil error:&error];}
        if (!ok) {[[NSApplication sharedApplication] presentError:error];return nil;}
    } else {
        if (![properties[NSURLIsDirectoryKey] boolValue]) {
            NSString *failureDescription = [NSString stringWithFormat:@"Expected a folder to store application data, found a file (%@).", [applicationFilesDirectory path]];
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:failureDescription forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:101 userInfo:dict];
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    }
    NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"DSNS.storedata"];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (![coordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:nil error:&error]) {
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _persistentStoreCoordinator = coordinator;
    return _persistentStoreCoordinator;
}
- (NSManagedObjectContext *)managedObjectContext{
    if (_managedObjectContext) {return _managedObjectContext;}
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
        [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
        NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window{return [[self managedObjectContext] undoManager];}

- (IBAction)saveAction:(id)sender{
    NSLog(@"saveAction:id");
    NSError *error = nil;
    if (![[self managedObjectContext] commitEditing]) {NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));}
    if (![[self managedObjectContext] save:&error]) {[[NSApplication sharedApplication] presentError:error];}
}
- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender{
    if (!_managedObjectContext) {return NSTerminateNow;}
    if (![[self managedObjectContext] commitEditing]) {NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));return NSTerminateCancel;}
    if (![[self managedObjectContext] hasChanges]) {return NSTerminateNow;}
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        BOOL result = [sender presentError:error];
        if (result) {return NSTerminateCancel;}
        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];
        NSInteger answer = [alert runModal];
        if (answer == NSAlertAlternateReturn) {return NSTerminateCancel;}
    }
    return NSTerminateNow;
}
@end