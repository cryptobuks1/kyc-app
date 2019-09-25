pragama solidity^0.5.0;

contract Helper {
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