//
//  PersistanceManager.swift
//  D'oh!
//
//  Created by notRoderick on 12/9/18.
//  Copyright © 2018 MobileApps. All rights reserved.
//

import Foundation
import CoreData


class PersistanceManager {
    static let sharedInstance = PersistanceManager()
    private init() { }
    
    private lazy var mainContext: NSManagedObjectContext = {
        
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = PersistanceManager.sharedInstance.persistentContainer.persistentStoreCoordinator
        return context
    }()
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = self.mainContext
        return context
    }()
    
    //MARK: Simpson Management
    
    static func addSimpson (_ name: String, _ bio: String, _ characterImage: Data ) -> Simpsons {
        
        //make Simpson 
        let myNewSimpson = NSEntityDescription.insertNewObject(forEntityName: "Simpsons", into: PersistanceManager.sharedInstance.backgroundContext)
        
        myNewSimpson.setValue(name, forKey: "name")
        myNewSimpson.setValue(bio, forKey: "bio")
        myNewSimpson.setValue(characterImage, forKey: "characterImage")
        
        // save the context 
        let bgContext = PersistanceManager.sharedInstance.backgroundContext
        bgContext.performAndWait {
            do {
                try bgContext.save()
            } catch {
                print("\(error)")
            }
        }
        
        return myNewSimpson as! Simpsons
    }
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "D_oh_")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error: \(error), : \(error.userInfo)")
//                fatalError("There is an error")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


//
//static func addPokemonToTrainer(_ pokemon: Pokemon) {
//    pokemon.trainer = PersistenceManager.sharedInstance.trainer
//    
//    PersistenceManager.sharedInstance.saveContext()
//}
//
//static func loadSavedPokemon() -> [Pokemon] {
//    return PersistenceManager.sharedInstance.trainer.pokemon?.array as! [Pokemon]
//    /*
//     let fetchRequest = NSFetchRequest<Pokemon>(entityName: "Pokemon")
//     
//     // refine our fetch request
//     let hitmontopPredicate = NSPredicate(format: "name = %@",
//     argumentArray: ["hitmontop"])
//     // fetchRequest.predicate = hitmontopPredicate
//     do {
//     let savedPokemon = try PersistenceManager.sharedInstance.mainContext.fetch(fetchRequest)
//     return savedPokemon
//     }
//     catch {
//     return []
//     }
//     */
//}
//
//static func deleteAllPokemon(_ name: String) {
//    let context = PersistenceManager.sharedInstance.mainContext
//    let fetchRequest = NSFetchRequest<Pokemon>(entityName: "Pokemon")
//    
//    // refine our fetch request
//    let hitmontopPredicate = NSPredicate(format: "name = %@",
//                                         argumentArray: [name])
//    fetchRequest.predicate = hitmontopPredicate
//    do {
//        let savedPokemon = try context.fetch(fetchRequest)
//        for pokemon in savedPokemon {
//            context.delete(pokemon)
//        }
//        PersistenceManager.sharedInstance.saveContext()
//    }
//    catch { }
//}
//
//static func savePokemon() {
//    PersistenceManager.sharedInstance.saveContext()
//}
//
//static func deletePokemon(_ pokemon: Pokemon) {
//    let context = PersistenceManager.sharedInstance.mainContext
//    context.delete(pokemon)
//    PersistenceManager.sharedInstance.saveContext()
//}
//
//static func queryForPokemon() {
//    let context = PersistenceManager.sharedInstance.mainContext
//    
//    let fetchRequest = NSFetchRequest<Pokemon>(entityName: "Pokemon")
//    do {
//        let savedPokemon = try context.fetch(fetchRequest)
//        print("savedPokemon: \(savedPokemon.count)")
//    } catch { }
//    
//}
//
//static func deleteAllWildPokemon() {
//    let context = PersistenceManager.sharedInstance.mainContext
//    
//    let fetchRequest = NSFetchRequest<Pokemon>(entityName: "Pokemon")
//    let predicate = NSPredicate(format: "trainer = nil")
//    fetchRequest.predicate = predicate
//    do {
//        let savedPokemon = try context.fetch(fetchRequest)
//        savedPokemon.forEach { mon in
//            context.delete(mon)
//        }
//    } catch { }
//    
//    PersistenceManager.sharedInstance.saveContext()
//}
//
//
// MARK: - Core Data stack




