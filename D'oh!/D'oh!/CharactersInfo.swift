//
//  Characters.swift
//  D'oh!
//
//  Created by notRoderick on 12/8/18.
//  Copyright © 2018 MobileApps. All rights reserved.
//

import Foundation


class CharactersInfo {
    
    var name: String
    
    var bio: String
    
    var charImage: URL
    
    init(name: String, bio: String, charImage: URL) {
        
        self.name = name
        self.bio = bio
        self.charImage = charImage
    }
}
