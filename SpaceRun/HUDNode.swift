//
//  HUDNode.swift
//  SpaceRun
//
//  Created by Matthew Sargeant on 5/15/17.
//  Copyright © 2017 assignment3 Matthew Sargeant. All rights reserved.
//

import SpriteKit

//
// Create a Heads-Up-Display (HUD) that will hold all of ou display areas.
//
// Once the node is added to the scene, we'll tell it to lay out its child nodes, The child nodes will not contain labels, but will be group containeers which will have the labels inside of them.
//

class HUDNode: SKNode {
  
  // Build two parent nodes as group containers to hold the score and the elapsed game time. Each group will have a title and value label.
  
  // Properties
  private let ScoreGroupName = "scoreGroup"
  private let ScoreValueName = "scoreValue"

  private let HealthGroupName = "healthGroup"
  private let HealthValueName = "healthValue"
  
  
  private let ElapsedGroupName = "elapsedGroup"
  private let ElapsedValueName = "elapsedValue"
  private let TimerActionName = "elapsedGameTimer"
  
  private let PowerupGroupName = "powerupGroup"
  private let PowerupValueName = "powerupValue"
  private let PowerupTimerActionName = "showPowerupTimer"
  
  private let BossIndicatorGroupName = "bossIndicatorGroup"
  private let BossIndicatorTimer = "BossIndicatorTimer"
  private let BossIndicatorValueName = "BossIndicatorValueName"
  
  private let LevelGroupName = "levelGroup"
  private let LevelValueName = "levelValue"
  
  
  var elapsedTime: TimeInterval = 0.0
  var score: Int = 0
  var health: Double = 0.0
  
