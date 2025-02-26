//
//  Book.swift
//  MyReads
//
//  Created by Leo Mogiano on 23/2/25.
//
import Foundation


struct BookResponse: Codable {
    let books: [Book]?
    let book: Book?
    let error: String?
}

struct Book: Identifiable, Codable, Equatable, Hashable {
    let id: String?
    let title: String?
    let authors: [String]?
    let description: String?
    let imageLinks: ImageLinks?
}

struct ImageLinks: Codable, Equatable, Hashable {
    let thumbnail: String?
}

func decodeBooks(from data: Data) -> [Book]? {
    
    let decoder = JSONDecoder()
    do {
        let booksResponse = try decoder.decode(BookResponse.self, from: data)
        if booksResponse.error != nil {
            return []
        }
        return booksResponse.books
    } catch let error as DecodingError {
        // Si el error es tipo 'typeMismatch', simplemente no hacemos nada
        if case .typeMismatch = error {
           
            return nil
        }
        
        print("Error decoding books: \(error)")
        return nil
    } catch {
        // Captura otros errores si ocurren
        print("Error desconocido: \(error)")
        return nil
    }

}

func decodeBook(from data: Data) -> Book? {
    
    let decoder = JSONDecoder()
    do {
        let booksResponse = try decoder.decode(BookResponse.self, from: data)
        return booksResponse.book
    } catch {
        print("Error desconocido: \(error)")
        return nil
    }
}
