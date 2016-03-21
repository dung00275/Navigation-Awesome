//
//  NavigationAwesome.swift
//  NavigationAwesome
//
//  Created by dungvh on 11/11/15.
//  Copyright © 2015 dungvh. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

extension UINavigationBar{
    private struct AssociatedKey {
        static var NavigationKey = "NavigationKey"
    }
    
    var overlay:UIView?{
        get{
            return objc_getAssociatedObject(self, &AssociatedKey.NavigationKey) as? UIView
        }
        
        set(newValue){
            objc_setAssociatedObject(self, &AssociatedKey.NavigationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func lt_setBackgroundColor(backgroundColor:UIColor?){
        
        defer{
            self.overlay?.backgroundColor = backgroundColor
        }
        
        guard let _ = self.overlay else{
            self.setBackgroundImage(UIImage(), forBarMetrics: .Default)
            let view = UIView(frame: CGRect(origin: CGPointMake(0, -20), size: CGSizeMake(CGRectGetWidth(UIScreen.mainScreen().bounds), CGRectGetHeight(self.bounds) + 20)))
            view.userInteractionEnabled = false
            view.autoresizingMask = UIViewAutoresizing.FlexibleWidth.union(UIViewAutoresizing.FlexibleHeight)
            self.insertSubview(view, atIndex: 0)
            self.overlay = view
            return
        }
    }
    
    func lt_setTranslationY(translationY:CGFloat){
        self.transform = CGAffineTransformMakeTranslation(0, translationY)
    }
    
    func lt_setElementsAlpha(alpha:CGFloat){
        if let leftViews = self.valueForKey("_leftViews") as? [UIView]{
            for view in leftViews{
                view.alpha = alpha
            }
        }
        
        if let rightViews = self.valueForKey("_rightViews") as? [UIView]{
            for view in rightViews{
                view.alpha = alpha
            }
        }
        
        if let titleView = self.valueForKey("_titleView") as? UIView{
           titleView.alpha = alpha
        }
    }
    
    func lt_reset(){
        self.setBackgroundImage(nil, forBarMetrics: .Default)
        self.overlay?.removeFromSuperview()
        self.overlay = nil
    }
    
    
}
