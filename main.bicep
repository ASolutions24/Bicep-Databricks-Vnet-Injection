// Vnet Parameters

@description('Azure region of the deployment')
param location string = resourceGroup().location

@description('Tags to add to the resources')
param tags object = {}

@description('Name of the virtual network resource')
param virtualNetworkName string = 'bicep-adb-vnet'

@description('Virtual network address prefix')
param vnetAddressPrefix string = '192.168.0.0/16'

@description('adbPrivate subnet address prefix')
param adbPrivateSubnetPrefix string = '192.168.0.0/24'

@description('adbPublic subnet address prefix')
param adbPublicSubnetPrefix string = '192.168.1.0/24'

//NSG
param nsgName string
param nsgNameOther string


// Run
module vnet './modules/vnet/vnet.bicep' = {
  name: 'vnetDeploy'
  params:{
    networkSecurityGroupId:nsg.outputs.nsgId
    OthernetworkSecurityGroupId:nsg.outputs.nsgOtherId
    virtualNetworkName:virtualNetworkName
    adbPrivateSubnetPrefix:adbPrivateSubnetPrefix
    adbPublicSubnetPrefix:adbPublicSubnetPrefix
    location:location
    tags:tags
    vnetAddressPrefix:vnetAddressPrefix
  }
}

module nsg './modules/nsg/nsg.bicep' = {
  name: 'nsgDeploy'
  params: {
    location:location
    nsgName:nsgName
    nsgNameOther:nsgNameOther
  }
}
