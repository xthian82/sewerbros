//
//  SKBCoin.h
//  Sewer Bros
//
//  Created by Cristhian Jesus Recalde Franco on 31/12/14.
//  Copyright (c) 2014 Cristhian Recalde. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "AppDelegate.h"
#import "SKBSpriteTextures.h"

#define kCoinSpawnSoundFileName @"SpawnCoin.caf"
#define kCoinCollectedFileName @"CoinCollected.caf"

#define kCoinRunningIncrement   40
#define kCoinPointValue 60

typedef enum : int {
    SBCoinRunningLeft = 0,
    SBCoinRunningRight
} SBCoinStatus;

@interface SKBCoin : SKSpriteNode

@property int coinStatus;
@property int lastKnownXposition, lastKnownYposition;
@property (nonatomic, strong) NSString *lastKnownContactedLedge;
@property (nonatomic, strong) SKBSpriteTextures *spriteTextures;
@property (nonatomic, strong) SKAction *spawnSound, *collectedSound;

+ (SKBCoin *)initNewCoin:(SKScene *)whichScene startingPoint:(CGPoint)location coinIndex:(int)index;

- (void) spawnedInScene:(SKScene *)whichScene;
- (void) wrapCoin:(CGPoint)where;
- (void) hitPipe;
- (void) coinCollected:(SKScene *)whichScene;
- (void) runRight;
- (void) runLeft;
- (void) turnRight;
- (void) turnLeft;

@end
