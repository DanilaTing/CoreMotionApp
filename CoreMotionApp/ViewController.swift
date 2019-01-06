//
//  ViewController.swift
//  CoreMotionApp
//
//  Created by Данила Тимофеев on 02.01.2019.
//  Copyright © 2019 Данила Тимофеев. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet weak var xGyro: UILabel!
    @IBOutlet weak var yGyro: UILabel!
    @IBOutlet weak var zGyro: UILabel!
    
    @IBOutlet weak var xMotion: UILabel!
    @IBOutlet weak var yMotion: UILabel!
    @IBOutlet weak var zMotion: UILabel!
    
    @IBOutlet weak var xAcc: UILabel!
    @IBOutlet weak var yAcc: UILabel!
    @IBOutlet weak var zAcc: UILabel!
    
    var motion = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gyroscope()
        deviceMotion()
        accelreometer()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func gyroscope() {
        motion.gyroUpdateInterval = 0.2
        motion.startGyroUpdates(to: OperationQueue.current!) { (data, error) in
            print(data as Any)
            if let trueData = data {
                self.view.reloadInputViews()
                let x = trueData.rotationRate.x
                let y = trueData.rotationRate.y
                let z = trueData.rotationRate.z
                
                print(x, y, z)
                
                self.xGyro.text = "x: \(x)"
                self.yGyro.text = "y: \(y)"
                self.zGyro.text = "z: \(z)"
            }
        }
    }
    
    func deviceMotion() {
        motion.deviceMotionUpdateInterval = 0.2
        motion.startDeviceMotionUpdates(to: OperationQueue.current!) { (data, error) in
            print(data as Any)
            if let trueData = data {
                self.view.reloadInputViews()
                let x = trueData.attitude.pitch
                let y = trueData.attitude.roll
                let z = trueData.attitude.yaw
                
                print(x, y, z)
                
                self.xMotion.text = "x: \(x)"
                self.yMotion.text = "y: \(y)"
                self.zMotion.text = "z: \(z)"
            }
        }
    }
    
    func accelreometer() {
        motion.accelerometerUpdateInterval = 0.2
        motion.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            print(data as Any)
            if let trueData = data {
                self.view.reloadInputViews()
                let x = trueData.acceleration.x
                let y = trueData.acceleration.y
                let z = trueData.acceleration.z
                
                print(x, y, z)
                
                self.xAcc.text = "x: \(x)"
                self.yAcc.text = "y: \(y)"
                self.zAcc.text = "z: \(z)"
            }
        }
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow (10.0, Double (places))
        return (self * divisor).rounded() / divisor
    }
}

