//
//  BookRepository.swift
//  MyReads
//
//  Created by Leo Mogiano on 23/2/25.
//

import Foundation
import SwiftUI

class BookRepository {
    
    private let _baseURL = "https://reactnd-books-api.udacity.com"
    
    // Crear los headers para las solicitudes
    private func createHeaders() -> [String: String] {
        return [
            "Authorization": "Bearer Test",
            "Content-Type": "application/json"
        ]
    }
    
    // Obtener los libros
    func getBooks() async throws -> [Book] {
        let apiURL = "\(_baseURL)/books"
        
        var request = URLRequest(url: URL(string: apiURL)!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = createHeaders() // Agregar headers
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            guard let books = decodeBooks(from: data) else {
                return []
            }
            return books
        } catch {
            print("Error fetching books: \(error)")
            throw error
        }
    }
    
    func searchBooks(query: String) async throws -> [Book] {
        
        if query.isEmpty {
            let books = try await getBooks()
            return books
        }
        
        let apiURL = "\(_baseURL)/search"
        
        var request = URLRequest(url: URL(string: apiURL)!)
        request.httpMethod = "POST"
        
        // Crea el cuerpo de la solicitud en formato JSON
        let body: [String: Any] = [
            "query": query,
            "maxResults": 5
        ]
        
        // Convierte el cuerpo a JSON
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error serializing JSON: \(error)")
            throw error
        }
        
        // Agregar los headers
        request.addValue("Bearer Test", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            // Realiza la solicitud y maneja la respuesta
            let (data, _) = try await URLSession.shared.data(for: request)

            guard let books = decodeBooks(from: data) else {
                return []
            }
            return books
            
        } catch {
            print("Error fetching books: \(error)")
            throw error
        }
    }
    
    // Obtener un libro por ID
        func getBookById(id: String) async throws -> Book {
            let apiURL = "\(_baseURL)/books/\(id)"
            
            var request = URLRequest(url: URL(string: apiURL)!)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = createHeaders()
            
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                guard let book = decodeBook(from: data) else {
                    throw URLError(.badServerResponse)
                }
                return book
            } catch {
                print("Error fetching book by id: \(error)")
                throw error
            }
        }
    
}
