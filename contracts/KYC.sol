pragma solidity^0.5.0;

contract KYC {

    struct Customer {
        string username;
        string dataHash;
        address bankAddress;
    }

    struct Bank {
        string name;
        address bankAddress;
        string regNumber;
    }

    struct Request {
        string username;
        string dataHash;
        address bankAddress;
    }

    address admin;

    /*mapping(address => Customer) private customers;
    mapping(address => Bank) private banks;
    mapping(address => Request) private requests;*/
    
    Customer[] customers;
    Bank[] public banks;
    Request[] public requests;
    Request[] public validKyc;

    constructor() public {
        admin = msg.sender;
    }

    function addRequest(string memory _username, string memory _data, address _bankAddress ) public returns (uint) {
        for(uint i=0; i<requests.length; i++ ) {
        	if(equalsTo(_username, requests[i].username) 
        	    && equalsTo(_data, requests[i].dataHash)
        	    && _bankAddress ==  requests[i].bankAddress) {
        		return 0;
        	}
        }
        requests[requests.length-1] = Request(_username, _data, _bankAddress);
        requests.length++;
        return 1;
    }

    function equalsTo(string memory _param1, string memory _param2) internal pure returns (bool) {
    	bytes memory param1 = bytes(_param1);
    	bytes memory param2 = bytes(_param2);

    	if(param1.length != param2.length) {
    		return false;
    	}

    	for(uint i=0; i< param1.length; i++) {
    		if(param1[i] != param2[i]) {
    			return false;
    		}
    	}
    	return true;
    }
    
}
