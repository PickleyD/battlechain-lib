// SPDX-License-Identifier: MIT
// aderyn-ignore-next-line(push-zero-opcode,unspecific-solidity-pragma)
pragma solidity ^0.8.24;

/// @notice Address registry for BattleChain contracts, resolved by chain ID.
/// All functions are internal view — inlined at compile time when chain ID is
/// known, or resolved at runtime on forks.
library BCConfig {
    // -------------------------------------------------------------------------
    // Chain IDs
    // -------------------------------------------------------------------------

    uint256 internal constant MAINNET_CHAIN_ID = 626;
    uint256 internal constant TESTNET_CHAIN_ID = 627;
    uint256 internal constant DEVNET_CHAIN_ID = 624;

    // -------------------------------------------------------------------------
    // CAIP-2 chain ID strings
    // -------------------------------------------------------------------------

    string internal constant MAINNET_CAIP2 = "eip155:626";
    string internal constant TESTNET_CAIP2 = "eip155:627";
    string internal constant DEVNET_CAIP2 = "eip155:624";

    // -------------------------------------------------------------------------
    // URIs
    // -------------------------------------------------------------------------

    string internal constant SAFE_HARBOR_V3_URI =
        "https://bafkreiernns2f4nv2uzvwtzjc2jboyivsu2mixz33y3xo7cvtllsuao6jy.ipfs.w3s.link/";
    string internal constant BATTLECHAIN_SAFE_HARBOR_URI =
        "ipfs://bafkreifgln3ir67woluatpwn3b65gjkrbmoq6jgzzotm3anas3vvq4yp4m";

    // -------------------------------------------------------------------------
    // Testnet addresses
    // -------------------------------------------------------------------------

    address internal constant TESTNET_REGISTRY = 0xCb2A561395118895e2572A04C2D8AB8eCA8d7E5D;
    address internal constant TESTNET_AGREEMENT_FACTORY = 0x0EbBEeB3aBeF51801a53Fdd1fb263Ac0f2E3Ed36;
    address internal constant TESTNET_ATTACK_REGISTRY = 0x9E62988ccA776ff6613Fa68D34c9AB5431Ce57e1;
    address internal constant TESTNET_DEPLOYER = 0x8f57054CBa2021bEE15631067dd7B7E0B43F17Dc;
    address internal constant TESTNET_CREATEX = 0xf1Ebfaa992854ECcB01Ac1F60e5b5279095cca7F;
    address internal constant TESTNET_REGISTRY_IMPL = 0xD9B325CA3f43aC153104C0875587Ffc1601076f2;
    address internal constant TESTNET_AGREEMENT_FACTORY_IMPL = 0x45B36746e35bD691d981CeE11bdddFa4fE14D43e;
    address internal constant TESTNET_ATTACK_REGISTRY_IMPL = 0x02f2d446fc20F71FD1414F5c4E99679595e17e50;
    address internal constant TESTNET_MOCK_REGISTRY_MODERATOR = 0x6C2DFbdF0714FC8CE065039911758b2821818745;

    // -------------------------------------------------------------------------
    // Errors
    // -------------------------------------------------------------------------

    error BCConfig__UnsupportedChainId(uint256 chainId);

    // -------------------------------------------------------------------------
    // Getters
    // -------------------------------------------------------------------------

    function registry() internal view returns (address) {
        if (block.chainid == TESTNET_CHAIN_ID) return TESTNET_REGISTRY;
        revert BCConfig__UnsupportedChainId(block.chainid);
    }

    function agreementFactory() internal view returns (address) {
        if (block.chainid == TESTNET_CHAIN_ID) return TESTNET_AGREEMENT_FACTORY;
        revert BCConfig__UnsupportedChainId(block.chainid);
    }

    function attackRegistry() internal view returns (address) {
        if (block.chainid == TESTNET_CHAIN_ID) return TESTNET_ATTACK_REGISTRY;
        revert BCConfig__UnsupportedChainId(block.chainid);
    }

    function deployer() internal view returns (address) {
        if (block.chainid == TESTNET_CHAIN_ID) return TESTNET_DEPLOYER;
        revert BCConfig__UnsupportedChainId(block.chainid);
    }

    function caip2ChainId() internal view returns (string memory) {
        if (block.chainid == MAINNET_CHAIN_ID) return MAINNET_CAIP2;
        if (block.chainid == TESTNET_CHAIN_ID) return TESTNET_CAIP2;
        if (block.chainid == DEVNET_CHAIN_ID) return DEVNET_CAIP2;
        revert BCConfig__UnsupportedChainId(block.chainid);
    }

    function isBattleChain() internal view returns (bool) {
        return block.chainid == MAINNET_CHAIN_ID
            || block.chainid == TESTNET_CHAIN_ID
            || block.chainid == DEVNET_CHAIN_ID;
    }

    function createX() internal view returns (address) {
        if (block.chainid == TESTNET_CHAIN_ID) return TESTNET_CREATEX;
        revert BCConfig__UnsupportedChainId(block.chainid);
    }
}
