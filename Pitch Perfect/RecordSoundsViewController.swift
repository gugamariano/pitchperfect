//
//  RecordSoundsViewController
//  Pitch Perfect
//
//  Created by antonio silva on 8/1/15.
//  Copyright (c) 2015 antonio silva. All rights reserved.
//

import UIKit
import AVFoundation

//This class records the user sound and pass the data to the next view
class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {

   
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    
    @IBOutlet weak var tapToRecord: UILabel!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    //when user press the stop button, hide the recording label and stop button, and show the tap to record label, finally stop the recorder.
    @IBAction func stopRecording(sender: UIButton) {
        recordingInProgress.hidden=true
        stopRecordingButton.hidden=true
        tapToRecord.hidden=false
        audioRecorder.stop()
    }
    
    
    //shows the "recording in progress" label and stop button , hiddes the tap to record label and disable the mic button.
    //Get the current path to record the audio file (sound.wav) , sets the category of the AVAudioSession and creates the AVAudioRecorder and starts to record
    @IBAction func startRecording(sender: UIButton) {
        
        recordingInProgress.hidden=false
        stopRecordingButton.hidden=false
        recordingButton.enabled=false
        tapToRecord.hidden=true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        

        let recordingName="sound"
        
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate=self
        
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {

        if(flag){
            recordedAudio=RecordedAudio(url:recorder.url)

            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            println("Recording error")
            recordingButton.enabled=true
            stopRecordingButton.hidden=true
            
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="stopRecording"){
        
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            
            let data = sender as! RecordedAudio
            playSoundsVC.recordedAudio=data

        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        stopRecordingButton.hidden=true
        recordingButton.enabled=true
    }

    


}

