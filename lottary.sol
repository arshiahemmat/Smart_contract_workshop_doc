
pragma solidity ^0.4.17;

contract lottary
{
    address public manager;
    address public winner_address;
    address[] public players;
    function lottary() public{
        manager = msg.sender;
    }
    function enter() public payable{
        require(msg.value > 0.01 ether);
        players.push(msg.sender);
    }
    function PickWinner() public CheckAdmin{
        uint index = random_generator() % players.length;
        players[index].transfer(this.balance);
        winner_address = players[index];
        players = new address[](0);
    }
    function random_generator() public view returns(uint){
        return uint(keccak256(block.difficulty, now, players));
    }
    function getPlayer() public view returns(address[]){
        return players;
    }
    function WinPrice() public view returns(uint)
    {
        return this.balance;
    }
    modifier CheckAdmin{
        require(msg.sender == manager);
        _;
    }
    
}