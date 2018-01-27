//
//  SwiftyCamButton.swift
//  simple-custom-camera
//
//  Created by Nicolau Atala Pelluzi on 27/01/18.
//  Copyright © 2018 nicolauatala. All rights reserved.
//


import UIKit

public protocol SwiftyCamButtonDelegate: class {
    
    func buttonWasTapped()
    
    func buttonDidBeginLongPress()

    func buttonDidEndLongPress()
    
    func longPressDidReachMaximumDuration()
    func setMaxiumVideoDuration() -> Double
}

open class SwiftyCamButton: UIButton {
    
    
    public weak var delegate: SwiftyCamButtonDelegate?
    
    
    fileprivate var timer : Timer?
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        createGestureRecognizers()
    }

    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createGestureRecognizers()
    }
    
    
    @objc fileprivate func Tap() {
       delegate?.buttonWasTapped()
    }
    
    @objc fileprivate func LongPress(_ sender:UILongPressGestureRecognizer!)  {
        switch sender.state {
        case .began:
            delegate?.buttonDidBeginLongPress()
            startTimer()
        case .ended:
            invalidateTimer()
            delegate?.buttonDidEndLongPress()
        default:
            break
        }
    }
    
    
    @objc fileprivate func timerFinished() {
        invalidateTimer()
        delegate?.longPressDidReachMaximumDuration()
    }
    
    
    fileprivate func startTimer() {
        if let duration = delegate?.setMaxiumVideoDuration() {
            //Check if duration is set, and greater than zero
            if duration != 0.0 && duration > 0.0 {
                timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector:  #selector(SwiftyCamButton.timerFinished), userInfo: nil, repeats: false)
            }
        }
    }
    
    
    fileprivate func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    fileprivate func createGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SwiftyCamButton.Tap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(SwiftyCamButton.LongPress))
        self.addGestureRecognizer(tapGesture)
        self.addGestureRecognizer(longGesture)
    }
}
