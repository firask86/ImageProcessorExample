//
//  AppDelegate.h
//  ImageProcessorExample
//
//  Created by macbook on 3/10/13.
//  Copyright (c) 2013 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSString* databasePath;
	sqlite3* database;
	sqlite3_stmt* selectTodoItemStatement;
}

@property (strong, nonatomic) UIWindow *window;

@end
