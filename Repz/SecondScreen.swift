//
//  SecondScreen.swift
//  Repz
//
//  Created by Dustin Allen on 8/14/16.
//  Copyright © 2016 Harloch. All rights reserved.
//

import Foundation
import UIKit


class SecondScreen: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let manager = IconManager.sharedManager()
    let kBaseTag = 1001
    // Below Half
    let CY:CGFloat = 650 //+ 64 //683
    
    @IBOutlet var cover2: UIButton!
    @IBOutlet var cover3: UIButton!
    
    @IBOutlet var btnDefencePass: UIButton!
    @IBOutlet var btnDefenceRun: UIButton!
    @IBOutlet var btnOffence3x4: UIButton!
    @IBOutlet var btnOffence4x3: UIButton!
    
    var startPos:CGPoint = CGPointZero
    var endPos:CGPoint = CGPointZero
    
    var iconName:String = ""
    var iconCount:Int = 0
    var pickerDataSource:[String] = [];

    enum LayoutType {
        case LayoutType_1
        case LayoutType_2
    }
    
    var deltaBoolFirst:Bool = true
    var deltaBoolSecond:Bool = true
    var iconPosArr:[CGPoint]!
    
    var iconRandomCircleArr_1:[CGPoint]!
    var iconRandomCircleArr_2:[CGPoint]!
    var iconRandomCrossArr_1:[CGPoint]!
    var iconRandomCrossArr_2:[CGPoint]!
    
    var iconPosDeffencePass:[CGPoint]!
    var iconPosDeffenceRun:[CGPoint]!
    
    var iconPosOffence3x4:[CGPoint]!
    var iconPosOffence4x3:[CGPoint]!
    
    var isLayoutSaving:Bool = false
    var shapeLayer:CAShapeLayer = CAShapeLayer()

    var iconType:IconType!
    
    var iconCrossInitalPosArr:NSMutableArray = NSMutableArray()
    var iconCircleInitalPosArr:NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet var nameField: UITextField!
    @IBOutlet weak var layoutName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iconType = IconType.Cross
        nameField.text = iconName
        let screenSize = UIScreen.mainScreen().bounds.size
        //it's array1 to store postion of all icons
