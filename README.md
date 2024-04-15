# Nix tree of nodes

Repository aggregating other repositories, using nix.

```
┌───────────────────────────────────────────┐
│Root Repository (treeverse-nix-demo-devoxx)│
└────┬────────────┬───────────────┬─────────┘
     │            │               │
     │            │               │
     │            │               │
┌────┴────┐     ┌─┴──┐      ┌─────┴──────┐
│variables│     │pkgs│      │repositories│
└────┬────┘     └────┘      ├────────────┤
     │                      │            │
     │                      │            │
   ┌─┴─┐                  ┌─┴───┐      ┌─┴───┐
   │env│                  │repoA│      │repoB│
   └───┘                  └┬───┬┘      └──┬──┘
                           │   │          │
                           │   │          │
               ┌───────────┴┐ ┌┴───┐    ┌─┴─┐
               │nixosModuleA│ │appA│    │vmB│
               └────────────┘ └────┘    └───┘
```

## Sub-repositories

- [repoA](https://github.com/abryko/treeverse-repoA)

- [repoB](https://github.com/abryko/treeverse-repoB)

## Artifacts

- *appA*: simple go web server serving «Hello Devoxx!»
- *nixosModuleA*: Nixos module declaring a systemd service for *appA*
- *vmB*: Nixos VM consuming nixosModuleA
- *testB*: testing vmB is working as expected

## Let's build a VM!

```sh
$> nom-build -A treeverse.repositories.repoB.vmB
/nix/store/0rvv98ff9q7ysr5sbbjqszblwa5ygp5s-nixos-vm
```
