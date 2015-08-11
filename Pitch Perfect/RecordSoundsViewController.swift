//
//  RecordSoundsViewController
//  Pitch Perfect
//
//  Created by antonio silva on 8/1/15.
//  Copyright (c) 2015 antonio silva. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {

   
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    
    @IBOutlet weak var tapToRecord: UILabel!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingInProgress.hidden=true
        stopRecordingButton.hidden=true
        tapToRecord.hidden=false
        audioRecorder.stop()
    }
    
    
    
    @IBAction func startRecording(sender: UIButton) {
        
        recordingInProgress.hidden=false
        stopRecordingButton.hidden=false
        recordingButton.enabled=false
        tapToRecord.hidden=true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        

        let recordingName="sound"
        
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        //println(filePath)
        
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
        stopRecordingButton.hidden=true
        recordingButton.enabled=true
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   

}

