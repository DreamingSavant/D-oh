//
//  Simpsons+CoreDataProperties.swift
//  D'oh!
//
//  Created by notRoderick on 12/11/18.
//  Copyright © 2018 MobileApps. All rights reserved.
//

import Foundation
import CoreData


extension Simpsons {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Simpsons> {
        return NSFetchRequest<Simpsons>(entityName: "Simpsons");
    }

    @NSManaged public var bio: String?
    @NSManaged public var characterImage: NSData?
    @NSManaged public var name: String?

}
