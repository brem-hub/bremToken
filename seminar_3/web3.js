const Web3 = require('web3')

web3 = new Web3(process.env.ENDPOINT)

const ABI = require("./abi.json")

const myContract = new web3.eth.Contract(ABI, process.env.CONTRACT_ENDPOINT)

myContract.methods.balanceOf(process.env.WALLET).call().then(console.log)

