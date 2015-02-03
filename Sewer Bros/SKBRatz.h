//
//  SKBRatz.h
//  Sewer Bros
//
//  Created by Cristhian Jesus Recalde Franco on 28/12/14.
//  Copyright (c) 2014 Cristhian Recalde. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "AppDelegate.h"
#import "SKBSpriteTextures.h"

#define kRatzSpawnSoundFileName     @"SpawnEnemy.caf"
#define kRatzKOSoundFileName        @"EnemyKO.caf"
#define kRatzCollectedSoundFileName @"EnemyCollected.caf"
#define kRatzSplashedSoundFileName  @"Splash.caf"

#define kRatzRunningIncrement       40
#define kRatzKickedIncrement        5
#define kRatzPointValue             100

typedef enum : int {
    SBRatzRunningLeft = 0,
    SBRatzRunningRight,
    SBRatzKOFacingLeft,
    SBRatzKOFacingRight,
    SBRatzKicked
} SBRatzStatus;

@interface SKBRatz : SKSpriteNode

@property int ratzStatus;
@property int lastKnownXposition, lastKnownYposition;
@property (nonatomic, strong) NSString *lastKnownContactedLedge;
@property (nonatomic, strong) SKBSpriteTextures *spriteTextures;
@property (nonatomic, strong) SKAction *spawnSound, *koSound, *collectedSound, *splashSound;

+ (SKBRatz *)initNewRatz:(SKScene *)whichScene startingPoint:(CGPoint)location ratzIndex:(int)index;
- (void)spawnedInScene:(SKScene *)whichScene;
- (void)wrapRatz:(CGPoint)where;
- (void)hitLeftPipe:(SKScene *)whichScene;
- (void)hitRightPipe:(SKScene *)whichScene;
- (void)knockedOut:(SKScene *)whicScene;
- (void)ratzCollected:(SKScene *)whichScene;
- (void)ratzHitWater:(SKScene *)whichScene;
- (void)runRight;
- (void)runLeft;
- (void)turnRight;
- (void)turnLeft;

@end
