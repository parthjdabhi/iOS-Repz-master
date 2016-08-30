//
//  IconManager.swift
//  Repz
//
//  Created by Dustin Allen on 8/14/16.
//  Copyright © 2016 Harloch. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class IconManager {
    
    static var manager:IconManager? = nil
    
    static func sharedManager() -> IconManager {
        if manager == nil {
            manager = IconManager()
        }
        
        return manager!
    }
    
    var iconArrary:[Icon] = []
    
    func addIcon(icon:Icon) {
//        print("filename=>", icon.fileName, "image=>", icon.image, "name=>", icon.name, "offset=>", icon.offset, "path=>", icon.path, "startPos=>", icon.startPos)
        iconArrary.append(icon)
    }
    
    func saveIcons() {
        let delegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = delegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Icon", inManagedObjectContext:managedContext)
        var index = 0;
//        PlistManager.sharedInstance.removeAllItemsFromPlist()
        for icon in iconArrary {
            let iconObject = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            iconObject.setValue(icon.name, forKey: "name")
            iconObject.setValue(icon.fileName, forKey: "fileName")
            iconObject.setValue(icon.startPos.x, forKey: "startPosX")
            iconObject.setValue(icon.startPos.y, forKey: "startPosY")
            iconObject.setValue(icon.offset.x, forKey: "offsetX")
            iconObject.setValue(icon.offset.y, forKey: "offsetY")
            
//            let dict = NSMutableDictionary()
//            dict.setObject(icon.name, forKey: "name")
//            //dict.setObject("Cover3", forKey: "name")
//            dict.setValue(icon.fileName, forKey: "fileName")
//            dict.setValue(icon.startPos.x, forKey: "startPosX")
//            dict.setValue(icon.startPos.y, forKey: "startPosY")
//            dict.setValue(icon.offset.x, forKey: "offsetX")
//            dict.setValue(icon.offset.y, forKey: "offsetY")
            
            if icon.path.count != 0 {
                var dataArray:[NSValue] = []
                
                for point in icon.path {
                    let pointObj = NSValue(CGPoint: point)
                    dataArray.append(pointObj)
                }
                
                let data = NSKeyedArchiver.archivedDataWithRootObject(dataArray as AnyObject)
                iconObject.setValue(data, forKey: "path")
                
                //dict.setValue(data, forKey: "path")
            }
//            print("iconObject=> ", iconObject)
//            print("Dict=> ", dict)
//            
//            PlistManager.sharedInCover3.addNewItemWithKey(String(format: "Key_%d", index), value: dict)
//            print(PlistManager.sharedInCover3.getValueForKey(String(format: "Key_%d", index)))
            index += 1
            do {
                try managedContext.save()
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
        index = 0
    }
    
}