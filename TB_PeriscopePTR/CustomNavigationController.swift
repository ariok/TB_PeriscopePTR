//
//  CustomNavigationController.swift
//  TB_PeriscopePTR
//
//  Created by Yari D'areglia on 03/05/15.
//  Copyright (c) 2015 Yari D'areglia. All rights reserved.
//

import UIKit

class CustomNavigationController:UINavigationController, UINavigationControllerDelegate{
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup(){
        self.delegate = self
    }
    
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        if let navBar = self.customNavigationBar(){
            navBar.updateTitleView()
        }
    }
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool){

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}



// MARK: CustomNavigationBar Extension

extension UINavigationController{
    
    // Return the customNavigationBar object, if it exists.
    func customNavigationBar()->CustomNavigationBar?{
        if let navbar = self.navigationBar as? CustomNavigationBar{
            return navbar
        }
        else{
            return nil
        }
    }
    
    // Set the CustomNavigationBar as delegate for a UIScrollView 
    func setupPulltoRefresh(scrollView:UIScrollView){
        if let navbar = self.customNavigationBar(){
            scrollView.delegate = navbar
        }
    }

}