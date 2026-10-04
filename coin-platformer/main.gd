extends Node2D

var coins = 0

func add_coin():
	coins += 1
	$UI/CoinLabel.text = "Coins: " + str(coins)
