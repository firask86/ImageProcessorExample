//
//  ImageProcessor.m
//  ImageProcessorExample
//
//  Created by macbook on 3/10/13.
//  Copyright (c) 2013 macbook. All rights reserved.
//

#import "ImageProcessor.h"

@interface ImageProcessor ()

@end

@implementation ImageProcessor
@synthesize toBeSavedImage,savedImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction) saveImage {
    sqlite3_stmt *compiledStmt;
    sqlite3 *db;
    if(sqlite3_open([[self databasesPath] UTF8String], &db)==SQLITE_OK){
        NSString *insertSQL=@"insert into CONTENT(image) VALUES(?)";
        if(sqlite3_prepare_v2(db,[insertSQL cStringUsingEncoding:NSUTF8StringEncoding], -1, &compiledStmt, NULL) == SQLITE_OK){
            UIImage *image = [toBeSavedImage image];
            NSData *imageData=UIImagePNGRepresentation(image);
            
            sqlite3_bind_blob(compiledStmt, 1, [imageData bytes], [imageData length], SQLITE_TRANSIENT);
            
            if(sqlite3_step(compiledStmt) != SQLITE_DONE ) {
                NSLog( @"Error: %s", sqlite3_errmsg(db) );
            } else {
                NSLog( @"Insert into row id = %lld", (sqlite3_last_insert_rowid(db)));
            }
            
            sqlite3_finalize(compiledStmt);
        }
    }
    sqlite3_close(db);
    
}


-(IBAction) readImage {
    sqlite3_stmt *compiledStmt;
    sqlite3 *db;
    if(sqlite3_open([[self databasesPath] UTF8String], &db)==SQLITE_OK){
        NSString *insertSQL = @"Select image from CONTENT";
        if(sqlite3_prepare_v2(db,[insertSQL cStringUsingEncoding:NSUTF8StringEncoding], -1, &compiledStmt, NULL) == SQLITE_OK) {
            while(sqlite3_step(compiledStmt) == SQLITE_ROW) {
                
                int length = sqlite3_column_bytes(compiledStmt, 0);
                NSData *imageData = [NSData dataWithBytes:sqlite3_column_blob(compiledStmt, 0) length:length];
                
                NSLog(@"Length : %d", [imageData length]);
                
                if(imageData == nil)
                    NSLog(@"No image found.");
                else
                    savedImage.image = [UIImage imageWithData:imageData];
            }
        }
        sqlite3_finalize(compiledStmt);
    }
    sqlite3_close(db);
    
}

-(NSString*) databasesPath {
	NSString* documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]; // Just take it to 0 check definition
	NSLog(@"%@",[documentsDir stringByAppendingPathComponent: @"IMAGE_READER.sqlite"]);
	return [documentsDir stringByAppendingPathComponent: @"IMAGE_READER.sqlite"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
