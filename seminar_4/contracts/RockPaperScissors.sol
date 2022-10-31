// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/utils/Strings.sol";

contract RockPaperScissors {

    event GameInitiated(address);
    event GameFinished(address);
    event PhaseChanged(Phase);

    enum Element {None, Rock, Scissors, Paper}
    enum Phase {Registration, Commit, Reveal }

    Phase public currentPhase;

    address public winner;
    address public kek;
    address public firstPlayer;
    address public secondPlayer;

    bytes32 private firstPlayerEnc;
    bytes32 private secondPlayerEnc;

    Element public firstPlayerMove;
    Element public secondPlayerMove;
    
    constructor() {
        firstPlayer = payable(0x0);
        secondPlayer = payable(0x0);
        
        currentPhase = Phase.Registration;
        emit PhaseChanged(Phase.Registration);
    }

    modifier correctRegistry() {
        require(msg.sender != firstPlayer && msg.sender != secondPlayer);
        _;
    }

    modifier activePlayer() {
        require(msg.sender == firstPlayer || msg.sender == secondPlayer);
        _;
    }

    modifier correctPhase(Phase phase) {
        require(currentPhase == phase);
        _;
    }
    
    function register() public correctRegistry correctPhase(Phase.Registration) returns (uint) {
        if (firstPlayer == address(0x0)) {
            emit GameInitiated(msg.sender);
            firstPlayer = payable(msg.sender);
            return 1;
        } else if (secondPlayer == address(0x0)) {
            secondPlayer = payable(msg.sender);
            currentPhase = Phase.Commit;
            emit PhaseChanged(Phase.Commit);
            return 2;
        }
        return 0;
    }

    // Make encoded move. 
    function commitMove(bytes32 move) public activePlayer correctPhase(Phase.Commit) returns (bool) {
        if (msg.sender == firstPlayer && firstPlayerEnc == 0x0) {
           firstPlayerEnc = move;
        } else if (msg.sender == secondPlayer && secondPlayerEnc == 0x0) {
            secondPlayerEnc = move;
        }

        if (firstPlayerEnc != 0x0 && secondPlayerEnc != 0x0) {
            currentPhase = Phase.Reveal;
            emit PhaseChanged(Phase.Reveal);
            return true;
        }

        return false;
    }

    function reveal(Element element, uint32 salt) public activePlayer correctPhase(Phase.Reveal) {
        require(firstPlayerEnc != 0x0 && secondPlayerEnc != 0x0);

        bytes32 encMove = sha256(bytes.concat(bytes(Strings.toString(uint(element))), bytes(Strings.toString(salt))));

        if (element == Element.None) {
            return;
        }

        if (msg.sender == firstPlayer && encMove == firstPlayerEnc) {
            firstPlayerMove = element;
        } else if (msg.sender == secondPlayer && encMove == secondPlayerEnc) {
            secondPlayerMove = element;
        } else {
            return;
        }

        if (firstPlayerMove != Element.None && secondPlayerMove != Element.None) {
             if (firstPlayerMove == secondPlayerMove) {
                winner = address(0x0);
            }
        
            if (
                (firstPlayerMove == Element.Scissors && secondPlayerMove == Element.Paper) ||
                (firstPlayerMove == Element.Paper && secondPlayerMove == Element.Rock) ||
                (firstPlayerMove == Element.Rock && secondPlayerMove == Element.Scissors) ||
                (firstPlayerMove != Element.None && secondPlayerMove == Element.None)) {
                    winner = firstPlayer;
                }
            else {
                winner = secondPlayer;
            }

            emit GameFinished(winner);
        }

        return;
    }

    function reset() public {
        prepareForNextGame();
    }

    function prepareForNextGame() private {
        winner = address(0x0);
        firstPlayer = address(0x0);
        secondPlayer = address(0x0);

        firstPlayerEnc = 0x0;
        secondPlayerEnc = 0x0;

        firstPlayerMove = Element.None;
        secondPlayerMove = Element.None;

        currentPhase = Phase.Registration;
        emit PhaseChanged(Phase.Registration);
    }
}
