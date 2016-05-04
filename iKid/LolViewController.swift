//
//  LolViewController.swift
//  iKid
//
//  Created by Trevor Allen on 5/3/16.
//  Copyright © 2016 Trevor Allen. All rights reserved.
//

import UIKit

class LolViewController: UIViewController {
    
    private var firstVC : FirstLolViewController!
    private var secondVC : SecondLolViewController!
    
    private func firstBuilder() {
        if firstVC == nil {
            firstVC = storyboard?.instantiateViewControllerWithIdentifier("LolFirst") as! FirstLolViewController
            print(firstVC)
        }
    }
    
    private func secondBuilder() {
        if secondVC == nil {
            secondVC = storyboard?.instantiateViewControllerWithIdentifier("LolSecond") as! SecondLolViewController
        }
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
}
