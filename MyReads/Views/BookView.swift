//
//  BookView.swift
//  MyReads
//
//  Created by Leo Mogiano on 23/2/25.
//
import SwiftUI

struct BookView: View {
    
    let book: Book
    
   
    init(book: Book) {
        self.book = book
    }
    var body: some View {
        VStack() {
            AsyncImage(url: URL(string: book.imageLinks?.thumbnail ?? "https://m.media-amazon.com/images/I/51RsucZ9RuL._AC_UF894,1000_QL80_.jpg")) { phase in
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


            
            Group {
                Text(book.title ?? "No Title")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.black)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Text(book.authors?.first ?? "No Author" )
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.gray)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(width: 160)
    }
}
