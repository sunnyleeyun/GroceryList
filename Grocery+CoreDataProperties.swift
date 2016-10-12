//
//  Grocery+CoreDataProperties.swift
//  Grocery List
//
//  Created by Sunny on 2016/10/12.
//  Copyright © 2016年 Sunny. All rights reserved.
//

import Foundation
import CoreData


extension Grocery {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Grocery> {
        return NSFetchRequest<Grocery>(entityName: "Grocery");
    }

    @NSManaged public var item: String?

}
