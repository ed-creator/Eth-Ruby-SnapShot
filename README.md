# Eth-Ruby-SnapShot

A simple Roda App that allows the user to take a snapshot of an Ethereum address and stores it in a Sqlite Database. 

## Add an Eth address snapshot

```
curl  http://localhost:9292//addresses/print
```


## Get a Json of all listed accounts

```
curl -d "address=0x8eeec35015baba2890e714e052dfbe73f4b752f9" http://localhost:9292//addresses/submit
```
