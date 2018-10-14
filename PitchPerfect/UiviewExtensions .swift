//
//  UiviewExtensions .swift
//  PitchPerfect
//
//  Created by Dale Kilgore, Jr on 10/8/18.
//  Copyright © 2018 Dale Kilgore, Jr. All rights reserved.
//

import Foundation
import UIKit


extension UIView  {
    
    
    func blinkingRecordLabelFadeIn(){
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.alpha = 1
            
            })
        
    }

}



extension RecordSoundsViewController {
    
    
    
    func recordingOnBlinkingText() {
        
        if labelIsBlinking == true    {
            self.recordingLabel.alpha = 0.0; UIView.animate(withDuration: 0.8, delay: 0.0, options: [.curveEaseInOut, .autoreverse, .repeat],animations:
                { [weak self] in self?.recordingLabel.alpha = 1.0 }
                ,completion: { [weak self] _ in self?.recordingLabel.alpha = 0.0 })
            
        } else if labelIsBlinking == false {
            //             recalls animation and ensures blinking labels alpha is set back to 1 before termination
            self.recordingLabel.alpha = 0.0; UIView.animate(withDuration: 0.8, delay: 0.0, options: [.curveEaseInOut, .autoreverse, .repeat],animations:
                { [weak self] in self?.recordingLabel.alpha = 1.0 }
                ,completion: { [weak self] _ in self?.recordingLabel.alpha = 1.0 })
            
            self.recordingLabel.layer.removeAllAnimations()
            
        }
        
    }
    

}
