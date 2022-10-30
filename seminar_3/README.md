
# Homework 3.3

Done by: Kulikov Bogdan, BSE 204.

## Description
In this homework we were asked to create simple web3 application and call a method of previously deployed contract.
Due to the problems with Goerli and faucets, I deployed local Ganache blockchain and used it to run my web3.js application, but i'll provide contract address and contract ABI in Goerli network.

Example run:
```(bash)
ENDPOINT='http://127.0.0.1:7545' \
CONTRACT_ENDPOINT='0xf896A27eA1fBa161F6030a2e716B6e99d8B47d98' \
WALLET='0x59d6a731CAb438b77ee870EDa0B41607E37fd148' \
node web3.js
```

See env variable in .env files. Wallet can be any wallet in blockchain, but I did not mint that many tokens :D