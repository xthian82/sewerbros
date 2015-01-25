//
//  SKBGameScene.h
//  Sewer Bros
//
//  Created by Cristhian Jesus Recalde Franco on 21/12/14.
//  Copyright (c) 2014 Cristhian Recalde. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKBPlayer.h"
#import "SKBLedge.h"
#import "SKBRatz.h"
#import "SKBCoin.h"
#import "SKBScore.h"

@interface SKBGameScene : SKScene<SKPhysicsContactDelegate>

@property (nonatomic, strong) SKBPlayer* playerSprite;
@property (nonatomic, strong) SKBSpriteTextures* spriteTextures;
@property (nonatomic, strong) SKBScore* scoreDisplay;
@property (nonatomic, strong) NSArray *cast_TypeArray, *cast_DelayArray, *cast_StartXindexArray;

@property int frameCounter;
@property int spawnedEnemyCount;
@property BOOL enemyIsSpawningFlag;
@property int playerScore;

@end
