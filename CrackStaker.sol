// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CrackStaker {
    IERC20 public ccc;
    mapping(address => uint256) public balances;
    mapping(address => uint256) public startTime;

    constructor(address _ccc) {
        ccc = IERC20(_ccc);
    }

    function stake(uint256 amount) public {
        require(ccc.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        balances[msg.sender] += amount;
        startTime[msg.sender] = block.timestamp;
    }

    function unstake() public {
        uint256 timeStaked = block.timestamp - startTime[msg.sender];
        uint256 reward = (balances[msg.sender] * timeStaked) / 1 weeks;
        ccc.transfer(msg.sender, balances[msg.sender] + reward);
        balances[msg.sender] = 0;
    }
}
