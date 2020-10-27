//
//  HomeController.swift
//  Ride_Share_App
//
//  Created by Xinyi Cheng on 26.10.20.
//

import UIKit
import Firebase
import MapKit

class HomeController: UIViewController {
    
    // MARK: Properties
    
    private let mapView = MKMapView()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIdLoggedIn()
        view.backgroundColor = .backgroundColor
        // signOut()
    }
    
    // MARK: API
    
    func checkIfUserIdLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureUI()
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out")
        }
    }
    
    // MARK: Helper Function
    
    func configureUI() {
        
        view.addSubview(mapView)
        mapView.frame = view.frame
    }
}