  lazy private var scoreFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 1
    formatter.maximumFractionDigits = 1
    return formatter
  }()
  
  lazy private var timeFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter
  }()

  lazy private var healthFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .percent
    return formatter
  }()
  
  lazy private var levelFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter
  }()
  
  override init() {
    
    super.init()
  
    //
    // Build an empty SKNode as our containing group and name it... so we can get a reference to it laterfrom the Scene Graph node tree.
    //
    let scoreGroup = SKNode()
    scoreGroup.name = ScoreGroupName
    
    // Score Title setup
    // Create an SKLabelNode
    let scoreTitle = SKLabelNode(fontNamed: "AvenirNext-Medium")
    scoreTitle.fontSize = 12.0
    scoreTitle.fontColor = SKColor.white
    
    // Set the vertical and horizontal alignment nodes in a wa that will hep us lay out the labels inside this group container.
    scoreTitle.horizontalAlignmentMode = .left
    scoreTitle.verticalAlignmentMode = .bottom
    
    scoreTitle.text = "SCORE"
    scoreTitle.position = CGPoint(x: 0.0, y: 4.0)
    
    scoreGroup.addChild(scoreTitle)
    
    // The chld nodes are position relative tothe parent node's origin.
    let scoreValue = SKLabelNode(fontNamed: "AvenirNext-Medium")
    scoreValue.fontSize = 12.0
    scoreValue.fontColor = SKColor.white
    
    // Set the vertical and horizontal alignment nodes in a wa that will hep us lay out the labels inside this group container.
    scoreValue.horizontalAlignmentMode = .left
    scoreValue.verticalAlignmentMode = .top
    scoreValue.name = ScoreValueName
    
    scoreValue.text = "0"
    scoreValue.position = CGPoint(x: 0.0, y: -4.0)
    
    scoreGroup.addChild(scoreValue)
    
    addChild(scoreGroup)
    
    
    
    
    let elapsedGroup = SKNode()
    elapsedGroup.name = ElapsedGroupName
    
    // Elapsed Title setup
    // Create an SKLabelNode
    let elapsedTitle = SKLabelNode(fontNamed: "AvenirNext-Medium")
    elapsedTitle.fontSize = 12.0
    elapsedTitle.fontColor = SKColor.white
    
    // Set the vertical and horizontal alignment nodes in a wa that will hep us lay out the labels inside this group container.
    elapsedTitle.horizontalAlignmentMode = .right
    elapsedTitle.verticalAlignmentMode = .bottom
    
    elapsedTitle.text = "TIME"
    elapsedTitle.position = CGPoint(x: 0.0, y: 4.0)
    
    elapsedGroup.addChild(elapsedTitle)
    
    // The chld nodes are position relative to the parent node's origin.
    let elapsedValue = SKLabelNode(fontNamed: "AvenirNext-Medium")
    elapsedValue.fontSize = 12.0
    elapsedValue.fontColor = SKColor.white
    
    // Set the vertical and horizontal alignment nodes in a wa that will hep us lay out the labels inside this group container.
    elapsedValue.horizontalAlignmentMode = .right
    elapsedValue.verticalAlignmentMode = .top
    elapsedValue.name = ElapsedValueName
    
    elapsedValue.text = "0.0s"
    elapsedValue.position = CGPoint(x: 0.0, y: -4.0)
    
    elapsedGroup.addChild(elapsedValue)
    
    // Add elapsedGroup as a chld of our HUDNode
    addChild(elapsedGroup)
    

    
    
    
    
    let levelGroup = SKNode()
    levelGroup.name = LevelGroupName
    
    // Elapsed Title setup
    // Create an SKLabelNode
    let levelTitle = SKLabelNode(fontNamed: "AvenirNext-Medium")
    levelTitle.fontSize = 12.0
    levelTitle.fontColor = SKColor.white
    
    // Set the vertical and horizontal alignment nodes in a wa that will hep us lay out the labels inside this group container.
    levelTitle.horizontalAlignmentMode = .center
    levelTitle.verticalAlignmentMode = .bottom
    
    levelTitle.text = "LEVEL"
    levelTitle.position = CGPoint(x: 0.0, y: 4.0)
    
    levelGroup.addChild(levelTitle)
    
    // The chld nodes are position relative to the parent node's origin.
    let levelValue = SKLabelNode(fontNamed: "AvenirNext-Medium")
    levelValue.fontSize = 12.0
    levelValue.fontColor = SKColor.white
    
    // Set the vertical and horizontal alignment nodes in a wa that will hep us lay out the labels inside this group container.
    levelValue.horizontalAlignmentMode = .center
    levelValue.verticalAlignmentMode = .top
    levelValue.name = LevelValueName
    
    levelValue.text = "1"
    levelValue.position = CGPoint(x: 0.0, y: -4.0)
    
    levelGroup.addChild(levelValue)
    
    // Add elapsedGroup as a chld of our HUDNode
    addChild(levelGroup)
    
    
    
    
    let healthGroup = SKNode()
    healthGroup.name = HealthGroupName
    
    // Score Title setup
    // Create an SKLabelNode
    let healthTitle = SKLabelNode(fontNamed: "AvenirNext-Medium")
    healthTitle.fontSize = 12.0
    healthTitle.fontColor = SKColor.white
    
    // Set the vertical and horizontal alignment nodes in a wa that will hep us lay out the labels inside this group container.
    healthTitle.horizontalAlignmentMode = .center
    healthTitle.verticalAlignmentMode = .bottom
    
    healthTitle.text = "Health"
    healthTitle.position = CGPoint(x: 0.0, y: 4.0)
    
    healthGroup.addChild(healthTitle)
    
    // The chld nodes are position relative tothe parent node's origin.
    let healthValue = SKLabelNode(fontNamed: "AvenirNext-Medium")
    healthValue.fontSize = 12.0
    healthValue.fontColor = SKColor.white
    
    // Set the vertical and horizontal alignment nodes in a wa that will hep us lay out the labels inside this group container.
    healthValue.horizontalAlignmentMode = .center
    healthValue.verticalAlignmentMode = .top
    healthValue.name = HealthValueName
    
    healthValue.text = "0"
    healthValue.position = CGPoint(x: 0.0, y: -4.0)
    
    healthGroup.addChild(healthValue)
    
    addChild(healthGroup)
    
    
    
    let powerupGroup = SKNode()
    powerupGroup.name = PowerupGroupName
    
    // Create an SKLabelNode for our title
    let powerupTitle = SKLabelNode(fontNamed: "AvenirNext-Bold")
    
    powerupTitle.fontSize = 14.0
    powerupTitle.fontColor = SKColor.red
    
    // Set the vertical and horizontal alignment modes in way
    // that will help use lay out the labels inside this group node.
    powerupTitle.verticalAlignmentMode = .bottom
    powerupTitle.text = "Power-up!"
    powerupTitle.position = CGPoint(x: 0.0, y: 4.0)
    
    powerupGroup.addChild(powerupTitle)
    
    
    // Set up actions to make our Power-down timer pulse
    powerupTitle.run(SKAction.repeatForever(SKAction.sequence([SKAction.scale(to: 1.3, duration: 0.3), SKAction.scale(to: 1.0, duration: 0.3)])))
    
    
    let powerupValue = SKLabelNode(fontNamed: "AvenirNext-Bold")
    
    powerupValue.fontSize = 20.0
    powerupValue.fontColor = SKColor.red
    
    // Set the vertical and horizontal alignment modes in way
    // that will help use lay out the labels inside this group node.
    powerupValue.verticalAlignmentMode = .top
    powerupValue.name = PowerupValueName
    powerupValue.text = "0.0s left"
    powerupValue.position = CGPoint(x: 0.0, y: -4.0)
    
    powerupGroup.addChild(powerupValue)
    
    // Add elapsedGroup as a child of our HUD node
    addChild(powerupGroup)
    
    powerupGroup.alpha = 0.0   // make it invisible to start
    

    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  //
  // Our labels are properly layed out within their parent group nodes but the group nodes are centered on the scren. We need to create a layout method to properly position these groups on the screen.
  //
  func layoutForScene() {
    
    if let scene = scene {
      
      let sceneSize = scene.size
      
      
      // This will be used to calculate the position of each group
      var groupSize = CGSize.zero
      
      if let scoreGroup = childNode(withName: ScoreGroupName) {
        
        groupSize = scoreGroup.calculateAccumulatedFrame().size

        scoreGroup.position = CGPoint(x: 0.0 - sceneSize.width/2.0 + 20.0, y: sceneSize.height/2.0 - groupSize.height)
        
        
      } else {
        assert(false, "No score group node was found in the Scene Graph Node tree")
      }
      
      if let elapsedGroup = childNode(withName: ElapsedGroupName) {
        
        groupSize = elapsedGroup.calculateAccumulatedFrame().size
        
        elapsedGroup.position = CGPoint(x: sceneSize.width/2.0 - 20.0, y: sceneSize.height/2.0 - groupSize.height)
        
        
      } else {
        assert(false, "No elapsed group node was found in the Scene Graph Node tree")
      }
      
      if let healthGroup = childNode(withName: HealthGroupName) {
        
        groupSize = healthGroup.calculateAccumulatedFrame().size
        
        healthGroup.position = CGPoint(x: -sceneSize.width/2 + groupSize.width, y: -sceneSize.height/2 + groupSize.height)
        
        
      } else {
        assert(false, "No health group node was found in the Scene Graph Node tree")
      }
      
      
      if let powerupGroup = childNode(withName: PowerupGroupName) {
        
        groupSize = powerupGroup.calculateAccumulatedFrame().size
        
        powerupGroup.position = CGPoint(x: 0.0, y: sceneSize.height/2.0 - groupSize.height)
        
      } else {
        assert(false, "No elapsed group node was found in the node tree")
      }

      if let levelGroup = childNode(withName: LevelGroupName) {
        
        groupSize = levelGroup.calculateAccumulatedFrame().size
        
        levelGroup.position = CGPoint(x: 0.0, y: sceneSize.height/2.0 - groupSize.height)
        
      } else {
        assert(false, "No level group node was found in the node tree")
      }
      
    }
    
  }
  
  //
  // This method will add new points to the score
  //
  func addPoints(_ points: Int) {
    
    score += points
    
    // Look up our score value label in the scene graph by name
    if let scoreValue = childNode(withName: "\(ScoreGroupName)/\(ScoreValueName)") as! SKLabelNode? {
    
      // Format our score with the thousands separator using our lazy cached self.scoreFormatter property.
      scoreValue.text = scoreFormatter.string(from: NSNumber(value: score))
      
      // Scale the noe up for a brief period of time and and then scale it back down
      scoreValue.run(SKAction.sequence([SKAction.scale(to: 1.1, duration: 0.02), SKAction.scale(to: 1.0, duration: 0.07)]))

      
  }
  
  
  }
  
  func showHealth(_ currentHealth: Double) {
    
   if let healthValue = childNode(withName: "\(HealthGroupName)/\(HealthValueName)") as! SKLabelNode? {
    
    healthValue.text = healthFormatter.string(from: NSNumber(value: Double(currentHealth/4)))
 
    healthValue.run(SKAction.sequence([SKAction.scale(to: 1.1, duration: 0.02), SKAction.scale(to: 1.0, duration: 0.07)]))
    
    }
  }
  
  func showLevel(_ currentLevel: Int) {
    if let levelValue = childNode(withName: "\(LevelGroupName)/\(LevelValueName)") as! SKLabelNode? {
      
      levelValue.text = levelFormatter.string(from: NSNumber(value: Double(currentLevel)))
      
      levelValue.run(SKAction.sequence([SKAction.scale(to: 1.1, duration: 0.02), SKAction.scale(to: 1.0, duration: 0.07)]))
      
    }
  }
  
  //
  // Show our Weapons Powerup Timer - countdown
  //
  func showPowerupTimer(_ time: TimeInterval) {
    
    if let powerupGroup = childNode(withName: PowerupGroupName) {
      
      // Remove any existing action with the following key because
      // we want to restart the timer as we are calling this method
      // as a result of the player collection a weapons powerup
      powerupGroup.removeAction(forKey: PowerupTimerActionName)
      
      // Look up powerValue node by name
      if let powerupValue = powerupGroup.childNode(withName: PowerupValueName) as! SKLabelNode? {
        
        // Run the countdown sequence
        //
        // The action will repeat itself every 0.05 seconds in order
        // to update the text in the powerupValue label.
        //
        // We will reuse the self.timeFormatter so we need to use a
        // weak reference to self to ensure the block does not retain self
        // which would produce a memory leak.
        //
        let start = Date.timeIntervalSinceReferenceDate
        
        let block = SKAction.run {
          [weak self] in
          
          if let weakSelf = self {
            
            let elapsedTime = Date.timeIntervalSinceReferenceDate - start
            let timeLeft = max(time - elapsedTime, 0)
            
            let timeLeftFormat = weakSelf.timeFormatter.string(from: NSNumber(value: timeLeft))!
            
            powerupValue.text = "\(timeLeftFormat)s left"
            
          }
          
        }
        
        // Actions
        let countDownSequence = SKAction.sequence([block, SKAction.wait(forDuration: 0.05)])
        
        let countDown = SKAction.repeatForever(countDownSequence)
        
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: 0.1)
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 1.0)
        
        let stopAction = SKAction.run({ () -> Void in
          
          powerupGroup.removeAction(forKey: self.PowerupTimerActionName)
          
        })
        
        let visuals = SKAction.sequence([fadeIn, SKAction.wait(forDuration: time), fadeOut, stopAction])
        
        powerupGroup.run(SKAction.group([countDown, visuals]), withKey: self.PowerupTimerActionName)
        
      }
      
    }
    
  }
  
  
  
  
  
  func startGame() {
    
    // Calculate the time stamp when starting the game
    
    let startTime = Date.timeIntervalSinceReferenceDate
    
    if let elapsedValue = childNode(withName: "\(ElapsedGroupName)/\(ElapsedValueName)") as! SKLabelNode? {

      // Use a code block to update the elapsedTime property to be the difference between the start time and the current timestamp.
      let update = SKAction.run({
        [weak self] in
        
        if let weakSelf = self {
          
          let currentTime = Date.timeIntervalSinceReferenceDate
          
          weakSelf.elapsedTime  = currentTime - startTime
          
          elapsedValue.text = weakSelf.timeFormatter.string(from: NSNumber(value: weakSelf.elapsedTime))
          
        }
        
      })
      
      let updateAndDelay = SKAction.sequence([update, SKAction.wait(forDuration: 0.05)])
      
      let timer = SKAction.repeatForever(updateAndDelay)
      
      run(timer, withKey: TimerActionName)
      
    }
    
    
  }
  
  func endGame() {
    
    // Stop the timer sequence
    removeAction(forKey: TimerActionName)
    
  }
  
}

