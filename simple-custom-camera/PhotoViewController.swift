//
//  PhotoViewController.swift
//  simple-custom-camera
//
//  Created by Nicolau Atala Pelluzi on 27/01/18.
//  Copyright © 2018 nicolauatala. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

	override var prefersStatusBarHidden: Bool {
		return true
	}

    var backgroundImage: UIImage?
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var contentSettings: UIView!

	override func viewDidLoad() {
		super.viewDidLoad()
        
        navigationBar.layer.zPosition = 10
        contentSettings.layer.zPosition = 9
        
        navigationBar.leftImageView.image = #imageLiteral(resourceName: "back")
        navigationBar.delegate = self
        
		self.view.backgroundColor = UIColor.gray
		let backgroundImageView = UIImageView(frame: view.frame)
		backgroundImageView.contentMode = UIViewContentMode.scaleAspectFit
		backgroundImageView.image = backgroundImage
		view.addSubview(backgroundImageView)
		
	}

}

extension PhotoViewController: NavigationBarDelegate {
    func leftButtonTouchUpInside() {
        dismiss(animated: true, completion: nil)
    }
}
