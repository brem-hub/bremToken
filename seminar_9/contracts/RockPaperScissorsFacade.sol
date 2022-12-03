// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 <0.9.0;

/*
RockPaperScissorsInterface defines public interface of the RockPaperScissors smart contract.
*/
abstract contract RockPaperScissorsInterface {
    enum Element {None, Rock, Scissors, Paper}
    enum Phase {Registration, Commit, Reveal }

    function register() external virtual returns (uint);

    function commitMove(bytes32 move) external virtual returns (bool);

    function reveal(Element element, uint32 salt) external virtual;

    function reset() external virtual;
}


/*
  RockPaperScissorsFacade is a contract that invokes RockPaperScissors contract, by using intercontract communication.
  The facade works by accessing deployed contract by its address.
  Updating the contract address allows for deploying this facade just once as long as the public interface of the contract does not change. 
  Current implementation of RockPaperScissors does not allow for connecting 2 different players from the same facade, due to the
   usage of the `msg.sender` attribute, that defines players.
*/
contract RockPaperScissorsFacade {
    // Address of the RockPaperScissors contract.
    address public rps_address;

    // Instance of the class, that proxies requests to the contract within the blockchain.  
    RockPaperScissorsInterface rcc;

    // setRpsAddress updates the smart contract address.
    function setRpsAddress(address addr) public {
        rcc = RockPaperScissorsInterface(addr);
        rps_address = addr;
    }

    // rccSet checks that the proxy class is invoked.
     modifier rccSet() {
        require(rps_address != address(0x0));
        _;
    }

    // register is the facade method of RockPaperScissors.register.
    function register() public rccSet returns(uint) {
        return rcc.register();
    }

    // commitMove is the facade method of RockPaperScissors.commitMove.
    function commitMove(bytes32 move) public rccSet returns(bool) {
        return rcc.commitMove(move);
    }


    // reveal is the facade method of RockPaperScissors.reveal.
    function reveal(RockPaperScissorsInterface.Element element, uint32 salt) public rccSet {
        return rcc.reveal(element, salt);
    }

    // reset is the facade method of RockPaperScissors.reset.
    function reset() public rccSet {
        return rcc.reset();
    }
}