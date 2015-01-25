//
//  GameScene.m
//  Sewer Bros
//
//  Created by Cristhian Jesus Recalde Franco on 20/12/14.
//  Copyright (c) 2014 Cristhian Recalde. All rights reserved.
//

#import "SKBSplashScene.h"
#import "SKBGameScene.h"

@implementation SKBSplashScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor blackColor];
        
        NSString* fileName = @"";
        if (self.frame.size.width == 480)
        {
            fileName = @"SewerSplash_480";
        }
        else
        {
            fileName = @"SewerSplash_568";
        }
        
        SKSpriteNode* splash = [SKSpriteNode spriteNodeWithImageNamed:fileName];
        splash.name = @"splashNode";
        splash.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        [self addChild:splash];
        
        //init text
        SKLabelNode *startText = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        startText.text = @"Press To Start";
        startText.name = @"startNode";
        startText.fontSize = 30;
        startText.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-100);
        
        SKAction *themeSong = [SKAction playSoundFileNamed:@"Theme.caf" waitForCompletion:NO];

        [self runAction:themeSong];
        
        [self addChild:startText];
    }
 
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // Called when a touch begins
    
    for (UITouch *touch in touches) {
        SKNode *splashNode = [self childNodeWithName:@"splashNode"];
        SKNode *startNode = [self childNodeWithName:@"startNode"];
        
        if (splashNode != nil) {
            splashNode.name = nil;
            SKAction* zoom = [SKAction scaleTo:4.0 duration:1];
            SKAction *fadeAway = [SKAction fadeOutWithDuration: 1];
            SKAction *grouped = [SKAction group:@[zoom, fadeAway]];
            
            [startNode runAction:grouped];
            [splashNode runAction: grouped completion:^{
                SKBGameScene *nextScene = [[SKBGameScene alloc] initWithSize:self.size];
                SKTransition *doors = [SKTransition doorwayWithDuration:0.5];
                [self.view presentScene:nextScene transition:doors];
            }];
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
