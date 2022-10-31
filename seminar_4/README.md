# Homework 3.3.

Assignee: Kulikov Bogdan, BSE204

## Description
In this homework we had to implement the Rock-Paper-Scissors game with Smart contracts.
The game is simple enough to skip explanation of the rules.
The major difficulty with building the Rock-Paper-Scissors game with Blockchain technologies is saving the player choice in a way, that would not allow an opponent to decode it and get advantage.
This difficulty is solved with commit-reveal approach - users firstly commit hash of the string **move-salt**, where **move** is their choice and **salt** is some random number that nobody else knows about.
After commiting thier choice, players are not allowed to change it and reveal phase steps in. Players now have to confirm their choices by sending **move** and **salt** openly.
The smart contract then calculates the hash from the given values and compares to commited hash, if they match - players move is accepted.

> Without commit-reveal approach it would be difficult to secretly send players move to the smart contract, due to transparant nature of Blockchain.


## Deployment
Following the 3 seminar homework, I still don't have enough funds to deploy my contracts to Goerli network, but I used Ganache platform and Truffle project manager to develop this smart contract.
The project is set up to use with Ganache and it's very simple to deploy there, without difficulties that Goerli brings.