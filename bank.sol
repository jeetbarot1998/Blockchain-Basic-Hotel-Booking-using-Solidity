pragma solidity ^0.6.0;

contract HotelRoom{
    
    enum Statuses { Vacant, Occupied }
    Statuses currenStatus;
    
    address payable public owner;
    
    event Occupy(address _occupant, uint value );
    
    constructor() public{
        owner= msg.sender;
        currenStatus = Statuses.Vacant;
    }
    
    modifier onlyWhileVacant{
        require(currenStatus == Statuses.Vacant , "Already Occupied");
        _;
    }
    
    modifier costs( uint _amount){
        require(msg.value >= _amount,"Not enough Ether Provided.");
        _;
    }
    
    receive() external payable onlyWhileVacant costs(2 ether){
        owner.transfer(msg.value);
        currenStatus= Statuses.Occupied;
        emit Occupy(msg.sender, msg.value);
    }
}
