//
//  PortadaViewModel.swift
//  IphoneIpadFirebase
//
//  Created by MAC on 09/08/22.
//

import Foundation
import Firebase
import FirebaseStorage

class PortadaViewModel: ObservableObject {
    
    @Published var data: Data? = nil
    
    init(imageUrl: String){
        let storageImage = Storage.storage().reference(forURL: imageUrl)
        storageImage.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error?.localizedDescription {
                print("Error al traer la imagen", error)
            } else {
                DispatchQueue.main.async {
                    self.data = data
                }
            }
        }
    }
    
}
