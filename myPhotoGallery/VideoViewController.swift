//
//  VideoViewController.swift
//  myPhotoGallery
//
//  Created by Mayuresh Rao on 3/23/17.
//  Copyright © 2017 Mayuresh Rao. All rights reserved.
//

import UIKit
import Photos
import AVKit
import AVFoundation

class VideoViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout{
    let fetchOptions = PHFetchOptions()
    let ImgManager = PHImageManager.default()
    let requestOptions = PHImageRequestOptions()
    var fetchResult: PHFetchResult<PHAsset>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        fetchResult = PHAsset.fetchAssets(with: .video, options: fetchOptions);
        fetchOptions.sortDescriptors = [NSSortDescriptor(key : "creationDate", ascending : true)]
        if (fetchResult == nil)
        {
            print("you dont have any photos...")
            self.collectionView?.reloadData()
        }    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResult.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! myVideoCollectionViewCell
        
        ImgManager.requestImage(for: fetchResult[indexPath.row], targetSize: CGSize(width:100,height:100), contentMode: .aspectFill, options: nil) { (img, nil) in
            cell.MyVideoImage.image = img!
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           self.performSegue(withIdentifier: "seguePlay", sender: indexPath)
        print("I CLICKED\(indexPath.row)");
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let destination = segue.destination as! AVPlayerViewController
        let indexPath = sender as! NSIndexPath!
        let asset =  fetchResult.object(at: (indexPath?.row)!) 
       guard (asset.mediaType == .video) else {
            print("Not a valid video media type")
            return
        }
        
        PHCachingImageManager().requestAVAsset(forVideo: asset, options: nil) { (asset, audioMix, args) in
        let asset = asset as! AVURLAsset
        DispatchQueue.main.async {
                destination.player = AVPlayer(url: asset.url)
                destination.player?.play()
                
            }
        }
    }
   
}
