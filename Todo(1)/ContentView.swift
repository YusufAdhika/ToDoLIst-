//
//  ContentView.swift
//  Todo(1)
//
//  Created by Mactop78 on 24/11/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ])var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(books, id: \.self){ book in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading){
                            Text(book.title ?? "Unknown title")
                                .font(.headline)
                            Text(book.author ?? "Unknown title")
                                .foregroundColor(.secondary)
                            
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationBarTitle("Save Your Book")
            .navigationBarItems(leading: EditButton() ,trailing:
                                    Button(action: {self.showingAddScreen.toggle()
                                    }) {
                                        Image(systemName: "plus")
                                    }
            )
            .sheet(isPresented: $showingAddScreen){
                AddBookView().environment(\.managedObjectContext,self.moc)
            }
        }
    }
    func deleteBooks(at offset: IndexSet){
        for offset in offset {
            let book = books[offset]
            moc.delete(book)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
