//
//  BookViewModel.swift
//  MyReads
//
//  Created by Leo Mogiano on 23/2/25.
//


import SwiftUI
import Observation

@Observable
class BookViewModel {
    
    var books: [Book] = []
    var book: Book? = nil
    var searchText: String = ""
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let bookRepository = BookRepository()
    
    init() {
        loadBooks()
    }
    
    // Cargar los libros desde el repositorio
    func loadBooks() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedBooks = try await bookRepository.getBooks()
                books = fetchedBooks
            } catch {
                errorMessage = "Failed to load books: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
    
    // Método de búsqueda que usa el repositorio para buscar libros
    func searchBooks() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedBooks = try await bookRepository.searchBooks(query: searchText)
                books = fetchedBooks
            } catch {
                errorMessage = "Failed to search books: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
    
    func getBookById(_ id: String) {
        isLoading = true
        errorMessage = nil
        
        Task{
            do {
                let fetchedBook = try await bookRepository.getBookById(id: id)
                book = fetchedBook
            } catch {
                errorMessage = "Failed to search book: \(error.localizedDescription)"
            }
            isLoading = false
        }

    }
}
