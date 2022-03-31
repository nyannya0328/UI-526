//
//  DetailView.swift
//  UI-526
//
//  Created by nyannyan0328 on 2022/03/31.
//

import SwiftUI

struct DetailView: View {
    var movie : Movie
    @Binding var showDetail : Bool
    @Binding var detailMovie : Movie?
    @Binding var currentSize : CGSize
    var animation : Namespace.ID
    
    @State var offset : CGFloat = 0
    @State var showDetailContent : Bool = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing:20){
                
                Image(movie.artwork)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: currentSize.width, height: currentSize.height)
                    .cornerRadius(20)
             
                
                VStack{
                    
                    Text("Story Plot")
                        .font(.title.weight(.heavy))
                        .foregroundColor(.black)
                        .frame(maxWidth:.infinity,alignment: .leading)
                    
                    
                    Text(sampleText)
                        .multilineTextAlignment(.leading)
                        .font(.subheadline.weight(.thin))
                        .padding(.top,20)
                    
                    
                    Button {
                        
                    } label: {
                        
                        Text("Book Ticket")
                            .font(.title.weight(.semibold))
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(maxWidth:.infinity)
                            .background{
                                
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                            }
                    }
                    .padding(.top,20)

                }
                .opacity(showDetailContent ? 1 : 0)
                .offset(y: showDetailContent ? 0  : 250)
                
                
            }
            .padding()
            .modifier(OffsetModifier(offset: $offset))
        }
        .coordinateSpace(name: "SCROLL")
        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .background{
            
            
            Rectangle()
                .fill(.ultraThinMaterial).ignoresSafeArea()
        }
        .onAppear {
            withAnimation{
                
                showDetailContent = true
            }
        }
        .onChange(of: offset) { newValue in
            
            if newValue > 120{
                
                withAnimation{
                    
                    
                    showDetailContent = false
                
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.03){
                    
                    withAnimation{
                        
                        
                        showDetail  = false
                    
                    }
                    
                }
            
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
