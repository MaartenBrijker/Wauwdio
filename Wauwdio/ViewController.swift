//
//  ViewController.swift
//  Wauwdio
//
//  Created by Maarten Brijker on 18/05/16.
//  Copyright © 2016 Maarten_Brijker. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {


    var oscillator = AKOscillator()
    var player: AKAudioPlayer!
    var reverb: AKReverb!
    
    let file = NSBundle.mainBundle().pathForResource("RFX6", ofType: "WAV")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    

    @IBAction func toggleSound(sender: AnyObject) {
        let filename = "RFX6"
        let afterdoth = "WAV"
        playSound(filename, theType: afterdoth)
    }
    
    @IBAction func reverb(sender: AnyObject) {
   
    
        
    }
    

    
    func playSound(filename: String, theType: String) {
        
        if AudioKit.output == nil {
            
            let player = AKAudioPlayer(file!)
            let reverb = AKReverb(player)
            let squareWave = AKSquareWaveOscillator()
            let dryWetMixer = AKDryWetMixer(reverb, squareWave, balance: 0.5)
            
            AudioKit.output = dryWetMixer
            AudioKit.start()
            
            if player.isStarted {
                player.looping = false
                print("ierer")
                player.stop()
            } else {
                player.looping = true
                player.play()
            }
        }
    }
}
