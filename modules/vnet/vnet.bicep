// File to create a virtual network 

param location string

param tags object

param vnetName string

param addressPrefixes array

param ipSubnets array

param nsgId string


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
      }
    }
   ]
  }
}
output vnetId string = vnet.id






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
