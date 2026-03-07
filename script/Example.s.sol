// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import { BCScript } from "src/BCScript.sol";
import { BCConfig } from "src/BCConfig.sol";
import { AgreementDetails, Contact, BcChain } from "src/types/AgreementTypes.sol";

/// @notice BattleChain deployment: deploy via BattleChainDeployer, create + adopt agreement, enter attack mode.
/// Run:  forge script script/Example.s.sol:BattleChainExample --fork-url <testnet-rpc>
contract BattleChainExample is BCScript {
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

        // 1. Deploy via BattleChainDeployer
        address token = bcDeployCreate(type(ExampleToken).creationCode);
        bcDeployCreate2(
            keccak256("vault-v1"),
            abi.encodePacked(type(ExampleVault).creationCode, abi.encode(token))
        );

        // 2. Create agreement with BattleChain defaults, adopt, commit
        address agreement = createAndAdoptAgreement(
            defaultAgreementDetails(
                _protocolName(), _contacts(), getDeployedContracts(), _recoveryAddress()
            ),
            msg.sender,
            keccak256("v1")
        );

        // 3. Enter attack mode
        requestAttackMode(agreement);

        vm.stopBroadcast();
    }
}

/// @notice Generic EVM deployment: deploy normally, build chain scope manually, create agreement.
/// Run:  forge script script/Example.s.sol:GenericEVMExample --fork-url <any-rpc>
contract GenericEVMExample is BCScript {
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

        // 1. Deploy with normal Solidity (no BattleChainDeployer needed)
        ExampleToken token = new ExampleToken();
        ExampleVault vault = new ExampleVault(address(token));

        // 2. Build chain scope for the current chain
        address[] memory contracts = new address[](2);
        contracts[0] = address(token);
        contracts[1] = address(vault);

        string memory caip2 = string.concat("eip155:", vm.toString(block.chainid));
        BcChain[] memory chains = new BcChain[](1);
        chains[0] = buildChainScope(contracts, _recoveryAddress(), caip2);

        // 3. Build agreement details with explicit URI
        AgreementDetails memory details = buildAgreementDetails(
            _protocolName(),
            _contacts(),
            chains,
            defaultBountyTerms(),
            BCConfig.SAFE_HARBOR_V3_URI
        );

        // 4. Create and adopt (requires factory/registry on this chain, or _setBcAddresses())
        createAndAdoptAgreement(details, msg.sender, keccak256("v1"));

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
