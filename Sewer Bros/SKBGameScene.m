//
//  SKBGameScene.m
//  Sewer Bros
//
//  Created by Cristhian Jesus Recalde Franco on 21/12/14.
//  Copyright (c) 2014 Cristhian Recalde. All rights reserved.
//

#import "SKBGameScene.h"

@implementation SKBGameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor blackColor];
        CGRect edgeRect = CGRectMake(0.0, 0.0, 568.0, 420.0);
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:edgeRect];
        self.physicsBody.categoryBitMask = kWallCategory;
        self.physicsWorld.contactDelegate = self;
        
        _spriteTextures = [[SKBSpriteTextures alloc] init];
        [_spriteTextures createAnimationTextures];
        
        //backdrop
        NSString* fileName = @"";
        fileName = self.frame.size.width == 480 ? @"Backdrop_480" : @"Backdrop_568" ;
        /*if (self.frame.size.width == 480) fileName = @"Backdrop_480";
        else fileName = @"Backdrop_568";*/
        SKSpriteNode* backdrop = [SKSpriteNode spriteNodeWithImageNamed:fileName];
        backdrop.name = @"backdropNode";
        backdrop.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        //add backdrop image to screen
        [self addChild:backdrop];
        
        //add surfaces to screen
        [self createSceneContents];
        
        //compose cast of characters from propertyList
        [self loadCastOfCharacters];
        
    }
    
    return self;
}

