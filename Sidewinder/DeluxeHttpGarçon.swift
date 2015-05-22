//
//  DeluxeHttpGarçon.swift
//  Sidewinder
//
//  Created by Greg on 5/21/15.
//  Copyright (c) 2015 Sidewinder. All rights reserved.
//

import Foundation

class DeluxeHttpGarçon : HttpGarçon {
    func Get(url: String) -> NSData? {
        let url = NSURL(string: url)
        let request = NSURLRequest(URL: url!)
        return NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
    }
}