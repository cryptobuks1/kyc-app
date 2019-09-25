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
    
    mapping(string => Customer) public customers;
    mapping(string => Request) public requests;
    
    /*Customer[] public uniqCid;
    Bank[] public banks;
    Request[] public uniqRid;
    Request[] public validKyc;*/

    constructor() public {
        admin = msg.sender;
    }
    
    function addCustomer(string memory _username, string memory _dataHash) public returns (uint) {
        require(!isEmpty(_username), 'username required');
        require(!isEmpty(_dataHash), 'dataHash required');
        
        if(!isEmpty(customers[_username].dataHash)) {
            revert('already exists');
        }
        Customer memory customer = Customer(_username, _dataHash, msg.sender);
        customers[_username] = customer;
        return 1;
    }
    
    function modifyCustomer(string memory _username, string memory _dataHash) public returns (uint) {
        require(!isEmpty(_username), 'username required');
        require(!isEmpty(_dataHash), 'dataHash required');
        
        if(isEmpty(customers[_username].dataHash)) {
            revert('user not found');
        }
        
        customers[_username].dataHash = _dataHash;
        return 1;
    }
    
    function deleteCustomer(string memory _username) public returns (uint) {
        require(!isEmpty(_username), 'username required');
        
        if(isEmpty(customers[_username].dataHash)) {
            revert('user not found');
        }
        delete customers[_username];
        return 1;
    }
    
    function addRequest(string memory _username, string memory _dataHash) public returns (uint) {
        require(!isEmpty(_username),'username required');
        require(!isEmpty(_dataHash), 'dataHash required');
        
        if(!isEmpty(requests[_username].dataHash)) {
            revert('already exists');
        }
        Request memory request = Request(_username, _dataHash, msg.sender);
        requests[_username] = request;
        return 1;
    }
    
    /*function addRequest(string memory _username, string memory _data , address _bankAddress) public returns (uint) {
        // checkig whether username is already taken or not
        if(empty(customers[_username].dataHash)) {
           return 0; 
        }
        
        Customer memory customer = Customer(_username, _data, _bankAddress);
        customers[_username] = customer;
        
    }*

    function addCustomer(string memory _username, string memory _data) public returns (uint){
        for(uint i=0; i < customers.length; i++) {
            if(equalsTo(_username, customers[i].username) && equalsTo(_data, customers[i].dataHash)) {
                return 0;                               
            }
        }

        customers[customers.length-1] = Customer(_username, _data, address(0));
        customers.length++;
        return 1;
    } /

    /*Helper Functions*/

    function equalsTo(string memory _param1, string memory _param2) internal pure returns (bool) {
        bytes memory param1 = bytes(_param1);
        bytes memory param2 = bytes(_param2);

        if(param1.length != param2.length) {
            return false;
        }

        for(uint i=0; i< param1.length; i++) {
            if(param1[i] != param2[i]) 
                return false;
        }
        return true;
    }

    function isEmpty(string memory _param1) internal pure returns (bool) {
        bytes memory param1 = bytes(_param1);
        if(param1.length == 0)
            return true;
        return false;
    }
    
}
