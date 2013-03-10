//
//  ImageProcessor.h
//  ImageProcessorExample
//
//  Created by macbook on 3/10/13.
//  Copyright (c) 2013 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageProcessor : UIViewController {
    NSString* databasePath;
	sqlite3* database;
	sqlite3_stmt* selectTodoItemStatement;
}

@property(strong) IBOutlet UIImageView* savedImage;
@property(strong) IBOutlet UIImageView* toBeSavedImage;
@property(strong) IBOutlet UIButton* saveImageButton;
@property(strong) IBOutlet UIButton* readImageButton;

-(IBAction) saveImage;
-(IBAction) readImage;

@end
