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

protocol TransparentProtocol: class {
    var alpha: CGFloat { get set }
}

extension UIView: TransparentProtocol{}
extension NSObject {
    public subscript(key: String) -> Any? {
        get{
            return self.value(forKey: key)
        }
        set{
            self.setValue(newValue, forKey: key)
        }
    }
}

func +<T>(lhs:Array<T>?, rhs:Array<T>?) -> Array<T>? {
    if lhs == nil && rhs == nil { return nil }
    var result = Array<T>()
    result += (lhs ?? [])
    result += (rhs ?? [])
    return result
}

func +=<T>(lhs: inout Array<T>?, rhs: T?) {
    if lhs == nil && rhs == nil { return }
    var result = lhs ?? Array<T>()
    guard let rhs = rhs else {
        return
    }
    result.append(rhs)
    lhs = result
}

extension UINavigationBar{
    fileprivate struct AssociatedKey {
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
    
    func lt_setBackgroundColor(_ backgroundColor:UIColor?){
        
        defer{
            self.overlay?.backgroundColor = backgroundColor
        }
        
        guard let _ = self.overlay else{
            self.setBackgroundImage(UIImage(), for: .default)
            let view = UIView(frame: CGRect(origin: CGPoint(x: 0, y: -20), size: CGSize(width: UIScreen.main.bounds.width, height: self.bounds.height + 20)))
            view.isUserInteractionEnabled = false
            view.autoresizingMask = UIViewAutoresizing.flexibleWidth.union(UIViewAutoresizing.flexibleHeight)
            self.insertSubview(view, at: 0)
            self.overlay = view
            return
        }
    }
    
    func lt_setTranslationY(_ translationY:CGFloat){
        self.transform = CGAffineTransform(translationX: 0, y: translationY)
    }
    
    func lt_setElementsAlpha(_ alpha:CGFloat){
        let leftViews = self["_leftViews"] as? [Any]
        let rightViews = self["_rightViews"] as? [Any]
        let titleView = self["_titleView"]
        var allViews = leftViews + rightViews
        allViews += titleView
        allViews?.flatMap({ $0 as? TransparentProtocol }).forEach({ $0.alpha = alpha })
    }
    
    func lt_reset(){
        self.setBackgroundImage(nil, for: .default)
        self.overlay?.removeFromSuperview()
        self.overlay = nil
    }
}
