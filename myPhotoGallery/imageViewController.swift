//
//  avControllerViewController.swift
//  myPhotoGallery
//
//  Created by Mayuresh Rao on 3/23/17.
//  Copyright © 2017 Mayuresh Rao. All rights reserved.
//

import UIKit
import Photos

class imageViewController: UIViewController {
    var asset: PHAsset!

    var fetchResult: PHFetchResult<PHAsset>!
    var assetCollection : PHAssetCollection!
    var index :Int = 0
    @IBOutlet weak var showImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.hidesBarsOnTap = true
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
       

        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { image, _ in
            
            guard let image = image else { return }
            
           
            self.showImage.image = image
        })

        // Do any additional setup after loading the view.
    }

    var targetSize: CGSize {
        let scale = UIScreen.main.scale
        return CGSize(width: showImage.bounds.width * scale,
                      height: showImage.bounds.height * scale)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
