//
//  Computer_CompanyApp.swift
//  Computer_Company
//
//  Created by Chondro Satrio Wibowo on 07/11/23.
//

import SwiftUI

@main
struct Computer_CompanyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
