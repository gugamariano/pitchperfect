//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by antonio silva on 8/3/15.
//  Copyright (c) 2015 antonio silva. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsViewController: UIViewController {
    
    
    var audioPlayer:AVAudioPlayer!
    var recordedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    @IBOutlet weak var stopAudioBtn: UIButton!
    
    
    
    
    @IBAction func playDarthvaderAudio(sender: AnyObject) {
        playAudioWithVariablePitch(-1000)
    }


    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        playAudioWithVariableRate(2)

    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudioWithVariableRate(0.5)
    }
    
    
    func stopAndResetAudio(){
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()

    }
    
    func playAudioWithVariableRate(rate:Float){
        stopAndResetAudio()
        
        audioPlayer.rate=rate
        audioPlayer.currentTime=0
        audioPlayer.play()
        
        stopAudioBtn.hidden=false
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        
        stopAndResetAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        stopAudioBtn.hidden=false
    }
    
    
    @IBAction func stopAudioEffect(sender: UIButton) {
        audioPlayer.stop()
        stopAudioBtn.hidden=true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer=AVAudioPlayer(contentsOfURL: recordedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate=true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recordedAudio.filePathUrl, error: nil)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
