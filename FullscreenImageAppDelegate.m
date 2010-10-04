//
//  FullscreenImageAppDelegate.m
//  FullscreenImage
//
//  Created by Matt Gallagher on 2009/08/14.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "FullscreenImageAppDelegate.h"
#import "FullscreenWindow.h"

@implementation FullscreenImageAppDelegate

- (IBAction)toggleFullscreen:(id)sender
{
	if (fullscreenWindow)
	{
		NSRect newFrame = [fullscreenWindow frameRectForContentRect:
			[mainWindow contentRectForFrameRect:[mainWindow frame]]];
		
		[fullscreenWindow
			setFrame:newFrame
			display:YES
			animate:YES];

		[mainWindow setBackgroundColor:[NSColor blackColor]];
		[mainWindow makeKeyAndOrderFront:nil];

		[fullscreenWindow close];
		fullscreenWindow = nil;

		if ([[mainWindow screen] isEqual:[[NSScreen screens] objectAtIndex:0]])
		{
			[NSMenu setMenuBarVisible:YES];
		}
		[NSCursor unhide];

	}
	else
	{
		[NSCursor hide];
		[mainWindow deminiaturize:nil];

		if ([[mainWindow screen] isEqual:[[NSScreen screens] objectAtIndex:0]])
		{
			[NSMenu setMenuBarVisible:NO];
		}
		
		fullscreenWindow = [[FullscreenWindow alloc]
			initWithContentRect:[mainWindow contentRectForFrameRect:[mainWindow frame]]
			styleMask:NSBorderlessWindowMask
			backing:NSBackingStoreBuffered
			defer:YES];

		// Uncomment to make the blank screen really appear on top of everything else.
		// I like to command-Tab between the blank screen and my other application instead.
		//[fullscreenWindow setLevel:NSFloatingWindowLevel];
		[fullscreenWindow setBackgroundColor:[NSColor blackColor]];
		[fullscreenWindow setTitle:[mainWindow title]];
		[fullscreenWindow makeKeyAndOrderFront:nil];

		[fullscreenWindow
			setFrame:
				[fullscreenWindow
					frameRectForContentRect:[[mainWindow screen] frame]]
			display:YES
			animate:YES];
		
		[mainWindow orderOut:nil];
	}
}



- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[mainWindow deminiaturize:nil];
	
	if ([[mainWindow screen] isEqual:[[NSScreen screens] objectAtIndex:0]])
	{
		[NSMenu setMenuBarVisible:NO];
	}
	
	fullscreenWindow = [[FullscreenWindow alloc]
						initWithContentRect:[mainWindow contentRectForFrameRect:[mainWindow frame]]
						styleMask:NSBorderlessWindowMask
						backing:NSBackingStoreBuffered
						defer:YES];

	
	// Uncomment to make the blank screen really appear on top of everything else.
	// I like to command-Tab between the blank screen and my other application instead.
	//[fullscreenWindow setLevel:NSFloatingWindowLevel];
	
	[fullscreenWindow setBackgroundColor:[NSColor blackColor]];
	[fullscreenWindow setTitle:[mainWindow title]];
	[fullscreenWindow makeKeyAndOrderFront:nil];
	
	[fullscreenWindow
	 setFrame:
	 [fullscreenWindow
	  frameRectForContentRect:[[mainWindow screen] frame]]
	 display:YES
	 animate:YES];
	
	
	[NSCursor hide];
	
	[mainWindow orderOut:nil];
}


@end
