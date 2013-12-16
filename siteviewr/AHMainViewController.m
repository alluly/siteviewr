//
//  AHMainViewController.m
//  siteviewr
//
//  Created by Ali Hasan on 10/14/13.
//  Copyright (c) 2013 Ali Hasan. All rights reserved.
//

#import "AHMainViewController.h"
#import "AHSlideShow.h"
#import "AHSlideShowDelegate.h"
#import <DropboxSDK/DropboxSDK.h>
#import <stdlib.h>

@interface AHMainViewController () <DBRestClientDelegate, AHSlideShowDelegate>
@property (nonatomic, readonly) DBRestClient* restClient;
@property(nonatomic, strong) IBOutlet UIWebView *web;
@property(nonatomic, strong) IBOutlet UILabel *loadingLabel;
@property(nonatomic, strong) IBOutlet UIActivityIndicatorView *loadingWheel;
@end

@implementation AHMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self createDirectory:@"/website" atFilePath:nil];
    
    if ([[DBSession sharedSession] isLinked]) {
        [[self restClient] createFolder:@"siteviewr"];
        [[self restClient] loadMetadata:@"/siteviewr"];
    } else {
        AHSlideShow *intro = [[AHSlideShow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) withPages:3 images:@[[UIImage imageNamed:@"1.png"],[UIImage imageNamed:@"2.png"],[UIImage imageNamed:@"3.png"]] blurbs:@[@"Connect with Dropbox", @"Drop in your website", @"Test it natively"]];
        
        [self.view addSubview:intro];
        //[[DBSession sharedSession] linkFromController:self];
    }
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - DBRestClient

- (DBRestClient *)restClient {
    if (!restClient) {
        restClient =
        [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }
    return restClient;
}

- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/website"];
    
    for (DBMetadata *file in metadata.contents) {
        
        NSArray *components = [file.path pathComponents];
        NSString *loadingComponent = file.path;
        _loadingLabel.text = [NSString stringWithFormat:@"Loading %@",[loadingComponent lastPathComponent]];
        [_loadingWheel startAnimating];
        NSString *path = @"";
        
        for (int i = 2; i < components.count; i++) {
            NSString *paths = [components objectAtIndex:i];
            path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",paths]];
        }
        if (file.isDirectory) {
            [self createDirectory:file.filename atFilePath:[NSString stringWithFormat:@"%@%@",dataPath,[path stringByDeletingLastPathComponent]]];
            [client loadMetadata:file.path withHash:file.hash];
        } else {
            [client loadFile:loadingComponent intoPath:[NSString stringWithFormat:@"%@%@",dataPath,path]];
        }
    }
}

- (void)restClient:(DBRestClient *)client loadMetadataFailedWithError:(NSError *)error {
    
    NSLog(@"Error loading metadata: %@", error);
    
}

- (void)restClient:(DBRestClient*)client loadedFile:(NSString*)localPath contentType:(NSString*)contentType metadata:(DBMetadata*)metadata {
    //should support other html file names as well

    if ([[localPath lastPathComponent] isEqualToString:@"index.html"]) {
        NSURL *url = [NSURL URLWithString: [localPath lastPathComponent]
                            relativeToURL: [NSURL fileURLWithPath: [localPath stringByDeletingLastPathComponent]
                                                      isDirectory: YES]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_web loadRequest:request];
    }
    if (client.requestCount < 3) {
        _loadingWheel.hidden = YES;
        _loadingLabel.text = @"";
        _loadingLabel.textAlignment = NSTextAlignmentCenter;
        [_loadingWheel stopAnimating];
        [UIView animateWithDuration:1.f animations:^{
            CGRect screenRect = [UIScreen mainScreen].bounds;
            _loadingLabel.frame = CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, 320, 20);

            _web.frame = CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height + 25, screenRect.size.width, screenRect.size.height);
        }];
        [_web reload];
        _loadingLabel.text = [_web stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
    NSLog(@"Loaded file at path %@",localPath);
}

- (void)restClient:(DBRestClient*)client loadFileFailedWithError:(NSError*)error {
    
    NSLog(@"There was an error loading the file - %@", error);
    
}

-(void)createDirectory:(NSString *)directoryName atFilePath:(NSString *)filePath
{
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:directoryName];
    
    if (filePath) {
        NSString *dataPathAtFilePath = [filePath stringByAppendingPathComponent:directoryName];
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPathAtFilePath]) {
            if (![[NSFileManager defaultManager] createDirectoryAtPath:dataPathAtFilePath withIntermediateDirectories:YES attributes:nil error:&error]) {
                NSLog(@"Directory error (new filepath) %@",error);
            } else {
                NSLog(@"Directory created at %@",dataPathAtFilePath);
            }
        } else {
            NSLog(@"File exists at path %@",dataPathAtFilePath);
        }
    } else {
        if(![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
            if (![[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]) {
                NSLog(@"Directory error (documents file path) %@",error);
            } else {
                NSLog(@"Directory created at documents file path");
            }
        } else {
            NSLog(@"File exists at documents file path");
        }
    }
}

#pragma mark - Flipside View Delegate

-(void)flipsideViewControllerDidFinish:(AHFlipsideViewController *)controller
{
    
}

#pragma mark - SlideShow Delegate

-(void)slideShowDidDismiss
{
    [[DBSession sharedSession] linkFromController:self];
}

@end
