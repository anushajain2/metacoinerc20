pragma solidity ^0.4.18;

import "./ConvertLib.sol";
import "tokens/eip20/EIP20.sol";
// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

contract MetaCoin is EIP20 {
	mapping (address => uint) balances;

	event Transfer(address indexed _from, address indexed _to, uint256 _value);

	constructor() public {
		balances[tx.origin] = 10000;
	}

	function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
		if (balances[msg.sender] < amount) return false;
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		emit Transfer(msg.sender, receiver, amount);
		return true;
	}

	function getBalanceInEth(address addr) public view returns(uint){
		return ConvertLib.convert(getBalance(addr),2);
	}

	function getBalance(address addr) public view returns(uint) {
		return balances[addr];
	}
}


[
	{
		"constant": true,
		"inputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"name": "campaigns",
		"outputs": [
			{
				"name": "beneficiary",
				"type": "address"
			},
			{
				"name": "fundingGoal",
				"type": "uint256"
			},
			{
				"name": "numFunders",
				"type": "uint256"
			},
			{
				"name": "amount",
				"type": "uint256"
			}
		],
		"payable": false,
		"type": "function",
		"stateMutability": "view"
	},
	{
		"constant": true,
		"inputs": [],
		"name": "numCampaigns",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": false,
		"type": "function",
		"stateMutability": "view"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "campaignID",
				"type": "uint256"
			}
		],
		"name": "checkGoalReached",
		"outputs": [
			{
				"name": "reached",
				"type": "bool"
			}
		],
		"payable": false,
		"type": "function",
		"stateMutability": "nonpayable"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "campaignID",
				"type": "uint256"
			}
		],
		"name": "contribute",
		"outputs": [],
		"payable": true,
		"type": "function",
		"stateMutability": "payable"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "beneficiary",
				"type": "address"
			},
			{
				"name": "goal",
				"type": "uint256"
			}
		],
		"name": "newCampaign",
		"outputs": [
			{
				"name": "campaignID",
				"type": "uint256"
			}
		],
		"payable": false,
		"type": "function",
		"stateMutability": "nonpayable"
	}
]
