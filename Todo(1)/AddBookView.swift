//
//  AddBookView.swift
//  Todo(1)
//
//  Created by Mactop78 on 26/11/20.
//

import SwiftUI
import CoreData

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Horor","Fantasy","Romance","Mystery","Action","Adventure","War"]
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Name of book", text: $title)
                    TextField("Author's Name", text: $author)
                    
                    Picker("Genre", selection : $genre){
                        ForEach(genres,id: \.self){
                            Text($0)
                        }
                    }
                }
                Section {
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }
                Section{
                    Button("Save"){
                        //add Book//
                        let newbook = Book(context: self.moc)
                        newbook.title = self.title
                        newbook.author = self.author
                        newbook.rating = Int16(self.rating)
                        newbook.genre = self.genre
                        newbook.review = self.review
                        
                        try? self.moc.save()
                        
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Book")
        }
    }
}


struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
