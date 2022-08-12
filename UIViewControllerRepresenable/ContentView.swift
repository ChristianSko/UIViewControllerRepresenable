//
//  ContentView.swift
//  UIViewControllerRepresenable
//
//  Created by Christian Skorobogatow on 12/8/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showscreen: Bool = false
    @State private var image: UIImage? = nil
    
    var body: some View {
        VStack {
            Text("Hello!")
                .padding()
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
            Button {
                showscreen.toggle()
            } label: {
                Text("Click Here")
            }
            .sheet(isPresented: $showscreen) {
                UIImagePickerControllerRepresenable(image: $image, showingScreen: $showscreen)
//                BasicUIViewControllerRepresentable(labelText: "new text here")
            }

        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct UIImagePickerControllerRepresenable: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    @Binding var showingScreen: Bool
    
    
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate =  context.coordinator
        
        return vc
    }
    
    
    // From SwiftUI to UIKIT
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Not used so often in these case
        // Used more ofen UIViewRepresentable
        
    }
    
    // From UIKIT to SwiftUI
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, showingScreen: $showingScreen)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @Binding var image: UIImage?
        @Binding var showingScreen: Bool
        
        
        init(image: Binding<UIImage?>, showingScreen: Binding<Bool>) {
            self._image = image
            self._showingScreen = showingScreen
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            guard let newImage = info[.originalImage] as? UIImage else { return }
            image = newImage
            showingScreen = false
            
        }
        
        
    }

}



struct BasicUIViewControllerRepresentable: UIViewControllerRepresentable {
    
    let labelText: String
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = MyFirstViewController()
        vc.labelText = labelText
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class MyFirstViewController: UIViewController {
    
    var labelText: String = "Starting Value"
    
    override func viewDidLoad() {
        
        view.backgroundColor = .blue
        
        let label = UILabel()
        label.text = labelText
        label.textColor = .white
        
        view.addSubview(label)
        label.frame = view.frame
    }
}
