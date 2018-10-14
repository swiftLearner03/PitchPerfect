//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Dale Kilgore, Jr on 10/6/18.
//  Copyright © 2018 Dale Kilgore, Jr. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    //  adding AVAudio property
    var audioRecorder: AVAudioRecorder!
    
    
    
    
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    
    var labelIsBlinking = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordingButton.isEnabled = false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear called")
        
        
        
        
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    
    
    
    @IBAction func recordAudio(_ sender: Any) {
        
        recordingLabel.text = "Recording in Progress!"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        //  calls function that allows for blinking text when audio is recorded.
        labelIsBlinking = true
        recordingOnBlinkingText()
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
  
        
        
        let session = AVAudioSession.sharedInstance()
        //      swift 4.2 version

       try! session.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
//        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: .defaultToSpeaker)
       
        
        try! audioRecorder = AVAudioRecorder (url: filePath!, settings: [:])
        print(filePath!)
        
        
        //         sets current viewcontroller as delegate of AVAudioRecorder
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
        
    }
    
    
    @IBAction func stopRecording(_ sender: Any) {
        recordingLabel.text = "Tap to record"
        stopRecordingButton.isEnabled = false
        recordButton.isEnabled = true
        labelIsBlinking = false
        recordingOnBlinkingText()
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
       
        if flag {
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
    } else {
    print("recording was not successful")
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
            
            
            
         }
      }
    }
    
    

