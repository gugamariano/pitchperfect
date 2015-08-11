//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by antonio silva on 8/5/15.
//  Copyright (c) 2015 antonio silva. All rights reserved.
//

import Foundation


class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(url:NSURL) {
        filePathUrl=url
        title=url.lastPathComponent
    }
}
