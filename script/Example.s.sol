// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import { BCScript } from "src/BCScript.sol";
import { Contact } from "src/types/AgreementTypes.sol";

/// @notice Unified deployment example — works on BattleChain and any supported EVM chain.
///
/// BattleChain (deploys via BattleChainDeployer, creates agreement, enters attack mode):
///   forge script script/Example.s.sol --fork-url <bc-testnet-rpc> --broadcast
///
/// Any other supported chain (deploys via CreateX, creates Safe Harbor agreement):
///   forge script script/Example.s.sol --fork-url <l2-rpc> --broadcast
contract Example is BCScript {
    function _protocolName() internal pure override returns (string memory) {
        return "ExampleProtocol";
    }

    function _contacts() internal pure override returns (Contact[] memory) {
        Contact[] memory c = new Contact[](1);
        c[0] = Contact({ name: "Security Team", contact: "security@example.xyz" });
        return c;
    }

    function _recoveryAddress() internal view override returns (address) {
        return msg.sender;
    }

    function run() external {
        vm.startBroadcast();

        // 1. Deploy via CreateX on any chain (BattleChain also registers with AttackRegistry)
        address token = bcDeployCreate(type(ExampleToken).creationCode);
        bcDeployCreate2(
            keccak256("vault-v1"),
            abi.encodePacked(type(ExampleVault).creationCode, abi.encode(token))
        );

        // 2. Create + adopt Safe Harbor agreement (picks correct scope and URI per chain)
        address agreement = createAndAdoptAgreement(
            defaultAgreementDetails(
                _protocolName(), _contacts(), getDeployedContracts(), _recoveryAddress()
            ),
            msg.sender,
            keccak256("v1")
        );

        // 3. Enter attack mode (BattleChain only)
        if (_isBattleChain()) {
            requestAttackMode(agreement);
        }

        vm.stopBroadcast();
    }
}

/// @dev Minimal token for demonstration purposes.
contract ExampleToken {
    string public name = "Example";
}

/// @dev Minimal vault for demonstration purposes.
contract ExampleVault {
    address public immutable TOKEN;

    constructor(address token_) {
        TOKEN = token_;
    }
}
