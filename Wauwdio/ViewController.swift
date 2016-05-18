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
    var player: AKAudioPlayer?
    var reverb: AKReverb?
    var mixer = AKMixer()
    var drywetmixer = AKDryWetMixer?()
    
    var checkie: Bool?
    
    let file = NSBundle.mainBundle().pathForResource("RFX6", ofType: "WAV")
    let file2 = NSBundle.mainBundle().pathForResource("akonalien", ofType: "mp3")
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        player = AKAudioPlayer(file!)
        
//        mixer.connect(player!)
        
        reverb = AKReverb(player!)
        let squareWave = AKSquareWaveOscillator()

        drywetmixer = AKDryWetMixer(reverb!, squareWave, balance: 0.5)
        
        checkie = true
        
        AudioKit.output = drywetmixer
        AudioKit.start()
        
        }
    

    @IBAction func toggleSound(sender: AnyObject) {
        let filename = "RFX6"
        let afterdoth = "WAV"
        playSound(filename, theType: afterdoth)
    }
    
    @IBAction func reverb(sender: AnyObject) {

        
        drywetmixer?.balance = random(0, 1)

        
//        if ((reverb?.isStarted) == true) {
////            reverb?.stop()
//        } else {
//            reverb?.start()
//        }
        
    }
    

    
    func playSound(filename: String, theType: String) {
                
        if checkie == true {
            player?.replaceFile(file2!)
            checkie = false
            player?.stop()
        } else {
            player?.replaceFile(file!)
            checkie = true
            player?.stop()

        }
        
        player?.start()
        
//        if player!.isStarted {
//            player!.stop()
//        } else {
//            player!.start()
//        }
        
    }
}
