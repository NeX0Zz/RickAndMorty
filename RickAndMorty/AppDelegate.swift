//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by Денис Николаев on 16.10.2024.
//



import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let apiService = APIService()
        appCoordinator = AppCoordinator(navigationController: navigationController, apiService: apiService)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        appCoordinator?.start()
        return true
    }
}
