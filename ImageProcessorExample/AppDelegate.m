//
//  AppDelegate.m
//  ImageProcessorExample
//
//  Created by macbook on 3/10/13.
//  Copyright (c) 2013 macbook. All rights reserved.
//

#import "AppDelegate.h"
#import "ImageProcessor.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    databasePath = [self databasesPath];
	NSError *error;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"IMAGE_READER.sqlite"];
	BOOL success = [fileManager fileExistsAtPath:databasePath];
	
	NSLog(@"If needed, bundled default DB is at: %@",defaultDBPath);
	
	NSLog(@"Database didn't exist... Copying default from resource dir");
    if (!success) {
	success = [fileManager copyItemAtPath:defaultDBPath toPath:databasePath error:&error];
    }

    
    ImageProcessor* mainPage = [[ImageProcessor alloc] initWithNibName:@"ImageProcessor" bundle:nil];
    UINavigationController* uinavigation = [[UINavigationController alloc] initWithRootViewController:mainPage];
    uinavigation.navigationBarHidden = true;
    [self.window addSubview:mainPage.view];
    [self.window makeKeyAndVisible];
    return YES;
}

-(NSString*) databasesPath {
	NSString* documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]; // Just take it to 0 check definition
	NSLog(@"%@",[documentsDir stringByAppendingPathComponent: @"IMAGE_READER.sqlite"]);
	return [documentsDir stringByAppendingPathComponent: @"IMAGE_READER.sqlite"];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
