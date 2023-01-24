//
//  testProjectApp.swift
//  testProject
//
//  Created by Mark.Che on 24/1/2023.
//

import SwiftUI

@main
struct testProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
