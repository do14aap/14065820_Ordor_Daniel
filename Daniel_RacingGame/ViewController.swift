//
//  ViewController.swift
//  Daniel_RacingGame
//
//  Created by Daniel Ordor on 26/03/2018.
//  Copyright © 2018 Daniel Ordor. All rights reserved.
//

import UIKit

protocol subviewDelegate {
    func change()
    
}
class ViewController: UIViewController, subviewDelegate {
    func change() {
        
    
        CBehaviour.removeAllBoundaries()
        CBehaviour.addBoundary(withIdentifier: "UserCar" as NSCopying, for: UIBezierPath(rect: carImage.frame))
       
        Score = Score - 2
        self.ShotClock.text = String(self.Score)
    }
    
    @IBOutlet weak var replay: UIButton!
    @IBOutlet weak var ShotClock: UILabel!
    
    var carGameAnimator: UIDynamicAnimator!
    var DIBehaviour: UIDynamicItemBehavior!
    var GBehaviour: UIGravityBehavior!
    var CBehaviour: UICollisionBehavior!
    var Score = 0;
    var ScoreArray: [UIImageView] = []
    let GameOver = UIImageView(image: nil)
    
    
    let carArrary = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    
    @IBOutlet weak var roadImage: UIImageView!
    
    @IBOutlet weak var carImage: DraggedImageView!
    
    @IBAction func restart(_ sender: Any) {
        viewDidLoad()
        
        ShotClock.text = ""
        Score = 0;
        GameOver.isHidden = true
        replay.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        carImage.myDelegate = self
        
        carGameAnimator = UIDynamicAnimator(referenceView: self.view)
        DIBehaviour = UIDynamicItemBehavior(items:[])
        CBehaviour = UICollisionBehavior(items:[])

        
        for index in 0...19 {
            
            let delay = Double(self.carArrary[index])
            let when = DispatchTime.now() + delay
            
        DispatchQueue.main.asyncAfter(deadline: when ) {
            
            let carObstacle = arc4random_uniform(7)
            let carObstacleView = UIImageView(image: nil)
            let ScrWidth = UIScreen.main.bounds.width
            
            switch carObstacle {
            case 1: carObstacleView.image = UIImage(named: "car3.png")
            case 2: carObstacleView.image = UIImage(named: "car4.png")
            case 3: carObstacleView.image = UIImage(named: "car5.png")
            case 4: carObstacleView.image = UIImage(named: "car6.png")
            default:
                carObstacleView.image = UIImage(named: "car6.png")
            }
            
            carObstacleView.frame = CGRect(x: Int(arc4random_uniform(UInt32(ScrWidth))), y: 0, width: 40, height: 65)
            
            self.view.addSubview(carObstacleView)
            self.view.bringSubview(toFront: carObstacleView)
            
            self.DIBehaviour.addItem(carObstacleView)
            self.DIBehaviour.addLinearVelocity(CGPoint(x: 0, y: 200), for: carObstacleView)
            self.CBehaviour.addItem(carObstacleView)
            
            self.ScoreArray.append((carObstacleView))
            self.Score += 2
            self.ShotClock.text = String(describing: self.ShotClock)

            }
        
        }
        
        carGameAnimator.addBehavior(DIBehaviour)
        CBehaviour = UICollisionBehavior(items: [])
        CBehaviour.translatesReferenceBoundsIntoBoundary = false
        carGameAnimator.addBehavior(CBehaviour)
        
        let GameEnd = DispatchTime.now() + 20
        DispatchQueue.main.asyncAfter(deadline: GameEnd) {
            
            self.GameOver.isHidden = false
            self.replay.isHidden = false
            self.GameOver.image = UIImage(named: "game_over.jpg")
            self.GameOver.frame = UIScreen.main.bounds
            self.view.addSubview(self.GameOver)
            self.view.bringSubview(toFront: self.GameOver)
            self.view.bringSubview(toFront: self.replay)
        }
        
        
        var imageArray : [UIImage]!
        
        
        imageArray = [UIImage(named: "road1.png")!,
                      UIImage(named: "road2.png")!,
                      UIImage(named: "road3.png")!,
                      UIImage(named: "road4.png")!,
                      UIImage(named: "road5.png")!,
                      UIImage(named: "road6.png")!,
                      UIImage(named: "road7.png")!,
                      UIImage(named: "road8.png")!,
                      UIImage(named: "road9.png")!,
                      UIImage(named: "road10.png")!]
        
         roadImage.image = UIImage.animatedImage(with: imageArray, duration: 0.2)
    
        
    }
        
      //  UIView.animate(withDuration: 2, delay: 0.0, options: [UIViewAnimationOptions.repeat, .curveLinear], animations:
           // {
             //   self.roadImage.alpha = 0.0
              //  self.roadImage.center.x += self.view.bounds.width
                
      //  }, completion: nil
      //  )
        
 //   }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

