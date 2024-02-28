// Parameters

// All
param location string = resourceGroup().location

param tags object

// Subnet
param vnetName string

param addressPrefixes array

param ipSubnets array

//NSG
param nsgName string

// Run
module vnet './modules/vnet/vnet.bicep' = {
  name: 'vnetDeploy'
  params: {
    location: location
    tags: tags
    ipSubnets: ipSubnets
    vnetName: vnetName
    addressPrefixes: addressPrefixes
    nsgId: nsg.outputs.nsgId
  }
}

module nsg './modules/nsg/nsg.bicep' = {
  name: 'nsgDeploy'
  params: {
    location:location
    nsgName:nsgName
  }
}
