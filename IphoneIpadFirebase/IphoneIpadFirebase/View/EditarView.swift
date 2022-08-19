//
//  EditarView.swift
//  IphoneIpadFirebase
//
//  Created by MAC on 09/08/22.
//

import SwiftUI

struct EditarView: View {
    
    @State private var titulo = ""
    @State private var desc = ""
    
    var plataforma: String
    var datos: FirebaseModel
    @StateObject var guardar = FirebaseViewModel()
    
    @State private var imageData: Data = .init(capacity: 0)
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source: UIImagePickerController.SourceType = .camera
    
    @State private var progress = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.yellow.edgesIgnoringSafeArea(.all)
                VStack {
                    
                    NavigationLink(destination: ImagePicker(show: $imagePicker, image: $imageData, source: source), isActive: $imagePicker) {
                        EmptyView()
                    }
                    .navigationBarHidden(true)
                    
                    
                    TextField("Titulo", text: $titulo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onAppear{
                            titulo = datos.titulo
                        }
                    TextEditor(text: $desc)
                        .frame(height: 200)
                        .onAppear{
                            desc = datos.desc
                        }
            
                    Button {
                        mostrarMenu.toggle()
                    } label: {
                        Text("Cargar imagen")
                            .foregroundColor(.black)
                            .bold()
                            .font(.largeTitle)
                    }
                    .actionSheet(isPresented: $mostrarMenu) {
                        ActionSheet(title: Text("Menu"), message: Text("Selecciona una opcion"), buttons: [
                            .default(Text("Camara"), action: {
                                source = .camera
                                imagePicker.toggle()
                            }),
                            .default(Text("Galeria"), action: {
                                source = .photoLibrary
                                imagePicker.toggle()
                            }),
                            .default(Text("Cancelar"))
                        ])
                    }
                    
                    if imageData.count != 0 {
                        Image(uiImage: UIImage(data: imageData)!)
                            .resizable()
                            .frame(width: 250, height: 250)
                            .cornerRadius(15)
                    }
                    
                    Button {
                        if imageData.isEmpty {
                            guardar.edit(titulo: titulo, desc: desc, plataforma: plataforma, id: datos.id) { done in
                                if done {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        } else {
                            progress = true
                            guardar.editWithImage(titulo: titulo, desc: desc, plataforma: plataforma, id: datos.id, index: datos, portada: imageData) { done in
                                if done {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                    } label: {
                        Text("Editar")
                            .foregroundColor(.black)
                            .bold()
                            .font(.largeTitle)
                    }
                    
                    if progress {
                        Text("Espere un momento, por favor").foregroundColor(.black)
                        ProgressView()
                    }
                    
                    Spacer()
                }
                .padding(.all)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            print(datos)
        }
    }
}


