//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Liam Kelly on 6/14/16.
//  Copyright © 2016 LiamKelly. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // assign button tag values equal to the case we want
    enum ButtonType: Int { case slow = 0, fast, chipmunk, vader, echo, reverb }
    
    // choose the proper audio manipulation based on the sender's tag
    @IBAction func playSoundForButton(_ sender: UIButton) {
        print("Play sound button has been pressed")
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 3.0)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    // stops audio
    @IBAction func stopSoundButton(_ sender: UIButton) {
        print("Stop button has been pressed")
        stopAudio()
    }
    
    // load audio file once the view loads
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAudio()
        
        // Do any additional setup after loading the view.
    }
    
    // Stops playing audio when the view is about to appear
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
