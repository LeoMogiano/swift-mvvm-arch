//
//  BookDetailView.swift
//  MyReads
//
//  Created by Leo Mogiano on 23/2/25.
//

import SwiftUI

struct BookDetailView: View {
    
    @Environment(BookViewModel.self) var bookViewModel: BookViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        HStack {
            Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                    .font(.system(size: 22))
            }
            .padding(.leading, 10)
            
            Text("Book")
                .font(.system(size: 22))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
            Spacer()
            Spacer()
            Spacer()
            
        }.padding(.vertical, 10)
            .background(Color.green)
            .navigationBarBackButtonHidden(true)
        
        
        if bookViewModel.isLoading {
            
            ProgressView()
            Spacer()
        }
        
        
        if !bookViewModel.isLoading {
            
            Text(bookViewModel.book?.title ?? "")
                .font(.system(size: 22))
                .foregroundStyle(.black)
            
            Text(bookViewModel.book?.authors?.first ?? "")
                .font(.system(size: 17))
                .foregroundStyle(.gray)
            
            Spacer().frame(height: 20)
            
            
            
            AsyncImage(url: URL(string: bookViewModel.book?.imageLinks?.thumbnail ?? "https://m.media-amazon.com/images/I/51RsucZ9RuL._AC_UF894,1000_QL80_.jpg")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 160, height: 200)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)  // Ajusta el comportamiento según lo desees
                        .frame(width: 160, height: 200)
                        .clipped()
                        .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 5)
                case .failure:
                    Image(systemName: "exclamationmark.triangle.fill")  // Imagen de error si falla la carga
                        .foregroundColor(.red)
                        .frame(width: 160, height: 200)
                @unknown default:
                    EmptyView()
                }
                
                
                
            }
            .frame(width: 160)
            
            Spacer().frame(height: 20)
            
            JustifiedText(text: bookViewModel.book?.description ?? "No hay descripcion")
                .font(.system(size: 17))
                .padding(.horizontal, 20)
            
            
            
            
            
        }
    }
}



#Preview {
    @Previewable @State var mockRouter = Router()
    @Previewable @State var bookViewModel = BookViewModel()
    
    NavigationStack(path:($mockRouter.navPath)) {
        HomeView()
            .environment(mockRouter)
            .environment(bookViewModel)
            .navigationDestination(for: Router.Destination.self) { destination in
                switch destination {
                    //   case .bookView(book: let book):
                    //       BookView(book: book)
                case .bookDetailView:
                    BookDetailView()
                        .environment(bookViewModel)
                }
            }
    }
}


struct JustifiedText: View {
    var text: String
    
    var body: some View {
        TextView(text: text)
            .frame(maxWidth: .infinity, alignment: .leading) // Asegura que ocupe todo el ancho disponible
    }
}

struct TextView: UIViewRepresentable {
    var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        //color negro
        textView.textColor = UIColor.darkGray
        textView.textAlignment = .justified
        textView.isEditable = false // Evita que el usuario edite el texto
        textView.isSelectable = true // Permite que el texto sea seleccionable
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}
