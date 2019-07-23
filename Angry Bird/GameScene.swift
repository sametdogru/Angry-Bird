//
//  GameScene.swift
//  Angry Bird
//
//  Created by MacBookPro on 9.07.2019.
//  Copyright © 2019 Samet Dogru. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  
    
    var bird = SKSpriteNode()
    var box = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    var gameStarted = false
    
    var originalPosition : CGPoint!
    var originalPosition2 : CGPoint!
    var originalPosition3 : CGPoint!
    var originalPosition4 : CGPoint!
    var originalPosition5 : CGPoint!
    var originalPosition6 : CGPoint!
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    
    enum ColliderType: UInt32 {
        case Bird = 1
        case Box = 2
    }
    
    override func didMove(to view: SKView) {
       
        
         physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        //delegate
        
        physicsWorld.contactDelegate = self
        
        //bird
        
        let birdTexture = SKTexture(imageNamed: "bird.png")
        
        bird = childNode(withName: "bird") as! SKSpriteNode
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 12)
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.mass = 0.1
        bird.physicsBody?.affectedByGravity = false
        originalPosition = bird.position

        
        bird.physicsBody!.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody!.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody!.collisionBitMask = ColliderType.Box.rawValue
        
        let boxTexture = SKTexture(imageNamed: "box.png")
        let size = CGSize(width: boxTexture.size().width / 5, height: boxTexture.size().height / 5)
        
        box = childNode(withName: "box") as! SKSpriteNode
        box.physicsBody = SKPhysicsBody(rectangleOf: size)
        box.physicsBody?.isDynamic = true
        box.physicsBody?.affectedByGravity = true
        box.physicsBody?.allowsRotation = true
        originalPosition2 = box.position

        box.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue

        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.allowsRotation = true
        originalPosition3 = box2.position

        box2.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.allowsRotation = true
        originalPosition4 = box3.position

        box3.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue

        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.allowsRotation = true
        originalPosition5 = box4.position
        
        box4.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue

        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.allowsRotation = true
        originalPosition6 = box5.position

        box5.physicsBody!.collisionBitMask = ColliderType.Bird.rawValue
        
        
        //score
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        scoreLabel.zPosition = 3
        self.addChild(scoreLabel)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyB.collisionBitMask  == ColliderType.Bird.rawValue || contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue {
            
            score = score + 1
            scoreLabel.text = String(score)
            
        }
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
            
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                        
                    }
                }
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if gameStarted == false {
            if let touch = touches.first {
                
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    
                    for node in touchNodes {
                        
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                
                                let dx = -(touchLocation.x - originalPosition.x)
                                let dy = -(touchLocation.y - originalPosition.y)
                                
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                
                                gameStarted = true
                                
                                
                            }
                        }
                        
                    }
                }
            }
        }
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if let birdPhysicsBody = bird.physicsBody {
            if birdPhysicsBody.velocity.dx <= 1
                && birdPhysicsBody.velocity.dy <= 1 && birdPhysicsBody.angularVelocity <= 1 && gameStarted == true {
                
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.zRotation = 0
                bird.position = originalPosition
                
                box.position = originalPosition2
                box2.position = originalPosition3
                box3.position = originalPosition4
                box4.position = originalPosition5
                box5.position = originalPosition6
                
                
                score = 0
                scoreLabel.text = String(score)
                
                gameStarted = false
                
                
                
            }
        }
    }

}