//        iconPosArr = [CGPointMake(screenSize.width * 0.445312, self.view.frame.size.height * 0.072266),//0
//                      CGPointMake(screenSize.width * 0.628906, self.view.frame.size.height * 0.472070),//1
//                      CGPointMake(screenSize.width * 0.476562, self.view.frame.size.height * 0.451563),//2
//                      CGPointMake(screenSize.width * 0.332899, self.view.frame.size.height * 0.630273),//3
//                      CGPointMake(screenSize.width * 0.169010, self.view.frame.size.height * 0.322656),//4
//                      CGPointMake(screenSize.width * 0.196701, self.view.frame.size.height * 0.486719),//5
//                      CGPointMake(screenSize.width * 0.224219, self.view.frame.size.height * 0.444727),//6
//                      CGPointMake(screenSize.width * 0.324653, self.view.frame.size.height * 0.487695),//7
//                      CGPointMake(screenSize.width * 0.443056, self.view.frame.size.height * 0.364583),//8
//                      CGPointMake(screenSize.width * 0.031250, self.view.frame.size.height * 0.450195),//9
//                      CGPointMake(screenSize.width * 20.098958, self.view.frame.size.height * 20.885742),
//                      CGPointMake(screenSize.width * 0.125347, self.view.frame.size.height * 0.575195),//10
//                      CGPointMake(screenSize.width * 0.597656, self.view.frame.size.height * 0.358398),//11
//                      CGPointMake(screenSize.width * 0.446615, self.view.frame.size.height * 0.488672),//12
//                      CGPointMake(screenSize.width * 0.352865, self.view.frame.size.height * 0.446680),//13
//                      CGPointMake(screenSize.width * 0.461892, self.view.frame.size.height * 0.677148),//14
//                      CGPointMake(screenSize.width * 0.292795, self.view.frame.size.height * 0.446680),//15
//                      CGPointMake(screenSize.width * 0.261719, self.view.frame.size.height * 0.488672),//16
//                      CGPointMake(screenSize.width * 0.190451, self.view.frame.size.height * 0.082422),//17
//                      CGPointMake(screenSize.width * 0.508767, self.view.frame.size.height * 0.489583),//18
//                      CGPointMake(screenSize.width * 0.000434, self.view.frame.size.height * 0.365625),//19
//                      CGPointMake(screenSize.width * 0.385417, self.view.frame.size.height * 0.488932),//20
//                      CGPointMake(screenSize.width * 0.321788, self.view.frame.size.height * 0.372721),//21
//        ]
        
        //For Set Default Value Generating Cover3 Mode
        iconPosArr = [CGPointMake(278,590),//0
            CGPointMake(344,590),//1
            CGPointMake(410,590),//2
            CGPointMake(495,590),//3
            CGPointMake(48,506),//4
            CGPointMake(202,535),//5
            CGPointMake(278,535),//6
            CGPointMake(434,535),//7
            CGPointMake(530,543),//8
            CGPointMake(648,553),//9
            //CGPointMake(48,506),
            CGPointMake(332,198),//10
            CGPointMake(30,CY+53),//11
            CGPointMake(140,CY+140),//12
            CGPointMake(266,CY+25),//13
            CGPointMake(320,CY+25),//14
            CGPointMake(376,CY+25),//15
            CGPointMake(424,CY+25),//16
            CGPointMake(475,CY+25),//17
            CGPointMake(530,CY+140),//18
            CGPointMake(644,CY+25),//19
            CGPointMake(278,CY+166),//20
            CGPointMake(344,CY+153),//21
         ]
            
        iconRandomCircleArr_1 = [
            CGPointMake(screenSize.width * 0.628906, self.view.frame.size.height * 0.472070),
            CGPointMake(screenSize.width * 0.332899, self.view.frame.size.height * 0.630273),
            CGPointMake(screenSize.width * 0.196701, self.view.frame.size.height * 0.486719),
            CGPointMake(screenSize.width * 0.324653, self.view.frame.size.height * 0.487695),
            CGPointMake(screenSize.width * 0.031250, self.view.frame.size.height * 0.450195),
            CGPointMake(screenSize.width * 0.125347, self.view.frame.size.height * 0.575195),
            CGPointMake(screenSize.width * 0.446615, self.view.frame.size.height * 0.488672),
            CGPointMake(screenSize.width * 0.461892, self.view.frame.size.height * 0.677148),
            CGPointMake(screenSize.width * 0.261719, self.view.frame.size.height * 0.488672),
            CGPointMake(screenSize.width * 0.508767, self.view.frame.size.height * 0.489583),
            CGPointMake(screenSize.width * 0.385417, self.view.frame.size.height * 0.488932),
        ]
        iconRandomCircleArr_2 = [
            CGPointMake(screenSize.width * 0.589844, self.view.frame.size.height * 0.846093),
            CGPointMake(screenSize.width * 0.310764, self.view.frame.size.height * 0.767968),
            CGPointMake(screenSize.width * 0.184982, self.view.frame.size.height * 0.625391),
            CGPointMake(screenSize.width * 0.340278, self.view.frame.size.height * 0.612695),
            CGPointMake(screenSize.width * 0.024740, self.view.frame.size.height * 0.560547),
            CGPointMake(screenSize.width * 0.069357, self.view.frame.size.height * 0.731445),
            CGPointMake(screenSize.width * 0.464844, self.view.frame.size.height * 0.579492),
            CGPointMake(screenSize.width * 0.465798, self.view.frame.size.height * 0.799218),
            CGPointMake(screenSize.width * 0.162761, self.view.frame.size.height * 0.523828),
            CGPointMake(screenSize.width * 0.556944, self.view.frame.size.height * 0.644856),
            CGPointMake(screenSize.width * 0.414063, self.view.frame.size.height * 0.709635),
        ]
        iconRandomCrossArr_1 = [
            CGPointMake(screenSize.width * 0.598958, self.view.frame.size.height * 0.081055),
            CGPointMake(screenSize.width * 0.602864, self.view.frame.size.height * 0.386133),
            CGPointMake(screenSize.width * 0.172916, self.view.frame.size.height * 0.224023),
            CGPointMake(screenSize.width * 0.177344, self.view.frame.size.height * 0.373438),
            CGPointMake(screenSize.width * 0.436546, self.view.frame.size.height * 0.190755),
            CGPointMake(screenSize.width * 0.071614, self.view.frame.size.height * 0.833984),
            CGPointMake(screenSize.width * 0.597656, self.view.frame.size.height * 0.242187),
            CGPointMake(screenSize.width * 0.464844, self.view.frame.size.height * 0.375391),
            CGPointMake(screenSize.width * 0.318837, self.view.frame.size.height * 0.398828),
            CGPointMake(screenSize.width * 0.048524, self.view.frame.size.height * 0.079492),
            CGPointMake(screenSize.width * 0.049913, self.view.frame.size.height * 0.286523),
            CGPointMake(screenSize.width * 0.326996, self.view.frame.size.height * 0.290690),
        ]
        iconRandomCrossArr_2 = [
            CGPointMake(screenSize.width * 0.445312, self.view.frame.size.height * 0.072266),
            CGPointMake(screenSize.width * 0.476562, self.view.frame.size.height * 0.451563),
            CGPointMake(screenSize.width * 0.169010, self.view.frame.size.height * 0.322656),
            CGPointMake(screenSize.width * 0.224219, self.view.frame.size.height * 0.444727),
            CGPointMake(screenSize.width * 0.443056, self.view.frame.size.height * 0.364583),
            CGPointMake(screenSize.width * 0.098958, self.view.frame.size.height * 0.885742),
            CGPointMake(screenSize.width * 0.597656, self.view.frame.size.height * 0.358398),
            CGPointMake(screenSize.width * 0.352865, self.view.frame.size.height * 0.446680),
            CGPointMake(screenSize.width * 0.292795, self.view.frame.size.height * 0.446680),
            CGPointMake(screenSize.width * 0.190451, self.view.frame.size.height * 0.082422),
            CGPointMake(screenSize.width * 0.000434, self.view.frame.size.height * 0.365625),
            CGPointMake(screenSize.width * 0.321788, self.view.frame.size.height * 0.372721),

        ]
        
        // --- OFFENCE ---
        //Like iconRandomCrossArr_1
        iconPosOffence4x3 = [
            CGPointMake(216, 602),
            CGPointMake(304, 602),
            CGPointMake(389, 602),
            CGPointMake(473, 602),
            CGPointMake(57, 537),
            CGPointMake(632, 537),
            CGPointMake(261, 537),
            CGPointMake(344, 537),
            CGPointMake(427, 537),
            CGPointMake(279, 144),
            CGPointMake(411, 144),
            //CGPointMake(-340, 360), //i Hides 12th Player
        ]
        
        iconPosOffence3x4 = [
            CGPointMake(57, 590),
            CGPointMake(265, 590),
            CGPointMake(344, 590),
            CGPointMake(423, 590),
            CGPointMake(632, 590),
            CGPointMake(215, 524),
            CGPointMake(303, 524),
            CGPointMake(388, 524),
            CGPointMake(472, 524),
            CGPointMake(278, 148),
            CGPointMake(410, 148),
            CGPointMake(-3800, 360), //i Hides 12th Player
        ]
        
        // --- DEFENCE ---
        iconPosDeffencePass = [
            CGPointMake(37, CY+20),
            CGPointMake(113, CY+35),
            CGPointMake(253, CY+30),
            CGPointMake(303, CY+30),
            CGPointMake(350, CY+30),
            CGPointMake(399, CY+30),
            CGPointMake(446, CY+30),
            CGPointMake(575, CY+35),
            CGPointMake(652, CY+20),
            CGPointMake(298, CY+208),
            CGPointMake(391, CY+208),
            //CGPointMake(340, CY+360),   //i Hides 12th Player
        ]
        
        iconPosDeffenceRun = [
            CGPointMake(78, CY+25),
            CGPointMake(239, CY+25),
            CGPointMake(275, CY+25),
            CGPointMake(310, CY+25),
            CGPointMake(344, CY+25),
            CGPointMake(380, CY+25),
            CGPointMake(415, CY+25),
            CGPointMake(449, CY+25),
            CGPointMake(604, CY+25),
            CGPointMake(653, CY+25),
            CGPointMake(344, CY+66),
            CGPointMake(344, CY+90),
        ]
        
        
        //First time we set all default values as a CGPoint
        let keyCount = getKeyCount()
        if keyCount == 0 {
            //Save end user name
            
//            NSUserDefaults.standardUserDefaults().setValue("Icon Set 2", forKey: String(format: "%@%d", K.KeyValue.LayoutName, getKeyCount()))
            for iconPos in iconPosArr {
                iconCrossInitalPosArr.addObject(NSStringFromCGPoint(iconPos))
            }
            for iconPos in iconPosArr {
                iconCircleInitalPosArr.addObject(NSStringFromCGPoint(iconPos))
            }
            //Saving all cgpoints of the layout
            NSUserDefaults.standardUserDefaults().setValue("Cross Icon Set", forKey: String(format: "%@%d", K.KeyValue.LayoutName, getKeyCount()))
            NSUserDefaults.standardUserDefaults().setObject(iconCrossInitalPosArr, forKey: String(format: "KEY_%d", incrementKeyCount()))
            NSUserDefaults.standardUserDefaults().setInteger(IconType.Cross.hashValue, forKey: String(format: "ICON_TYPE_%d", getKeyCount()))
            
            NSUserDefaults.standardUserDefaults().setValue("Circle Icon Set", forKey: String(format: "%@%d", K.KeyValue.LayoutName, getKeyCount()))
            NSUserDefaults.standardUserDefaults().setObject(iconCircleInitalPosArr, forKey: String(format: "KEY_%d", incrementKeyCount()))
            NSUserDefaults.standardUserDefaults().setInteger(IconType.Circle.hashValue, forKey: String(format: "ICON_TYPE_%d", getKeyCount()))
            
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        //Opening default LAyout
        openLayoutWithIndex(1)
        //Reload picker view with different layout
        for index in 0...(getKeyCount()-1) {
            let name = NSUserDefaults.standardUserDefaults().stringForKey(String(format: "%@%d", K.KeyValue.LayoutName, index))
            pickerDataSource.append(name!)
        }
        pickerView.reloadAllComponents()
        
        self.title = "Strategic layout"
    }

    func setNewPosArr() -> Void {
        let newArray:NSMutableArray = NSMutableArray()
        for icon in manager.iconArrary {
            let cgValue = NSStringFromCGPoint( icon.path.count == 0 ? icon.startPos : icon.path[icon.path.count - 1])
            newArray.addObject(cgValue)
        }
  
        NSUserDefaults.standardUserDefaults().setObject(newArray, forKey: String(format: "KEY_%d", incrementKeyCount()))
        NSUserDefaults.standardUserDefaults().setInteger(iconType.hashValue, forKey: String(format: "ICON_TYPE_%d", getKeyCount()))
        saveLayoutNames()
        pickerDataSource.append(layoutName.text!)
        pickerView.reloadAllComponents()
        
        layoutName.text = ""
    }
    func incrementKeyCount() -> Int {
        let keyCount = NSUserDefaults.standardUserDefaults().integerForKey("KEY_COUNT")
        NSUserDefaults.standardUserDefaults().setInteger(keyCount+1, forKey: "KEY_COUNT")
        return NSUserDefaults.standardUserDefaults().integerForKey("KEY_COUNT")
    }
    func getKeyCount() -> Int {
        return NSUserDefaults.standardUserDefaults().integerForKey("KEY_COUNT")
    }
    func saveLayoutNames() -> Void {
        NSUserDefaults.standardUserDefaults().setValue(layoutName.text, forKey:String(format: "%@%d", K.KeyValue.LayoutName, getKeyCount()-1))
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    //Common method to initialize icons with type
    func initIconWithType(iconType:IconType, position:CGPoint) -> Void {
        if iconType == IconType.Circle {
            let circle:Icon = Icon()
            circle.image = UIImage(named: "Circle.png")
            circle.fileName = "Circle.png"
            circle.startPos = position//getPosAt(index, layoutType: layoutType)
            circle.name = iconName
            circle.type = IconType.Circle
            manager.addIcon(circle)
            return
        }
        let cross:Icon = Icon()
        cross.image = UIImage(named: "X.png")
        cross.startPos = position//getPosAt(index, layoutType: layoutType)
        cross.fileName = "X.png"
        cross.name = iconName
        cross.type = IconType.Cross
        manager.addIcon(cross)
    }

    func layoutIcons() {
        var tag = 0
        for icon in manager.iconArrary {
            let imageView:UIImageView = UIImageView(image: icon.image)
            self.view.addSubview(imageView)
            imageView.frame = CGRectMake(icon.startPos.x, icon.startPos.y, imageView.frame.size.width, imageView.frame.size.height)
            imageView.tag = kBaseTag + tag
            tag += 1
        }
    }
    
    func removeExistedIcons() -> Void {
        var tag = 0
        for icon in manager.iconArrary {
            let imgView = self.view.viewWithTag(kBaseTag + tag) as? UIImageView
            imgView?.removeFromSuperview()
            tag += 1
        }
        manager.iconArrary.removeAll(keepCapacity: true)
    }
    
//    func removeExistedIconsOfType(moveType:IconType, array:[CGPoint]) -> Void {
//        var tag = 0
//        var countCross = 0
//        for icon in manager.iconArrary {
//            let imgView = self.view.viewWithTag(kBaseTag + tag) as! UIImageView
//            if icon.type == moveType && countCross < array.count {
//                let point =  array[countCross]
//                imgView.frame = CGRectMake(point.x, point.y, imgView.frame.size.width,  imgView.frame.size.width)
//                countCross += 1
//            }
//            tag += 1
//        }
//    }
    
    var offset:CGPoint = CGPointZero
    var selectedIndex:Int = -1
    var selectedIcon:UIView? = nil
    
    
    func setSelectedIconFromTouch(touch:UITouch?) {
        
        if touch == nil {
            
            selectedIcon = nil
            return
        }
        
        let touchLocation = touch?.locationInView(self.view)
        
        for i in 0 ..< manager.iconArrary.count {
            
            let tag = kBaseTag + i
            let imageView = self.view.viewWithTag(tag)
            
            let iconFrame = self.view.convertRect(imageView!.frame, toView: self.view)
            
            if CGRectContainsPoint(iconFrame, touchLocation!) {
                selectedIcon = imageView
                return
            }
            
        }
    }

    func setOffsetFromTouch(touch:UITouch?) {
        
        if touch == nil || selectedIcon == nil {
            offset = CGPointZero
            return
        }
        
        offset = touch!.locationInView(selectedIcon!)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        setSelectedIconFromTouch(touch)
        setOffsetFromTouch(touch)
        if selectedIcon == nil {
            return
        }

        if layoutName.text?.characters.count > 0 {
            return
        }
        startPos = getCenter(selectedIcon!.frame.origin)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        
        if selectedIcon == nil {
            return
        }
        
        let touchPos = touch?.locationInView(self.view)
        let pathPos = CGPointMake(touchPos!.x - offset.x, touchPos!.y - offset.y)
        selectedIcon?.frame = CGRectMake(pathPos.x, pathPos.y, selectedIcon!.frame.size.width, selectedIcon!.frame.size.height)

        let tag = selectedIcon?.tag
        
        manager.iconArrary[tag! - kBaseTag].path.append(pathPos)
        
        endPos = getCenter(pathPos)
        drawLine(startPos, endPos: endPos, imageView: selectedIcon!)
        startPos = CGPointMake(endPos.x, endPos.y)
    }
    
    func getCenter(pos:CGPoint) -> CGPoint {
        
        let center:CGPoint = CGPointMake(pos.x + selectedIcon!.frame.size.width / 2, pos.y + selectedIcon!.frame.size.height / 2)
        return center
    }
    
    func drawLine(startPos:CGPoint, endPos:CGPoint, imageView:UIView) {
        if layoutName.text?.characters.count > 0 {
            return
        }
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(startPos.x, startPos.y))
        path.addLineToPoint(CGPointMake(endPos.x, endPos.y))
        
        shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = UIColor.whiteColor().CGColor
        shapeLayer.lineWidth = 3.0
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.name = K.KeyValue.shapeLayerName

        self.view.layer.insertSublayer(shapeLayer, below: imageView.layer)
    }
    func clearDrawLine() -> Void {
        for layer in self.view.layer.sublayers! {
            if layer.name == K.KeyValue.shapeLayerName {
                layer.removeFromSuperlayer()
            }
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
         let touch = touches.first
        let touchPos = touch?.locationInView(self.view)
        selectedIcon = nil
        offset = CGPointZero
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let identifier = segue.identifier
        if identifier! == "playRecord" {
            manager.saveIcons()
            let thirdController:ThirdScreen = segue.destinationViewController as! ThirdScreen
            thirdController.iconName = self.iconName
        }
    }
    func openLayoutWithIndex(layoutIndex:Int) -> Void {

        removeExistedIcons()
            var iconPosArray = NSUserDefaults.standardUserDefaults().objectForKey(String(format: "KEY_%d", layoutIndex)) as! NSMutableArray
            for index in 0...(iconPosArray.count - 1) {
                if index % 2 != 0 {
//                 print(String(format: "CGPointMake(screenSize.width * %f, self.view.frame.size.height * %f),", CGPointFromString(iconPosArray.objectAtIndex(index) as! String).x/self.view.frame.size.width, CGPointFromString(iconPosArray.objectAtIndex(index) as! String).y/self.view.frame.size.height))
                }
                iconPosArray = NSUserDefaults.standardUserDefaults().objectForKey(String(format: "KEY_%d", layoutIndex)) as! NSMutableArray
                
                //Remove this comment after made Cover 3 layout
                //initIconWithType(index % 2 == 0 ? IconType.Cross : IconType.Circle /*iconType*/, position: CGPointFromString(iconPosArray.objectAtIndex(index) as! String))
                initIconWithType(index <= 10 ? IconType.Cross : IconType.Circle /*iconType*/, position: CGPointFromString(iconPosArray.objectAtIndex(index) as! String))
            }
        layoutIcons()
    }
    func changeLocationOnly(moveType:IconType, array:[CGPoint]) -> Void {
        var tag = 0
        var countCross = 0
        for icon in manager.iconArrary {
            let imgView = self.view.viewWithTag(kBaseTag + tag) as! UIImageView
            if icon.type == moveType && countCross < array.count {
                let point =  array[countCross]
                imgView.frame = CGRectMake(point.x, point.y, imgView.frame.size.width,  imgView.frame.size.width)
                icon.startPos = point
                icon.path = []
                countCross += 1
            }
            tag += 1
        }
    }
    @IBAction func cover2Button(sender: AnyObject) {
        iconType = IconType.Cross
        openLayoutWithIndex(1)
    }
    
    @IBAction func cover3Button(sender: AnyObject) {
        iconType = IconType.Circle
        openLayoutWithIndex(2)
    }
    
    @IBAction func saveLayout(sender: AnyObject) {
        clearDrawLine()
        for name in pickerDataSource {
            if name == layoutName.text {
                showAlert("Layout is already existed with this name")
                return
            }
        }
        if layoutName.text?.characters.count > 0 {
            setNewPosArr()
        }else {
            showAlert("Please enter layout name")
        }
    }
    @IBAction func onSave(sender: AnyObject) {
        if layoutName.text?.characters.count > 0 {
            showAlert("Please save the layout first. If you don't want to save layout then clear the layout field")
            return
        }
        iconName = nameField.text!
        self.performSegueWithIdentifier("playRecord", sender: nil)
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerDataSource[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        clearDrawLine()
        //(format: "ICON_TYPE_%d", getKeyCount())
        let iconIntType = NSUserDefaults.standardUserDefaults().integerForKey(String(format: "ICON_TYPE_%d", row + 1))
        if iconIntType == IconType.Cross.hashValue {
                    iconType = IconType.Cross
        }else {
                    iconType = IconType.Circle
            
        }
        if (row +  1)  == 1 {
            if deltaBoolFirst == false {
                print("X1 Move X2", "O1 Stopped")
                changeLocationOnly(IconType.Cross, array: iconRandomCrossArr_2)
                deltaBoolFirst = true
            }else {
                print("X2 Move X1", "O2 Stopped")
                changeLocationOnly(IconType.Cross, array: iconRandomCrossArr_1)
                deltaBoolFirst = false
            }
        }
        else if(row +  1)  == 2{
            if deltaBoolSecond == true {
                print("O1 Move O2", "X2 Stopped")
                changeLocationOnly(IconType.Circle, array: iconRandomCircleArr_2)
                deltaBoolSecond = false
            }else {
                print("O2 Move O1", "X1 Stopped")
                changeLocationOnly(IconType.Circle, array: iconRandomCircleArr_1)
                deltaBoolSecond = true
            }
        }else {
            openLayoutWithIndex(row + 1)
        }
    }
    func showAlert(message:String) {
        let alertController:UIAlertController = UIAlertController(title: message, message: nil, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(alertAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func blitzerAction(sender: AnyObject) {
        let lower : UInt32 = 0
        let upper : UInt32 = UInt32( manager.iconArrary.count)
        let randomNumber = arc4random_uniform(upper - lower) + lower
        let icon = manager.iconArrary[Int(randomNumber)]

        for index in 0...50 {
            icon.path.append(CGPointMake(icon.startPos.x, icon.startPos.y + CGFloat(index*3)))
        }
    }
    
    /*
 var iconPosOffencePass:[CGPoint]!
 var iconPosOffenceRun:[CGPoint]!
 
 var iconPosDeffence3x4:[CGPoint]!
 var iconPosDeffence4x3:[CGPoint]!
 */
    @IBAction func actionSetIconPos(sender: UIButton)
    {
        switch sender {
        case btnDefencePass:
            print("Circle Moves", "Deffence Pass Mode")
            clearDrawLine()
            changeLocationOnly(IconType.Circle, array: iconPosDeffencePass)
        case btnDefenceRun:
            print("Circle Moves", "Deffence Run Mode")
            clearDrawLine()
            changeLocationOnly(IconType.Circle, array: iconPosDeffenceRun)
        case btnOffence3x4:
            print("Cross Moves", "Offence 3x4 Mode")
            clearDrawLine()
            changeLocationOnly(IconType.Cross, array: iconPosOffence3x4)
        case btnOffence4x3:
            print("Cross Moves", "Offence 4x3 Mode")
            clearDrawLine()
            changeLocationOnly(IconType.Cross, array: iconPosOffence4x3)
        default:
            print("Other mode selected")
        }
        //circle.startPos = position
    }
}