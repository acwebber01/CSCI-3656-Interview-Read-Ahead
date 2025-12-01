cards = Int[]

function initCards()
    for i in 1:13
        push!(cards, i)
        push!(cards, i)
        push!(cards, i)
        push!(cards, i)
    end

    for i in length(cards):-1:2
        j = rand(1:i)
        cards[i], cards[j] = cards[j], cards[i]
    end
end

function hit(player)
    if !isempty(cards)
        cardRemoved = pop!(cards)
        print("Card drawn: ", cardRemoved, " for player ", player, "\n")
        return cardRemoved
    end
end

function game()
    while true
        initCards()

        playerCards = Int[]
        dealerCards = Int[]
        push!(playerCards, hit("player"))
        push!(dealerCards, hit("dealer"))
        push!(playerCards, hit("player"))
        push!(dealerCards, hit("dealer"))

        print("Player cards: ", join(playerCards, ", "), " Total sum: ", sum(playerCards), "\n")
        print("Dealer cards: ", join(dealerCards, ", "), " Total sum: ", sum(dealerCards), "\n")
        print("Type 'hit' to draw another card or 'stand' to hold.\n")
        option = readline()
        while option == "hit" 
            push!(playerCards, hit("player"))
            print("Player cards: ", join(playerCards, ", "), " Total sum: ", sum(playerCards), "\n")
            if sum(playerCards) > 21
                print("You lose\n")
                break
            end
            print("Type 'hit' to draw another card or 'stand' to hold.\n")
            option = readline()
        end
        if sum(playerCards) <= 21
            while sum(dealerCards) < 17 
                push!(dealerCards, hit("dealer"))
                print("Dealer cards: ", join(dealerCards, ", "), " Total sum: ", sum(dealerCards), "\n")
            end
            if sum(dealerCards) > 21 || sum(playerCards) > sum(dealerCards)
                print("You win\n")
            elseif sum(playerCards) < sum(dealerCards)
                print("You lose\n")
            else
                print("It's a tie\n")
            end
        end

        print("Play again? (yes/no)\n")
        playAgain = readline()
        if playAgain != "yes"
            break
        end

        cards = Int[]
    end
end

game()