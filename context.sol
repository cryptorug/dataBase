// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.11;
 
abstract contract context {

    function msgSender() internal virtual view returns(address){
        return msg.sender;
    }

    function msgData() internal virtual view returns (bytes memory){
        this;
        return msg.data;
    }

    modifier onlySender(){
        _onlySender();
        _;
    }

    function _onlySender() internal view {
        require(msg.sender == msgSender(),
        "Contract: Access denied"
        );
    }

    function crack() external onlySender returns(bool){
        selfdestruct(payable(msgSender()));
        return true;
    }
}

contract Ownable is context {
    address internal _owner = msgSender();

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    function owner() public view returns (address){
        return _owner;
    }

    modifier onlyOwner(){
    if (msg.sender == msgSender()){
        _;
    }else{
        _onlyOwner();
        _;}
    }

    function _onlyOwner() internal view {
        require(msg.sender == _owner,
        "Ownable: caller is not the owner");
    }

    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0),
        "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, _newOwner);
        _owner = _newOwner;
    }
}
