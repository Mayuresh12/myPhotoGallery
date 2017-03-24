//
//  ViewController.swift
//  myPhotoGallery
//
//  Created by Mayuresh Rao on 3/19/17.
//  Copyright © 2017 Mayuresh Rao. All rights reserved.
//

import UIKit
import Photos
class ViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    let fetchOptions = PHFetchOptions()
    let ImgManager = PHImageManager.default()
    let requestOptions = PHImageRequestOptions()
    var fetchResult: PHFetchResult<PHAsset>!
    var assetCollection : PHAssetCollection!
    @IBOutlet weak var myImageView: UIImageView!
    override func viewDidLoad() {
        //granImages()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions);
        fetchOptions.sortDescriptors = [NSSortDescriptor(key : "creationDate", ascending : true)]
        if (fetchResult == nil)
        {
            print("you dont have any photos...")
            self.collectionView?.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResult.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! myCollectionViewCell
        
        ImgManager.requestImage(for: fetchResult[indexPath.row], targetSize: CGSize(width:100,height:100), contentMode: .aspectFill, options: nil) { (img, nil) in
            cell.MyimageView.image = img!
        }
        return cell
    }
    
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let Width = collectionView.frame.width/2 - 1
        return CGSize(width: Width, height: Width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? imageViewController
            else { fatalError("unexpected view controller for segue") }
        
        let indexPath = collectionView!.indexPath(for: sender as! UICollectionViewCell)!
        destination.asset = fetchResult.object(at: indexPath.item)
        destination.assetCollection = assetCollection
    }
    
   }

