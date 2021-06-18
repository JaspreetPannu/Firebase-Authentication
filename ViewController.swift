//
//  ViewController.swift
//  Login
//
//  Created by Jaspreet Pannu on 2021-06-09.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
   
    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?
    
    
  
    
    
    @IBOutlet weak var SignUpButton: UIButton!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    
        }
    

    
    override func viewDidAppear(_ animated: Bool) {
        setUpVideo()
    }

    
    func setUpElements() {
        
        Utilities.styleFilledButton(SignUpButton)
        Utilities.styleFilledButton(LoginButton)
    }
    
    func setUpVideo() {
        
        //the path to reduce the bundle
        let bundlePath = Bundle.main.path(forResource: "loginbg", ofType: "mp4")
        
        guard bundlePath != nil else {
            return
        }
        //create url from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        //create video player item
        let item = AVPlayerItem(url: url)
        
        //creaTe the player
        videoPlayer = AVPlayer(playerItem: item)
        
        //create the size
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        //adjust size and frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
//        videoPlayerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        //add it to view and play
        videoPlayer?.playImmediately(atRate: 0.3)
        
    }
    
  


}

