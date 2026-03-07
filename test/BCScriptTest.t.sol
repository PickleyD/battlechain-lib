// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import { Test } from "forge-std/Test.sol";
import { BCScript } from "src/BCScript.sol";
import { AgreementDetails, Contact } from "src/types/AgreementTypes.sol";
import {
    MockAgreementFactory,
    MockAgreement,
    MockBCRegistry,
    MockAttackRegistry,
    MockBCDeployer,
    MockToken
} from "test/mocks/MockBCInfra.sol";

contract BCScriptHarness is BCScript {
    function _protocolName() internal pure override returns (string memory) {
        return "TestProtocol";
    }

    function _contacts() internal pure override returns (Contact[] memory) {
        Contact[] memory c = new Contact[](1);
        c[0] = Contact({ name: "Security", contact: "sec@test.xyz" });
        return c;
    }

    function _recoveryAddress() internal view override returns (address) {
        return msg.sender;
    }

    function configure(
        address registry,
        address factory,
        address attackRegistry,
        address deployer_
    )
        external
    {
        _setBcAddresses(registry, factory, attackRegistry, deployer_);
    }

    function exposedProtocolName() external pure returns (string memory) {
        return _protocolName();
    }

    function exposedContacts() external pure returns (Contact[] memory) {
        return _contacts();
    }

    function exposedRecoveryAddress() external view returns (address) {
        return _recoveryAddress();
    }

    function deployToken() external returns (address) {
        return bcDeployCreate(type(MockToken).creationCode);
    }

    function exposedCreateAndAdoptAgreement(
        AgreementDetails memory details,
        address owner,
        bytes32 salt
    )
        external
        returns (address)
    {
        return createAndAdoptAgreement(details, owner, salt);
    }

    function exposedDefaultAgreementDetails(
        string memory protocolName,
        Contact[] memory contacts,
        address[] memory contracts,
        address recoveryAddr
    )
        external
        view
        returns (AgreementDetails memory)
    {
        return defaultAgreementDetails(protocolName, contacts, contracts, recoveryAddr);
    }

    function exposedGetDeployedContracts() external view returns (address[] memory) {
        return getDeployedContracts();
    }

    function exposedRequestAttackMode(address agreement) external {
        requestAttackMode(agreement);
    }
}

contract BCScriptTest is Test {
    BCScriptHarness harness;
    MockAgreementFactory factory;
    MockBCRegistry registry;
    MockAttackRegistry attackRegistry;
    MockBCDeployer deployer;

    function setUp() public {
        vm.chainId(627);

        harness = new BCScriptHarness();
        factory = new MockAgreementFactory();
        registry = new MockBCRegistry();
        attackRegistry = new MockAttackRegistry();
        deployer = new MockBCDeployer();

        harness.configure(
            address(registry), address(factory), address(attackRegistry), address(deployer)
        );
    }

    function test_protocolName() public view {
        assertEq(harness.exposedProtocolName(), "TestProtocol");
    }

    function test_contacts() public view {
        Contact[] memory c = harness.exposedContacts();
        assertEq(c.length, 1);
        assertEq(c[0].name, "Security");
        assertEq(c[0].contact, "sec@test.xyz");
    }

    function test_recoveryAddress() public view {
        assertEq(harness.exposedRecoveryAddress(), address(this));
    }

    function test_endToEnd_deployAndAgreement() public {
        address token = harness.deployToken();
        assertTrue(token != address(0));

        AgreementDetails memory details = harness.exposedDefaultAgreementDetails(
            harness.exposedProtocolName(),
            harness.exposedContacts(),
            harness.exposedGetDeployedContracts(),
            address(this)
        );

        address agreement = harness.exposedCreateAndAdoptAgreement(
            details, address(this), keccak256("v1")
        );
        assertTrue(agreement != address(0));

        MockAgreement mockAgreement = MockAgreement(agreement);
        assertEq(mockAgreement.cantChangeUntil(), block.timestamp + 14 days);
        assertEq(registry.agreements(address(harness)), agreement);

        harness.exposedRequestAttackMode(agreement);
        assertTrue(attackRegistry.attackRequested(agreement));
    }
}
