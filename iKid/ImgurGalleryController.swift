//
//  ImgurGalleryController.swift
//  iKid
//
//  Created by Trevor Allen on 5/3/16.
//  Copyright © 2016 Trevor Allen. All rights reserved.
//

import UIKit
import SwiftSpinner

class ImgurGalleryController: UIViewController {
    
    @IBOutlet var gallery: UICollectionView!
    private var images: [UIImage] = [UIImage]()
    
    override func viewDidLoad() {
        SwiftSpinner.show("Loading Memes")
        ImgurAPI.Instance.GetGallery() { complete in
            if (complete) {
                SwiftSpinner.hide()
                for img in ImgurAPI.Instance.Images {
                    if let url = NSURL(string: img.GetAttrs()["link"] as! String), data = NSData(contentsOfURL: url) {
                        self.images.append(UIImage(data: data)!)
                        self.gallery.reloadData()
                    }
                }
            }
        }
        gallery.delegate = self
        gallery.dataSource = self
    }
}

extension ImgurGalleryController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("image-cell", forIndexPath: indexPath) as! ImageCollectionViewCell
        cell.thumbnail.image = self.images[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width / 3, height: self.view.frame.size.width / 3);
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let imageViewController = storyboard!.instantiateViewControllerWithIdentifier("ImageViewer")
        let image = self.images[indexPath.row]
        let imageView = UIImageView(image: image)
        imageView.frame.size.width = self.view.frame.size.width
        imageView.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageViewController.view.addSubview(imageView)
        self.presentViewController(imageViewController, animated: true, completion: nil)
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        
    }
}

