//
//  FavoriteProduct+CoreDataProperties.swift
//  Computer_Company
//
//  Created by Chondro Satrio Wibowo on 08/11/23.
//
//

import Foundation
import CoreData


extension FavoriteProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteProduct> {
        return NSFetchRequest<FavoriteProduct>(entityName: "FavoriteProduct")
    }

    @NSManaged public var created_at: Date?
    @NSManaged public var imagePath: String?
    @NSManaged public var isFavorited: Bool
    @NSManaged public var productId: Int16
    @NSManaged public var quantity: Int16
    @NSManaged public var title: String?

}

extension FavoriteProduct : Identifiable {

}
