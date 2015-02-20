//
//  Game.swift
//  BlackJack
//
//  Created by Asees on 2/20/15.
//  Copyright (c) 2015 Asees. All rights reserved.
//

import UIKit



var totalAmount = 100

var amountBetting = 5

var numBetting = 1



struct Card {
    
    let fc: String
    
    let val: Int
    
    let suit: String
    
    init(f: String, v: Int, s: String) {
        
        fc = f
        
        val = v
        
        suit = s
        
    }
    
}



struct Deck {
    
    
    
    var cards: [Card] = []
    
    
    
    init() {
        
        for index in 1...13 {
            
            for i in ["♠","♡", "♢", "♣"] {
                
                switch index {
                    
                case 1:
                    
                    cards.append(Card(f:"A", v:11, s:i))
                    
                case 2,3,4,5,6,7,8,9,10:
                    
                    cards.append(Card(f:"\(index)", v:index, s:i))
                    
                case 11:
                    
                    cards.append(Card(f:"J", v:10, s:i))
                    
                case 12:
                    
                    cards.append(Card(f:"Q", v:10, s:i))
                    
                case 13:
                    
                    cards.append(Card(f:"K", v:10, s:i))
                    
                default:
                    
                    println("Invalid card object")}
                
                
                
            }
            
        }
        
        deckShuffle()
        
    }
    
    
    
    mutating func drawACard() -> Card {
        
        return cards.removeLast()
        
    }
    
    
    
    mutating func deckShuffle() {
        
        var bgn = 0
        
        var to = 0
        
        for i in cards {
            
            bgn = Int(arc4random_uniform(UInt32(cards.count)))
            
            to = Int(arc4random_uniform(UInt32(cards.count)))
            
            cards.insert(cards.removeAtIndex(bgn), atIndex: to)
            
        }
        
    }
    
}



var deck = Deck()

var handD: [Card] = []

var handP: [Card] = []

var totalD = 0

var totalP = 0

var acesP = 0



func matchMade() {
    
    handP.append(deck.drawACard())
    
    totalP += handP[handP.count-1].val
    
    if( handP[handP.count-1].val == 11 ) { acesP++ }
    
    if( totalP > 21 && acesP > 0 ){ acesP--; totalP - 10 }
    
}







func dealer_plays() {
    
    handD = []
    
    totalD = 0
    
    var dealer_aces = 0
    
    
    
    while(totalD < 18) {
        
        println("+++++++++++++++++++++++++++++++Dealer Draws++++++++++++++++++++++++++++")
        
        handD.append( deck.drawACard() )
        
        totalD += handD[handD.count-1].val
        
        if( handD[handD.count-1].val == 11 ) { dealer_aces++ }
        
        if( totalD > 21 && dealer_aces > 0 ){ dealer_aces--; totalD - 10 }
        
    }
    
    
    
    print("+++++++++++++++++++++++++Hand is hidden+++++++++++++++++++")
    
    for i in 1..<handD.count {
        
        print( " - " + handD[i].fc + handD[i].suit )
        
    }
    
}







func stay() {
    
    println("++++++++++++++++++++++Player Stays+++++++++++\n")
    
    println("\n")
    
    println("\n")
    
    println("\n")
    
    println("++++++++++++++++++++++Dealer's Hand:")
    
    for i in 0..<handD.count {
        
        print(" " + handD[i].fc + handD[i].suit)
        
    }
    
    print(" = " + String(totalD) + "\n")
    
    if( totalD > 21 ){ print("Dealer busts\n");totalD = -1 }
    
    
    
    println()
    
    
    
    println("++++++++++++++++++++++++++++++Player's Hand:++++++++++++++++++++++++++")
    
    for i in 0..<handP.count {
        
        print(" " + handP[i].fc + handP[i].suit)
        
    }
    
    print(" = " + String(totalP) + "\n")
    
    if( totalP > 21 ){ print("+++++++++++++++++++++++++++Player busts+++++++++++++++++++++++++\n"); totalP = -1 }
    
    
    
    println()
    
    
    
    if( totalD > totalP ) { println("+++++++++++++++++++Dealer Wins+++++++++++++++" + String(amountBetting) ); totalAmount -= amountBetting }
        
    else if( totalD < totalP ) { println("+++++++++++++++++Player wins++++++++++++++++" + String(amountBetting) ); totalAmount += amountBetting }
        
    else { println("+++++++++++++++++++++++++++++++It's a draw++++++++++++++++++++++++++++++") }
    
    
    
    acesP = 0
    
    
    
    for i in handD {
        
        deck.cards.append(handD.removeLast())
        
    }
    
    for i in handP {
        
        deck.cards.append(handP.removeLast())
        
    }
    
    
    
    numBetting++
    
    if (numBetting > 5) {
        
        deck.deckShuffle()
        
    }
    
    
    
    if( totalAmount >= amountBetting ) {
        
        dealer_plays()
        
    }
        
    else {
        
        println("+++++++++++++++++++++++++++You ran out of money++++++++++++++++++++++")
        
    }
    
}