#pragma mark Scene creation
-(void) createSceneContents
{
    _spawnedEnemyCount = 0;
    _enemyIsSpawningFlag = NO;
    
    //bricks
    SKSpriteNode* brick = [SKSpriteNode spriteNodeWithImageNamed:@"Base_600"];
    brick.name = @"brickNode";
    brick.position = CGPointMake(CGRectGetMidX(self.frame), brick.size.height / 2);
    brick.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:brick.size];
    brick.physicsBody.categoryBitMask = kBaseCategory;
    brick.physicsBody.dynamic = NO;
    
    [self addChild:brick];
    
    //ledge
    SKBLedge* sceneLedge = [[SKBLedge alloc] init];
    int ledgeIndex = 0;
    
    // ------------------------------------------------
    //                ledge, bottom left
    // ------------------------------------------------
    int howMany = 0;
    if (CGRectGetMaxX(self.frame) < 500)
        howMany = 18;
    else
        howMany = 23;
    
    [sceneLedge createNewSetOfLedgeNodes:self startingPoint:CGPointMake(kLedgeSideBufferSpacing, brick.position.y + 80) withHowManyBlocks:howMany startingIndex:ledgeIndex];
    
    ledgeIndex += howMany;

    // ------------------------------------------------
    //                ledge, bottom right
    // ------------------------------------------------
    if (CGRectGetMaxX(self.frame) < 500)
        howMany = 18;
    else
        howMany = 23;
    [sceneLedge createNewSetOfLedgeNodes:self
                           startingPoint:CGPointMake(CGRectGetMaxX(self.frame) -
                                                     kLedgeSideBufferSpacing - ((howMany - 1) * kLedgeBrickSpacing),
                                                     brick.position.y + 80)
                       withHowManyBlocks:howMany startingIndex:ledgeIndex];
    ledgeIndex += howMany;
    
    // ------------------------------------------------
    //               ledge, middle left
    // ------------------------------------------------
    if (CGRectGetMaxX(self.frame) < 500)
        howMany = 6;
    else
        howMany = 8;
    
    [sceneLedge createNewSetOfLedgeNodes:self
                           startingPoint:CGPointMake(CGRectGetMinX(self.frame) + kLedgeSideBufferSpacing,
                                                     brick.position.y + 142)
                       withHowManyBlocks:howMany startingIndex:ledgeIndex];
    ledgeIndex += howMany;
    
    // ------------------------------------------------
    //             ledge, middle middle
    // ------------------------------------------------
    if (CGRectGetMaxX(self.frame) < 500)
        howMany = 31;
    else
        howMany = 36;
    
    [sceneLedge createNewSetOfLedgeNodes:self
                           startingPoint:CGPointMake(CGRectGetMidX(self.frame)-((howMany * kLedgeBrickSpacing) / 2),
                                                     brick.position.y+152)
                       withHowManyBlocks:howMany
                           startingIndex:ledgeIndex];
    ledgeIndex = ledgeIndex + howMany;
    
    // ------------------------------------------------
    //              ledge, middle right
    // ------------------------------------------------
    if (CGRectGetMaxX(self.frame) < 500)
        howMany = 6;
    else
        howMany = 9;
    
    [sceneLedge createNewSetOfLedgeNodes:self
                           startingPoint:CGPointMake(CGRectGetMaxX(self.frame) - kLedgeSideBufferSpacing -
                                                     ((howMany - 1)*kLedgeBrickSpacing),
                                                     brick.position.y+142)
                       withHowManyBlocks:howMany
                           startingIndex:ledgeIndex];
    ledgeIndex = ledgeIndex + howMany;
    
    // ------------------------------------------------
    //                  ledge, top left
    // ------------------------------------------------
    if (CGRectGetMaxX(self.frame) < 500)
        howMany = 23;
    else
        howMany = 28;
    
    [sceneLedge createNewSetOfLedgeNodes:self
                           startingPoint:CGPointMake(CGRectGetMinX(self.frame) + kLedgeSideBufferSpacing, brick.position.y+224)
                       withHowManyBlocks:howMany
                           startingIndex:ledgeIndex];
    ledgeIndex = ledgeIndex + howMany;
    
    // ------------------------------------------------
    //                ledge, top right
    // ------------------------------------------------
    if (CGRectGetMaxX(self.frame) < 500)
        howMany = 23;
    else
        howMany = 28;
    
    [sceneLedge createNewSetOfLedgeNodes:self
                           startingPoint:CGPointMake(CGRectGetMaxX(self.frame) - kLedgeSideBufferSpacing -
                                                     ((howMany - 1) * kLedgeBrickSpacing), brick.position.y + 224)
                       withHowManyBlocks:howMany
                           startingIndex:ledgeIndex];
    ledgeIndex = ledgeIndex + howMany;
    
    // ------------------------------------------------
    //                      Grates
    // ------------------------------------------------
    SKSpriteNode *grate = [SKSpriteNode spriteNodeWithImageNamed:@"Grate.png"];
    grate.name = @"grate1";
    grate.position = CGPointMake(30, CGRectGetMaxY(self.frame) - 25);
    [self addChild:grate];
    
    grate = [SKSpriteNode spriteNodeWithImageNamed:@"Grate.png"];
    grate.name = @"grate2";
    grate.position = CGPointMake(CGRectGetMaxX(self.frame)-30, CGRectGetMaxY(self.frame) - 25);
    [self addChild:grate];
    
    // ------------------------------------------------
    //                       Pipes
    // ------------------------------------------------
    SKSpriteNode *pipe = [SKSpriteNode spriteNodeWithImageNamed:@"PipeLwrLeft.png"];
    pipe.name = @"pipeLeft";
    pipe.position = CGPointMake(9, 25);
    pipe.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pipe.size];
    pipe.physicsBody.categoryBitMask = kPipeCategory;
    pipe.physicsBody.dynamic = NO;
    [self addChild:pipe];
    
    pipe = [SKSpriteNode spriteNodeWithImageNamed:@"PipeLwrRight.png"];
    pipe.name = @"pipeRight";
    pipe.position = CGPointMake(CGRectGetMaxX(self.frame) - 9, 25);
    pipe.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:pipe.size];
    pipe.physicsBody.categoryBitMask = kPipeCategory;
    pipe.physicsBody.dynamic = NO;
    [self addChild:pipe];
    
    // ------------------------------------------------
    //                     Scoring
    // ------------------------------------------------
    SKBScore *sceneScores = [[SKBScore alloc] init];
    [sceneScores createScoreNodes:self];
    
    _scoreDisplay = sceneScores;
    _playerScore = 0;
    [_scoreDisplay updateScore:self newScore:_playerScore];
    
    // ------------------------------------------------
    //                     Player
    // ------------------------------------------------
    _playerSprite = [SKBPlayer initNewPlayer:self startingPoint:CGPointMake(40, 25)];
    [_playerSprite spawnedInScene:self];
}

