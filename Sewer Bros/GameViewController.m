//
//  GameViewController.m
//  Sewer Bros
//
//  Created by Cristhian Jesus Recalde Franco on 20/12/14.
//  Copyright (c) 2014 Cristhian Recalde. All rights reserved.
//

#import "GameViewController.h"
#import "SKBSplashScene.h"

/*
@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    // Retrieve scene file path from the application bundle
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    // Unarchive the file to an SKScene object
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end */

@implementation GameViewController

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    //configure the view
    SKView* skView = (SKView *)self.view;
    
    if (!skView.scene) {
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        
        //Create and configure the scene
        SKScene* scene = [SKBSplashScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene
        [skView presentScene:scene];
        
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
