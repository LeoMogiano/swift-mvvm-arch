//
//  ContentView.swift
//  MyReads
//
//  Created by Leo Mogiano on 23/2/25.
//

import SwiftUI


struct HomeView: View {
    
    @Environment(Router.self) var router: Router
    @Environment(BookViewModel.self) var bookViewModel: BookViewModel
   
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        VStack(spacing: 15) {
            
            HStack {
                Text("MyReads")
                    .font(.system(size: 22))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(.green)
            
            TextField("", text: Bindable(bookViewModel).searchText)
                .padding(10)
                .overlay(
                    Group {
                        if bookViewModel.searchText.isEmpty {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(.secondary)
                                    .padding(.leading, 10)
                                Text("Search")
                                    .foregroundStyle(.secondary)
                                Spacer()
                            }
                        }
                    }
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.black, lineWidth: 1)
                )
                .cornerRadius(10)
                .padding(10)
                .onChange(of: bookViewModel.searchText) { oldValue, newValue in
                    bookViewModel.searchBooks()
                }
            
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Currently Reading")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.black)
                
                Divider()
                    .background(Color.gray.opacity(0.5))
            }
            .padding(.horizontal)
            
            if bookViewModel.isLoading {
                Spacer().frame(height: 200)
                ProgressView()
                
            }
            
            if bookViewModel.errorMessage != nil {
                Spacer().frame(height: 200)
                VStack{
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(.red)
                        .font(.system(size: 30))
                        .frame(width: 30, height: 30)
                    Text(bookViewModel.errorMessage!)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.red)
                        .padding()
                }
                
            }
            
            ScrollView {
                if bookViewModel.books.isEmpty && !bookViewModel.isLoading && bookViewModel.errorMessage == nil {
                    Text("No books found")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.gray)
                        .padding()
                } else {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(bookViewModel.books) { book in
                            BookView(book: book)
                                .onTapGesture {
                                    bookViewModel.getBookById(book.id!)
                                    router.navigate(to: .bookDetailView)
                                }
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                }
            }
            
        }
        .environment(bookViewModel)
        
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
