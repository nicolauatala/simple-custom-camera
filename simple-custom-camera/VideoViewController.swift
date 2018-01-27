//
//  VideoViewController.swift
//  simple-custom-camera
//
//  Created by Nicolau Atala Pelluzi on 27/01/18.
//  Copyright © 2018 nicolauatala. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    var videoURL: URL?
    var player: AVPlayer?
    var playerController : AVPlayerViewController?
    
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var contentSettings: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.layer.zPosition = 10
        contentSettings.layer.zPosition = 9
        
        navigationBar.leftImageView.image = #imageLiteral(resourceName: "back")
        navigationBar.delegate = self
        
        self.view.backgroundColor = UIColor.gray
        player = AVPlayer(url: videoURL!)
        playerController = AVPlayerViewController()

        guard player != nil && playerController != nil else {
            return
        }
        playerController!.showsPlaybackControls = false

        playerController!.player = player!
        self.addChildViewController(playerController!)
        self.view.addSubview(playerController!.view)
        playerController!.view.frame = view.frame
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player!.currentItem)
        
        let cancelButton = UIButton(frame: CGRect(x: 10.0, y: 10.0, width: 30.0, height: 30.0))
        cancelButton.setImage(#imageLiteral(resourceName: "cancel"), for: UIControlState())
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        view.addSubview(cancelButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player?.play()
    }
    
    func cancel() {
        dismiss(animated: true, completion: nil)
    }

    @objc fileprivate func playerItemDidReachEnd(_ notification: Notification) {
        if self.player != nil {
            self.player!.seek(to: kCMTimeZero)
            self.player!.play()
        }
    }
}

extension VideoViewController: NavigationBarDelegate {
    func leftButtonTouchUpInside() {
        print(#function)
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
}