#pragma mark Characters
- (void)loadCastOfCharacters
{
    //load cast from plist file
    NSString *path = [[NSBundle mainBundle] pathForResource:kCastOfCharactersFileName ofType:@"plist"];
    NSDictionary *plistDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if (plistDictionary) {
        
        NSDictionary *levelDictionary = [plistDictionary valueForKey:@"Level"];
        if (levelDictionary) {
            NSArray *levelOneArray = [levelDictionary valueForKey:@"One"];
            if (levelOneArray) {
                NSDictionary *enemyDictionary = nil;
                NSMutableArray *newTypeArray = [NSMutableArray arrayWithCapacity:[levelOneArray count]];
                NSMutableArray *newDelayArray = [NSMutableArray arrayWithCapacity:[levelOneArray count]];
                NSMutableArray *newStartArray = [NSMutableArray arrayWithCapacity:[levelOneArray count]];
                NSNumber *rawType, *rawDelay, *rawStartXindex;
                
                int enemyType, spawnDelay, startXindex = 0;
                for (int index=0; index<[levelOneArray count]; index++) {
                    enemyDictionary = [levelOneArray objectAtIndex:index];
                    
                    // NSNumbers from dictionary
                    rawType = [enemyDictionary valueForKey:@"Type"];
                    rawDelay = [enemyDictionary valueForKey:@"Delay"];
                    rawStartXindex = [enemyDictionary valueForKey:@"StartXindex"];
                    
                    // local integer values
                    enemyType = [rawType intValue];
                    spawnDelay = [rawDelay intValue];
                    startXindex = [rawStartXindex intValue];
                    
                    // long term storage
                    [newTypeArray addObject:rawType];
                    [newDelayArray addObject:rawDelay];
                    [newStartArray addObject:rawStartXindex];
                    NSLog(@"%d, %d, %d, %d", index, enemyType, spawnDelay, startXindex);
                }
                // store data locally
                _cast_TypeArray = [NSArray arrayWithArray:newTypeArray];
                _cast_DelayArray = [NSArray arrayWithArray:newDelayArray];
                _cast_StartXindexArray = [NSArray arrayWithArray:newStartArray];
            } else {
                NSLog(@"No levelOneArray");
            }
        } else {
            NSLog(@"No levelDictionary");
        }
    } else {
        NSLog(@"No list loaded from '%@'", kCastOfCharactersFileName);
    }
}

#pragma mark Contact / Collision / Touches

