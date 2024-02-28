// Creates a virtual network
@description('Azure region of the deployment')
param location string = resourceGroup().location

@description('Tags to add to the resources')
param tags object = {}

@description('Name of the virtual network resource')
param virtualNetworkName string

@description('Group ID of the network security group')
param networkSecurityGroupId string
param OthernetworkSecurityGroupId string

@description('Virtual network address prefix')
param vnetAddressPrefix string = '192.168.0.0/16'

@description('adbPrivate subnet address prefix')
param adbPrivateSubnetPrefix string = '192.168.0.0/24'

@description('adbPublic subnet address prefix')
param adbPublicSubnetPrefix string = '192.168.1.0/24'

@description('adbPublic subnet address prefix')
param adbPrivateLinkSubnetPrefix string = '192.168.2.0/24'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: virtualNetworkName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      { 
        name: 'snet-adb-private'
        properties: {
          addressPrefix: adbPrivateSubnetPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          networkSecurityGroup: {
            id: networkSecurityGroupId
          }
          delegations: [
            {
              name: 'databricks-del-private'
              properties:{
                serviceName: 'Microsoft.Databricks/workspaces'
              }
            }
          ]
        }
      }
      { 
        name: 'snet-adb-public'
        properties: {
          addressPrefix: adbPublicSubnetPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          /*serviceEndpoints: [
            {
              service: 'Microsoft.KeyVault'
            }
            {
              service: 'Microsoft.Storage'
            }
          ]*/
          networkSecurityGroup: {
            id: networkSecurityGroupId
          }
          delegations: [
            {
              name: 'databricks-del-public'
              properties:{
                serviceName: 'Microsoft.Databricks/workspaces'
              }
            }
          ]
        }
      }
      { 
        name: 'snet-adb-privatelink'
        properties: {
          addressPrefix: adbPrivateLinkSubnetPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          /*serviceEndpoints: [
            {
              service: 'Microsoft.KeyVault'
            }
            {
              service: 'Microsoft.Storage'
            }
          ]*/
          networkSecurityGroup: {
            id: OthernetworkSecurityGroupId
          }
        }
      }
    ]
  }
}

output id string = virtualNetwork.id
output name string = virtualNetwork.name







/*
param vNetSettings object = {
  name: 'bicep-adb-vnet'
  location: 'australiaeast'
  addressPrefixes: [
    {
      name: 'firstPrefix'
      addressPrefix: '10.0.0.0/22'
    }
  ]
  subnets: [
    {
      name: 'adb-private-subnet'
      addressPrefix: '10.0.0.0/24'
    }
    {
      name: 'adb-public-subnet'
      addressPrefix: '10.0.1.0/24'
    }
  ]
}

param nsgAdbSubnets string
//param nsgOtherSubnet string

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vNetSettings.name
  location: vNetSettings.location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vNetSettings.addressPrefixes[0].addressPrefix
      ]
    }
    subnets: [
      {
        name: vNetSettings.subnets[0].name
        properties: {
          addressPrefix: vNetSettings.subnets[0].addressPrefix
          networkSecurityGroup: {
            id:nsgAdbSubnets
          }
          delegations: [
            {
              name: 'databricks-del-private'
              properties:{
                serviceName: 'Microsoft.Databricks/workspaces'
              }
            }
          ]
          privateEndpointNetworkPolicies:'privateEndpointNetworkPolicies'
          privateLinkServiceNetworkPolicies:'privateLinkServiceNetworkPolicies'
        }
        
      }
      {
        name: vNetSettings.subnets[1].name
        properties: {
          addressPrefix: vNetSettings.subnets[1].addressPrefix
          networkSecurityGroup: {
            id:nsgAdbSubnets
          }
          delegations: [
            {
              name: 'databricks-del-public'
              properties:{
                serviceName: 'Microsoft.Databricks/workspaces'
              }
            }
          ]
          privateEndpointNetworkPolicies:'privateEndpointNetworkPolicies'
          privateLinkServiceNetworkPolicies:'privateLinkServiceNetworkPolicies'
        }
      }
    ]
  }
}




// File to create a virtual network 

param location string

param tags object

param vnetName string

param addressPrefixes array

param ipSubnets array

param nsgId string

param privateEndpointNetworkPolicies string = 'Enabled'

param privateLinkServiceNetworkPolicies string = 'Enabled'


resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
    subnets: [for ipSubnet in ipSubnets: {
      name: ipSubnet.name
      properties: {
        addressPrefix: ipSubnet.subnetPrefix
        networkSecurityGroup: {
          id: nsgId
        }
        delegations:[
          {
            name: ipSubnet.delegatoinName
            properties:{
              serviceName: ipSubnet.delServiceName
            }
          }
        ]
        privateEndpointNetworkPolicies:privateEndpointNetworkPolicies
        privateLinkServiceNetworkPolicies:privateLinkServiceNetworkPolicies
      }
    }
   ]
  }
}
output vnetId string = vnet.id

*/




/*
    subnets: [for ipSubnet in ipSubnets: {
      name: ipSubnet.name
      properties: {
        addressPrefix: ipSubnet.subnetPrefix
        networkSecurityGroup: {
          id: nsgId
        }
        delegations:[
          {
            name:'databricks-del-public'
            properties:{
              serviceName:'Microsoft.Databricks/workspaces'
            }
          }
        ]
      }
    }
   ]
*/
