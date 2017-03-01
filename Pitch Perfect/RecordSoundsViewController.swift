//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Liam Kelly on 6/7/16.
//  Copyright © 2016 LiamKelly. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate {

    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var recordLabel: UILabel!
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var isRecording: Bool!
    
    // Enable and disable buttons
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Create a file path for the audio and record
    @IBAction func recordAudio(_ sender: AnyObject) {
        isRecording = true
        configureView(isRecording: isRecording)
    
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]

        let filePath = URL.fileURL(withPathComponents: pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecordingAudio(_ sender: AnyObject) {
        audioRecorder.stop()
    }
    
    // Example given by Udacity reviewer (thanks for the tip to use a ternary operator)
    func configureView(isRecording recording: Bool) {
        stopRecordingButton.isEnabled = recording
        recordButton.isEnabled = !recording
        recordLabel.text = recording ? "Recording . . ." : "Tap to Record"
    }
    
    
    // set text label, enable and disable buttons
    override func viewWillAppear(_ animated: Bool) {
        isRecording = false
        configureView(isRecording: isRecording)
    }
    
    // perform segue when recording stops
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("audioRecorderDidFinishRecording has been called")
        if (flag) {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Saving of recording failed")
        }
    }
    
    // set the segue identifier, pass in recorded audio URL to save in next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepareForSegue has been called")
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}

