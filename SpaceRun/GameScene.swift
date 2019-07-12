//
//  GameScene.swift
//  SpaceRun
//
//  Created by Matthew Sargeant on 5/1/17.
//  Copyright © 2017 assignment3 Matthew Sargeant. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
  // Class properties
  
  // Instance properties
  
  // MARK: - Properties
  private let SpaceshipNodeName = "ship"
  private let PhotonTorpedoName = "photon"
  private let ObstacleNodeName = "obstacle"
  private let PowerupNodeName = "powerup"
  private let LudacrispPowerupNodeName = "ludacrispPowerup"
  private let SpreaderPowerupNodeName = "spreaderPowerup"
  private let WagglePowerupNodeName = "wagglePowerup"
  private let SpiralPowerupNodeName = "spiralPowerup"
  private let HealthPowerupNodeName = "shipHealth"
  private let ShieldNodeName = "shield"
  private let HUDNodeName = "hud"
  private let Boss1NodeName = "boss1"
  private let Boss2NodeName = "boss2"
  private let Boss3NodeName = "boss3"
  private let Boss4NodeName = "boss4"
  private let Boss5NodeName = "boss5"
  private let Boss6NodeName = "boss6"
  private let Boss7NodeName = "boss7"
  private let Boss8NodeName = "boss8"
  private let Boss9NodeName = "boss9"
  private let Boss10NodeName = "boss10"
  private let Boss11NodeName = "boss11"
  private let Boss12NodeName = "boss12"
  private let Boss13NodeName = "boss13"
  private let Boss14NodeName = "boss14"

  // properties to hold sound actions. We will preload our sounds
  // into these properties so there is no delay when they are implemented the first time.
  private let shootSound: SKAction = SKAction.playSoundFileNamed("laserShot.wav", waitForCompletion: false)
  private let obstacleExplodeSound: SKAction = SKAction.playSoundFileNamed("darkExplosion.wav", waitForCompletion: false)
  private let shipExplodeSound: SKAction = SKAction.playSoundFileNamed("explosion.wav", waitForCompletion: false)
  private let waggleSound: SKAction = SKAction.playSoundFileNamed("waggleSound.wav", waitForCompletion: false)
  private let spiralSound: SKAction = SKAction.playSoundFileNamed("spiralSound.wav", waitForCompletion: false)
  private let spreaderSound: SKAction = SKAction.playSoundFileNamed("spreaderSound.wav", waitForCompletion: false)
  private let hurtSound: SKAction = SKAction.playSoundFileNamed("hurtSound.mp3", waitForCompletion: false)
  private let healthPickup: SKAction = SKAction.playSoundFileNamed("healthPickup.wav", waitForCompletion: false)
  private let powerupSound: SKAction = SKAction.playSoundFileNamed("powerupSound.wav", waitForCompletion: false)

  private let SpiralTorpedoName = "spiralShot"
  private let SpreaderTorpedoName = "spreaderShot"
  private let WaggleTorpedoName = "waggleShot"

  private let BackgroundNodeName = "background"
  
  private weak var shipTouch: UITouch?
  private var lastUpdateTime: TimeInterval = 0
  private var lastDifficultyUpdateTime: TimeInterval = 0
  private var lastShotFireTime: TimeInterval = 0
  private var lastShotFireTime2: TimeInterval = 0
  private var lastShotFireTime3: TimeInterval = 0
  private var lastShotFireTime4: TimeInterval = 0
  private var lastShotFireTime5: TimeInterval = 0
  
  private var defaultFireRate: Double = 0.5
  private var shipFireRate: Double = 0.5
  private var enhancedFireRate: Double = 0.3
  private var ludacrispFireRate: Double = 0.1
  private let powerUpDuration: TimeInterval = 5.0
  private let typePowerupDuration: TimeInterval = 6.0
  private var shipHealthRate: Double = 2.0
  private let defaultFireType: String = "photon"
  private var shipFireType: String = "photon"
  private var shieldStrength: Double = 2.0
  private var bossHealthIncrementer: Double = 2
  private var secondBossSetHelthIncrementer: Double = 3
  private var initialBoss1Health: Double = 10
  
  private var boss1Health: Double = 10
  private var boss2Health: Double = 15
  private var boss3Health: Double = 18
  private var boss4Health: Double = 21
  private var boss5Health: Double = 24
  private var boss6Health: Double = 27
  private var boss7Health: Double = 30
  private var boss8Health: Double = 33
  private var boss9Health: Double = 36
  private var boss10Health: Double = 49
  private var boss11Health: Double = 52
  private var boss12Health: Double = 65
  private var boss13Health: Double = 78
  private var boss14Health: Double = 81
  
  private var boss1WaitTime: Double = 10
  private var boss2WaitTime: Double = 30
  private var boss3WaitTime: Double = 50
  private var boss4WaitTime: Double = 70
  private var boss5WaitTime: Double = 90
  private var boss6WaitTime: Double = 110
  private var boss7WaitTime: Double = 130
  private var boss8WaitTime: Double = 150
  private var boss9WaitTime: Double = 170
  private var boss10WaitTime: Double = 190
  private var boss11WaitTime: Double = 210
  private var boss12WaitTime: Double = 230
  private var boss13WaitTime: Double = 250
  private var boss14WaitTime: Double = 270
  
  // We will be using the explosion particle emitters more than once, and we don't want to load them form thier .sks files every time, so instead we'll create instance properties and load (ache) them for quick reuse like we did our sound-related properties.
  private let shipExplodeTemplate: SKEmitterNode = SKEmitterNode.nodeWithFile("shipExplode.sks")!
  private let obstacleExplodeTemplate: SKEmitterNode = SKEmitterNode.nodeWithFile("obstacleExplode.sks")!
  
  private var level = 1
  private var incrementer = 0.0
  private var incrementer2 = Double(CGFloat.pi/2)
  private var xPosition1 = 0
  private var yPosition1 = 0
  private var startPositionX = 0
  private var startPositionY = 0
  private var yPosition2 = 0
  private var xPosition2 = 0
  private var yPosition3 = 0
  private var xPosition3 = 0
  private var yPosition4 = 0
  private var xPosition4 = 0
  private let jiggleConstant = 5.0
  private var spreaderIncrementer = 0.0
  private var waggleIncrementer1 = Double(1*CGFloat.pi/3)
  private var waggleIncrementer2 = Double(2*CGFloat.pi/3)
  private var waggleIncrementer3 = Double(3*CGFloat.pi/3)
  
  private var initialTime = 0.0
  private var nowTime = 0.0
 
  private var difficultyTimer = Double(30.0)
  private var difficulty: UInt32 = UInt32(0.0)
  private var difficultyIncrementer: UInt32 = UInt32(5.0)

  
  private var enemy3count = 0
  private var bossLevel = 1
  
  private var reverseFire = false
  private var circleFire = false
  private var reverseWaggle1 = false
  private var reverseWaggle2 = false
  private var reverseWaggle3 = false
  private var boss1 = false
  private var boss2 = false
  private var boss3 = false
  private var boss4 = false
  private var boss5 = false
  private var boss6 = false
  private var boss7 = false
  private var boss8 = false
  private var boss9 = false
  private var boss10 = false
  private var boss11 = false
  private var boss12 = false
  private var boss13 = false
  private var boss14 = false

  override init(size: CGSize) {
  super.init(size: size)
    
  setupGame(size: size)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - setup Game
  func setupGame(size: CGSize) {
  
    initialTime = Date.timeIntervalSinceReferenceDate

    
    let ship = SKSpriteNode(imageNamed: "ship_cosmic.png")
    
    ship.position = CGPoint(x: size.width/2.0, y: size.height/8.0)
    ship.size = CGSize(width: 20.0, height: 40.0)
    ship.name = SpaceshipNodeName
    
    let background = SKSpriteNode(imageNamed: "background6_cosmic.png")
    
    background.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
    background.zPosition = -300
    background.size = CGSize(width: 640.0, height: 960.0)
    background.name = BackgroundNodeName
    
    addChild(background)
    
    addChild(ship)
    
    // Add ship thruster particle to our ship
    if let thruster = SKEmitterNode.nodeWithFile("thruster.sks") {
      
      thruster.position = CGPoint(x: 0.0, y: -25.0)
      
      // Now, add the thruster as a child of our ship so its position is relative to ship's position.
      ship.addChild(thruster)
    }
    
    // set up our HUD
    let hudNode = HUDNode()   // instantiate the HUDNode class
    
    hudNode.name = HUDNodeName
    
    // By default, nodes will overlap (stack) according to the order in which they are added to the scene. If we want to change this order, we can use a node's zPosition to do so.
    hudNode.zPosition = 100.0
    
    // Set the position of the node to the center of the screen.
    // All of the child nodes of the HUD will be positioned realative
    // to this parent node's origin point
    hudNode.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
    
    addChild(hudNode)
    
    // Lay out the score and time label
    hudNode.layoutForScene()
    
    // Start game HUD stuff
    hudNode.startGame()
    // MARK: - start HUD
    if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
      
      hud.showHealth(Double(self.shipHealthRate))
      
    }
    // MARK: - startShield
      if let shield = SKEmitterNode.nodeWithFile("Shield.sks") {
      
      shield.position = CGPoint(x: 0.0, y: 0.0)
      shield.name = ShieldNodeName
      shield.alpha = 0.35
      shield.particleScaleRange = 0.2
      shield.setScale(0.6)
        
      ship.addChild(shield)
        
      }
    
    
    
    // Add our star field parallax effect to the scene by creating an instance of our starfield class and adding it to the scene as a child.
    addChild(StarField())
  }
  
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {

      // Called when a touches occurs
      if let touch = touches.first
      {
        
        /*
        // locate the touch point
        let touchPoint = touch.location(in: self)
        
        // we want to move our ship to the touch point
        //
        // to do this though, we need to acquire a reference
        // to our ship node in our Scene Graph node tree.
        // 
        if let ship = self.childNode(withName: SpaceshipNodeName) {
          
          // reposition the ship to the touch point
          ship.position = touchPoint
          */
        
        self.shipTouch = touch
        }
      }

    override func update(_ currentTime: TimeInterval) {
      // Called before each frame is rendered
      
      //If the lastUpdateTime property is zero, this is the first frame
      // rendered for the scene. Reset it to the passed-in current time.
      if lastUpdateTime == 0 {
        lastUpdateTime = currentTime
      }
      
      // Calculate the time change (delta)since the last frame
      let timeDelta = currentTime - lastUpdateTime
      
      nowTime = Date.timeIntervalSinceReferenceDate

      // If the touch is still there (since shipTouch is a weak reference,
      // it will automatically be set to nil by the touch-handling system
      // when it releases the touches after they are done), find the ship
      // node in the Scene Graph node tree by its name and update its
      // position property gradually to the point on the screen that was
      // touched.
      //
      // This will happen every frame becuse we are in update() so the
      // ship will keep up with wherever the user's finger moves to on
      // the screen.
      
      if let shipTouch = self.shipTouch {
        
       /* if let ship = self.childNode(withName: SpaceshipNodeName) {
          
          // Repositoin the ship
          ship.position = shipTouch.location(in: self)
          
        }*/
       
        moveShipTowardPoint(touchPoint: shipTouch.location(in: self), timeDelta: timeDelta)
        
        // We only want photon torpedos to launch from our ship when the
        // user's finger is in contact with the screen AND if the difference
        // between the current time and the last time a torpedo was fired
        // is greater than half a second.
        
        // MARK: - shoot
        if currentTime - lastShotFireTime > shipFireRate && shipFireType == "photon" {
          shoot() // fire a photon torpedo from our ship
          lastShotFireTime = currentTime
        }
        
        if currentTime - lastShotFireTime2 > shipFireRate && shipFireType == "spiral" {
         spiralShoot() // call spiralshoot function
          lastShotFireTime2 = currentTime
        }
        
        if currentTime - lastShotFireTime3 > shipFireRate && shipFireType == "spreader" {
          spreader() // call spreader function
          lastShotFireTime3 = currentTime
        }
        
        if currentTime - lastShotFireTime4 > shipFireRate && shipFireType == "waggle" {
          waggleShoot() // call waggleShoot function
          lastShotFireTime4 = currentTime
        }
        
        // MARK: - dropBoss
        
        if ((nowTime - initialTime) > boss1WaitTime) && boss1 == false{
          dropBoss1()
          boss1 = true
          level += 1
        }
        
        if ((nowTime - initialTime) > boss2WaitTime) && boss2 == false{
          dropBoss2()
          boss2 = true
          level += 1

        }
        
        if ((nowTime - initialTime) > boss3WaitTime) && boss3 == false{
          dropBoss3()
          boss3 = true
          level += 1

        }
        
        if ((nowTime - initialTime) > boss4WaitTime) && boss4 == false{
          dropBoss4()
          boss4 = true
          level += 1

        }
        
        if ((nowTime - initialTime) > boss5WaitTime) && boss5 == false{
          dropBoss5()
          boss5 = true
          level += 1

        }
        
        if ((nowTime - initialTime) > boss6WaitTime) && boss6 == false{
          dropBoss6()
          boss6 = true
          level += 1

        }
        
        if ((nowTime - initialTime) > boss7WaitTime) && boss7 == false{
          dropBoss7()
          boss7 = true
          level += 1

        }
        
        if ((nowTime - initialTime) > boss8WaitTime) && boss8 == false{
          dropBoss8()
          boss8 = true
        }
        
        if ((nowTime - initialTime) > boss9WaitTime) && boss9 == false{
          dropBoss9()
          boss9 = true
        }
        
        if ((nowTime - initialTime) > boss10WaitTime) && boss10 == false{
          dropBoss10()
          boss10 = true
        }
        
        if ((nowTime - initialTime) > boss11WaitTime) && boss11 == false{
          dropBoss11()
          boss11 = true
        }
        
        if ((nowTime - initialTime) > boss12WaitTime) && boss12 == false{
          dropBoss12()
          boss12 = true
        }
        
        if ((nowTime - initialTime) > boss13WaitTime) && boss13 == false{
          dropBoss13()
          boss13 = true
        }
        
        if ((nowTime - initialTime) > boss14WaitTime) && boss14 == false{
          dropBoss14()
          boss14 = true
        }
        

      }

      
        if bossLevel == 2 {
          if let background = self.childNode(withName: BackgroundNodeName) {
            
            background.removeFromParent()
            
            let background = SKSpriteNode(imageNamed: "background2_cosmic.png")
            
            background.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
            background.zPosition = -300
            background.size = CGSize(width: 640.0, height: 960.0)
            background.name = BackgroundNodeName
            
            addChild(background)
            
          }

        } else if bossLevel == 3 {
          
          if let background = self.childNode(withName: BackgroundNodeName) {
            
            background.removeFromParent()
            
            let background = SKSpriteNode(imageNamed: "background3_cosmic.png")
            
            background.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
            background.zPosition = -300
            background.size = CGSize(width: 640.0, height: 960.0)
            background.name = BackgroundNodeName
            
            addChild(background)
            
          }
        } else if bossLevel == 4 {
          
          if let background = self.childNode(withName: BackgroundNodeName) {
            
            background.removeFromParent()
            
            let background = SKSpriteNode(imageNamed: "background4_cosmic.png")
            
            background.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
            background.zPosition = -300
            background.size = CGSize(width: 640.0, height: 960.0)
            background.name = BackgroundNodeName
            
            addChild(background)
            
          }
        } else if bossLevel == 5 {
          
          if let background = self.childNode(withName: BackgroundNodeName) {
            
            background.removeFromParent()
            
            let background = SKSpriteNode(imageNamed: "background5_cosmic.png")
            
            background.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
            background.zPosition = -300
            background.size = CGSize(width: 640.0, height: 960.0)
            background.name = BackgroundNodeName
            
            addChild(background)
            
          }
        }  else if bossLevel == 6 {
          
          if let background = self.childNode(withName: BackgroundNodeName) {
            
            background.removeFromParent()
            
            let background = SKSpriteNode(imageNamed: "background6_cosmic.png")
            
            background.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
            background.zPosition = -300
            background.size = CGSize(width: 640.0, height: 960.0)
            background.name = BackgroundNodeName
            
            addChild(background)
            
          }
        }  else if bossLevel == 7 {
          
          if let background = self.childNode(withName: BackgroundNodeName) {
            
            background.removeFromParent()
            
            let background = SKSpriteNode(imageNamed: "background7_cosmic.png")
            
            background.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
            background.zPosition = -300
            background.size = CGSize(width: 640.0, height: 960.0)
            background.name = BackgroundNodeName
            
            addChild(background)
            
          }
        }  else if bossLevel == 8 {
          
          if let background = self.childNode(withName: BackgroundNodeName) {
            
            background.removeFromParent()
            
            let background = SKSpriteNode(imageNamed: "background8_cosmic.png")
            
            background.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
            background.zPosition = -300
            background.size = CGSize(width: 640.0, height: 960.0)
            background.name = BackgroundNodeName
            
            addChild(background)
            
          }
        }  else if bossLevel == 9 {
          
          if let background = self.childNode(withName: BackgroundNodeName) {
            
            background.removeFromParent()
            
            let background = SKSpriteNode(imageNamed: "background9_cosmic.png")
            
            background.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
            background.zPosition = -300
            background.size = CGSize(width: 640.0, height: 960.0)
            background.name = BackgroundNodeName
            
            addChild(background)
            
          }
        }  else if bossLevel == 10 {
          
          if let background = self.childNode(withName: BackgroundNodeName) {
            
            background.removeFromParent()
            
            let background = SKSpriteNode(imageNamed: "background10_cosmic.png")
            
            background.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
            background.zPosition = -300
            background.size = CGSize(width: 640.0, height: 960.0)
            background.name = BackgroundNodeName
            
            addChild(background)
            
          }
        }  else if bossLevel == 11 {
          
          if let background = self.childNode(withName: BackgroundNodeName) {
            
            background.removeFromParent()
            
            let background = SKSpriteNode(imageNamed: "background11_cosmic.png")
            
            background.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
            background.zPosition = -300
            background.size = CGSize(width: 640.0, height: 960.0)
            background.name = BackgroundNodeName
            
            addChild(background)
            
          }
        }  else if bossLevel == 12 {
          
          if let background = self.childNode(withName: BackgroundNodeName) {
            
            background.removeFromParent()
            
            let background = SKSpriteNode(imageNamed: "background12_cosmic.png")
            
            background.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
            background.zPosition = -300
            background.size = CGSize(width: 640.0, height: 960.0)
            background.name = BackgroundNodeName
            
            addChild(background)
            
          }
        }  else if bossLevel == 13 {
          
          if let background = self.childNode(withName: BackgroundNodeName) {
            
            background.removeFromParent()
            
            let background = SKSpriteNode(imageNamed: "background13_cosmic.png")
            
            background.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
            background.zPosition = -300
            background.size = CGSize(width: 640.0, height: 960.0)
            background.name = BackgroundNodeName
            
            addChild(background)
            
          }
        } else if bossLevel == 14 {
          
          if let background = self.childNode(withName: BackgroundNodeName) {
            
            background.removeFromParent()
            
            let background = SKSpriteNode(imageNamed: "background14_cosmic.png")
            
            background.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
            background.zPosition = -300
            background.size = CGSize(width: 640.0, height: 960.0)
            background.name = BackgroundNodeName
            
            addChild(background)
            
          }
        } else if bossLevel == 15 {
          
          if let background = self.childNode(withName: BackgroundNodeName) {
            
            background.removeFromParent()
            
            let background = SKSpriteNode(imageNamed: "background15_cosmic.png")
            
            background.position = CGPoint(x: size.width/2.0, y: size.height/2.0)
            background.zPosition = -300
            background.size = CGSize(width: 640.0, height: 960.0)
            background.name = BackgroundNodeName
            
            addChild(background)
            
          }
        }
      
      // MARK: - Difficulty
      // We want to release obstacles 4% of the time a frame is drawn
        if (currentTime - lastDifficultyUpdateTime) > difficultyTimer {
          difficulty += difficultyIncrementer
          lastDifficultyUpdateTime = currentTime
        }
      
      dropThing()

      // Check for any collisions before each frame is rendered
      checkCollisions()
      
      
      // Update lastUpdateTime to current Time
      lastUpdateTime = currentTime
    }
  
  
  //
  // Nudge the ship toward the touch point by an appropriate distance amount based 
  // on elapsed time (timeDelta) since the last frame
  // 
  func moveShipTowardPoint(touchPoint: CGPoint, timeDelta: TimeInterval) {
    
    // Points per second the ship should travel
    let shipSpeed = CGFloat(300)
    
    if let ship = self.childNode(withName: SpaceshipNodeName) {
      
      // Using the Pythageorean Theorem, determine the distance
      // between the ship's current location and the oint that was
      // passed in (touchPoint).
      let distanceLeftToTravel = sqrt(pow(ship.position.x - touchPoint.x, 2) + pow(ship.position.y - touchPoint.y, 2))
      
      // if the distance left to trave is greater than 4 points,
      // keep moving the ship. Otherwise, stop movin the ship
      // because we may experience "jitter" around the touch point.
      // (due to imprecision with floating point numbers) if we
      // get too close.
      if distanceLeftToTravel > 18 {
        
        // Calculate how far we should move the sip during this 
        // frame (current run of update()).
        let distanceToMove = CGFloat(timeDelta) * shipSpeed
        
        // Convert the distance remaining back into (x,y) coordinates
        // using hte atan2() function to determine the proper angle
        // based on ship's opsition and the destination
        let angle = atan2(touchPoint.y - ship.position.y, touchPoint.x - ship.position.x)
        
        // Then, using the angle along with sine and cosine (trig funcitons),
        // determine the x and y offset values (x-distance and y-distance to move)
        let xOffset = distanceToMove * cos(angle)
        let yOffset = distanceToMove * sin(angle)
        
        // Use the offsets to reposition the ship
        ship.position = CGPoint(x: ship.position.x + xOffset, y: ship.position.y + yOffset)
        
      }
    }
  }
  
  //
  // Fire a photon torpedo from our ship
  //
  
  func shoot() {
    
    if let ship = self.childNode(withName: SpaceshipNodeName) {
      
      // create a photon torpedo sprite
      //let photon = SKSpriteNode(imageNamed: "picture_cosmic")
      //let photon2 = SKSpriteNode(imageNamed: "photon2")
      let photon = SKSpriteNode(imageNamed: "photon")

      
      photon.name = PhotonTorpedoName
      photon.position = ship.position
      photon.size = CGSize(width:10, height:20)
      
      //photon2.name = PhotonTorpedoName2
      //photon2.position = ship.position
      //photon2.size = CGSize(width:30, height:30)

     // photonSpiral.name = PhotonTorpedoName3
     // photonSpiral.position = ship.position
     //photonSpiral.size = CGSize(width:30, height:30)

      
      self.addChild(photon)

      //self.addChild(photon2)
      
      //self.addChild(photonSpiral)
      
      
      // Move the torpedo from its original position (ship.position)
      // past the upper edge of the screen over a half a second.
      // NOTE: the y-axis in SpriteKit is flipped back to normal.
      //        (0, 0) is the bottom-left corner  and scene height
      //        (self.size.height) is the top edge of the screen.
      //
      //  SKAction's are actions built into SpriteKit that we
      // can use to implement aimations and grouping, sequences,
      // and loooping...
      
      let fly = SKAction.moveBy(x: 0, y: self.size.height + photon.size.height, duration: 0.75)
      
      //let fly2 = SKAction.moveBy(x: CGFloat(incrementer), y: -self.size.height - photon2.size.height, duration: 1.0)

      // let fly = SKAction.moveBy(x: CGFloat(incrementer), y: CGFloat(incrementer2) * (self.size.height - photon.size.height), duration: 1.0)

      //let fly = SKAction.moveBy(x: CGFloat(xPosition), y: CGFloat(yPosition), duration: 1.0)
      
      // Run the fly action
      // photon.run(fly)
      
      // Remove the torpedo once it leaves the scene
      let remove = SKAction.removeFromParent()

      
      let fireAndRemove = SKAction.sequence([fly, remove])
      
      photon.run(fireAndRemove)

      self.run(self.shootSound)
      
      
    }
    
  }
  
  func spiralShoot() {
    
    if let ship = self.childNode(withName: SpaceshipNodeName) {

      let photon1 = SKSpriteNode(imageNamed: "picture_cosmic")
      let photon2 = SKSpriteNode(imageNamed: "picture_cosmic")
      let photon3 = SKSpriteNode(imageNamed: "picture_cosmic")
      let photon4 = SKSpriteNode(imageNamed: "picture_cosmic")
      let photon5 = SKSpriteNode(imageNamed: "picture_cosmic")
      let photon6 = SKSpriteNode(imageNamed: "picture_cosmic")
      let photon7 = SKSpriteNode(imageNamed: "picture_cosmic")
      let photon8 = SKSpriteNode(imageNamed: "picture_cosmic")
      
      photon1.name = SpiralTorpedoName
      photon1.position = ship.position
      photon1.size = CGSize(width:15, height:15)
      
      photon2.name = SpiralTorpedoName
      photon2.position = ship.position
      photon2.size = CGSize(width:15, height:15)
    
      photon3.name = SpiralTorpedoName
      photon3.position = ship.position
      photon3.size = CGSize(width:15, height:15)

      photon4.name = SpiralTorpedoName
      photon4.position = ship.position
      photon4.size = CGSize(width:15, height:15)
      
      photon5.name = SpiralTorpedoName
      photon5.position = ship.position
      photon5.size = CGSize(width:15, height:15)
      
      photon6.name = SpiralTorpedoName
      photon6.position = ship.position
      photon6.size = CGSize(width:15, height:15)
      
      photon7.name = SpiralTorpedoName
      photon7.position = ship.position
      photon7.size = CGSize(width:15, height:15)
      
      photon8.name = SpiralTorpedoName
      photon8.position = ship.position
      photon8.size = CGSize(width:15, height:15)
      
      self.addChild(photon1)
      self.addChild(photon2)
      self.addChild(photon3)
      self.addChild(photon4)
      self.addChild(photon5)
      self.addChild(photon6)
      self.addChild(photon7)
      self.addChild(photon8)
    
      xPosition1 = Int(CGFloat(cos(CGFloat(incrementer))) * (1.5 * self.size.height + photon2.size.height))
      yPosition1 = Int(CGFloat(sin(CGFloat(incrementer))) * (1.5 * self.size.height + photon2.size.height))
    
      xPosition2 = Int(CGFloat(cos(CGFloat(incrementer2))) * (1.5 * self.size.height + photon2.size.height))
      yPosition2 = Int(CGFloat(sin(CGFloat(incrementer2))) * (1.5 * self.size.height + photon2.size.height))

      xPosition3 = Int(CGFloat(cos(CGFloat(incrementer + Double(CGFloat.pi/4)))) * (1.5 * self.size.height + photon2.size.height))
      yPosition3 = Int(CGFloat(sin(CGFloat(incrementer + Double(CGFloat.pi/4)))) * (1.5 * self.size.height + photon2.size.height))
      
      xPosition4 = Int(CGFloat(cos(CGFloat(incrementer2 + Double(CGFloat.pi/4)))) * (1.5 * self.size.height + photon2.size.height))
      yPosition4 = Int(CGFloat(sin(CGFloat(incrementer2 + Double(CGFloat.pi/4)))) * (1.5 * self.size.height + photon2.size.height))

      
      if incrementer > Double(CGFloat(2.0) * CGFloat.pi) {
        incrementer = 0
      }
      
      if incrementer2 > Double(CGFloat(2.0) * CGFloat.pi) {
        incrementer2 = 0
      }
    
      incrementer += Double(CGFloat.pi / 32)
    
      incrementer2 += Double(CGFloat.pi / 32)
      
      let fly = SKAction.moveBy(x: CGFloat(xPosition1), y: CGFloat(yPosition1), duration: 1.0)
      let fly2 = SKAction.moveBy(x: CGFloat(-xPosition1), y: CGFloat(-yPosition1), duration: 1.0)
      let fly3 = SKAction.moveBy(x: CGFloat(xPosition2), y: CGFloat(yPosition2), duration: 1.0)
      let fly4 = SKAction.moveBy(x: CGFloat(-xPosition2), y: CGFloat(-yPosition2), duration: 1.0)
      let fly5 = SKAction.moveBy(x: CGFloat(xPosition3), y: CGFloat(yPosition3), duration: 1.0)
      let fly6 = SKAction.moveBy(x: CGFloat(-xPosition3), y: CGFloat(-yPosition3), duration: 1.0)
      let fly7 = SKAction.moveBy(x: CGFloat(xPosition4), y: CGFloat(yPosition4), duration: 1.0)
      let fly8 = SKAction.moveBy(x: CGFloat(-xPosition4), y: CGFloat(-yPosition4), duration: 1.0)
      
      let remove = SKAction.removeFromParent()

      let fireAndRemove1 = SKAction.sequence([fly, remove])
      let fireAndRemove2 = SKAction.sequence([fly2, remove])
      let fireAndRemove3 = SKAction.sequence([fly3, remove])
      let fireAndRemove4 = SKAction.sequence([fly4, remove])

      let fireAndRemove5 = SKAction.sequence([fly5, remove])
      let fireAndRemove6 = SKAction.sequence([fly6, remove])
      let fireAndRemove7 = SKAction.sequence([fly7, remove])
      let fireAndRemove8 = SKAction.sequence([fly8, remove])

      photon1.run(fireAndRemove1)
      photon2.run(fireAndRemove2)
      photon3.run(fireAndRemove3)
      photon4.run(fireAndRemove4)
      photon5.run(fireAndRemove5)
      photon6.run(fireAndRemove6)
      photon7.run(fireAndRemove7)
      photon8.run(fireAndRemove8)

      self.run(self.spiralSound)
    }
  }
  
  func spreader() {
    
    if let ship = self.childNode(withName: SpaceshipNodeName) {
      
      let spreader0 = SKSpriteNode(imageNamed: "spreader")
      let spreader1 = SKSpriteNode(imageNamed: "spreader")
      let spreader2 = SKSpriteNode(imageNamed: "spreader")
      let spreader3 = SKSpriteNode(imageNamed: "spreader")
      let spreader4 = SKSpriteNode(imageNamed: "spreader")
      let spreader5 = SKSpriteNode(imageNamed: "spreader")
      let spreader6 = SKSpriteNode(imageNamed: "spreader")
      let spreader7 = SKSpriteNode(imageNamed: "spreader")
      let spreader8 = SKSpriteNode(imageNamed: "spreader")

      let twoPie = 2 * CGFloat.pi
      if spreaderIncrementer > 3.1415 {
        spreaderIncrementer = 0.0
      }
      
      spreader0.name = SpreaderTorpedoName
      spreader0.position = ship.position
      spreader0.size = CGSize(width:10, height:10)
      
      spreader1.name = SpreaderTorpedoName
      spreader1.position = ship.position
      spreader1.size = CGSize(width:10, height:10)

      spreader2.name = SpreaderTorpedoName
      spreader2.position = ship.position
      spreader2.size = CGSize(width:10, height:10)

      spreader3.name = SpreaderTorpedoName
      spreader3.position = ship.position
      spreader3.size = CGSize(width:10, height:10)

      spreader4.name = SpreaderTorpedoName
      spreader4.position = ship.position
      spreader4.size = CGSize(width:10, height:10)

      spreader5.name = SpreaderTorpedoName
      spreader5.position = ship.position
      spreader5.size = CGSize(width:10, height:10)

      spreader6.name = SpreaderTorpedoName
      spreader6.position = ship.position
      spreader6.size = CGSize(width:10, height:10)

      spreader7.name = SpreaderTorpedoName
      spreader7.position = ship.position
      spreader7.size = CGSize(width:10, height:10)

      spreader8.name = SpreaderTorpedoName
      spreader8.position = ship.position
      spreader8.size = CGSize(width:10, height:10)

      
      self.addChild(spreader0)
      self.addChild(spreader1)
      self.addChild(spreader2)
      self.addChild(spreader3)
      self.addChild(spreader4)
      self.addChild(spreader5)
      self.addChild(spreader6)
      self.addChild(spreader7)
      self.addChild(spreader8)
      
      //self.addChild(photon2)
      
      //self.addChild(photonSpiral)
      
      
      let xPosition0 = CGFloat(CGFloat(cos(CGFloat(spreaderIncrementer))) * (1.5 * self.size.height + spreader0.size.height))
      let yPosition0 = CGFloat(CGFloat(sin(CGFloat(spreaderIncrementer))) * (1.5 * self.size.height + spreader0.size.height))
      
      spreaderIncrementer += Double(twoPie/16.0)

      let xPosition1 = CGFloat(CGFloat(cos(CGFloat(spreaderIncrementer))) * (1.5 * self.size.height + spreader1.size.height))
      let yPosition1 = CGFloat(CGFloat(sin(CGFloat(spreaderIncrementer))) * (1.5 * self.size.height + spreader1.size.height))
      
      spreaderIncrementer += Double(twoPie/16.0)

      let xPosition2 = CGFloat(CGFloat(cos(CGFloat(spreaderIncrementer))) * (1.5 * self.size.height + spreader2.size.height))
      let yPosition2 = CGFloat(CGFloat(sin(CGFloat(spreaderIncrementer))) * (1.5 * self.size.height + spreader2.size.height))
      
      spreaderIncrementer += Double(twoPie/16.0)

      let xPosition3 = CGFloat(CGFloat(cos(CGFloat(spreaderIncrementer))) * (1.5 * self.size.height + spreader3.size.height))
      let yPosition3 = CGFloat(CGFloat(sin(CGFloat(spreaderIncrementer))) * (1.5 * self.size.height + spreader3.size.height))
      
      spreaderIncrementer += Double(twoPie/16.0)

      let xPosition4 = CGFloat(CGFloat(cos(CGFloat(spreaderIncrementer))) * (1.5 * self.size.height + spreader4.size.height))
      let yPosition4 = CGFloat(CGFloat(sin(CGFloat(spreaderIncrementer))) * (1.5 * self.size.height + spreader4.size.height))
      
      spreaderIncrementer += Double(twoPie/16.0)

      let xPosition5 = CGFloat(CGFloat(cos(CGFloat(spreaderIncrementer))) * (1.5 * self.size.height + spreader5.size.height))
      let yPosition5 = CGFloat(CGFloat(sin(CGFloat(spreaderIncrementer))) * (1.5 * self.size.height + spreader5.size.height))
      
      spreaderIncrementer += Double(twoPie/16.0)

      let xPosition6 = CGFloat(CGFloat(cos(CGFloat(spreaderIncrementer))) * (1.5 * self.size.height + spreader6.size.height))
      let yPosition6 = CGFloat(CGFloat(sin(CGFloat(spreaderIncrementer))) * (1.5 * self.size.height + spreader6.size.height))
      
      spreaderIncrementer += Double(twoPie/16.0)

      let xPosition7 = CGFloat(CGFloat(cos(CGFloat(spreaderIncrementer))) * (1.5 * self.size.height + spreader7.size.height))
      let yPosition7 = CGFloat(CGFloat(sin(CGFloat(spreaderIncrementer))) * (1.5 * self.size.height + spreader7.size.height))
      
      spreaderIncrementer += Double(twoPie/16.0)

      let xPosition8 = CGFloat(CGFloat(cos(CGFloat(spreaderIncrementer))) * (1.5 * self.size.height + spreader8.size.height))
      let yPosition8 = CGFloat(CGFloat(sin(CGFloat(spreaderIncrementer))) * (1.5 * self.size.height + spreader8.size.height))

      
      let spreaderFly0 = SKAction.moveBy(x: CGFloat(xPosition0), y: CGFloat(yPosition0), duration: 1.0)
      let spreaderFly1 = SKAction.moveBy(x: CGFloat(xPosition1), y: CGFloat(yPosition1), duration: 1.0)
      let spreaderFly2 = SKAction.moveBy(x: CGFloat(xPosition2), y: CGFloat(yPosition2), duration: 1.0)
      let spreaderFly3 = SKAction.moveBy(x: CGFloat(xPosition3), y: CGFloat(yPosition3), duration: 1.0)
      let spreaderFly4 = SKAction.moveBy(x: CGFloat(xPosition4), y: CGFloat(yPosition4), duration: 1.0)
      let spreaderFly5 = SKAction.moveBy(x: CGFloat(xPosition5), y: CGFloat(yPosition5), duration: 1.0)
      let spreaderFly6 = SKAction.moveBy(x: CGFloat(xPosition6), y: CGFloat(yPosition6), duration: 1.0)
      let spreaderFly7 = SKAction.moveBy(x: CGFloat(xPosition7), y: CGFloat(yPosition7), duration: 1.0)
      let spreaderFly8 = SKAction.moveBy(x: CGFloat(xPosition8), y: CGFloat(yPosition8), duration: 1.0)

      let spreaderRemove0 = SKAction.removeFromParent()
      let spreaderRemove1 = SKAction.removeFromParent()
      let spreaderRemove2 = SKAction.removeFromParent()
      let spreaderRemove3 = SKAction.removeFromParent()
      let spreaderRemove4 = SKAction.removeFromParent()
      let spreaderRemove5 = SKAction.removeFromParent()
      let spreaderRemove6 = SKAction.removeFromParent()
      let spreaderRemove7 = SKAction.removeFromParent()
      let spreaderRemove8 = SKAction.removeFromParent()

      let spreaderFireAndRemove0 = SKAction.sequence([spreaderFly0, spreaderRemove0])
      let spreaderFireAndRemove1 = SKAction.sequence([spreaderFly1, spreaderRemove1])
      let spreaderFireAndRemove2 = SKAction.sequence([spreaderFly2, spreaderRemove2])
      let spreaderFireAndRemove3 = SKAction.sequence([spreaderFly3, spreaderRemove3])
      let spreaderFireAndRemove4 = SKAction.sequence([spreaderFly4, spreaderRemove4])
      let spreaderFireAndRemove5 = SKAction.sequence([spreaderFly5, spreaderRemove5])
      let spreaderFireAndRemove6 = SKAction.sequence([spreaderFly6, spreaderRemove6])
      let spreaderFireAndRemove7 = SKAction.sequence([spreaderFly7, spreaderRemove7])
      let spreaderFireAndRemove8 = SKAction.sequence([spreaderFly8, spreaderRemove8])

      spreader0.run(spreaderFireAndRemove0)
      spreader1.run(spreaderFireAndRemove1)
      spreader2.run(spreaderFireAndRemove2)
      spreader3.run(spreaderFireAndRemove3)
      spreader4.run(spreaderFireAndRemove4)
      spreader5.run(spreaderFireAndRemove5)
      spreader6.run(spreaderFireAndRemove6)
      spreader7.run(spreaderFireAndRemove7)
      spreader8.run(spreaderFireAndRemove8)
      
      self.run(self.spreaderSound)

    }
  }
  
  func waggleShoot() {
    
    if let ship = self.childNode(withName: SpaceshipNodeName) {
      
      let waggle1 = SKSpriteNode(imageNamed: "waggle_cosmic")
      let waggle2 = SKSpriteNode(imageNamed: "waggle_cosmic")
      let waggle3 = SKSpriteNode(imageNamed: "waggle_cosmic")

      
      waggle1.name = WaggleTorpedoName
      waggle1.position = ship.position
      waggle1.size = CGSize(width:15, height:15)
      
      waggle2.name = WaggleTorpedoName
      waggle2.position = ship.position
      waggle2.size = CGSize(width:15, height:15)

      waggle3.name = WaggleTorpedoName
      waggle3.position = ship.position
      waggle3.size = CGSize(width:15, height:15)

      
      self.addChild(waggle1)
      self.addChild(waggle2)
      self.addChild(waggle3)

      //self.addChild(photon2)
      
      //self.addChild(photonSpiral)
      
      xPosition1 = Int(CGFloat(cos(CGFloat(waggleIncrementer1))) * (1.5 * self.size.height + waggle1.size.height))
      yPosition1 = Int(self.size.height)
      
      xPosition2 = Int(CGFloat(cos(CGFloat(waggleIncrementer2))) * (1.5 * self.size.height + waggle2.size.height))
      yPosition2 = Int(self.size.height)

      xPosition3 = Int(CGFloat(cos(CGFloat(waggleIncrementer3))) * (1.5 * self.size.height + waggle3.size.height))
      yPosition3 = Int(self.size.height)

      
      if reverseWaggle1 == false {
        waggleIncrementer1 += Double(CGFloat.pi / 16)
      } else {
        waggleIncrementer1 -= Double(CGFloat.pi / 16)
      }
      
      if waggleIncrementer1 >= Double(CGFloat.pi + 0.005) {
          reverseWaggle1 = true
      }
      
      
      if reverseWaggle2 == false {
        waggleIncrementer2 += Double(CGFloat.pi / 16)
      } else {
        waggleIncrementer2 -= Double(CGFloat.pi / 16)
      }
      
      if waggleIncrementer2 >= Double(CGFloat.pi + 0.005) {
        reverseWaggle2 = true
      }
      
      
      if reverseWaggle3 == false {
        waggleIncrementer3 += Double(CGFloat.pi / 16)
      } else {
        waggleIncrementer3 -= Double(CGFloat.pi / 16)
      }
      
      if waggleIncrementer3 >= Double(CGFloat.pi + 0.005) {
        reverseWaggle3 = true
      }
      
      let fly1 = SKAction.moveBy(x: CGFloat(xPosition1), y: CGFloat(yPosition1), duration: 1.0)
      let fly2 = SKAction.moveBy(x: CGFloat(xPosition2), y: CGFloat(yPosition2), duration: 1.0)
      let fly3 = SKAction.moveBy(x: CGFloat(xPosition3), y: CGFloat(yPosition3), duration: 1.0)

      let remove = SKAction.removeFromParent()
      
      let fireAndRemove1 = SKAction.sequence([fly1, remove])
      let fireAndRemove2 = SKAction.sequence([fly2, remove])
      let fireAndRemove3 = SKAction.sequence([fly3, remove])

      waggle1.run(fireAndRemove1)
      waggle2.run(fireAndRemove2)
      waggle3.run(fireAndRemove3)

      self.run(self.waggleSound)

    }
  }
  
  //
  // Choose randomly when o drop a different type of obstacle or power up
  //
  
  func dropThing() {
    
    var dieRoll = arc4random_uniform(620)    // die value between 0 and 619
    let dieRoll2 = arc4random_uniform(3)
    var drop = false
    dieRoll = dieRoll + difficulty
    print("difficulty = \(difficulty)")
    print("dieRoll = \(dieRoll)")
    
    if dieRoll > 600 {
      drop = true
      if (dieRoll2 == 0){
        dropHealthPowerup()
        dropAsteroid()

      } else if (dieRoll2 == 1){
        dropWeaponsPowerUp()
        dropAsteroid()

      } else {
        dropAsteroid()

      }
    }
    
    if dieRoll > 612 && bossLevel > 3 {
      dropSpiralPowerUp()
    }
    
    if dieRoll > 650 && bossLevel > 5 {
      dropWagglePowerUp()
    }
    
    if dieRoll > 700 && bossLevel > 7 {
      dropSpreaderPowerUp()
    }
    
    if dieRoll > 750 && bossLevel > 9 {
      dropWeaponsPowerUp()
    }
    
    if dieRoll > 950 && bossLevel > 11 {
      dropLudacrispPowerUp()
    }
    
    if (drop){
      if(bossLevel == 1) {
        dropLevel1()
      }else if(bossLevel == 2) {
        dropLevel2()
      }else if(bossLevel == 3) {
        dropLevel3()
      }else if(bossLevel == 4) {
        dropLevel4()
      }else if(bossLevel == 5) {
        dropLevel5()
      }else if(bossLevel == 6) {
        dropLevel6()
      }else if(bossLevel == 7) {
        dropLevel7()
      }else if(bossLevel == 8) {
        dropLevel8()
      }else if(bossLevel == 9) {
        dropLevel9()
      }else if(bossLevel == 10) {
        dropLevel10()
      }else if(bossLevel == 11) {
        dropLevel11()
      }else if(bossLevel == 12) {
        dropLevel12()
      }else if(bossLevel == 13) {
        dropLevel13()
      }else if(bossLevel == 14) {
        dropLevel14()
      }else if(bossLevel == 15) {
        dropLevel15()
      }
    }
    
    
  }
  
  
  func dropBoss1() {
    // Define the asteroids size which will be a random number between 15 and 44 points
    
    let sideSize = Double(300.0)
    
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the asteroid
    let startX = Double(self.size.width/2)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    // Create our asteroid sprite and set its propterties
    let boss1 = SKSpriteNode(imageNamed: "boss1_cosmic")
    
    boss1.size = CGSize(width: sideSize, height: sideSize)
    boss1.position = CGPoint(x: startX, y: startY)
    
    boss1.name = Boss1NodeName
    
    self.addChild(boss1)
    
    
    // ending positions
    let endX1 = Double(self.size.width/2)
    
    let endX2 = Double(self.size.width/4)
    
    let endX3 = Double(3*self.size.width/4)
    
    let endY = Double(self.size.height/2)
    // Run some actions
    //
    // move our boss to a pretermined point
    let move1 = SKAction.move(to: CGPoint(x: endX1, y: endY), duration: Double(15))
    
    let move2 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(2.5))

    let move3 = SKAction.move(to: CGPoint(x: endX3, y: endY), duration: Double(5))
    
    let move4 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(5))
    
    let travel1 = SKAction.sequence([move1, move2])
    
    let travel2 = SKAction.sequence([move3, move4])
    
    let travel3 = SKAction.repeatForever(travel2)
    
    let totalTravel = SKAction.sequence([travel1, travel3])
    // As it is moving, rotate the asteroid by 3 radians ( just under 180 degrees)
    // over 1-3 seconds duration.
    
    boss1.run(totalTravel)
    
  }
  
  func dropBoss2() {
    // Define the asteroids size which will be a random number between 15 and 44 points
    
    let sideSize = Double(300.0)
    
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the asteroid
    let startX = Double(self.size.width/2)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    
    // Create our asteroid sprite and set its propterties
    let boss2 = SKSpriteNode(imageNamed: "boss2_cosmic")
    
    boss2.size = CGSize(width: sideSize, height: sideSize)
    boss2.position = CGPoint(x: startX, y: startY)
    
    boss2.name = Boss2NodeName
    
    self.addChild(boss2)
    
    // Run some actions
    //
    // move our asteroid to a randomly generated point over
    // a duration of 3-6 seconds
    // ending positions
    let endX1 = Double(self.size.width/2)
    
    let endX2 = Double(self.size.width/4)
    
    let endX3 = Double(3*self.size.width/4)
    
    let endY = Double(self.size.height/2)
    // Run some actions
    //
    // move our boss to a pretermined point
    let move1 = SKAction.move(to: CGPoint(x: endX1, y: endY), duration: Double(15))
    
    let move2 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(2.5))
    
    let move3 = SKAction.move(to: CGPoint(x: endX3, y: endY), duration: Double(5))
    
    let move4 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(5))
    
    let travel1 = SKAction.sequence([move1, move2])
    
    let travel2 = SKAction.sequence([move3, move4])
    
    let travel3 = SKAction.repeatForever(travel2)
    
    let totalTravel = SKAction.sequence([travel1, travel3])
    // As it is moving, rotate the asteroid by 3 radians ( just under 180 degrees)
    // over 1-3 seconds duration.
    
    boss2.run(totalTravel)
    
  }
  
  func dropBoss3() {
    // Define the asteroids size which will be a random number between 15 and 44 points
    
    let sideSize = Double(300.0)
    
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the asteroid
    let startX = Double(self.size.width/2)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    // Create our asteroid sprite and set its propterties
    let boss3 = SKSpriteNode(imageNamed: "boss3_cosmic")
    
    boss3.size = CGSize(width: sideSize, height: sideSize)
    boss3.position = CGPoint(x: startX, y: startY)
    
    boss3.name = Boss3NodeName
    
    self.addChild(boss3)
    
    // Run some actions
    //
    // move our asteroid to a randomly generated point over
    // a duration of 3-6 seconds
    let endX1 = Double(self.size.width/2)
    
    let endX2 = Double(self.size.width/4)
    
    let endX3 = Double(3*self.size.width/4)
    
    let endY = Double(self.size.height/2)
    // Run some actions
    //
    // move our boss to a pretermined point
    let move1 = SKAction.move(to: CGPoint(x: endX1, y: endY), duration: Double(15))
    
    let move2 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(2.5))
    
    let move3 = SKAction.move(to: CGPoint(x: endX3, y: endY), duration: Double(5))
    
    let move4 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(5))
    
    let travel1 = SKAction.sequence([move1, move2])
    
    let travel2 = SKAction.sequence([move3, move4])
    
    let travel3 = SKAction.repeatForever(travel2)
    
    let totalTravel = SKAction.sequence([travel1, travel3])
    
    // As it is moving, rotate the asteroid by 3 radians ( just under 180 degrees)
    // over 1-3 seconds duration.
    
    boss3.run(totalTravel)
    
  }
  
  func dropBoss4() {
    // Define the asteroids size which will be a random number between 15 and 44 points
    
    let sideSize = Double(300.0)
    
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the asteroid
    let startX = Double(self.size.width/2)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    // Create our asteroid sprite and set its propterties
    let boss4 = SKSpriteNode(imageNamed: "boss4_cosmic")
    
    boss4.size = CGSize(width: sideSize, height: (sideSize - 100))
    boss4.position = CGPoint(x: startX, y: startY)
    
    boss4.name = Boss4NodeName
    
    self.addChild(boss4)
    
    let endX1 = Double(self.size.width/2)
    
    let endX2 = Double(self.size.width/4)
    
    let endX3 = Double(3*self.size.width/4)
    
    let endY = Double(self.size.height/2)
    // Run some actions
    //
    // move our boss to a pretermined point
    let move1 = SKAction.move(to: CGPoint(x: endX1, y: endY), duration: Double(15))
    
    let move2 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(2.5))
    
    let move3 = SKAction.move(to: CGPoint(x: endX3, y: endY), duration: Double(5))
    
    let move4 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(5))
    
    let travel1 = SKAction.sequence([move1, move2])
    
    let travel2 = SKAction.sequence([move3, move4])
    
    let travel3 = SKAction.repeatForever(travel2)
    
    let totalTravel = SKAction.sequence([travel1, travel3])
    
    boss4.run(totalTravel)
    
  }
  
  func dropBoss5() {
    // Define the asteroids size which will be a random number between 15 and 44 points
    
    let sideSize = Double(300.0)
    
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the asteroid
    let startX = Double(self.size.width/2)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    // Create our asteroid sprite and set its propterties
    let boss5 = SKSpriteNode(imageNamed: "boss5_cosmic")
    
    boss5.size = CGSize(width: sideSize, height: sideSize)
    boss5.position = CGPoint(x: startX, y: startY)
    
    boss5.name = Boss5NodeName
    
    self.addChild(boss5)
    
    let endX1 = Double(self.size.width/2)
    
    let endX2 = Double(self.size.width/4)
    
    let endX3 = Double(3*self.size.width/4)
    
    let endY = Double(self.size.height/2)
    // Run some actions
    //
    // move our boss to a pretermined point
    let move1 = SKAction.move(to: CGPoint(x: endX1, y: endY), duration: Double(15))
    
    let move2 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(2.5))
    
    let move3 = SKAction.move(to: CGPoint(x: endX3, y: endY), duration: Double(5))
    
    let move4 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(5))
    
    let travel1 = SKAction.sequence([move1, move2])
    
    let travel2 = SKAction.sequence([move3, move4])
    
    let travel3 = SKAction.repeatForever(travel2)
    
    let totalTravel = SKAction.sequence([travel1, travel3])
    // As it is moving, rotate the asteroid by 3 radians ( just under 180 degrees)
    // over 1-3 seconds duration.
    
    boss5.run(totalTravel)
    
  }
  
  func dropBoss6() {
    // Define the asteroids size which will be a random number between 15 and 44 points
    
    let sideSize = Double(300.0)
    
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the asteroid
    let startX = Double(self.size.width/2)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    // Create our asteroid sprite and set its propterties
    let boss6 = SKSpriteNode(imageNamed: "boss6_cosmic")
    
    boss6.size = CGSize(width: sideSize, height: sideSize)
    boss6.position = CGPoint(x: startX, y: startY)
    
    boss6.name = Boss6NodeName
    
    self.addChild(boss6)
    
    let endX1 = Double(self.size.width/2)
    
    let endX2 = Double(self.size.width/4)
    
    let endX3 = Double(3*self.size.width/4)
    
    let endY = Double(self.size.height/2)
    // Run some actions
    //
    // move our boss to a pretermined point
    let move1 = SKAction.move(to: CGPoint(x: endX1, y: endY), duration: Double(15))
    
    let move2 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(2.5))
    
    let move3 = SKAction.move(to: CGPoint(x: endX3, y: endY), duration: Double(5))
    
    let move4 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(5))
    
    let travel1 = SKAction.sequence([move1, move2])
    
    let travel2 = SKAction.sequence([move3, move4])
    
    let travel3 = SKAction.repeatForever(travel2)
    
    let totalTravel = SKAction.sequence([travel1, travel3])    // As it is moving, rotate the asteroid by 3 radians ( just under 180 degrees)
    // over 1-3 seconds duration.
    
    boss6.run(totalTravel)
    
  }
  
  func dropBoss7() {
    // Define the asteroids size which will be a random number between 15 and 44 points
    
    let sideSize = Double(300.0)
    
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the asteroid
    let startX = Double(self.size.width/2)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    // Create our asteroid sprite and set its propterties
    let boss7 = SKSpriteNode(imageNamed: "boss7_cosmic")
    
    boss7.size = CGSize(width: sideSize, height: sideSize)
    boss7.position = CGPoint(x: startX, y: startY)
    
    boss7.name = Boss7NodeName
    
    self.addChild(boss7)
    
    let endX1 = Double(self.size.width/2)
    
    let endX2 = Double(self.size.width/4)
    
    let endX3 = Double(3*self.size.width/4)
    
    let endY = Double(self.size.height/2)
    // Run some actions
    //
    // move our boss to a pretermined point
    let move1 = SKAction.move(to: CGPoint(x: endX1, y: endY), duration: Double(15))
    
    let move2 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(2.5))
    
    let move3 = SKAction.move(to: CGPoint(x: endX3, y: endY), duration: Double(5))
    
    let move4 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(5))
    
    let travel1 = SKAction.sequence([move1, move2])
    
    let travel2 = SKAction.sequence([move3, move4])
    
    let travel3 = SKAction.repeatForever(travel2)
    
    let totalTravel = SKAction.sequence([travel1, travel3])
    // As it is moving, rotate the asteroid by 3 radians ( just under 180 degrees)
    // over 1-3 seconds duration.
    
    boss7.run(totalTravel)
    
  }
  
  func dropBoss8() {
    // Define the asteroids size which will be a random number between 15 and 44 points
    
    let sideSize = Double(300.0)
    
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the asteroid
    let startX = Double(self.size.width/2)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    // Create our asteroid sprite and set its propterties
    let boss8 = SKSpriteNode(imageNamed: "boss8_cosmic")
    
    boss8.size = CGSize(width: sideSize, height: sideSize)
    boss8.position = CGPoint(x: startX, y: startY)
    
    boss8.name = Boss8NodeName
    
    self.addChild(boss8)
    
    let endX1 = Double(self.size.width/2)
    
    let endX2 = Double(self.size.width/4)
    
    let endX3 = Double(3*self.size.width/4)
    
    let endY = Double(self.size.height/2)
    // Run some actions
    //
    // move our boss to a pretermined point
    let move1 = SKAction.move(to: CGPoint(x: endX1, y: endY), duration: Double(15))
    
    let move2 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(2.5))
    
    let move3 = SKAction.move(to: CGPoint(x: endX3, y: endY), duration: Double(5))
    
    let move4 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(5))
    
    let travel1 = SKAction.sequence([move1, move2])
    
    let travel2 = SKAction.sequence([move3, move4])
    
    let travel3 = SKAction.repeatForever(travel2)
    
    let totalTravel = SKAction.sequence([travel1, travel3])    // As it is moving, rotate the asteroid by 3 radians ( just under 180 degrees)
    // over 1-3 seconds duration.
    
    boss8.run(totalTravel)
    
  }
  
  func dropBoss9() {
    // Define the asteroids size which will be a random number between 15 and 44 points
    
    let sideSize = Double(300.0)
    
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the asteroid
    let startX = Double(self.size.width/2)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    // Create our asteroid sprite and set its propterties
    let boss9 = SKSpriteNode(imageNamed: "boss9_cosmic")
    
    boss9.size = CGSize(width: sideSize, height: sideSize)
    boss9.position = CGPoint(x: startX, y: startY)
    
    boss9.name = Boss9NodeName
    
    self.addChild(boss9)
    
    let endX1 = Double(self.size.width/2)
    
    let endX2 = Double(self.size.width/4)
    
    let endX3 = Double(3*self.size.width/4)
    
    let endY = Double(self.size.height/2)
    // Run some actions
    //
    // move our boss to a pretermined point
    let move1 = SKAction.move(to: CGPoint(x: endX1, y: endY), duration: Double(15))
    
    let move2 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(2.5))
    
    let move3 = SKAction.move(to: CGPoint(x: endX3, y: endY), duration: Double(5))
    
    let move4 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(5))
    
    let travel1 = SKAction.sequence([move1, move2])
    
    let travel2 = SKAction.sequence([move3, move4])
    
    let travel3 = SKAction.repeatForever(travel2)
    
    let totalTravel = SKAction.sequence([travel1, travel3])
    // As it is moving, rotate the asteroid by 3 radians ( just under 180 degrees)
    // over 1-3 seconds duration.
    
    boss9.run(totalTravel)
    
  }
  
  func dropBoss10() {
    // Define the asteroids size which will be a random number between 15 and 44 points
    
    let sideSize = Double(300.0)
    
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the asteroid
    let startX = Double(self.size.width/2)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    // Create our asteroid sprite and set its propterties
    let boss10 = SKSpriteNode(imageNamed: "boss10_cosmic")
    
    boss10.size = CGSize(width: sideSize, height: sideSize)
    boss10.position = CGPoint(x: startX, y: startY)
    
    boss10.name = Boss10NodeName
    
    self.addChild(boss10)
    
    let endX1 = Double(self.size.width/2)
    
    let endX2 = Double(self.size.width/4)
    
    let endX3 = Double(3*self.size.width/4)
    
    let endY = Double(self.size.height/2)
    // Run some actions
    //
    // move our boss to a pretermined point
    let move1 = SKAction.move(to: CGPoint(x: endX1, y: endY), duration: Double(15))
    
    let move2 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(2.5))
    
    let move3 = SKAction.move(to: CGPoint(x: endX3, y: endY), duration: Double(5))
    
    let move4 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(5))
    
    let travel1 = SKAction.sequence([move1, move2])
    
    let travel2 = SKAction.sequence([move3, move4])
    
    let travel3 = SKAction.repeatForever(travel2)
    
    let totalTravel = SKAction.sequence([travel1, travel3])
    // As it is moving, rotate the asteroid by 3 radians ( just under 180 degrees)
    // over 1-3 seconds duration.
    
    boss10.run(totalTravel)
    
  }
  
  func dropBoss11() {
    // Define the asteroids size which will be a random number between 15 and 44 points
    
    let sideSize = Double(300.0)
    
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the asteroid
    let startX = Double(self.size.width/2)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    
    // Create our asteroid sprite and set its propterties
    let boss11 = SKSpriteNode(imageNamed: "boss11_cosmic")
    
    boss11.size = CGSize(width: sideSize, height: sideSize)
    boss11.position = CGPoint(x: startX, y: startY)
    
    boss11.name = Boss11NodeName
    
    self.addChild(boss11)
    
    let endX1 = Double(self.size.width/2)
    
    let endX2 = Double(self.size.width/4)
    
    let endX3 = Double(3*self.size.width/4)
    
    let endY = Double(self.size.height/2)
    // Run some actions
    //
    // move our boss to a pretermined point
    let move1 = SKAction.move(to: CGPoint(x: endX1, y: endY), duration: Double(15))
    
    let move2 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(2.5))
    
    let move3 = SKAction.move(to: CGPoint(x: endX3, y: endY), duration: Double(5))
    
    let move4 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(5))
    
    let travel1 = SKAction.sequence([move1, move2])
    
    let travel2 = SKAction.sequence([move3, move4])
    
    let travel3 = SKAction.repeatForever(travel2)
    
    let totalTravel = SKAction.sequence([travel1, travel3])
    // As it is moving, rotate the asteroid by 3 radians ( just under 180 degrees)
    // over 1-3 seconds duration.
    
    boss11.run(totalTravel)
    
  }
  
  func dropBoss12() {
    // Define the asteroids size which will be a random number between 15 and 44 points
    
    let sideSize = Double(300.0)
    
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the asteroid
    let startX = Double(self.size.width/2)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    // Create our asteroid sprite and set its propterties
    let boss12 = SKSpriteNode(imageNamed: "boss12_cosmic")
    
    boss12.size = CGSize(width: sideSize, height: sideSize)
    boss12.position = CGPoint(x: startX, y: startY)
    
    boss12.name = Boss12NodeName
    
    self.addChild(boss12)
    
    let endX1 = Double(self.size.width/2)
    
    let endX2 = Double(self.size.width/4)
    
    let endX3 = Double(3*self.size.width/4)
    
    let endY = Double(self.size.height/2)
    // Run some actions
    //
    // move our boss to a pretermined point
    let move1 = SKAction.move(to: CGPoint(x: endX1, y: endY), duration: Double(15))
    
    let move2 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(2.5))
    
    let move3 = SKAction.move(to: CGPoint(x: endX3, y: endY), duration: Double(5))
    
    let move4 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(5))
    
    let travel1 = SKAction.sequence([move1, move2])
    
    let travel2 = SKAction.sequence([move3, move4])
    
    let travel3 = SKAction.repeatForever(travel2)
    
    let totalTravel = SKAction.sequence([travel1, travel3])
    // As it is moving, rotate the asteroid by 3 radians ( just under 180 degrees)
    // over 1-3 seconds duration.
    
    boss12.run(totalTravel)
    
  }
  
  func dropBoss13() {
    // Define the asteroids size which will be a random number between 15 and 44 points
    
    let sideSize = Double(300.0)
    
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the asteroid
    let startX = Double(self.size.width/2)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    // Create our asteroid sprite and set its propterties
    let boss13 = SKSpriteNode(imageNamed: "boss13_cosmic")
    
    boss13.size = CGSize(width: sideSize, height: sideSize)
    boss13.position = CGPoint(x: startX, y: startY)
    
    boss13.name = Boss13NodeName
    
    self.addChild(boss13)
    
    let endX1 = Double(self.size.width/2)
    
    let endX2 = Double(self.size.width/4)
    
    let endX3 = Double(3*self.size.width/4)
    
    let endY = Double(self.size.height/2)
    // Run some actions
    //
    // move our boss to a pretermined point
    let move1 = SKAction.move(to: CGPoint(x: endX1, y: endY), duration: Double(15))
    
    let move2 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(2.5))
    
    let move3 = SKAction.move(to: CGPoint(x: endX3, y: endY), duration: Double(5))
    
    let move4 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(5))
    
    let travel1 = SKAction.sequence([move1, move2])
    
    let travel2 = SKAction.sequence([move3, move4])
    
    let travel3 = SKAction.repeatForever(travel2)
    
    let totalTravel = SKAction.sequence([travel1, travel3])
    // As it is moving, rotate the asteroid by 3 radians ( just under 180 degrees)
    // over 1-3 seconds duration.
    
    boss13.run(totalTravel)
    
  }
  
  func dropBoss14() {
    // Define the asteroids size which will be a random number between 15 and 44 points
    
    let sideSize = Double(300.0)
    
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the asteroid
    let startX = Double(self.size.width/2)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    // Create our asteroid sprite and set its propterties
    let boss14 = SKSpriteNode(imageNamed: "boss14_cosmic")
    
    boss14.size = CGSize(width: sideSize, height: sideSize)
    boss14.position = CGPoint(x: startX, y: startY)
    
    boss14.name = Boss14NodeName
    
    self.addChild(boss14)
    
    let endX1 = Double(self.size.width/2)
    
    let endX2 = Double(self.size.width/4)
    
    let endX3 = Double(3*self.size.width/4)
    
    let endY = Double(self.size.height/2)
    // Run some actions
    //
    // move our boss to a pretermined point
    let move1 = SKAction.move(to: CGPoint(x: endX1, y: endY), duration: Double(15))
    
    let move2 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(2.5))
    
    let move3 = SKAction.move(to: CGPoint(x: endX3, y: endY), duration: Double(5))
    
    let move4 = SKAction.move(to: CGPoint(x: endX2, y: endY), duration: Double(5))
    
    let travel1 = SKAction.sequence([move1, move2])
    
    let travel2 = SKAction.sequence([move3, move4])
    
    let travel3 = SKAction.repeatForever(travel2)
    
    let totalTravel = SKAction.sequence([travel1, travel3])
    // As it is moving, rotate the asteroid by 3 radians ( just under 180 degrees)
    // over 1-3 seconds duration.
    
    boss14.run(totalTravel)
    
  }
  
  //
  // Drop a powerup sprite which spins and moves from top to bottom
  // 
  func dropWeaponsPowerUp() {
    
    let sideSize = 30.0
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the power up
    let startX = Double(arc4random_uniform(uint(self.size.width - 60)) + 30)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    // Create our power-up sprite and set its propterties
    let powerUp = SKSpriteNode(imageNamed: "powerup")
    
    powerUp.size = CGSize(width: sideSize, height: sideSize)
    powerUp.position = CGPoint(x: startX, y: startY)
    
    powerUp.name = PowerupNodeName
    
    self.addChild(powerUp)
    
    // Set up powerUp ship movement
    let powerUpPath = curveMeisterEnemyPath()
    
    let followPath = SKAction.follow(powerUpPath, asOffset: true, orientToPath: false, duration: 9.0)
    
    powerUp.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    
    
  }
  
  
  
  //
  // Drop a powerup sprite which spins and moves from top to bottom
  //
  func dropLudacrispPowerUp() {
    
    let sideSize = 30.0
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the power up
    let startX = Double(arc4random_uniform(uint(self.size.width - 60)) + 30)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    // Create our power-up sprite and set its propterties
    let powerUp = SKSpriteNode(imageNamed: "ludacrispPowerup")
    
    powerUp.size = CGSize(width: sideSize, height: sideSize)
    powerUp.position = CGPoint(x: startX, y: startY)
    
    powerUp.name = LudacrispPowerupNodeName
    
    self.addChild(powerUp)
    
    // Set up powerUp ship movement
    let powerUpPath = curveMeisterEnemyPath()
    
    let followPath = SKAction.follow(powerUpPath, asOffset: true, orientToPath: false, duration: 6.0)
    
    powerUp.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    
    
  }

  
  func dropSpreaderPowerUp() {
    
    let sideSize = 30.0
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the power up
    let startX = Double(arc4random_uniform(uint(self.size.width - 60)) + 30)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    // Create our power-up sprite and set its propterties
    let powerUp = SKSpriteNode(imageNamed: "spreaderPowerup")
    
    powerUp.size = CGSize(width: sideSize, height: sideSize)
    powerUp.position = CGPoint(x: startX, y: startY)
    
    powerUp.name = SpreaderPowerupNodeName
    
    self.addChild(powerUp)
    
    // Set up powerUp ship movement
    let powerUpPath = curveMeisterEnemyPath()
    
    let followPath = SKAction.follow(powerUpPath, asOffset: true, orientToPath: false, duration: 9.0)
    
    powerUp.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    
    
  }
  
  func dropWagglePowerUp() {
    
    let sideSize = 30.0
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the power up
    let startX = Double(arc4random_uniform(uint(self.size.width - 60)) + 30)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    // Create our power-up sprite and set its propterties
    let powerUp = SKSpriteNode(imageNamed: "wagglePowerup")
    
    powerUp.size = CGSize(width: sideSize, height: sideSize)
    powerUp.position = CGPoint(x: startX, y: startY)
    
    powerUp.name = WagglePowerupNodeName
    
    self.addChild(powerUp)
    
    // Set up powerUp ship movement
    let powerUpPath = curveMeisterEnemyPath()
    
    let followPath = SKAction.follow(powerUpPath, asOffset: true, orientToPath: false, duration: 9.0)
    
    powerUp.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    
    
  }

  func dropSpiralPowerUp() {
    
    let sideSize = 30.0
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the power up
    let startX = Double(arc4random_uniform(uint(self.size.width - 60)) + 30)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    // Create our power-up sprite and set its propterties
    let powerUp = SKSpriteNode(imageNamed: "spiralPowerup")
    
    powerUp.size = CGSize(width: sideSize, height: sideSize)
    powerUp.position = CGPoint(x: startX, y: startY)
    
    powerUp.name = SpiralPowerupNodeName
    
    self.addChild(powerUp)
    
    // Set up powerUp ship movement
    let powerUpPath = curveMeisterEnemyPath()
    
    let followPath = SKAction.follow(powerUpPath, asOffset: true, orientToPath: false, duration: 9.0)
    
    powerUp.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    
    
  }
  
  func dropHealthPowerup() {
    
    let sideSize = 20.0
    
    // Determine the starting x-position for the power up
    let startX = Double(arc4random_uniform(uint(self.size.width - 60)) + 30)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    // Create our power-up sprite and set its propterties
    let powerUp = SKSpriteNode(imageNamed: "healthPowerUp")
    
    powerUp.size = CGSize(width: sideSize, height: sideSize)
    powerUp.position = CGPoint(x: startX, y: startY)
    
    powerUp.name = HealthPowerupNodeName
    
    self.addChild(powerUp)
    
    // Set up powerUp movement
    
    let fly = SKAction.moveBy(x: 0, y: -self.size.height - CGFloat(sideSize), duration: 5)
    
    let fade = SKAction.fadeAlpha(to: 0, duration: 5)
    
    let scale = SKAction.scale(to: 0.5, duration: 5)
    
    let remove = SKAction.removeFromParent()

    let group = SKAction.group([fly, fade, scale])
    
    let sequence = SKAction.sequence([group, remove])
    
    
    powerUp.run(sequence)
  }
  
  //
  // Drop an asteroid from above the top edge of the screen some percentage of the time
  
  func dropAsteroid() {
    
    // Define the asteroids size which will be a random number between 15 and 44 points
    
    let sideSize = Double(arc4random_uniform(100) + 15)
    
    // Maximum x-value for the scene
    let maxX = Double(self.size.width)
    let quarterX = maxX / 4.0
    
    let randRange = UInt32(maxX + (quarterX * 2))
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the asteroid
    let startX = Double(arc4random_uniform(randRange)) - quarterX
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize

    // Random ending x-position
    let endX = Double(arc4random_uniform(UInt32(maxX)))
    
    let endY = 0.0 - sideSize
    
    // Create our asteroid sprite and set its propterties
    let asteroid = SKSpriteNode(imageNamed: "moon_cosmic")
    
    asteroid.size = CGSize(width: sideSize, height: sideSize)
    asteroid.position = CGPoint(x: startX, y: startY)
    
    asteroid.name = ObstacleNodeName
    
    self.addChild(asteroid)
    
    // Run some actions
    //
    // move our asteroid to a randomly generated point over
    // a duration of 3-6 seconds
    let move = SKAction.move(to: CGPoint(x: endX, y: endY), duration: Double(arc4random_uniform(4) + 3))
    
    let remove = SKAction.removeFromParent()
    
    let travelAndRemove = SKAction.sequence([move, remove])
    
    // As it is moving, rotate the asteroid by 3 radians ( just under 180 degrees)
    // over 1-3 seconds duration.
    let spin = SKAction.rotate(byAngle: 3, duration: Double(arc4random_uniform(3) + 1))
    
    let spinForever = SKAction.repeatForever(spin)
    
    let groupAction = SKAction.group([spinForever, travelAndRemove])
    
    asteroid.run(groupAction)
    
    
  }
  
  func spawnEnemy(atPoint spawnPoint:CGPoint){
    
    let enemy = getEnemy()
    
    enemy.position = spawnPoint
    
    addChild(enemy)
    
    //moving action
    let shipPath = curveMeisterEnemyPath()

    let followPath = SKAction.follow(shipPath, asOffset: true, orientToPath: true, duration: 9.0)

    let remove = SKAction.removeFromParent()
    
    let sequence = SKAction.sequence([followPath, remove])
    
    enemy.run(sequence, withKey: "moving")
  }
  
  func getEnemy()->SKSpriteNode{
    
    let sideSize = 40.0
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the asteroid
    let startX = Double(arc4random_uniform(uint(self.size.width - 40)) + 20)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    // Create our asteroid sprite and set its propterties
    let enemy = SKSpriteNode(imageNamed: "enemy3")
    
    enemy.size = CGSize(width: sideSize, height: sideSize)
    enemy.position = CGPoint(x: startX, y: startY)
    
    enemy.name = ObstacleNodeName
    
    return enemy
  }
  
  func startSpawningEnemies(){
    
    if action(forKey: "spawning") == nil {
      
      let sideSize = 40.0

      let startX = Double(arc4random_uniform(uint(self.size.width - 40)) + 20)
      
      // Starting y-position should be above the top edge of the scene
      let startY = Double(self.size.height) + sideSize

      let spawnPoint = CGPoint(x: startX, y: startY)
      
      let wait = SKAction.wait(forDuration: 0.3)
      
      let spawn = SKAction.run({[unowned self] in

        self.spawnEnemy(atPoint: spawnPoint)
      })
      
      let sequence = SKAction.sequence([spawn,wait])
      
      run(SKAction.repeat(sequence, count: 5))
    }
  }
  
  //
  // Drop an enemy ship onto the ship
  
  func dropLevel1() {

    let dieRoll = arc4random_uniform(60)    // die value between 0 and 59

    if dieRoll < 10 {
      dropEnemyShip10()
    }else if dieRoll < 30 {
      dropEnemyShip9()
    }else {
      dropEnemyShip17()
    }

  }
  
  
  func dropLevel2() {
    
    let dieRoll = arc4random_uniform(60)    // die value between 0 and 59
    
    if dieRoll < 10 {
      dropEnemyShip4()
    }else if dieRoll < 30 {
      dropEnemyShip5()
    }else {
      dropEnemyShip18()
    }
    
  }
  
  func dropLevel3() {
    
    let dieRoll = arc4random_uniform(60)    // die value between 0 and 59
    
    if dieRoll < 10 {
      dropEnemyShip7()
    }else if dieRoll < 30 {
      dropEnemyShip8()
    }else {
      dropEnemyShip9()
    }
    
  }
  
  func dropLevel4() {
    
    let dieRoll = arc4random_uniform(60)    // die value between 0 and 59
    
    if dieRoll < 10 {
      dropEnemyShip10()
    }else if dieRoll < 30 {
      dropEnemyShip11()
    }else {
      dropEnemyShip12()
    }
    
  }
  
  func dropLevel5() {
    
    let dieRoll = arc4random_uniform(60)    // die value between 0 and 59
    
    if dieRoll < 10 {
      dropEnemyShip13()
    }else if dieRoll < 30 {
      dropEnemyShip14()
    }else {
      dropEnemyShip15()
    }
    
  }
  
  func dropLevel6() {
    
    let dieRoll = arc4random_uniform(60)    // die value between 0 and 59
    
    if dieRoll < 10 {
      dropEnemyShip16()
    }else if dieRoll < 30 {
      dropEnemyShip1()
    }else {
      dropEnemyShip5()
    }
    
  }
  
  func dropLevel7() {
    
    let dieRoll = arc4random_uniform(60)    // die value between 0 and 59
    
    if dieRoll < 10 {
      dropEnemyShip2()
    }else if dieRoll < 30 {
      dropEnemyShip6()
    }else {
      dropEnemyShip9()
    }
    
  }
  
  func dropLevel8() {
    
    let dieRoll = arc4random_uniform(60)    // die value between 0 and 59
    
    if dieRoll < 10 {
      dropEnemyShip3()
    }else if dieRoll < 30 {
      dropEnemyShip7()
    }else {
      dropEnemyShip10()
    }
    
  }
  
  func dropLevel9() {
    
    let dieRoll = arc4random_uniform(60)    // die value between 0 and 59
    
    if dieRoll < 10 {
      dropEnemyShip4()
    }else if dieRoll < 30 {
      dropEnemyShip8()
    }else {
      dropEnemyShip11()
    }
    
  }
  
  func dropLevel10() {
    
    let dieRoll = arc4random_uniform(60)    // die value between 0 and 59
    
    if dieRoll < 10 {
      dropEnemyShip5()
    }else if dieRoll < 30 {
      dropEnemyShip9()
    }else {
      dropEnemyShip12()
    }
    
  }
  
  func dropLevel11() {
    
    let dieRoll = arc4random_uniform(60)    // die value between 0 and 59
    
    if dieRoll < 10 {
      dropEnemyShip6()
    }else if dieRoll < 30 {
      dropEnemyShip10()
    }else {
      dropEnemyShip13()
    }
    
  }
  
  func dropLevel12() {
    
    let dieRoll = arc4random_uniform(60)    // die value between 0 and 59
    
    if dieRoll < 10 {
      dropEnemyShip7()
    }else if dieRoll < 30 {
      dropEnemyShip11()
    }else {
      dropEnemyShip14()
    }
    
  }
  
  func dropLevel13() {
    
    let dieRoll = arc4random_uniform(60)    // die value between 0 and 59
    
    if dieRoll < 10 {
      dropEnemyShip8()
    }else if dieRoll < 30 {
      dropEnemyShip12()
    }else {
      dropEnemyShip15()
    }
    
  }
  
  func dropLevel14() {
    
    let dieRoll = arc4random_uniform(60)    // die value between 0 and 59
    
    if dieRoll < 10 {
      dropEnemyShip1()
    }else if dieRoll < 30 {
      dropEnemyShip2()
    }else {
      dropEnemyShip1()
    }
    
  }
  
  func dropLevel15() {
    
    let dieRoll = arc4random_uniform(80)    // die value between 0 and 59
    
    if dieRoll < 5 {
      dropEnemyShip1()
    }else if dieRoll < 10 {
      dropEnemyShip2()
    }else if dieRoll < 15 {
      dropEnemyShip3()
    }else if dieRoll < 20 {
      dropEnemyShip4()
    }else if dieRoll < 25 {
      dropEnemyShip5()
    }else if dieRoll < 30 {
      dropEnemyShip6()
    }else if dieRoll < 35 {
      dropEnemyShip7()
    }else if dieRoll < 40 {
      dropEnemyShip8()
    }else if dieRoll < 45 {
      dropEnemyShip9()
    }else if dieRoll < 50 {
      dropEnemyShip10()
    }else if dieRoll < 55 {
      dropEnemyShip11()
    }else if dieRoll < 60 {
      dropEnemyShip12()
    }else if dieRoll < 65 {
      dropEnemyShip13()
    }else if dieRoll < 70 {
      dropEnemyShip14()
    }else if dieRoll < 75 {
      dropEnemyShip15()
    }else {
      dropRandomBoss()
    }
    
  }
  
  func dropRandomBoss() {
    let dieRoll = arc4random_uniform(70)

    if dieRoll < 5 {
      dropBoss1()
    }else if dieRoll < 10 {
      dropBoss2()
    }else if dieRoll < 15 {
      dropBoss3()
    }else if dieRoll < 20 {
      dropBoss4()
    }else if dieRoll < 25 {
      dropBoss5()
    }else if dieRoll < 30 {
      dropBoss6()
    }else if dieRoll < 35 {
      dropBoss7()
    }else if dieRoll < 40 {
      dropBoss8()
    }else if dieRoll < 45 {
      dropBoss9()
    }else if dieRoll < 50 {
      dropBoss10()
    }else if dieRoll < 55 {
      dropBoss11()
    }else if dieRoll < 60 {
      dropBoss12()
    }else if dieRoll < 65 {
      dropBoss13()
    }else if dieRoll < 70 {
      dropBoss14()
    }else {
    }
  }
  
  func dropEnemyShip1() {
    
      let sideSize = 60.0
      
      // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
      // Determine the starting x-position for the asteroid
      let startX = Double(arc4random_uniform(uint(self.size.width - 40)) + 20)
      
      // Starting y-position should be above the top edge of the scene
      let startY = Double(self.size.height) + sideSize
      
      // Create our asteroid sprite and set its propterties
      let enemy1 = SKSpriteNode(imageNamed: "enemy1")
      let enemy2 = SKSpriteNode(imageNamed: "enemy1")
      let enemy3 = SKSpriteNode(imageNamed: "enemy1")
      let enemy4 = SKSpriteNode(imageNamed: "enemy1")
      let enemy5 = SKSpriteNode(imageNamed: "enemy1")
    
      enemy1.size = CGSize(width: 40, height: (sideSize - 20))
      enemy1.position = CGPoint(x: startX, y: startY + (0 * sideSize))
      enemy2.size = CGSize(width: 40, height: (sideSize - 20))
      enemy2.position = CGPoint(x: startX, y: startY + (1 * sideSize))
      enemy3.size = CGSize(width: 40, height: (sideSize - 20))
      enemy3.position = CGPoint(x: startX, y: startY + (2 * sideSize))
      enemy4.size = CGSize(width: 40, height: (sideSize - 20))
      enemy4.position = CGPoint(x: startX, y: startY + (3 * sideSize))
      enemy5.size = CGSize(width: 40, height: (sideSize - 20))
      enemy5.position = CGPoint(x: startX, y: startY + (4 * sideSize))

      enemy1.name = ObstacleNodeName
      enemy2.name = ObstacleNodeName
      enemy3.name = ObstacleNodeName
      enemy4.name = ObstacleNodeName
      enemy5.name = ObstacleNodeName

      self.addChild(enemy1)
      self.addChild(enemy2)
      self.addChild(enemy3)
      self.addChild(enemy4)
      self.addChild(enemy5)

      // Set up enemy ship movement
      //
      // We want the enemy ship to follow a curved flight path (Bezier curve) which uses control point to define how the curvature of teh path is formed. The following method will create and return that path.
      let shipPath = curveMeisterEnemyPath7()
      
      // Add SKActions to make the enemy ship fly
      //
      // asOffset parameter:
      // if set to true, lets us treate the actual point values of the path as offsets from the enemy ship's starting point VS them being treated as absolute positions on the screen if this parameter is set to false.
      //
      // the orientToPath parameter:
      // if true, causes the enemy ship to turn and face the direction of the path automatically.
      let followPath = SKAction.follow(shipPath, asOffset: true, orientToPath: true, duration: 9.0)
      
      enemy1.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
      enemy2.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
      enemy3.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
      enemy4.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
      enemy5.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))

    }
  
    func dropEnemyShip2() {
      let sideSize = 60.0
      let startX = Double(arc4random_uniform(uint(self.size.width - 40)) + 20)
      let startY = Double(self.size.height) + sideSize
      let enemy1 = SKSpriteNode(imageNamed: "enemy2")
      let enemy2 = SKSpriteNode(imageNamed: "enemy2")
      let enemy3 = SKSpriteNode(imageNamed: "enemy2")
      let enemy4 = SKSpriteNode(imageNamed: "enemy2")
      let enemy5 = SKSpriteNode(imageNamed: "enemy2")
      let enemy6 = SKSpriteNode(imageNamed: "enemy2")

      enemy1.size = CGSize(width: sideSize, height: sideSize)
      enemy1.position = CGPoint(x: startX + (0 * sideSize), y: startY)
      enemy2.size = CGSize(width: sideSize, height: sideSize)
      enemy2.position = CGPoint(x: startX + (1 * sideSize), y: startY)
      enemy3.size = CGSize(width: sideSize, height: sideSize)
      enemy3.position = CGPoint(x: startX + (2 * sideSize), y: startY)
      enemy4.size = CGSize(width: sideSize, height: sideSize)
      enemy4.position = CGPoint(x: startX + (3 * sideSize), y: startY)
      enemy5.size = CGSize(width: sideSize, height: sideSize)
      enemy5.position = CGPoint(x: startX + (4 * sideSize), y: startY)
      enemy6.size = CGSize(width: sideSize, height: sideSize)
      enemy6.position = CGPoint(x: startX + (5 * sideSize), y: startY)

      enemy1.name = ObstacleNodeName
      enemy2.name = ObstacleNodeName
      enemy3.name = ObstacleNodeName
      enemy4.name = ObstacleNodeName
      enemy5.name = ObstacleNodeName
      enemy6.name = ObstacleNodeName

      self.addChild(enemy1)
      self.addChild(enemy2)
      self.addChild(enemy3)
      self.addChild(enemy4)
      self.addChild(enemy5)
      self.addChild(enemy6)

      let shipPath = curveMeisterEnemyPath5()
      let followPath = SKAction.follow(shipPath, asOffset: true, orientToPath: true, duration: 9.0)
      
      enemy1.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
      enemy2.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
      enemy3.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
      enemy4.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
      enemy5.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
      enemy6.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))

    }
  
  func dropEnemyShip3() {
      startSpawningEnemies()
    }
  
  func dropEnemyShip4() {

      let timer = SKAction.wait(forDuration: 0.5)

      let enemy4Spawn = SKAction.run {
      let sideSize = 40.0
      let startX = Double(arc4random_uniform(uint(self.size.width - 40)) + 20)
      let startY = Double(self.size.height) + sideSize
      let enemy = SKSpriteNode(imageNamed: "enemy4")
        
      enemy.size = CGSize(width: sideSize, height: sideSize)
      enemy.position = CGPoint(x: startX, y: startY)
      enemy.name = self.ObstacleNodeName
      
      self.addChild(enemy)
      
      let shipPath = self.curveMeisterEnemyPath2()
      let followPath = SKAction.follow(shipPath, asOffset: true, orientToPath: true, duration: 9.0)
      
      enemy.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
        
      }
      
      let sequence = SKAction.sequence([timer, enemy4Spawn])
      
      self.run(SKAction.repeat(sequence, count: 5))
      
    }
  
  func dropEnemyShip5() {
      let sideSize = 60.0
      let startX = Double(arc4random_uniform(uint(self.size.width - 40)) + 20)
      let startY = Double(self.size.height) + sideSize
      let enemy = SKSpriteNode(imageNamed: "enemy5")
      
      enemy.size = CGSize(width: sideSize, height: sideSize)
      enemy.position = CGPoint(x: startX, y: startY)
      
      enemy.name = ObstacleNodeName
      
      self.addChild(enemy)
      
      let shipPath = curveMeisterEnemyPath2()
      let followPath = SKAction.follow(shipPath, asOffset: true, orientToPath: false, duration: 9.0)
      let spin = SKAction.rotate(byAngle: 9, duration: Double(arc4random_uniform(3) + 1))
      let spinForever = SKAction.repeatForever(spin)
      let remove = SKAction.removeFromParent()
      let followAndRemove = SKAction.sequence([followPath, remove])
      let actions = SKAction.group([spinForever, followAndRemove])
    
      enemy.run(actions)
    
    }
  
  func dropEnemyShip6() {
      let sideSize = 40.0
      let startX = Double(arc4random_uniform(uint(self.size.width - 40)) + 20)
      let startY = Double(self.size.height) + sideSize
      let enemy = SKSpriteNode(imageNamed: "enemy6")
      
      enemy.size = CGSize(width: sideSize, height: sideSize)
      enemy.position = CGPoint(x: startX, y: startY)
      
      enemy.name = ObstacleNodeName
      
      self.addChild(enemy)
      
      let shipPath = curveMeisterEnemyPath2()
      let followPath = SKAction.follow(shipPath, asOffset: true, orientToPath: true, duration: 9.0)
      
      enemy.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    }
  func dropEnemyShip7() {
      let sideSize = 40.0
      let startX = Double(arc4random_uniform(uint(self.size.width - 40)) + 20)
      let startY = Double(self.size.height) + sideSize
      let enemy = SKSpriteNode(imageNamed: "enemy7")
      
      enemy.size = CGSize(width: sideSize, height: (sideSize + 20))
      enemy.position = CGPoint(x: startX, y: startY)
      
      enemy.name = ObstacleNodeName
      
      self.addChild(enemy)
      
      let shipPath = curveMeisterEnemyPath2()
      let followPath = SKAction.follow(shipPath, asOffset: true, orientToPath: true, duration: 9.0)
      
      enemy.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    }
  func dropEnemyShip8() {
      let sideSize = 60.0
      let startX = Double(arc4random_uniform(uint(self.size.width - 40)) + 20)
      let startY = Double(self.size.height) + sideSize
      let enemy = SKSpriteNode(imageNamed: "enemy8")
      
      enemy.size = CGSize(width: sideSize, height: sideSize)
      enemy.position = CGPoint(x: startX, y: startY)
      
      enemy.name = ObstacleNodeName
      
      self.addChild(enemy)
      
      let shipPath = curveMeisterEnemyPath3()
      let followPath = SKAction.follow(shipPath, asOffset: true, orientToPath: true, duration: 18.0)
      
      enemy.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    }
  
  func dropEnemyShip9() {
      let sideSize = 40.0
      let startX = Double(arc4random_uniform(uint(self.size.width - 40)) + 20)
      let startY = Double(self.size.height) + sideSize
      let enemy = SKSpriteNode(imageNamed: "enemy9")
      
      enemy.size = CGSize(width: sideSize, height: sideSize)
      enemy.position = CGPoint(x: startX, y: startY)
      
      enemy.name = ObstacleNodeName
      
      self.addChild(enemy)

      let shipPath = curveMeisterEnemyPath4()
      let followPath = SKAction.follow(shipPath, asOffset: true, orientToPath: false, duration: 18.0)
      let travelAndRemove = SKAction.sequence([followPath, SKAction.removeFromParent()])
    
      let spin = SKAction.rotate(byAngle: 3, duration: Double(arc4random_uniform(3) + 1))
    
      let spinForever = SKAction.repeatForever(spin)

      enemy.run(SKAction.group([spinForever, travelAndRemove]))
    }
  
  func dropEnemyShip10() {
      let sideSize = 40.0
      let startX = Double(arc4random_uniform(uint(self.size.width - 40)) + 20)
      let startY = Double(self.size.height) + sideSize
      let enemy = SKSpriteNode(imageNamed: "enemy10")
      
      enemy.size = CGSize(width: sideSize, height: sideSize)
      enemy.position = CGPoint(x: startX, y: startY)
      
      enemy.name = ObstacleNodeName
      
      self.addChild(enemy)
      
      let shipPath = curveMeisterEnemyPath4()
      let followPath = SKAction.follow(shipPath, asOffset: true, orientToPath: true, duration: 9.0)
      
      enemy.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    }
  func dropEnemyShip11() {
      let sideSize = 60.0
      let startX = Double(arc4random_uniform(uint(self.size.width - 40)) + 20)
      let startY = Double(self.size.height) + sideSize
      let enemy = SKSpriteNode(imageNamed: "enemy11")
      
      enemy.size = CGSize(width: sideSize, height: sideSize)
      enemy.position = CGPoint(x: startX, y: startY)
      
      enemy.name = ObstacleNodeName
      
      self.addChild(enemy)
      
      let shipPath = curveMeisterEnemyPath()
      let followPath = SKAction.follow(shipPath, asOffset: true, orientToPath: true, duration: 9.0)
      
      enemy.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    }
  func dropEnemyShip12() {
      let sideSize = 60.0
      let startX = Double(arc4random_uniform(uint(self.size.width - 40)) + 20)
      let startY = Double(self.size.height) + sideSize
      let enemy = SKSpriteNode(imageNamed: "enemy12")
      
      enemy.size = CGSize(width: sideSize, height: sideSize)
      enemy.position = CGPoint(x: startX, y: startY)
      
      enemy.name = ObstacleNodeName
      
      self.addChild(enemy)
      let shipPath = curveMeisterEnemyPath4()
      
      let followPath = SKAction.follow(shipPath, asOffset: true, orientToPath: true, duration: 18.0)
      
      enemy.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    }
  func dropEnemyShip13() {
      let sideSize = 60.0
      let startX = Double(arc4random_uniform(uint(self.size.width - 40)) + 20)
      let startY = Double(self.size.height) + sideSize
      let enemy = SKSpriteNode(imageNamed: "enemy13")
      
      enemy.size = CGSize(width: sideSize, height: sideSize)
      enemy.position = CGPoint(x: startX, y: startY)
      
      enemy.name = ObstacleNodeName
    
      self.addChild(enemy)
      
      let shipPath = curveMeisterEnemyPath()
      
      let followPath = SKAction.follow(shipPath, asOffset: true, orientToPath: true, duration: 9.0)
      
      enemy.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    }
  func dropEnemyShip14() {
      let sideSize = 60.0
      let startX = Double(arc4random_uniform(uint(self.size.width - 40)) + 20)
      let startY = Double(self.size.height) + sideSize
      let enemy = SKSpriteNode(imageNamed: "enemy14")
      
      enemy.size = CGSize(width: sideSize, height: sideSize)
      enemy.position = CGPoint(x: startX, y: startY)
      
      enemy.name = ObstacleNodeName
      
      self.addChild(enemy)
      let shipPath = curveMeisterEnemyPath()
      
      let followPath = SKAction.follow(shipPath, asOffset: true, orientToPath: true, duration: 9.0)
      
      enemy.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    }
  
  func dropEnemyShip15() {
      let sideSize = 60.0
      let startX = Double(arc4random_uniform(uint(self.size.width - 40)) + 20)
      let startY = Double(self.size.height) + sideSize
      let enemy = SKSpriteNode(imageNamed: "enemy15")
      
      enemy.size = CGSize(width: sideSize, height: sideSize)
      enemy.position = CGPoint(x: startX, y: startY)
      
      enemy.name = ObstacleNodeName
      
      self.addChild(enemy)
      
      let shipPath = curveMeisterEnemyPath()
      
      let followPath = SKAction.follow(shipPath, asOffset: true, orientToPath: true, duration: 9.0)
      
      enemy.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    }
  func dropEnemyShip16() {
      let sideSize = 40.0
      let startX = Double(arc4random_uniform(uint(self.size.width - 40)) + 20)
      let startY = Double(self.size.height) + sideSize
      let enemy = SKSpriteNode(imageNamed: "enemy16")
      
      enemy.size = CGSize(width: sideSize, height: sideSize - 10)
      enemy.position = CGPoint(x: startX, y: startY)
      
      enemy.name = ObstacleNodeName
      
      self.addChild(enemy)
    
    let shipPath = curveMeisterEnemyPath()
      
      let followPath = SKAction.follow(shipPath, asOffset: true, orientToPath: true, duration: 9.0)
      
      enemy.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    }
  
  func dropEnemyShip17() {

    let sideSize = 60.0
    
    // arc for random_uniform() require a UInt32 paramerter value to be passed to it.
    // Determine the starting x-position for the asteroid
    let startX = Double(arc4random_uniform(uint(self.size.width - 40)) + 20)
    
    // Starting y-position should be above the top edge of the scene
    let startY = Double(self.size.height) + sideSize
    
    // Create our asteroid sprite and set its propterties
    let enemy1 = SKSpriteNode(imageNamed: "enemy9")
    let enemy2 = SKSpriteNode(imageNamed: "enemy9")
    let enemy3 = SKSpriteNode(imageNamed: "enemy9")
    let enemy4 = SKSpriteNode(imageNamed: "enemy9")
    let enemy5 = SKSpriteNode(imageNamed: "enemy9")
    
    enemy1.size = CGSize(width: 40, height: (sideSize - 20))
    enemy1.position = CGPoint(x: startX, y: startY + (0 * sideSize))
    enemy2.size = CGSize(width: 40, height: (sideSize - 20))
    enemy2.position = CGPoint(x: startX, y: startY + (1 * sideSize))
    enemy3.size = CGSize(width: 40, height: (sideSize - 20))
    enemy3.position = CGPoint(x: startX, y: startY + (2 * sideSize))
    enemy4.size = CGSize(width: 40, height: (sideSize - 20))
    enemy4.position = CGPoint(x: startX, y: startY + (3 * sideSize))
    enemy5.size = CGSize(width: 40, height: (sideSize - 20))
    enemy5.position = CGPoint(x: startX, y: startY + (4 * sideSize))
    
    enemy1.name = ObstacleNodeName
    enemy2.name = ObstacleNodeName
    enemy3.name = ObstacleNodeName
    enemy4.name = ObstacleNodeName
    enemy5.name = ObstacleNodeName
    
    self.addChild(enemy1)
    self.addChild(enemy2)
    self.addChild(enemy3)
    self.addChild(enemy4)
    self.addChild(enemy5)
    
    // Set up enemy ship movement
    //
    // We want the enemy ship to follow a curved flight path (Bezier curve) which uses control point to define how the curvature of teh path is formed. The following method will create and return that path.
    let shipPath = curveMeisterEnemyPath7()
    
    // Add SKActions to make the enemy ship fly
    //
    // asOffset parameter:
    // if set to true, lets us treate the actual point values of the path as offsets from the enemy ship's starting point VS them being treated as absolute positions on the screen if this parameter is set to false.
    //
    // the orientToPath parameter:
    // if true, causes the enemy ship to turn and face the direction of the path automatically.
    let followPath = SKAction.follow(shipPath, asOffset: true, orientToPath: true, duration: 9.0)
    
    enemy1.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    enemy2.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    enemy3.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    enemy4.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    enemy5.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))

  }
  
  func dropEnemyShip18() {
    let sideSize = 60.0
    let startX = Double(arc4random_uniform(uint(self.size.width - 40)) + 20)
    let startY = Double(self.size.height) + sideSize
    let enemy1 = SKSpriteNode(imageNamed: "enemy4")
    let enemy2 = SKSpriteNode(imageNamed: "enemy4")
    let enemy3 = SKSpriteNode(imageNamed: "enemy4")
    let enemy4 = SKSpriteNode(imageNamed: "enemy4")
    let enemy5 = SKSpriteNode(imageNamed: "enemy4")
    let enemy6 = SKSpriteNode(imageNamed: "enemy4")
    
    enemy1.size = CGSize(width: sideSize, height: sideSize)
    enemy1.position = CGPoint(x: startX + (0 * sideSize), y: startY)
    enemy2.size = CGSize(width: sideSize, height: sideSize)
    enemy2.position = CGPoint(x: startX + (1 * sideSize), y: startY)
    enemy3.size = CGSize(width: sideSize, height: sideSize)
    enemy3.position = CGPoint(x: startX + (2 * sideSize), y: startY)
    enemy4.size = CGSize(width: sideSize, height: sideSize)
    enemy4.position = CGPoint(x: startX + (3 * sideSize), y: startY)
    enemy5.size = CGSize(width: sideSize, height: sideSize)
    enemy5.position = CGPoint(x: startX + (4 * sideSize), y: startY)
    enemy6.size = CGSize(width: sideSize, height: sideSize)
    enemy6.position = CGPoint(x: startX + (5 * sideSize), y: startY)
    
    enemy1.name = ObstacleNodeName
    enemy2.name = ObstacleNodeName
    enemy3.name = ObstacleNodeName
    enemy4.name = ObstacleNodeName
    enemy5.name = ObstacleNodeName
    enemy6.name = ObstacleNodeName
    
    self.addChild(enemy1)
    self.addChild(enemy2)
    self.addChild(enemy3)
    self.addChild(enemy4)
    self.addChild(enemy5)
    self.addChild(enemy6)
    
    let shipPath = curveMeisterEnemyPath5()
    let followPath = SKAction.follow(shipPath, asOffset: true, orientToPath: true, duration: 9.0)
    
    enemy1.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    enemy2.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    enemy3.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    enemy4.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    enemy5.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    enemy6.run(SKAction.sequence([followPath, SKAction.removeFromParent()]))
    
  }

  
  
  // MARK: - bezier curve path section
  func curveMeisterEnemyPath() -> CGPath {
    
    let yMax = -1.0 * self.size.height
    
    // Bezier path that we are using was produced using the PaintCode app at www.paintcodeapp.com
    //
    // Use the UIBezierPath class to build an object that adds points with two control points per point to construct a curved path
    let bezierPath = UIBezierPath()
    
    bezierPath.move(to: CGPoint(x: 0.5, y: -0.5))
    
    bezierPath.addCurve(to: CGPoint(x: -2.5, y: -59.5), controlPoint1: CGPoint(x: 0.5, y: -0.5), controlPoint2: CGPoint(x: 4.55, y: -29.48))
    
    bezierPath.addCurve(to: CGPoint(x: -27.5, y: -154.5), controlPoint1: CGPoint(x: -9.55, y: -89.52), controlPoint2: CGPoint(x: -43.32, y: -115.43))
    
    bezierPath.addCurve(to: CGPoint(x: 30.5, y: -243.5), controlPoint1: CGPoint(x: -11.68, y: -193.57), controlPoint2: CGPoint(x: 17.28, y: -186.95))
    
    bezierPath.addCurve(to: CGPoint(x: -52.5, y: -379.5), controlPoint1: CGPoint(x: 43.72, y: -300.05), controlPoint2: CGPoint(x: -47.71, y: -335.76))
    
    bezierPath.addCurve(to: CGPoint(x: 54.5, y: -449.5), controlPoint1: CGPoint(x: -57.29, y: -423.24), controlPoint2: CGPoint(x: -8.14, y: -482.45))
    
    bezierPath.addCurve(to: CGPoint(x: -5.5, y: -348.5), controlPoint1: CGPoint(x: 117.14, y: -416.55), controlPoint2: CGPoint(x: 52.25, y: -308.62))
    
    bezierPath.addCurve(to: CGPoint(x: 10.5, y: -494.5), controlPoint1: CGPoint(x: -63.25, y: -388.38), controlPoint2: CGPoint(x: -14.48, y: -457.43))
    
    bezierPath.addCurve(to: CGPoint(x: 0.5, y: -559.5), controlPoint1: CGPoint(x: 23.74, y: -514.16), controlPoint2: CGPoint(x: 6.93, y: -537.57))
    
    bezierPath.addCurve(to: CGPoint(x: -2.5, y: yMax - 375), controlPoint1: CGPoint(x: -5.2, y: yMax - 375), controlPoint2: CGPoint(x: -2.5, y: yMax - 375))
    
    
    return bezierPath.cgPath
    
  }
  
  func curveMeisterEnemyPath2() -> CGPath {
    
    let yMax = -1.0 * self.size.height
    
    let bezierPath = UIBezierPath()
    
    bezierPath.move(to: CGPoint(x: 0.5, y: -0.5))
    
    bezierPath.addCurve(to: CGPoint(x: -5.0, y: -120.0), controlPoint1: CGPoint(x: 1.0, y: -1.0), controlPoint2: CGPoint(x: 10.0, y: -60.0))
    
    bezierPath.addCurve(to: CGPoint(x: -50.0, y: -300.0), controlPoint1: CGPoint(x: -20.0, y: -180.0), controlPoint2: CGPoint(x: -80.0, y: -200.0))
    
    bezierPath.addCurve(to: CGPoint(x: 60.0, y: -500.0), controlPoint1: CGPoint(x: -22.0, y: -400.0), controlPoint2: CGPoint(x: 30.0, y: -370.0))
    
    bezierPath.addCurve(to: CGPoint(x: -100.0, y: -600.0), controlPoint1: CGPoint(x: 80.0, y: -600.05), controlPoint2: CGPoint(x: -47.71, y: -335.76))
    
    bezierPath.addCurve(to: CGPoint(x: 104.5, y: -849.5), controlPoint1: CGPoint(x: -157.29, y: -823.24), controlPoint2: CGPoint(x: -8.14, y: -482.45))
    
    bezierPath.addCurve(to: CGPoint(x: -11.5, y: -648.5), controlPoint1: CGPoint(x: 217.14, y: -816.55), controlPoint2: CGPoint(x: 52.25, y: -308.62))
    
    bezierPath.addCurve(to: CGPoint(x: 20.5, y: -894.5), controlPoint1: CGPoint(x: -123.25, y: -688.38), controlPoint2: CGPoint(x: -14.48, y: -457.43))
    
    bezierPath.addCurve(to: CGPoint(x: 1.5, y: -1059.5), controlPoint1: CGPoint(x: 43.74, y: -1014.16), controlPoint2: CGPoint(x: 12.93, y: -1037.57))
    
    bezierPath.addCurve(to: CGPoint(x: -5.5, y: yMax - 675), controlPoint1: CGPoint(x: -10.2, y: yMax - 675), controlPoint2: CGPoint(x: -5.5, y: yMax - 675))
    
    
    return bezierPath.cgPath
    
  }
  
  func curveMeisterEnemyPath3() -> CGPath {
    
    let yMax = -1.0 * self.size.height
    
    let bezierPath = UIBezierPath()
    
    bezierPath.move(to: CGPoint(x: 0.5, y: -0.5))
    
    bezierPath.addCurve(to: CGPoint(x: -5.0, y: -120.0), controlPoint1: CGPoint(x: 1.0, y: -1.0), controlPoint2: CGPoint(x: 10.0, y: -60.0))
    
    bezierPath.addCurve(to: CGPoint(x: -50.0, y: -300.0), controlPoint1: CGPoint(x: -20.0, y: -180.0), controlPoint2: CGPoint(x: -80.0, y: -200.0))
    
    bezierPath.addCurve(to: CGPoint(x: 60.0, y: -500.0), controlPoint1: CGPoint(x: -22.0, y: -400.0), controlPoint2: CGPoint(x: 30.0, y: -370.0))
    
    bezierPath.addCurve(to: CGPoint(x: -100.0, y: -600.0), controlPoint1: CGPoint(x: 80.0, y: -600.05), controlPoint2: CGPoint(x: -47.71, y: -335.76))
    
    bezierPath.addCurve(to: CGPoint(x: 104.5, y: -849.5), controlPoint1: CGPoint(x: -157.29, y: -823.24), controlPoint2: CGPoint(x: -8.14, y: -482.45))
    
    bezierPath.addCurve(to: CGPoint(x: -11.5, y: -648.5), controlPoint1: CGPoint(x: 217.14, y: -816.55), controlPoint2: CGPoint(x: 52.25, y: -308.62))
    
    bezierPath.addCurve(to: CGPoint(x: 20.5, y: -894.5), controlPoint1: CGPoint(x: -123.25, y: -688.38), controlPoint2: CGPoint(x: -14.48, y: -457.43))
    
    bezierPath.addCurve(to: CGPoint(x: 1.5, y: -1059.5), controlPoint1: CGPoint(x: 43.74, y: -1014.16), controlPoint2: CGPoint(x: 12.93, y: -1037.57))
    
    bezierPath.addCurve(to: CGPoint(x: -2.5, y: -59.5), controlPoint1: CGPoint(x: 0.5, y: -0.5), controlPoint2: CGPoint(x: 4.55, y: -29.48))
    
    bezierPath.addCurve(to: CGPoint(x: -27.5, y: -154.5), controlPoint1: CGPoint(x: -9.55, y: -89.52), controlPoint2: CGPoint(x: -43.32, y: -115.43))
    
    bezierPath.addCurve(to: CGPoint(x: 30.5, y: -243.5), controlPoint1: CGPoint(x: -11.68, y: -193.57), controlPoint2: CGPoint(x: 17.28, y: -186.95))
    
    bezierPath.addCurve(to: CGPoint(x: -52.5, y: -379.5), controlPoint1: CGPoint(x: 43.72, y: -300.05), controlPoint2: CGPoint(x: -47.71, y: -335.76))
    
    bezierPath.addCurve(to: CGPoint(x: 54.5, y: -449.5), controlPoint1: CGPoint(x: -57.29, y: -423.24), controlPoint2: CGPoint(x: -8.14, y: -482.45))
    
    bezierPath.addCurve(to: CGPoint(x: -5.5, y: -348.5), controlPoint1: CGPoint(x: 117.14, y: -416.55), controlPoint2: CGPoint(x: 52.25, y: -308.62))
    
    bezierPath.addCurve(to: CGPoint(x: 10.5, y: -494.5), controlPoint1: CGPoint(x: -63.25, y: -388.38), controlPoint2: CGPoint(x: -14.48, y: -457.43))
    
    bezierPath.addCurve(to: CGPoint(x: 0.5, y: -559.5), controlPoint1: CGPoint(x: 23.74, y: -514.16), controlPoint2: CGPoint(x: 6.93, y: -537.57))
    
    bezierPath.addCurve(to: CGPoint(x: -5.5, y: yMax - 675), controlPoint1: CGPoint(x: -10.2, y: yMax - 675), controlPoint2: CGPoint(x: -5.5, y: yMax - 675))
    
    
    return bezierPath.cgPath
    
  }
  
  
  func curveMeisterEnemyPath4() -> CGPath {
    
    let yMax = -1.0 * self.size.height
    
    let bezierPath = UIBezierPath()
    
    bezierPath.move(to: CGPoint(x: 0.5, y: -0.5))
    
    bezierPath.addCurve(to: CGPoint(x: 0.0, y: -59.5), controlPoint1: CGPoint(x: 0.5, y: -0.5), controlPoint2: CGPoint(x: 4.55, y: -29.48))
    
    bezierPath.addCurve(to: CGPoint(x: 0.0, y: -154.5), controlPoint1: CGPoint(x: -9.55, y: -89.52), controlPoint2: CGPoint(x: -43.32, y: -115.43))
    
    bezierPath.addCurve(to: CGPoint(x: 30.5, y: -243.5), controlPoint1: CGPoint(x: -11.68, y: -193.57), controlPoint2: CGPoint(x: 17.28, y: -186.95))
    
    bezierPath.addCurve(to: CGPoint(x: 0.0, y: yMax - 375), controlPoint1: CGPoint(x: -5.2, y: yMax - 375), controlPoint2: CGPoint(x: -2.5, y: yMax - 375))

    bezierPath.addCurve(to: CGPoint(x: -52.5, y: -379.5), controlPoint1: CGPoint(x: 43.72, y: -300.05), controlPoint2: CGPoint(x: -47.71, y: -335.76))
    
    bezierPath.addCurve(to: CGPoint(x: 0.0, y: -559.5), controlPoint1: CGPoint(x: 23.74, y: -514.16), controlPoint2: CGPoint(x: 6.93, y: -537.57))

    bezierPath.addCurve(to: CGPoint(x: 54.5, y: -449.5), controlPoint1: CGPoint(x: -57.29, y: -423.24), controlPoint2: CGPoint(x: -8.14, y: -482.45))
    
    bezierPath.addCurve(to: CGPoint(x: 0.0, y: -494.5), controlPoint1: CGPoint(x: -63.25, y: -388.38), controlPoint2: CGPoint(x: -14.48, y: -457.43))

    bezierPath.addCurve(to: CGPoint(x: 0.0, y: -348.5), controlPoint1: CGPoint(x: 117.14, y: -416.55), controlPoint2: CGPoint(x: 52.25, y: -308.62))
  
    return bezierPath.cgPath
    
  }
  
  func curveMeisterEnemyPath5() -> CGPath {
    
    let yMax = -1.0 * self.size.height
    
    let bezierPath = UIBezierPath()
    
    bezierPath.move(to: CGPoint(x: 5.0, y: 5.0))
    
    bezierPath.addCurve(to: CGPoint(x: -2.5, y: -59.5), controlPoint1: CGPoint(x: 0.5, y: -0.5), controlPoint2: CGPoint(x: 4.55, y: -29.48))
    
    bezierPath.addCurve(to: CGPoint(x: -52.5, y: -379.5), controlPoint1: CGPoint(x: 43.72, y: -300.05), controlPoint2: CGPoint(x: -47.71, y: -335.76))
    
    bezierPath.addCurve(to: CGPoint(x: 54.5, y: -449.5), controlPoint1: CGPoint(x: -57.29, y: -423.24), controlPoint2: CGPoint(x: -8.14, y: -482.45))
    
    bezierPath.addCurve(to: CGPoint(x: -5.5, y: -348.5), controlPoint1: CGPoint(x: 117.14, y: -416.55), controlPoint2: CGPoint(x: 52.25, y: -308.62))
    
    bezierPath.addCurve(to: CGPoint(x: -2.5, y: yMax - 375), controlPoint1: CGPoint(x: -5.2, y: yMax - 375), controlPoint2: CGPoint(x: -2.5, y: yMax - 375))
    
    
    return bezierPath.cgPath
    
  }
  
  func curveMeisterEnemyPath6() -> CGPath {
    
    let yMax = -1.0 * self.size.height

    let bezierPath = UIBezierPath()
    
    bezierPath.move(to: CGPoint(x: 0.5, y: -0.5))
    
    bezierPath.addCurve(to: CGPoint(x: -2.5, y: -59.5), controlPoint1: CGPoint(x: 0.5, y: -0.5), controlPoint2: CGPoint(x: 4.55, y: -29.48))
    
    bezierPath.addCurve(to: CGPoint(x: -27.5, y: -154.5), controlPoint1: CGPoint(x: -9.55, y: -89.52), controlPoint2: CGPoint(x: -43.32, y: -115.43))
    
    bezierPath.addCurve(to: CGPoint(x: 30.5, y: -243.5), controlPoint1: CGPoint(x: -11.68, y: -193.57), controlPoint2: CGPoint(x: 17.28, y: -186.95))
    
    bezierPath.addCurve(to: CGPoint(x: -52.5, y: -379.5), controlPoint1: CGPoint(x: 43.72, y: -300.05), controlPoint2: CGPoint(x: -47.71, y: -335.76))
    
    bezierPath.addCurve(to: CGPoint(x: 54.5, y: -449.5), controlPoint1: CGPoint(x: -57.29, y: -423.24), controlPoint2: CGPoint(x: -8.14, y: -482.45))
    
    bezierPath.addCurve(to: CGPoint(x: -5.5, y: -348.5), controlPoint1: CGPoint(x: 117.14, y: -416.55), controlPoint2: CGPoint(x: 52.25, y: -308.62))
    
    bezierPath.addCurve(to: CGPoint(x: 10.5, y: -494.5), controlPoint1: CGPoint(x: -63.25, y: -388.38), controlPoint2: CGPoint(x: -14.48, y: -457.43))
    
    bezierPath.addCurve(to: CGPoint(x: 0.5, y: -559.5), controlPoint1: CGPoint(x: 23.74, y: -514.16), controlPoint2: CGPoint(x: 6.93, y: -537.57))
    
    bezierPath.addCurve(to: CGPoint(x: -2.5, y: yMax - 375), controlPoint1: CGPoint(x: -5.2, y: yMax - 375), controlPoint2: CGPoint(x: -2.5, y: yMax - 375))
    
    
    return bezierPath.cgPath
    
  }
  
  func curveMeisterEnemyPath7() -> CGPath {
    
    let yMax = -1.0 * self.size.height
    

    let bezierPath = UIBezierPath()
    
    bezierPath.move(to: CGPoint(x: 0.5, y: -0.5))
    
    bezierPath.addCurve(to: CGPoint(x: -2.5, y: -59.5), controlPoint1: CGPoint(x: 0.5, y: -0.5), controlPoint2: CGPoint(x: 4.55, y: -29.48))
    
    bezierPath.addCurve(to: CGPoint(x: -27.5, y: -154.5), controlPoint1: CGPoint(x: -9.55, y: -89.52), controlPoint2: CGPoint(x: -43.32, y: -115.43))
    
    bezierPath.addCurve(to: CGPoint(x: 30.5, y: -243.5), controlPoint1: CGPoint(x: -11.68, y: -193.57), controlPoint2: CGPoint(x: 17.28, y: -186.95))
    
    bezierPath.addCurve(to: CGPoint(x: -52.5, y: -379.5), controlPoint1: CGPoint(x: 43.72, y: -300.05), controlPoint2: CGPoint(x: -47.71, y: -335.76))
    
    bezierPath.addCurve(to: CGPoint(x: 54.5, y: -449.5), controlPoint1: CGPoint(x: -57.29, y: -423.24), controlPoint2: CGPoint(x: -8.14, y: -482.45))
    
    bezierPath.addCurve(to: CGPoint(x: -5.5, y: -348.5), controlPoint1: CGPoint(x: 117.14, y: -416.55), controlPoint2: CGPoint(x: 52.25, y: -308.62))
    
    bezierPath.addCurve(to: CGPoint(x: 10.5, y: -494.5), controlPoint1: CGPoint(x: -63.25, y: -388.38), controlPoint2: CGPoint(x: -14.48, y: -457.43))
    
    bezierPath.addCurve(to: CGPoint(x: 0.5, y: -559.5), controlPoint1: CGPoint(x: 23.74, y: -514.16), controlPoint2: CGPoint(x: 6.93, y: -537.57))
    
    bezierPath.addCurve(to: CGPoint(x: -2.5, y: yMax - 375), controlPoint1: CGPoint(x: -5.2, y: yMax - 375), controlPoint2: CGPoint(x: -2.5, y: yMax - 375))
    
    
    return bezierPath.cgPath
    

    
  }
  
  //
  // Perform collisoin detection between various sprites in our game
  //
  // MARK: - check collisions
  func checkCollisions() {
    
    if let ship = self.childNode(withName: SpaceshipNodeName) {
      
      // if the ship bumps into a powerup, remove the powerup from the scene and reset shipFireRate property to a much smaller value to increase the ship's fire rate.
      enumerateChildNodes(withName: PowerupNodeName) {
        myPowerUp, _ in
        
        if ship.intersects(myPowerUp) {
          myPowerUp.removeFromParent()
          self.run(self.powerupSound)
          
          if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
            
            hud.showPowerupTimer(self.powerUpDuration)
            
          }

          // Increase the ship's fire rate
          self.shipFireRate = self.enhancedFireRate
          
          // But, we need to power back down after a delay so we are not unbeatable...
          let powerDown = SKAction.run {
            
            self.shipFireRate = self.defaultFireRate
            
          }
          
          let typePowerDown = SKAction.run {
            
            self.shipFireType = self.defaultFireType
            
          }
          let typeWait = SKAction.wait(forDuration: self.typePowerupDuration)
          
          let typeWaitAndPowerDown = SKAction.sequence([typeWait, typePowerDown])
          
          let typePowerDownActionKey = "typeWaitAndPowerDown"
          ship.removeAction(forKey: typePowerDownActionKey)
          ship.run(typeWaitAndPowerDown, withKey: typePowerDownActionKey)
          
          let wait = SKAction.wait(forDuration: self.powerUpDuration)
          
          let waitAndPowerDown = SKAction.sequence([wait, powerDown])
          
         // ship.run(waitAndPowerDown)
          
          // if we collect another powerup while one is already in progress, we need to stop the one in progress and start a new one so we always get the full duration for any powerup collected.
          //
          // Sprite Kit lets us run actions with a key that we can use to identify and remove the action before it has a chance to run or finish.
          //
          // If no key is found, nothing happens...
          //
          let powerDownActionKey = "waitAndPowerDown"
          ship.removeAction(forKey: powerDownActionKey)
          
          ship.run(waitAndPowerDown, withKey: powerDownActionKey)
          
        }
      }
      
      enumerateChildNodes(withName: LudacrispPowerupNodeName) {
        myPowerUp, _ in
        
        if ship.intersects(myPowerUp) {
          myPowerUp.removeFromParent()
          self.run(self.powerupSound)
          
          if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
            
            hud.showPowerupTimer(self.powerUpDuration)
            
          }
          
          // Increase the ship's fire rate
          self.shipFireRate = self.ludacrispFireRate
          
          // But, we need to power back down after a delay so we are not unbeatable...
          let powerDown = SKAction.run {
            
            self.shipFireRate = self.defaultFireRate
            
          }
          
          let typePowerDown = SKAction.run {
            
            self.shipFireType = self.defaultFireType
            
          }
          let typeWait = SKAction.wait(forDuration: self.typePowerupDuration)
          
          let typeWaitAndPowerDown = SKAction.sequence([typeWait, typePowerDown])
          
          let typePowerDownActionKey = "typeWaitAndPowerDown"
          ship.removeAction(forKey: typePowerDownActionKey)
          ship.run(typeWaitAndPowerDown, withKey: typePowerDownActionKey)
          
          let wait = SKAction.wait(forDuration: self.powerUpDuration)
          
          let waitAndPowerDown = SKAction.sequence([wait, powerDown])
          
          let powerDownActionKey = "waitAndPowerDown"
          ship.removeAction(forKey: powerDownActionKey)
          
          ship.run(waitAndPowerDown, withKey: powerDownActionKey)
          
        }
      }
      
      enumerateChildNodes(withName: HealthPowerupNodeName) {
        myPowerUp, _ in
        
        if ship.intersects(myPowerUp) {
          myPowerUp.removeFromParent()
          
          self.shipHealthRate = 4.0
          self.run(self.healthPickup)
          
          if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
            
            hud.showHealth(Double(self.shipHealthRate))
            
          }
          if let shield = ship.childNode(withName: self.ShieldNodeName) {

            shield.alpha = 1.4
            shield.setScale(0.8)
          }
          
        }
      }
      
      enumerateChildNodes(withName: SpreaderPowerupNodeName) {
        myPowerUp, _ in
        
        if ship.intersects(myPowerUp) {
          myPowerUp.removeFromParent()
          
          self.run(self.powerupSound)
          
          if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
            
            hud.showPowerupTimer(self.typePowerupDuration)
            
          }
          
          self.shipFireType = "spreader"
          
          // But, we need to power back down after a delay so we are not unbeatable...
          let powerDown = SKAction.run {
            
            self.shipFireRate = self.defaultFireRate
            
          }
          
          let typePowerDown = SKAction.run {
            
            self.shipFireType = self.defaultFireType
            
          }
          let typeWait = SKAction.wait(forDuration: self.typePowerupDuration)
          
          let typeWaitAndPowerDown = SKAction.sequence([typeWait, typePowerDown])
          
          let typePowerDownActionKey = "typeWaitAndPowerDown"
          ship.removeAction(forKey: typePowerDownActionKey)
         
          ship.run(typeWaitAndPowerDown, withKey: typePowerDownActionKey)
          
          
          let wait = SKAction.wait(forDuration: self.powerUpDuration)
          
          let waitAndPowerDown = SKAction.sequence([wait, powerDown])
          
          // ship.run(waitAndPowerDown)

          let powerDownActionKey = "waitAndPowerDown"
          ship.removeAction(forKey: powerDownActionKey)
          
          ship.run(waitAndPowerDown, withKey: powerDownActionKey)
          
        }
      
      }
      
      enumerateChildNodes(withName: WagglePowerupNodeName) {
        myPowerUp, _ in
        
        if ship.intersects(myPowerUp) {
          myPowerUp.removeFromParent()
          
          self.run(self.powerupSound)
          
          if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
            
            hud.showPowerupTimer(self.typePowerupDuration)
            
          }


          self.shipFireType = "waggle"
          
          // But, we need to power back down after a delay so we are not unbeatable...
          let powerDown = SKAction.run {
            
            self.shipFireRate = self.defaultFireRate
            
          }
          
          let typePowerDown = SKAction.run {
            
            self.shipFireType = self.defaultFireType
            
          }
          let typeWait = SKAction.wait(forDuration: self.typePowerupDuration)
          
          let typeWaitAndPowerDown = SKAction.sequence([typeWait, typePowerDown])
          
          let typePowerDownActionKey = "typeWaitAndPowerDown"
          ship.removeAction(forKey: typePowerDownActionKey)
          
          ship.run(typeWaitAndPowerDown, withKey: typePowerDownActionKey)
          
          let wait = SKAction.wait(forDuration: self.powerUpDuration)
          
          let waitAndPowerDown = SKAction.sequence([wait, powerDown])
          
          // ship.run(waitAndPowerDown)
          
          let powerDownActionKey = "waitAndPowerDown"
          ship.removeAction(forKey: powerDownActionKey)
          
          ship.run(waitAndPowerDown, withKey: powerDownActionKey)
          
          
        }
        
      }
      
      
      enumerateChildNodes(withName: SpiralPowerupNodeName) {
        myPowerUp, _ in
        
        if ship.intersects(myPowerUp) {
          myPowerUp.removeFromParent()
          self.run(self.powerupSound)
          
          if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
            
            hud.showPowerupTimer(self.typePowerupDuration)
            
          }

          self.shipFireType = "spiral"
          
          // But, we need to power back down after a delay so we are not unbeatable...
          let powerDown = SKAction.run {
            
            self.shipFireRate = self.defaultFireRate
            
          }
          
          let typePowerDown = SKAction.run {
            
            self.shipFireType = self.defaultFireType
            
          }
          let typeWait = SKAction.wait(forDuration: self.typePowerupDuration)
          
          let typeWaitAndPowerDown = SKAction.sequence([typeWait, typePowerDown])
          
          let typePowerDownActionKey = "typeWaitAndPowerDown"
          ship.removeAction(forKey: typePowerDownActionKey)
          
          ship.run(typeWaitAndPowerDown, withKey: typePowerDownActionKey)
          
          let wait = SKAction.wait(forDuration: self.powerUpDuration)
          
          let waitAndPowerDown = SKAction.sequence([wait, powerDown])
          
          // ship.run(waitAndPowerDown)
          
          let powerDownActionKey = "waitAndPowerDown"
          ship.removeAction(forKey: powerDownActionKey)
          
          ship.run(waitAndPowerDown, withKey: powerDownActionKey)
          
          
        }
        
      }
      
      // The enumerateChildNodes method will execute a given code block For every node that is an obstacle node in our scene. This code will iterate trhough all of the obstacle nodes in our Scene Graph node tree.
      //
      // enumerateChildNodes will automattically populate the local identifier
      // obstacle with a reference to the next "obstacle" node it found as
      // it enumerates (loops) through the Scene Graph node tree.
      
      enumerateChildNodes(withName: ObstacleNodeName) {
        obstacle, _ in // _ means continue

        // Check for collision with our ship
        if ship.intersects(obstacle) {
          
          if self.shipHealthRate == 0 {
          self.shipTouch = nil
          
          // Remove the ship and the obstacle from the Scene Graph
          ship.removeFromParent()
          obstacle.removeFromParent()
          
          self.run(self.shipExplodeSound)

            let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = ship.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // update timer
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.endGame()
              
            }
            
          } else {
            self.shipHealthRate -= 1
            obstacle.removeFromParent()
            self.run(self.hurtSound)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.showHealth(Double(self.shipHealthRate))
              
            }
            
            if let shield = ship.childNode(withName: self.ShieldNodeName) {
            
            if self.shipHealthRate == 0.0 {
              
                shield.alpha = 0.0
                shield.setScale(0.0)
              
            } else if self.shipHealthRate == 1.0 {
              
                shield.alpha = 0.15
                shield.setScale(0.5)
              
              
            } else if self.shipHealthRate == 2.0 {
              
                shield.alpha = 0.35
              shield.setScale(0.6)
              
            } else if self.shipHealthRate == 3.0 {
              
                shield.alpha = 0.7
              shield.setScale(0.8)
              
            }
            }
          }
        }
        
        
        // Now, check if the obstacle collided with one of our photon torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.PhotonTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(obstacle) {
            
            myPhoton.removeFromParent()
            obstacle.removeFromParent()
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = obstacle.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // Update our score
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }

        // Now, check if the obstacle collided with one of our Waggle torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.WaggleTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(obstacle) {
            
            myPhoton.removeFromParent()
            obstacle.removeFromParent()
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = obstacle.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spiral torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpiralTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(obstacle) {
            
            myPhoton.removeFromParent()
            obstacle.removeFromParent()
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = obstacle.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }

        // Now, check if the obstacle collided with one of our Spreader0 torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpreaderTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(obstacle) {
            
            myPhoton.removeFromParent()
            obstacle.removeFromParent()
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = obstacle.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
      }
      
      
      
      enumerateChildNodes(withName: Boss1NodeName) {
        boss1, _ in // _ means continue
        
        // Check for collision with our ship
        if ship.intersects(boss1) {
          
          if self.shipHealthRate == 0 {
            self.shipTouch = nil
            
            // Remove the ship and the obstacle from the Scene Graph
            ship.removeFromParent()
            self.boss1Health -= 1
            if self.boss1Health < 0 {
              boss1.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss1.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.shipExplodeSound)
            
            let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = ship.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // update timer
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.endGame()
              
            }
            
          } else {
            self.shipHealthRate -= 1
            
            self.boss1Health -= 1
            
            if self.boss1Health < 0 {
              boss1.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss1.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
                hud.showLevel(self.bossLevel)
              
              }
              
            }
            
            self.run(self.hurtSound)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.showHealth(Double(self.shipHealthRate))
              
            }
            
            if let shield = ship.childNode(withName: self.ShieldNodeName) {
              
              if self.shipHealthRate == 0.0 {
                
                shield.alpha = 0.0
                shield.setScale(0.0)
                
              } else if self.shipHealthRate == 1.0 {
                
                shield.alpha = 0.15
                shield.setScale(0.5)
                
                
              } else if self.shipHealthRate == 2.0 {
                
                shield.alpha = 0.35
                shield.setScale(0.6)
                
              } else if self.shipHealthRate == 3.0 {
                
                shield.alpha = 0.7
                shield.setScale(0.8)
                
              }
            }
          }
        }
        
        
        // Now, check if the obstacle collided with one of our photon torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.PhotonTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss1) {
            
            myPhoton.removeFromParent()
            
            self.boss1Health -= 1
            if self.boss1Health < 0 {
              boss1.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss1.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
              
            }
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss1.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // Update our score
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Waggle torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.WaggleTorpedoName) {
          myPhoton, stop in
        
          if myPhoton.intersects(boss1) {
            
            myPhoton.removeFromParent()
            self.boss1Health -= 1
            if self.boss1Health < 0 {
              boss1.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss1.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
              
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss1.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spiral torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpiralTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss1) {
            
            myPhoton.removeFromParent()
            self.boss1Health -= 1
            if self.boss1Health < 0 {
              boss1.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss1.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
              
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss1.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spreader0 torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpreaderTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss1) {
            
            myPhoton.removeFromParent()
            self.boss1Health -= 1
            if self.boss1Health < 0 {
              boss1.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss1.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss1.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
      }
    
      enumerateChildNodes(withName: Boss2NodeName) {
        boss2, _ in // _ means continue
        
        // Check for collision with our ship
        if ship.intersects(boss2) {
          
          if self.shipHealthRate == 0 {
            self.shipTouch = nil
            
            // Remove the ship and the obstacle from the Scene Graph
            ship.removeFromParent()
            self.boss2Health -= 1
            if self.boss2Health < 0 {
              boss2.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss2.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.shipExplodeSound)
            
            let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = ship.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // update timer
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.endGame()
              
            }
            
          } else {
            self.shipHealthRate -= 1
            
            self.boss2Health -= 1
            
            if self.boss2Health < 0 {
              boss2.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss2.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.hurtSound)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.showHealth(Double(self.shipHealthRate))
              
            }
            
            if let shield = ship.childNode(withName: self.ShieldNodeName) {
              
              if self.shipHealthRate == 0.0 {
                
                shield.alpha = 0.0
                shield.setScale(0.0)
                
              } else if self.shipHealthRate == 1.0 {
                
                shield.alpha = 0.15
                shield.setScale(0.5)
                
                
              } else if self.shipHealthRate == 2.0 {
                
                shield.alpha = 0.35
                shield.setScale(0.6)
                
              } else if self.shipHealthRate == 3.0 {
                
                shield.alpha = 0.7
                shield.setScale(0.8)
                
              }
            }
          }
        }
        
        
        // Now, check if the obstacle collided with one of our photon torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.PhotonTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss2) {
            
            myPhoton.removeFromParent()
            
            self.boss2Health -= 1
            if self.boss2Health < 0 {
              boss2.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss2.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss2.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // Update our score
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Waggle torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.WaggleTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss2) {
            
            myPhoton.removeFromParent()
            self.boss2Health -= 1
            if self.boss2Health < 0 {
              boss2.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss2.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss2.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spiral torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpiralTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss2) {
            
            myPhoton.removeFromParent()
            self.boss2Health -= 1
            if self.boss2Health < 0 {
              boss2.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss2.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss2.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spreader0 torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpreaderTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss2) {
            
            myPhoton.removeFromParent()
            self.boss2Health -= 1
            if self.boss2Health < 0 {
              boss2.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss2.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss2.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
      }
      
      enumerateChildNodes(withName: Boss3NodeName) {
        boss3, _ in // _ means continue
        
        // Check for collision with our ship
        if ship.intersects(boss3) {
          
          // our ship collided with an obstacle
          //
          // set shipTouch property to nil so it will not
          // be used by our shooting logic in the update()
          // method to continue to track the touch and
          // shoot photon torpedos. If this doesn't work torpedos would continue to fire from (0,0) since the ship is gone.
          if self.shipHealthRate == 0 {
            self.shipTouch = nil
            
            // Remove the ship and the obstacle from the Scene Graph
            ship.removeFromParent()
            self.boss3Health -= 1
            if self.boss3Health < 0 {
              boss3.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss3.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.shipExplodeSound)
            
            let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = ship.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // update timer
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.endGame()
              
            }
            
          } else {
            self.shipHealthRate -= 1
            
            self.boss3Health -= 1
            
            if self.boss3Health < 0 {
              boss3.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss3.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.hurtSound)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.showHealth(Double(self.shipHealthRate))
              
            }
            
            if let shield = ship.childNode(withName: self.ShieldNodeName) {
              
              if self.shipHealthRate == 0.0 {
                
                shield.alpha = 0.0
                shield.setScale(0.0)
                
              } else if self.shipHealthRate == 1.0 {
                
                shield.alpha = 0.15
                shield.setScale(0.5)
                
                
              } else if self.shipHealthRate == 2.0 {
                
                shield.alpha = 0.35
                shield.setScale(0.6)
                
              } else if self.shipHealthRate == 3.0 {
                
                shield.alpha = 0.7
                shield.setScale(0.8)
                
              }
            }
          }
        }
        
        
        // Now, check if the obstacle collided with one of our photon torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.PhotonTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss3) {
            
            myPhoton.removeFromParent()
            
            self.boss3Health -= 1
            if self.boss3Health < 0 {
              boss3.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss3.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            // create explosion
            
            // Call copy() on the node in the template property becuase nodes can only be added to a scene once.
            //
            // If we try to add a node again that already exists in a scene, the game will crash with an error. We must add copies of particle emitter noes that we weish to use moer than once and we will use the emittern  node template that is in our cached property as a template from which to make these copies.
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss3.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // Update our score
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Waggle torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.WaggleTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss3) {
            
            myPhoton.removeFromParent()
            self.boss3Health -= 1
            if self.boss3Health < 0 {
              boss3.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss3.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss3.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spiral torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpiralTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss3) {
            
            myPhoton.removeFromParent()
            self.boss3Health -= 1
            if self.boss3Health < 0 {
              boss3.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss3.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss3.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spreader0 torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpreaderTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss3) {
            
            myPhoton.removeFromParent()
            self.boss3Health -= 1
            if self.boss3Health < 0 {
              boss3.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss3.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss3.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
      }
      
      enumerateChildNodes(withName: Boss4NodeName) {
        boss4, _ in // _ means continue
        
        // Check for collision with our ship
        if ship.intersects(boss4) {
          
          // our ship collided with an obstacle
          //
          // set shipTouch property to nil so it will not
          // be used by our shooting logic in the update()
          // method to continue to track the touch and
          // shoot photon torpedos. If this doesn't work torpedos would continue to fire from (0,0) since the ship is gone.
          if self.shipHealthRate == 0 {
            self.shipTouch = nil
            
            // Remove the ship and the obstacle from the Scene Graph
            ship.removeFromParent()
            self.boss4Health -= 1
            if self.boss4Health < 0 {
              boss4.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss4.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.shipExplodeSound)
            
            let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = ship.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // update timer
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.endGame()
              
            }
            
          } else {
            self.shipHealthRate -= 1
            
            self.boss4Health -= 1
            
            if self.boss4Health < 0 {
              boss4.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss4.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.hurtSound)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.showHealth(Double(self.shipHealthRate))
              
            }
            
            if let shield = ship.childNode(withName: self.ShieldNodeName) {
              
              if self.shipHealthRate == 0.0 {
                
                shield.alpha = 0.0
                shield.setScale(0.0)
                
              } else if self.shipHealthRate == 1.0 {
                
                shield.alpha = 0.15
                shield.setScale(0.5)
                
                
              } else if self.shipHealthRate == 2.0 {
                
                shield.alpha = 0.35
                shield.setScale(0.6)
                
              } else if self.shipHealthRate == 3.0 {
                
                shield.alpha = 0.7
                shield.setScale(0.8)
                
              }
            }
          }
        }
        
        
        // Now, check if the obstacle collided with one of our photon torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.PhotonTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss4) {
            
            myPhoton.removeFromParent()
            
            self.boss4Health -= 1
            if self.boss4Health < 0 {
              boss4.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss4.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            // create explosion
            
            // Call copy() on the node in the template property becuase nodes can only be added to a scene once.
            //
            // If we try to add a node again that already exists in a scene, the game will crash with an error. We must add copies of particle emitter noes that we weish to use moer than once and we will use the emittern  node template that is in our cached property as a template from which to make these copies.
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss4.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // Update our score
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Waggle torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.WaggleTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss4) {
            
            myPhoton.removeFromParent()
            self.boss4Health -= 1
            if self.boss4Health < 0 {
              boss4.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss4.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss4.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spiral torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpiralTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss4) {
            
            myPhoton.removeFromParent()
            self.boss4Health -= 1
            if self.boss4Health < 0 {
              boss4.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss4.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss4.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spreader0 torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpreaderTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss4) {
            
            myPhoton.removeFromParent()
            self.boss4Health -= 1
            if self.boss4Health < 0 {
              boss4.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss4.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss4.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
      }
      
      enumerateChildNodes(withName: Boss5NodeName) {
        boss5, _ in // _ means continue
        
        // Check for collision with our ship
        if ship.intersects(boss5) {
          
          // our ship collided with an obstacle
          //
          // set shipTouch property to nil so it will not
          // be used by our shooting logic in the update()
          // method to continue to track the touch and
          // shoot photon torpedos. If this doesn't work torpedos would continue to fire from (0,0) since the ship is gone.
          if self.shipHealthRate == 0 {
            self.shipTouch = nil
            
            // Remove the ship and the obstacle from the Scene Graph
            ship.removeFromParent()
            self.boss5Health -= 1
            if self.boss5Health < 0 {
              boss5.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss5.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.shipExplodeSound)
            
            let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = ship.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // update timer
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.endGame()
              
            }
            
          } else {
            self.shipHealthRate -= 1
            
            self.boss5Health -= 1
            
            if self.boss5Health < 0 {
              boss5.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss5.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.hurtSound)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.showHealth(Double(self.shipHealthRate))
              
            }
            
            if let shield = ship.childNode(withName: self.ShieldNodeName) {
              
              if self.shipHealthRate == 0.0 {
                
                shield.alpha = 0.0
                shield.setScale(0.0)
                
              } else if self.shipHealthRate == 1.0 {
                
                shield.alpha = 0.15
                shield.setScale(0.5)
                
                
              } else if self.shipHealthRate == 2.0 {
                
                shield.alpha = 0.35
                shield.setScale(0.6)
                
              } else if self.shipHealthRate == 3.0 {
                
                shield.alpha = 0.7
                shield.setScale(0.8)
                
              }
            }
          }
        }
        
        
        // Now, check if the obstacle collided with one of our photon torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.PhotonTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss5) {
            
            myPhoton.removeFromParent()
            
            self.boss5Health -= 1
            if self.boss5Health < 0 {
              boss5.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss5.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            // create explosion
            
            // Call copy() on the node in the template property becuase nodes can only be added to a scene once.
            //
            // If we try to add a node again that already exists in a scene, the game will crash with an error. We must add copies of particle emitter noes that we weish to use moer than once and we will use the emittern  node template that is in our cached property as a template from which to make these copies.
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss5.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // Update our score
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Waggle torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.WaggleTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss5) {
            
            myPhoton.removeFromParent()
            self.boss5Health -= 1
            if self.boss5Health < 0 {
              boss5.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss5.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss5.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spiral torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpiralTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss5) {
            
            myPhoton.removeFromParent()
            self.boss5Health -= 1
            if self.boss5Health < 0 {
              boss5.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss5.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss5.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spreader0 torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpreaderTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss5) {
            
            myPhoton.removeFromParent()
            self.boss5Health -= 1
            if self.boss5Health < 0 {
              boss5.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss5.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss5.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
      }
      
      enumerateChildNodes(withName: Boss6NodeName) {
        boss6, _ in // _ means continue
        
        // Check for collision with our ship
        if ship.intersects(boss6) {
          
          // our ship collided with an obstacle
          //
          // set shipTouch property to nil so it will not
          // be used by our shooting logic in the update()
          // method to continue to track the touch and
          // shoot photon torpedos. If this doesn't work torpedos would continue to fire from (0,0) since the ship is gone.
          if self.shipHealthRate == 0 {
            self.shipTouch = nil
            
            // Remove the ship and the obstacle from the Scene Graph
            ship.removeFromParent()
            self.boss6Health -= 1
            if self.boss6Health < 0 {
              boss6.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss6.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.shipExplodeSound)
            
            let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = ship.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // update timer
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.endGame()
              
            }
            
          } else {
            self.shipHealthRate -= 1
            
            self.boss6Health -= 1
            
            if self.boss6Health < 0 {
              boss6.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss6.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.hurtSound)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.showHealth(Double(self.shipHealthRate))
              
            }
            
            if let shield = ship.childNode(withName: self.ShieldNodeName) {
              
              if self.shipHealthRate == 0.0 {
                
                shield.alpha = 0.0
                shield.setScale(0.0)
                
              } else if self.shipHealthRate == 1.0 {
                
                shield.alpha = 0.15
                shield.setScale(0.5)
                
                
              } else if self.shipHealthRate == 2.0 {
                
                shield.alpha = 0.35
                shield.setScale(0.6)
                
              } else if self.shipHealthRate == 3.0 {
                
                shield.alpha = 0.7
                shield.setScale(0.8)
                
              }
            }
          }
        }
        
        
        // Now, check if the obstacle collided with one of our photon torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.PhotonTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss6) {
            
            myPhoton.removeFromParent()
            
            self.boss6Health -= 1
            if self.boss6Health < 0 {
              boss6.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss6.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            // create explosion
            
            // Call copy() on the node in the template property becuase nodes can only be added to a scene once.
            //
            // If we try to add a node again that already exists in a scene, the game will crash with an error. We must add copies of particle emitter noes that we weish to use moer than once and we will use the emittern  node template that is in our cached property as a template from which to make these copies.
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss6.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // Update our score
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Waggle torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.WaggleTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss6) {
            
            myPhoton.removeFromParent()
            self.boss6Health -= 1
            if self.boss6Health < 0 {
              boss6.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss6.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss6.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spiral torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpiralTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss6) {
            
            myPhoton.removeFromParent()
            self.boss6Health -= 1
            if self.boss6Health < 0 {
              boss6.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss6.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss6.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spreader0 torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpreaderTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss6) {
            
            myPhoton.removeFromParent()
            self.boss6Health -= 1
            if self.boss6Health < 0 {
              boss6.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss6.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss6.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
      }
      
      enumerateChildNodes(withName: Boss7NodeName) {
        boss7, _ in // _ means continue
        
        // Check for collision with our ship
        if ship.intersects(boss7) {
          
          // our ship collided with an obstacle
          //
          // set shipTouch property to nil so it will not
          // be used by our shooting logic in the update()
          // method to continue to track the touch and
          // shoot photon torpedos. If this doesn't work torpedos would continue to fire from (0,0) since the ship is gone.
          if self.shipHealthRate == 0 {
            self.shipTouch = nil
            
            // Remove the ship and the obstacle from the Scene Graph
            ship.removeFromParent()
            self.boss7Health -= 1
            if self.boss7Health < 0 {
              boss7.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss7.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.shipExplodeSound)
            
            let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = ship.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // update timer
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.endGame()
              
            }
            
          } else {
            self.shipHealthRate -= 1
            
            self.boss7Health -= 1
            
            if self.boss7Health < 0 {
              boss7.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss7.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.hurtSound)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.showHealth(Double(self.shipHealthRate))
              
            }
            
            if let shield = ship.childNode(withName: self.ShieldNodeName) {
              
              if self.shipHealthRate == 0.0 {
                
                shield.alpha = 0.0
                shield.setScale(0.0)
                
              } else if self.shipHealthRate == 1.0 {
                
                shield.alpha = 0.15
                shield.setScale(0.5)
                
                
              } else if self.shipHealthRate == 2.0 {
                
                shield.alpha = 0.35
                shield.setScale(0.6)
                
              } else if self.shipHealthRate == 3.0 {
                
                shield.alpha = 0.7
                shield.setScale(0.8)
                
              }
            }
          }
        }
        
        
        // Now, check if the obstacle collided with one of our photon torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.PhotonTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss7) {
            
            myPhoton.removeFromParent()
            
            self.boss7Health -= 1
            if self.boss7Health < 0 {
              boss7.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss7.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            // create explosion
            
            // Call copy() on the node in the template property becuase nodes can only be added to a scene once.
            //
            // If we try to add a node again that already exists in a scene, the game will crash with an error. We must add copies of particle emitter noes that we weish to use moer than once and we will use the emittern  node template that is in our cached property as a template from which to make these copies.
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss7.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // Update our score
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Waggle torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.WaggleTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss7) {
            
            myPhoton.removeFromParent()
            self.boss7Health -= 1
            if self.boss7Health < 0 {
              boss7.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss7.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss7.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spiral torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpiralTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss7) {
            
            myPhoton.removeFromParent()
            self.boss7Health -= 1
            if self.boss7Health < 0 {
              boss7.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss7.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss7.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spreader0 torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpreaderTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss7) {
            
            myPhoton.removeFromParent()
            self.boss7Health -= 1
            if self.boss7Health < 0 {
              boss7.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss7.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss7.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
      }
      
      enumerateChildNodes(withName: Boss8NodeName) {
        boss8, _ in // _ means continue
        
        // Check for collision with our ship
        if ship.intersects(boss8) {
          
          // our ship collided with an obstacle
          //
          // set shipTouch property to nil so it will not
          // be used by our shooting logic in the update()
          // method to continue to track the touch and
          // shoot photon torpedos. If this doesn't work torpedos would continue to fire from (0,0) since the ship is gone.
          if self.shipHealthRate == 0 {
            self.shipTouch = nil
            
            // Remove the ship and the obstacle from the Scene Graph
            ship.removeFromParent()
            self.boss8Health -= 1
            if self.boss8Health < 0 {
              boss8.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss8.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.shipExplodeSound)
            
            let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = ship.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // update timer
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.endGame()
              
            }
            
          } else {
            self.shipHealthRate -= 1
            
            self.boss8Health -= 1
            
            if self.boss8Health < 0 {
              boss8.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss8.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.hurtSound)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.showHealth(Double(self.shipHealthRate))
              
            }
            
            if let shield = ship.childNode(withName: self.ShieldNodeName) {
              
              if self.shipHealthRate == 0.0 {
                
                shield.alpha = 0.0
                shield.setScale(0.0)
                
              } else if self.shipHealthRate == 1.0 {
                
                shield.alpha = 0.15
                shield.setScale(0.5)
                
                
              } else if self.shipHealthRate == 2.0 {
                
                shield.alpha = 0.35
                shield.setScale(0.6)
                
              } else if self.shipHealthRate == 3.0 {
                
                shield.alpha = 0.7
                shield.setScale(0.8)
                
              }
            }
          }
        }
        
        
        // Now, check if the obstacle collided with one of our photon torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.PhotonTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss8) {
            
            myPhoton.removeFromParent()
            
            self.boss8Health -= 1
            if self.boss8Health < 0 {
              boss8.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss8.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            // create explosion
            
            // Call copy() on the node in the template property becuase nodes can only be added to a scene once.
            //
            // If we try to add a node again that already exists in a scene, the game will crash with an error. We must add copies of particle emitter noes that we weish to use moer than once and we will use the emittern  node template that is in our cached property as a template from which to make these copies.
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss8.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // Update our score
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Waggle torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.WaggleTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss8) {
            
            myPhoton.removeFromParent()
            self.boss8Health -= 1
            if self.boss8Health < 0 {
              boss8.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss8.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
            
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss8.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spiral torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpiralTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss8) {
            
            myPhoton.removeFromParent()
            self.boss8Health -= 1
            if self.boss8Health < 0 {
              boss8.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss8.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss8.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spreader0 torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpreaderTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss8) {
            
            myPhoton.removeFromParent()
            self.boss8Health -= 1
            if self.boss8Health < 0 {
              boss8.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss8.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss8.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
      }
      
      enumerateChildNodes(withName: Boss9NodeName) {
        boss9, _ in // _ means continue
        
        // Check for collision with our ship
        if ship.intersects(boss9) {
          
          // our ship collided with an obstacle
          //
          // set shipTouch property to nil so it will not
          // be used by our shooting logic in the update()
          // method to continue to track the touch and
          // shoot photon torpedos. If this doesn't work torpedos would continue to fire from (0,0) since the ship is gone.
          if self.shipHealthRate == 0 {
            self.shipTouch = nil
            
            // Remove the ship and the obstacle from the Scene Graph
            ship.removeFromParent()
            self.boss9Health -= 1
            if self.boss9Health < 0 {
              boss9.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss9.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.shipExplodeSound)
            
            let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = ship.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // update timer
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.endGame()
              
            }
            
          } else {
            self.shipHealthRate -= 1
            
            self.boss9Health -= 1
            
            if self.boss9Health < 0 {
              boss9.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss9.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.hurtSound)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.showHealth(Double(self.shipHealthRate))
              
            }
            
            if let shield = ship.childNode(withName: self.ShieldNodeName) {
              
              if self.shipHealthRate == 0.0 {
                
                shield.alpha = 0.0
                shield.setScale(0.0)
                
              } else if self.shipHealthRate == 1.0 {
                
                shield.alpha = 0.15
                shield.setScale(0.5)
                
                
              } else if self.shipHealthRate == 2.0 {
                
                shield.alpha = 0.35
                shield.setScale(0.6)
                
              } else if self.shipHealthRate == 3.0 {
                
                shield.alpha = 0.7
                shield.setScale(0.8)
                
              }
            }
          }
        }
        
        
        // Now, check if the obstacle collided with one of our photon torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.PhotonTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss9) {
            
            myPhoton.removeFromParent()
            
            self.boss9Health -= 1
            if self.boss9Health < 0 {
              boss9.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss9.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            // create explosion
            
            // Call copy() on the node in the template property becuase nodes can only be added to a scene once.
            //
            // If we try to add a node again that already exists in a scene, the game will crash with an error. We must add copies of particle emitter noes that we weish to use moer than once and we will use the emittern  node template that is in our cached property as a template from which to make these copies.
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss9.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // Update our score
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Waggle torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.WaggleTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss9) {
            
            myPhoton.removeFromParent()
            self.boss9Health -= 1
            if self.boss9Health < 0 {
              boss9.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss9.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss9.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spiral torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpiralTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss9) {
            
            myPhoton.removeFromParent()
            self.boss9Health -= 1
            if self.boss9Health < 0 {
              boss9.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss9.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss9.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spreader0 torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpreaderTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss9) {
            
            myPhoton.removeFromParent()
            self.boss9Health -= 1
            if self.boss9Health < 0 {
              boss9.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss9.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss9.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
      }
      
      enumerateChildNodes(withName: Boss10NodeName) {
        boss10, _ in // _ means continue
        
        // Check for collision with our ship
        if ship.intersects(boss10) {
          
          // our ship collided with an obstacle
          //
          // set shipTouch property to nil so it will not
          // be used by our shooting logic in the update()
          // method to continue to track the touch and
          // shoot photon torpedos. If this doesn't work torpedos would continue to fire from (0,0) since the ship is gone.
          if self.shipHealthRate == 0 {
            self.shipTouch = nil
            
            // Remove the ship and the obstacle from the Scene Graph
            ship.removeFromParent()
            self.boss10Health -= 1
            if self.boss10Health < 0 {
              boss10.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss10.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.shipExplodeSound)
            
            let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = ship.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // update timer
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.endGame()
              
            }
            
          } else {
            self.shipHealthRate -= 1
            
            self.boss10Health -= 1
            
            if self.boss10Health < 0 {
              boss10.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss10.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.hurtSound)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.showHealth(Double(self.shipHealthRate))
              
            }
            
            if let shield = ship.childNode(withName: self.ShieldNodeName) {
              
              if self.shipHealthRate == 0.0 {
                
                shield.alpha = 0.0
                shield.setScale(0.0)
                
              } else if self.shipHealthRate == 1.0 {
                
                shield.alpha = 0.15
                shield.setScale(0.5)
                
                
              } else if self.shipHealthRate == 2.0 {
                
                shield.alpha = 0.35
                shield.setScale(0.6)
                
              } else if self.shipHealthRate == 3.0 {
                
                shield.alpha = 0.7
                shield.setScale(0.8)
                
              }
            }
          }
        }
        
        
        // Now, check if the obstacle collided with one of our photon torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.PhotonTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss10) {
            
            myPhoton.removeFromParent()
            
            self.boss10Health -= 1
            if self.boss10Health < 0 {
              boss10.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss10.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            // create explosion
            
            // Call copy() on the node in the template property becuase nodes can only be added to a scene once.
            //
            // If we try to add a node again that already exists in a scene, the game will crash with an error. We must add copies of particle emitter noes that we weish to use moer than once and we will use the emittern  node template that is in our cached property as a template from which to make these copies.
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss10.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // Update our score
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Waggle torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.WaggleTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss10) {
            
            myPhoton.removeFromParent()
            self.boss10Health -= 1
            if self.boss10Health < 0 {
              boss10.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss10.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss10.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spiral torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpiralTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss10) {
            
            myPhoton.removeFromParent()
            self.boss10Health -= 1
            if self.boss10Health < 0 {
              boss10.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss10.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss10.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spreader0 torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpreaderTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss10) {
            
            myPhoton.removeFromParent()
            self.boss10Health -= 1
            if self.boss10Health < 0 {
              boss10.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss10.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss10.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
      }
      
      enumerateChildNodes(withName: Boss11NodeName) {
        boss11, _ in // _ means continue
        
        // Check for collision with our ship
        if ship.intersects(boss11) {
          
          // our ship collided with an obstacle
          //
          // set shipTouch property to nil so it will not
          // be used by our shooting logic in the update()
          // method to continue to track the touch and
          // shoot photon torpedos. If this doesn't work torpedos would continue to fire from (0,0) since the ship is gone.
          if self.shipHealthRate == 0 {
            self.shipTouch = nil
            
            // Remove the ship and the obstacle from the Scene Graph
            ship.removeFromParent()
            self.boss11Health -= 1
            if self.boss11Health < 0 {
              boss11.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss11.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.shipExplodeSound)
            
            let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = ship.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // update timer
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.endGame()
              
            }
            
          } else {
            self.shipHealthRate -= 1
            
            self.boss11Health -= 1
            
            if self.boss11Health < 0 {
              boss11.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss11.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.hurtSound)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.showHealth(Double(self.shipHealthRate))
              
            }
            
            if let shield = ship.childNode(withName: self.ShieldNodeName) {
              
              if self.shipHealthRate == 0.0 {
                
                shield.alpha = 0.0
                shield.setScale(0.0)
                
              } else if self.shipHealthRate == 1.0 {
                
                shield.alpha = 0.15
                shield.setScale(0.5)
                
                
              } else if self.shipHealthRate == 2.0 {
                
                shield.alpha = 0.35
                shield.setScale(0.6)
                
              } else if self.shipHealthRate == 3.0 {
                
                shield.alpha = 0.7
                shield.setScale(0.8)
                
              }
            }
          }
        }
        
        
        // Now, check if the obstacle collided with one of our photon torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.PhotonTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss11) {
            
            myPhoton.removeFromParent()
            
            self.boss11Health -= 1
            if self.boss11Health < 0 {
              boss11.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss11.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            // create explosion
            
            // Call copy() on the node in the template property becuase nodes can only be added to a scene once.
            //
            // If we try to add a node again that already exists in a scene, the game will crash with an error. We must add copies of particle emitter noes that we weish to use moer than once and we will use the emittern  node template that is in our cached property as a template from which to make these copies.
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss11.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // Update our score
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Waggle torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.WaggleTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss11) {
            
            myPhoton.removeFromParent()
            self.boss11Health -= 1
            if self.boss11Health < 0 {
              boss11.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss11.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss11.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spiral torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpiralTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss11) {
            
            myPhoton.removeFromParent()
            self.boss11Health -= 1
            if self.boss11Health < 0 {
              boss11.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss11.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss11.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spreader0 torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpreaderTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss11) {
            
            myPhoton.removeFromParent()
            self.boss11Health -= 1
            if self.boss11Health < 0 {
              boss11.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss11.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss11.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
      }
      
      
      
      
      enumerateChildNodes(withName: Boss12NodeName) {
        boss12, _ in // _ means continue
        
        // Check for collision with our ship
        if ship.intersects(boss12) {
          
          // our ship collided with an obstacle
          //
          // set shipTouch property to nil so it will not
          // be used by our shooting logic in the update()
          // method to continue to track the touch and
          // shoot photon torpedos. If this doesn't work torpedos would continue to fire from (0,0) since the ship is gone.
          if self.shipHealthRate == 0 {
            self.shipTouch = nil
            
            // Remove the ship and the obstacle from the Scene Graph
            ship.removeFromParent()
            self.boss12Health -= 1
            if self.boss12Health < 0 {
              boss12.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss12.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.shipExplodeSound)
            
            let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = ship.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // update timer
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.endGame()
              
            }
            
          } else {
            self.shipHealthRate -= 1
            
            self.boss12Health -= 1
            
            if self.boss12Health < 0 {
              boss12.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss12.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.hurtSound)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.showHealth(Double(self.shipHealthRate))
              
            }
            
            if let shield = ship.childNode(withName: self.ShieldNodeName) {
              
              if self.shipHealthRate == 0.0 {
                
                shield.alpha = 0.0
                shield.setScale(0.0)
                
              } else if self.shipHealthRate == 1.0 {
                
                shield.alpha = 0.15
                shield.setScale(0.5)
                
                
              } else if self.shipHealthRate == 2.0 {
                
                shield.alpha = 0.35
                shield.setScale(0.6)
                
              } else if self.shipHealthRate == 3.0 {
                
                shield.alpha = 0.7
                shield.setScale(0.8)
                
              }
            }
          }
        }
        
        
        // Now, check if the obstacle collided with one of our photon torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.PhotonTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss12) {
            
            myPhoton.removeFromParent()
            
            self.boss12Health -= 1
            if self.boss12Health < 0 {
              boss12.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss12.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            // create explosion
            
            // Call copy() on the node in the template property becuase nodes can only be added to a scene once.
            //
            // If we try to add a node again that already exists in a scene, the game will crash with an error. We must add copies of particle emitter noes that we weish to use moer than once and we will use the emittern  node template that is in our cached property as a template from which to make these copies.
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss12.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // Update our score
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Waggle torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.WaggleTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss12) {
            
            myPhoton.removeFromParent()
            self.boss12Health -= 1
            if self.boss12Health < 0 {
              boss12.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss12.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss12.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spiral torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpiralTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss12) {
            
            myPhoton.removeFromParent()
            self.boss12Health -= 1
            if self.boss12Health < 0 {
              boss12.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss12.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss12.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spreader0 torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpreaderTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss12) {
            
            myPhoton.removeFromParent()
            self.boss12Health -= 1
            if self.boss12Health < 0 {
              boss12.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss12.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss12.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
      }
      
      
      
      
      enumerateChildNodes(withName: Boss13NodeName) {
        boss13, _ in // _ means continue
        
        // Check for collision with our ship
        if ship.intersects(boss13) {
          
          // our ship collided with an obstacle
          //
          // set shipTouch property to nil so it will not
          // be used by our shooting logic in the update()
          // method to continue to track the touch and
          // shoot photon torpedos. If this doesn't work torpedos would continue to fire from (0,0) since the ship is gone.
          if self.shipHealthRate == 0 {
            self.shipTouch = nil
            
            // Remove the ship and the obstacle from the Scene Graph
            ship.removeFromParent()
            self.boss13Health -= 1
            if self.boss13Health < 0 {
              boss13.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss13.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.shipExplodeSound)
            
            let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = ship.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // update timer
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.endGame()
              
            }
            
          } else {
            self.shipHealthRate -= 1
            
            self.boss13Health -= 1
            
            if self.boss13Health < 0 {
              boss13.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss13.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.hurtSound)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.showHealth(Double(self.shipHealthRate))
              
            }
            
            if let shield = ship.childNode(withName: self.ShieldNodeName) {
              
              if self.shipHealthRate == 0.0 {
                
                shield.alpha = 0.0
                shield.setScale(0.0)
                
              } else if self.shipHealthRate == 1.0 {
                
                shield.alpha = 0.15
                shield.setScale(0.5)
                
                
              } else if self.shipHealthRate == 2.0 {
                
                shield.alpha = 0.35
                shield.setScale(0.6)
                
              } else if self.shipHealthRate == 3.0 {
                
                shield.alpha = 0.7
                shield.setScale(0.8)
                
              }
            }
          }
        }
        
        
        // Now, check if the obstacle collided with one of our photon torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.PhotonTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss13) {
            
            myPhoton.removeFromParent()
            
            self.boss13Health -= 1
            if self.boss13Health < 0 {
              boss13.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss13.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            // create explosion
            
            // Call copy() on the node in the template property becuase nodes can only be added to a scene once.
            //
            // If we try to add a node again that already exists in a scene, the game will crash with an error. We must add copies of particle emitter noes that we weish to use moer than once and we will use the emittern  node template that is in our cached property as a template from which to make these copies.
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss13.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // Update our score
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Waggle torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.WaggleTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss13) {
            
            myPhoton.removeFromParent()
            self.boss13Health -= 1
            if self.boss13Health < 0 {
              boss13.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss13.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss13.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spiral torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpiralTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss13) {
            
            myPhoton.removeFromParent()
            self.boss13Health -= 1
            if self.boss13Health < 0 {
              boss13.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss13.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss13.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spreader0 torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpreaderTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss13) {
            
            myPhoton.removeFromParent()
            self.boss13Health -= 1
            if self.boss13Health < 0 {
              boss13.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss13.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss13.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
      }
      
      enumerateChildNodes(withName: Boss14NodeName) {
        boss14, _ in // _ means continue
        
        // Check for collision with our ship
        if ship.intersects(boss14) {
          
          // our ship collided with an obstacle
          //
          // set shipTouch property to nil so it will not
          // be used by our shooting logic in the update()
          // method to continue to track the touch and
          // shoot photon torpedos. If this doesn't work torpedos would continue to fire from (0,0) since the ship is gone.
          if self.shipHealthRate == 0 {
            self.shipTouch = nil
            
            // Remove the ship and the obstacle from the Scene Graph
            ship.removeFromParent()
            self.boss14Health -= 1
            if self.boss14Health < 0 {
              boss14.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss14.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.shipExplodeSound)
            
            let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = ship.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // update timer
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.endGame()
              
            }
            
          } else {
            self.shipHealthRate -= 1
            
            self.boss14Health -= 1
            
            if self.boss14Health < 0 {
              boss14.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss14.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.hurtSound)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              hud.showHealth(Double(self.shipHealthRate))
              
            }
            
            if let shield = ship.childNode(withName: self.ShieldNodeName) {
              
              if self.shipHealthRate == 0.0 {
                
                shield.alpha = 0.0
                shield.setScale(0.0)
                
              } else if self.shipHealthRate == 1.0 {
                
                shield.alpha = 0.15
                shield.setScale(0.5)
                
                
              } else if self.shipHealthRate == 2.0 {
                
                shield.alpha = 0.35
                shield.setScale(0.6)
                
              } else if self.shipHealthRate == 3.0 {
                
                shield.alpha = 0.7
                shield.setScale(0.8)
                
              }
            }
          }
        }
        
        
        // Now, check if the obstacle collided with one of our photon torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.PhotonTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss14) {
            
            myPhoton.removeFromParent()
            
            self.boss14Health -= 1
            if self.boss14Health < 0 {
              boss14.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss14.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            // create explosion
            
            // Call copy() on the node in the template property becuase nodes can only be added to a scene once.
            //
            // If we try to add a node again that already exists in a scene, the game will crash with an error. We must add copies of particle emitter noes that we weish to use moer than once and we will use the emittern  node template that is in our cached property as a template from which to make these copies.
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss14.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            // Update our score
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Waggle torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.WaggleTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss14) {
            
            myPhoton.removeFromParent()
            self.boss14Health -= 1
            if self.boss14Health < 0 {
              boss14.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss14.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss14.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spiral torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpiralTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss14) {
            
            myPhoton.removeFromParent()
            self.boss14Health -= 1
            if self.boss14Health < 0 {
              boss14.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss14.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss14.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
        // Now, check if the obstacle collided with one of our Spreader0 torpedos using an inner loop (enumeration).
        self.enumerateChildNodes(withName: self.SpreaderTorpedoName) {
          myPhoton, stop in
          
          if myPhoton.intersects(boss14) {
            
            myPhoton.removeFromParent()
            self.boss14Health -= 1
            if self.boss14Health < 0 {
              boss14.removeFromParent()
              let explosion = self.shipExplodeTemplate.copy() as! SKEmitterNode
              explosion.position = boss14.position
              explosion.dieOutInDuration(0.2)
              self.addChild(explosion)
              
              self.bossLevel += 1
              
              if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
                
                hud.showLevel(self.bossLevel)
                
              }
            }
            self.run(self.obstacleExplodeSound)
            
            let explosion = self.obstacleExplodeTemplate.copy() as! SKEmitterNode
            
            explosion.position = boss14.position
            explosion.dieOutInDuration(0.1)
            self.addChild(explosion)
            
            if let hud = self.childNode(withName: self.HUDNodeName) as! HUDNode? {
              
              let score = 10
              
              hud.addPoints(score)
              
            }
            // Set top.pointee to true to end this inner loop
            //
            // This is like break statement n other languages
            stop.pointee = true
            
          }
        }
        
      }
      
    }
  }

}
