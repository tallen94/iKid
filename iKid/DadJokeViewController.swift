//
//  DadJokeViewController.swift
//  iKid
//
//  Created by Trevor Allen on 5/3/16.
//  Copyright © 2016 Trevor Allen. All rights reserved.
//

import UIKit

class DadJokeViewController: UIViewController {

 
    private var firstVC : FirstDadViewController!
    private var secondVC : SecondDadViewController!
    
    private func firstBuilder() {
        if firstVC == nil {
            firstVC = storyboard?.instantiateViewControllerWithIdentifier("DadFirst") as! FirstDadViewController
            print(firstVC)
        }
    }
    
    private func secondBuilder() {
        if secondVC == nil {
            secondVC = storyboard?.instantiateViewControllerWithIdentifier("DadSecond") as! SecondDadViewController
        }
    }
    
    @IBAction func flip(sender: UIBarButtonItem) {
        firstBuilder()
        secondBuilder()
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.EaseInOut)
        
        if firstVC != nil && firstVC?.view.superview != nil {
            UIView.setAnimationTransition(.FlipFromRight, forView: view, cache: true)
            secondVC.view.frame = view.frame
            switchToViewController(firstVC, to:secondVC)
        } else {
            UIView.setAnimationTransition(.FlipFromLeft, forView: view, cache: true)
            firstVC.view.frame = view.frame
            switchToViewController(secondVC, to: firstVC)
        }
        UIView.commitAnimations()
    }
    
    private func switchToViewController(from: UIViewController?, to: UIViewController?) {
        if from != nil {
            from!.willMoveToParentViewController(nil)
            from!.view.removeFromSuperview()
            from!.removeFromParentViewController()
        }
        
        if to != nil {
            self.addChildViewController(to!)
            self.view.insertSubview(to!.view, atIndex: 0)
            to!.didMoveToParentViewController(self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
