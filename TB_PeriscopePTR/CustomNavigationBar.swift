//
//  CustomNavigationBar.swift
//  TB_PeriscopePTR
//
//  Created by Yari D'areglia on 03/05/15.
//  Copyright (c) 2015 Yari D'areglia. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationBar, UIScrollViewDelegate {

    var scrollview:UIScrollView?
    var titleLabel:UILabel?
    var refreshLabel:UILabel?
    var loadingBg:UIView?
    var containerView:UIView?
    var stepOffset:CGFloat = 70.0
    
    func updateTitleView(){
        
        // Reset views
        
        self.loadingBg?.removeFromSuperview()
        self.containerView?.removeFromSuperview()
        
        
        // Setup the wrapping views ------------
        
        var maskView = UIView(frame: CGRectMake(0, -20 , 200, 64))
        maskView.clipsToBounds = true

        containerView = UIView(frame: CGRectMake(0, 0, 200, 44))
        containerView!.clipsToBounds = false
        containerView!.addSubview(maskView)
        
        
        // Setup Labels-------------------------
        
        var titleLabel = UILabel(frame: CGRectMake(0, 20, 200, 44))
        titleLabel.font = UIFont.boldSystemFontOfSize(17)
        titleLabel.text = self.topItem?.title
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        self.titleLabel = titleLabel
        
        var releaseLabel = UILabel(frame: CGRectMake(0, -50, 200, 44))
        releaseLabel.font = UIFont.boldSystemFontOfSize(15)
        releaseLabel.text = "Release to Refresh"
        releaseLabel.textColor = UIColor.whiteColor()
        releaseLabel.textAlignment = NSTextAlignment.Center
        self.refreshLabel = releaseLabel
        
        titleLabel.sizeToFit()
        titleLabel.center = CGPoint(x: maskView.bounds.size.width/2.0, y: maskView.bounds.size.height/2.0 + 10)

        maskView.addSubview(titleLabel)
        maskView.addSubview(releaseLabel)
        
        
        // Setup the titleView -----------------
        
        topItem?.titleView = containerView!
        
        
        // Setup the Loading-image view --------
        
        var rect = bounds
        rect.size.width = rect.size.width * 2
        loadingBg = UIView(frame: rect)
        loadingBg?.alpha = 0.0
        loadingBg?.backgroundColor = UIColor(patternImage: UIImage(named: "Loading")!)
        loadingBg?.center.x = bounds.size.width
        insertSubview(loadingBg!, atIndex: 1)
    }
    
    func startLoaderAnimation(){
        loadingBg?.layer.removeAllAnimations()
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.loadingBg?.alpha = 1.0
        })
        
        var animation = CABasicAnimation(keyPath: "position.x")
        animation.duration = 3
        animation.fromValue = loadingBg!.layer.position.x
        animation.toValue = loadingBg!.layer.position.x - 100
        animation.repeatCount = HUGE
        loadingBg?.layer.addAnimation(animation, forKey: "pos")
    }
    
    func stopLoaderAnimation(){
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.loadingBg?.alpha = 0.0

        }) { (Completed) -> Void in
            self.loadingBg?.layer.removeAllAnimations()
        }
    }
    
    
    
    // MARK: ScrollView Delegate
    
    func scrollViewDidScroll(scrollView: UIScrollView){
        
        var scrollviewOffset = -(scrollView.contentOffset.y + 64) // reset the offset to 0 when the scrollbar is at its initial state.
        
        if scrollviewOffset >=  0 {
            var translationOffset = min(scrollviewOffset, stepOffset)
            var alpha =  min (scrollviewOffset / stepOffset, 1.0)
            
            self.refreshLabel?.layer.transform = CATransform3DMakeTranslation(0, translationOffset , 0)
            self.titleLabel?.layer.transform = CATransform3DMakeTranslation(0, translationOffset , 0)
            self.refreshLabel?.alpha = alpha
        }else{
            self.titleLabel?.layer.transform = CATransform3DIdentity
            self.refreshLabel?.layer.transform = CATransform3DIdentity
            self.refreshLabel?.alpha = 0.0
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool){
        var scrollviewOffset = -(scrollView.contentOffset.y + 64)
        
        if scrollviewOffset >= stepOffset{
            self.startLoaderAnimation()
        }
    }
    
}