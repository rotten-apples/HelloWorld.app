#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Coule be separated into a header file with interface definition,
// file with class implementation and one with main(), were this a
// bigger project.

@interface DzienDobry : UIApplication {
	UIWindow *window;
}
@end

@implementation DzienDobry
// Callback called exactly once from UIKit
-(void)applicationDidFinishLaunching: (UIApplication *)application
{
	// Physical screen
        UIScreen *screen = [UIScreen mainScreen];

	// Text area covering whole application frame
        UITextView *view = [[UITextView alloc] initWithFrame: [screen applicationFrame]];
        [view setText: @"Dzien Dobry!"];

	// Window for the text view
	window = [[[UIWindow alloc] initWithFrame:[screen applicationFrame]] retain];
        [window addSubview: view];
        [window makeKeyAndVisible];
}

// Destructor
-(void)dealloc
{
	[window release];
	[super dealloc];
}
@end

int
main (int argc, char **argv)
{
	// Auto release memory pool for the single thread we have
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc ] init];

	// Dispatch into main UIKit loop
	int ret = UIApplicationMain (argc, argv, @"DzienDobry", @"DzienDobry");

	// This is actually never reached unless there's an error
	[pool release];
	return ret;
}
