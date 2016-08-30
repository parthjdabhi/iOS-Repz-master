//
//  ThirdScreen.swift
//  Repz
//
//  Created by Dustin Allen on 8/14/16.
//  Copyright © 2016 Harloch. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ThirdScreen : UIViewController {
    
    
    let manager:IconManager = IconManager.sharedManager()
    let kBaseTag = 1001
    
    var imageViewArray:[UIView] = []
    var timerArray:[NSTimer] = []
    var lineLayerArray:[CALayer] = []
    
    var bDrawComplete:Bool = true
    
    //(100/(1024/307))-100
    var kXRate: CGFloat = 0.7001//0.667 //1.2998
    
    var iconName:String = ""
    let delegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet var toolBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Preview"
        
        let newBackButton = UIBarButtonItem.init(title: "Back", style: .Plain, target: self, action: #selector(ThirdScreen.goToback))
        self.navigationItem.leftBarButtonItem = newBackButton
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        
        loadIcons()
        layoutIcons()
    }
    
    func goToback() {
        //self.navigationController?.popViewControllerAnimated(false)
        //self.navigationController?.popViewControllerAnimated(false)
        
        let firstScreenVC = self.storyboard?.instantiateViewControllerWithIdentifier("FirstScreen") as! FirstScreen
        self.navigationController?.pushViewController(firstScreenVC, animated: true)
    }
    
    func loadIcons() {
        manager.iconArrary.removeAll()
        let managedContext = delegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Icon")
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            let iconObjects = results as? [NSManagedObject]
            
            if iconObjects == nil {
                return
            }
            
            for iconObject in iconObjects! {
                let name = String(iconObject.valueForKey("name") as! String)
                
                if iconName.compare(name) == .OrderedSame {
                    addIcons(iconObject)
                }
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func addIcons(object:NSManagedObject) {
        let icon = Icon()
        
        icon.name = object.valueForKey("name") as! String
        icon.fileName = object.valueForKey("fileName") as! String
        icon.image = UIImage(named: icon.fileName)
        icon.startPos = CGPointMake(object.valueForKey("startPosX") as! CGFloat, object.valueForKey("startPosY") as! CGFloat)
        icon.offset = CGPointMake(object.valueForKey("offsetX") as! CGFloat, object.valueForKey("offsetX") as! CGFloat)
        
        let pathData:NSData? = object.valueForKey("path") as? NSData
        if pathData != nil {
            let array = NSKeyedUnarchiver.unarchiveObjectWithData(pathData!) as! [NSValue]
            
            icon.path.removeAll()
            for value in array {
                let pos = value.CGPointValue()
                icon.path.append(pos)
            }
        }
        
        manager.addIcon(icon)
    }
    
    func layoutIcons() {
        var tag = 0
        
        for icon in manager.iconArrary {
            
            var imageView:UIImageView? = self.view.viewWithTag(kBaseTag + tag) as? UIImageView
            if imageView == nil {
                imageView = UIImageView(image: icon.image)
                self.view.addSubview(imageView!)
                imageView!.tag = kBaseTag + tag
            }
            
            imageView!.frame = CGRectMake(icon.startPos.x / kXRate, icon.startPos.y, imageView!.frame.size.width, imageView!.frame.size.height)
            tag += 1
        }
        
    }
    
    @IBAction func onClickPlay(sender: AnyObject) {
        if bDrawComplete == false {
            return
        }
        
        layoutIcons()
        removeAllLines()
        play()
    }
    
    func play() {
        var nodeCount:Int = 0
        var delayTime: NSTimeInterval = 0
        let duration:NSTimeInterval = 0.1
        
        var bComplete:Bool = false
        bDrawComplete = false
        
        timerArray.removeAll()
        lineLayerArray.removeAll()
        
        while bComplete == false {
            
            bComplete = true
            var tag = 0
            for icon in manager.iconArrary {
                let imageView:UIView = self.view.viewWithTag(kBaseTag + tag)!
                tag += 1
                
                if icon.path.count > nodeCount {
                    bComplete = false
                }
                else {
                    continue
                }
                
                UIView.animateWithDuration(duration, delay: delayTime, options: .CurveLinear, animations: {
                    () in
                    imageView.frame = CGRectMake(icon.path[nodeCount].x / self.kXRate, icon.path[nodeCount].y, imageView.frame.size.width, imageView.frame.size.height)
                    }, completion: {
                        (bFinish) in
                        
                })
                
                if (nodeCount > 0) {
                    let dic = NSMutableDictionary()
                    dic.setObject(NSValue(CGPoint: icon.path[nodeCount - 1]), forKey: "startPos")
                    dic.setObject(NSValue(CGPoint: icon.path[nodeCount]), forKey: "endPos")
                    dic.setObject(imageView, forKey: "imageView")
                    
                    let timer = NSTimer.scheduledTimerWithTimeInterval(delayTime, target: self, selector: #selector(ThirdScreen.drawLine(_:)), userInfo: dic, repeats: false)
                    timerArray.append(timer)
                }
                
                delayTime = duration * Double(nodeCount + 1)
                
            }
            nodeCount += 1
        }
        
        bDrawComplete = true
    }
    
    @IBAction func onClickRestart(sender: AnyObject) {
        
        if bDrawComplete == false {
            return
        }
        
        layoutIcons()
        removeAllLines()
        play()
    }
    
    func removeAllLines() {
        
        for timer in timerArray {
            timer.invalidate()
        }
        timerArray.removeAll()
        
        let subLayers:[CALayer]? = self.view.layer.sublayers
        
        for sublayer in subLayers! {
            sublayer.removeAllAnimations()
        }
        
        for sublayer in lineLayerArray {
            sublayer.removeFromSuperlayer()
        }
    }
    
//    func drawLine(pos1: CGPoint, pos2: CGPoint, imageView:UIView, startTime:NSTimeInterval) {
    func drawLine(timer:NSTimer) {
        
        let dic = timer.userInfo as! NSDictionary
        
        if dic.count == 0 {
            return
        }
        
        let pos1 = (dic.objectForKey("startPos") as! NSValue).CGPointValue()
        let pos2 = (dic.objectForKey("endPos") as! NSValue).CGPointValue()
        let imageView = dic.objectForKey("imageView") as! UIView
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(pos1.x / kXRate + imageView.frame.size.width / 2, pos1.y + imageView.frame.size.height / 2))
        path.addLineToPoint(CGPointMake(pos2.x / kXRate + imageView.frame.size.width / 2, pos2.y + imageView.frame.size.height / 2))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = UIColor.whiteColor().CGColor
        shapeLayer.lineWidth = 3.0
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        
        self.view.layer.insertSublayer(shapeLayer, below: imageView.layer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        // Set the animation duration appropriately
        animation.duration = 0.1
        
        // Animate from 0 (no circle) to 1 (full circle)
        animation.fromValue = 0
        animation.toValue = 1
        
        // Do a linear animation (i.e. the speed of the animation stays the same)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        shapeLayer.addAnimation(animation, forKey: "animateLine")
        
        lineLayerArray.append(shapeLayer)
    }
}