- (void)checkForEnemyHits:(NSString *)struckLedgeName
{
    // coins
    for (int index = 0; index <= _spawnedEnemyCount; index ++) {
        [self enumerateChildNodesWithName:[NSString stringWithFormat:@"coin%d", index]
                               usingBlock:^(SKNode *node, BOOL *stop) {
                                   *stop = YES;
                                   SKBCoin *theCoin = (SKBCoin *)node;
                                   
                                   //struckLedge check
                                   if ([theCoin.lastKnownContactedLedge isEqualToString:struckLedgeName]) {
                                       NSLog(@"Player hit %@ where %@ is known to be", struckLedgeName, theCoin.name);
                                       [theCoin coinCollected:self];
                                   }
                               }];
    }
    
    // ratz
    for (int index = 0; index <= _spawnedEnemyCount; index ++) {
        [self enumerateChildNodesWithName:[NSString stringWithFormat:@"ratz%d", index]
                               usingBlock:^(SKNode *node, BOOL *stop) {
                                   *stop = YES;
                                   SKBRatz *theRatz = (SKBRatz *)node;
                                   
                                   //struckLedge check
                                   if ([theRatz.lastKnownContactedLedge isEqualToString:struckLedgeName]) {
                                       NSLog(@"Player hit %@ where %@ is known to be", struckLedgeName, theRatz.name);
                                       [theRatz knockedOut:self];
                                   }
                               }];
    }
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    // contact body name
    NSString* firstBodyName = firstBody.node.name;
    
    //Player / bricks
    if (((firstBody.categoryBitMask & kPlayerCategory) != 0) && ((secondBody.categoryBitMask & kBaseCategory) != 0))
    {
        NSLog(@"player contacted brick");
    }
    
    // Player / sideWalls
    if (((firstBody.categoryBitMask & kPlayerCategory) != 0) && ((secondBody.categoryBitMask & kWallCategory) != 0))
    {
        if ([firstBodyName isEqualToString:@"player1"]) {
            if (_playerSprite.position.x <= 20) {
                NSLog(@"player contacted left edge");
                [_playerSprite wrapPlayer:CGPointMake(self.frame.size.width-10, _playerSprite.position.y)];
            }
            else {
                NSLog(@"player contacted right edge");
                [_playerSprite wrapPlayer:CGPointMake(10, _playerSprite.position.y)];
            }
        }
    }
    
    // player / ledges
    if (((firstBody.categoryBitMask & kPlayerCategory) != 0) && ((secondBody.categoryBitMask & kLedgeCategory) != 0))
    {
        if (_playerSprite.playerStatus == SBPlayerJumpingLeft || _playerSprite.playerStatus == SBPlayerJumpingRight ||
            _playerSprite.playerStatus == SBPlayerJumpingUpFacingLeft || _playerSprite.playerStatus == SBPlayerJumpingUpFacingRight) {
            SKSpriteNode *theLedge = (SKSpriteNode *)secondBody.node;
            [self checkForEnemyHits:theLedge.name];
        }
    }
    
    // player / coin
    if (((firstBody.categoryBitMask & kPlayerCategory) != 0) && ((secondBody.categoryBitMask & kCoinCategory) != 0))
    {
        SKBCoin *theCoin = (SKBCoin *)secondBody.node;
        [theCoin coinCollected:self];
        
        //score some bonuses
        _playerScore += kCoinPointValue;
        [_scoreDisplay updateScore:self newScore:_playerScore];
    }
    
    
    // Ratz / BaseBricks
    if ((((firstBody.categoryBitMask & kBaseCategory) != 0) && ((secondBody.categoryBitMask & kRatzCategory) != 0))) {
        SKBRatz *theRatz = (SKBRatz *)secondBody.node;
        theRatz.lastKnownContactedLedge = @"";
    }
    
    // Ratz / ledges
    if ((((firstBody.categoryBitMask & kLedgeCategory) != 0) && ((secondBody.categoryBitMask & kRatzCategory) != 0))) {
        SKBRatz *theRatz = (SKBRatz *)secondBody.node;
        SKNode *theLedge = firstBody.node;
        theRatz.lastKnownContactedLedge = theLedge.name;
    }
    
    // ratz / sideWalls
    if (((secondBody.categoryBitMask & kRatzCategory) != 0) && ((firstBody.categoryBitMask & kWallCategory) != 0))
    {
        SKBRatz* theRatz = (SKBRatz *)secondBody.node;
        if (theRatz.position.x < 100) {
            NSLog(@"ratz contacted left edge");
            [theRatz wrapRatz:CGPointMake(self.frame.size.width-11, theRatz.position.y)];
        } else {
            NSLog(@"ratz contacted right edge");
            [theRatz wrapRatz:CGPointMake(11, theRatz.position.y)];
        }
    }
    
    //ratz / pipes
    if (((secondBody.categoryBitMask & kPipeCategory) != 0) && ((firstBody.categoryBitMask & kRatzCategory) != 0))
    {
        SKBRatz* theRatz = (SKBRatz *)firstBody.node;
        
        if (theRatz.position.x < 100)
            [theRatz hitLeftPipe:self];
        else
            [theRatz hitRightPipe:self];
    }
    
    //ratz / ratz
    if (((secondBody.categoryBitMask & kRatzCategory) != 0) && ((firstBody.categoryBitMask & kRatzCategory) != 0))
    {
        SKBRatz* theFirstRatz = (SKBRatz *)firstBody.node;
        SKBRatz* theSecondRatz = (SKBRatz *)secondBody.node;
        NSLog(@"%@ & %@ have collided...", theFirstRatz.name, theSecondRatz.name);
        
        //cause the first ratz to turn and change directions
        if (theFirstRatz.ratzStatus == SBRatzRunningLeft) {
            [theFirstRatz turnRight];
        } else if (theFirstRatz.ratzStatus == SBRatzRunningRight) {
            [theFirstRatz turnLeft];
        }
        
        //cause the second ratz to turn and change directions
        if (theSecondRatz.ratzStatus == SBRatzRunningLeft) {
            [theSecondRatz turnRight];
        } else if (theSecondRatz.ratzStatus == SBRatzRunningRight) {
            [theSecondRatz turnLeft];
        }
    }
    
    // Coin / ledges
    if ((((firstBody.categoryBitMask & kLedgeCategory) != 0) && ((secondBody.categoryBitMask & kCoinCategory) != 0))) {
        SKBCoin *theCoin = (SKBCoin *)secondBody.node;
        SKNode *theLedge = firstBody.node;
        theCoin.lastKnownContactedLedge = theLedge.name;
    }
    
    //coin / sidewalls
    if (((secondBody.categoryBitMask & kCoinCategory) != 0) && ((firstBody.categoryBitMask & kWallCategory) != 0))
    {
        SKBCoin *theCoin = (SKBCoin *)secondBody.node;
        if (theCoin.position.x < 100) {
            [theCoin wrapCoin:CGPointMake(self.frame.size.width-6, theCoin.position.y)];
        } else {
            [theCoin wrapCoin:CGPointMake(6, theCoin.position.y)];
        }
    }
    
    //coin / pipes
    if (((firstBody.categoryBitMask & kCoinCategory) != 0) && ((secondBody.categoryBitMask & kPipeCategory) != 0))
    {
        SKBCoin *theCoin = (SKBCoin *)firstBody.node;
        [theCoin hitPipe];
    }
    
    //coin / coin
    if (((secondBody.categoryBitMask & kCoinCategory) != 0) && ((firstBody.categoryBitMask & kCoinCategory) != 0))
    {
        SKBCoin* theFirstCoin = (SKBCoin *)firstBody.node;
        SKBCoin* theSecondCoin = (SKBCoin *)secondBody.node;
        NSLog(@"%@ & %@ have collided...", theFirstCoin.name, theSecondCoin.name);
        
        //cause the first ratz to turn and change directions
        if (theFirstCoin.coinStatus == SBCoinRunningLeft) {
            [theFirstCoin turnRight];
        } else if (theFirstCoin.coinStatus == SBCoinRunningRight) {
            [theFirstCoin turnLeft];
        }
        
        //cause the second ratz to turn and change directions
        if (theSecondCoin.coinStatus == SBCoinRunningLeft) {
            [theSecondCoin turnRight];
        } else if (theSecondCoin.coinStatus == SBCoinRunningRight) {
            [theSecondCoin turnLeft];
        }
    }
    
    //coin / ratz
    if (((secondBody.categoryBitMask & kRatzCategory) != 0) && ((firstBody.categoryBitMask & kCoinCategory) != 0))
    {
        SKBCoin* theCoin = (SKBCoin *)firstBody.node;
        SKBRatz* theRatz = (SKBRatz *)secondBody.node;
        NSLog(@"%@ & %@ have collided...", theCoin.name, theRatz.name);
        
        //cause the first ratz to turn and change directions
        if (theCoin.coinStatus == SBCoinRunningLeft) {
            [theCoin turnRight];
        } else if (theCoin.coinStatus == SBCoinRunningRight) {
            [theCoin turnLeft];
        }
        
        //cause the second ratz to turn and change directions
        if (theRatz.ratzStatus == SBRatzRunningLeft) {
            [theRatz turnRight];
        } else if (theRatz.ratzStatus == SBRatzRunningRight) {
            [theRatz turnLeft];
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // Called when a touch begins
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SBPlayerStatus status = _playerSprite.playerStatus;
        
        if (location.y >= (self.frame.size.height / 2)) {
            //user touched upper half of the screen (zero = bottom of screen)
            if (status != SBPlayerJumpingLeft && status != SBPlayerJumpingRight && status != SBPlayerJumpingUpFacingLeft &&
                status != SBPlayerJumpingUpFacingRight) {
                [_playerSprite jump];
            }
        } else if (location.x <= (self.frame.size.width / 2)) {
            // user touched left side of screen
            if (status == SBPlayerRunningRight) {
                [_playerSprite skidRight];
            } else if (status == SBPlayerFacingLeft || status == SBPlayerFacingRight) {
                [_playerSprite runLeft];
            }
        } else {
            // user touched right side of screen
            if (status == SBPlayerRunningLeft) {
                [_playerSprite skidLeft];
            } else if (status == SBPlayerFacingLeft || status == SBPlayerFacingRight) {
                [_playerSprite runRight];
            }
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (!_enemyIsSpawningFlag && _spawnedEnemyCount < [_cast_TypeArray count]) {
        _enemyIsSpawningFlag = YES;
        int castIndex = _spawnedEnemyCount;

        int leftSideX = CGRectGetMinX(self.frame) + kEnemySpawnEdgeBufferX;
        int rightSideX = CGRectGetMaxX(self.frame) - kEnemySpawnEdgeBufferX;
        int topSideY = CGRectGetMaxY(self.frame) - kEnemySpawnEdgeBufferY;
        
        // from castOfCharacters file, the sprite Type
        NSNumber *theNumber = [_cast_TypeArray objectAtIndex:castIndex];
        int castType = [theNumber intValue];
        
        // from castOfCharacters file, the sprite Delay
        theNumber = [_cast_DelayArray objectAtIndex:castIndex];
        int castDelay = [theNumber intValue];
        
        // from castOfCharacters file, the sprite startXindex
        int startX = 0;
        // determine which side
        theNumber = [_cast_StartXindexArray objectAtIndex:castIndex];
     
        // alternate sides for every other spawn
        if ([theNumber intValue] == 0)
            startX = leftSideX;
        else
            startX = rightSideX;
        int startY = topSideY;
        
        // begin delay & when completed spawn new enemy
        SKAction *spacing = [SKAction waitForDuration:castDelay];
        [self runAction:spacing completion:^{
            // Create & spawn the new Enemy
            _enemyIsSpawningFlag = NO;
            _spawnedEnemyCount = _spawnedEnemyCount + 1;
            
            if (castType == SKBEnemyTypeCoin) {
                SKBCoin* newCoin = [SKBCoin initNewCoin:self startingPoint:CGPointMake(startX, startY) coinIndex:castIndex];
                [newCoin spawnedInScene:self];
            } else if (castType == SKBEnemyTypeRatz) {
                SKBRatz *newEnemy = [SKBRatz initNewRatz:self startingPoint:CGPointMake(startX, startY) ratzIndex:castIndex];
                [newEnemy spawnedInScene:self];
            }
        }];
    }
    
    //check for stuck enemies every 20 frames
    _frameCounter = _frameCounter + 1;
    if (_frameCounter >= 20) {
        _frameCounter = 0;
        for (int index=0; index <= _spawnedEnemyCount; index ++) {
            // coins
            [self enumerateChildNodesWithName:[NSString stringWithFormat:@"coin%d", index]
                                   usingBlock:^(SKNode* node, BOOL *stop)
             {
                 *stop = YES;
                 SKBCoin* theCoin = (SKBCoin *)node;
                 int currentX = theCoin.position.x;
                 int currentY = theCoin.position.y;
                 
                 if (currentX == theCoin.lastKnownXposition && currentY == theCoin.lastKnownYposition) {
                     NSLog(@"%@ appears to be stuck ...", theCoin.name);
                     if (theCoin.coinStatus == SBCoinRunningRight) {
                         [theCoin removeAllActions];
                         [theCoin runLeft];
                     } else if (theCoin.coinStatus == SBCoinRunningLeft) {
                         [theCoin removeAllActions];
                         [theCoin runRight];
                     }
                 }
                 theCoin.lastKnownXposition = currentX;
                 theCoin.lastKnownYposition = currentY;
             }
            ];
            
            //ratz
            [self enumerateChildNodesWithName:[NSString stringWithFormat:@"ratz%d", index]
                                   usingBlock:^(SKNode* node, BOOL *stop)
             {
                 *stop = YES;
                 SKBRatz* theRatz = (SKBRatz *)node;
                 int currentX = theRatz.position.x;
                 int currentY = theRatz.position.y;
                 
                 if (currentX == theRatz.lastKnownXposition && currentY == theRatz.lastKnownYposition) {
                     NSLog(@"%@ appears to be stuck ...", theRatz.name);
                     if (theRatz.ratzStatus == SBRatzRunningRight) {
                         [theRatz removeAllActions];
                         [theRatz runLeft];
                     } else if (theRatz.ratzStatus == SBRatzRunningLeft) {
                         [theRatz removeAllActions];
                         [theRatz runRight];
                     }
                 }
                 theRatz.lastKnownXposition = currentX;
                 theRatz.lastKnownYposition = currentY;
             }
             ];
        }
    }
}

@end
