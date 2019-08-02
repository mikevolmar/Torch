//
//  ViewController.swift
//  Torch
//
//  Created by Mike Volmar on 8/2/19.
//  Copyright © 2019 Mike Volmar. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBAction func TorchButton(_ sender: UIButton) {
        if let buttonTitle = sender.title(for: .normal) {
            if (buttonTitle == "ON") {
                sender.setTitle("OFF",for: .normal)
                toggleTorch(on: true)
            } else {
                sender.setTitle("ON",for: .normal)
                toggleTorch(on: false)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        toggleTorch(on: true)
    }
    
    func toggleTorch(on: Bool) {
        
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }
                device.unlockForConfiguration()
            } catch {
                print("Light could not be used")
                let alertController = UIAlertController(title: "Error", message: "Light could not be used", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        } else {
            print("Light is not available")
            let alertController = UIAlertController(title: "Error", message: "Light is not available", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }


}

