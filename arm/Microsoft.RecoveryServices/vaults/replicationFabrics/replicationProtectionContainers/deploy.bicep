@description('Required. Name of the Azure Recovery Service Vault')
param recoveryVaultName string

@description('Required. Name of the Replication Fabric')
param replicationFabricName string

@description('Required. The name of the replication container')
param name string

@description('Optional. Replication containers mappings to create.')
param replicationContainerMappings array = []

@description('Optional. Enable telemetry via the Customer Usage Attribution ID (GUID).')
param enableDefaultTelemetry bool = true

resource defaultTelemetry 'Microsoft.Resources/deployments@2021-04-01' = if (enableDefaultTelemetry) {
  name: 'pid-47ed15a6-730a-4827-bcb4-0fd963ffbd82-${uniqueString(deployment().name)}-rsvPolicy'
  properties: {
    mode: 'Incremental'
    template: {
      '$schema': 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
      contentVersion: '1.0.0.0'
      resources: []
    }
  }
}

resource replicationContainer 'Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers@2021-12-01' = {
  name: '${recoveryVaultName}/${replicationFabricName}/${name}'
  properties: {
    providerSpecificInput: [
      {
        instanceType: 'A2A'
      }
    ]
  }
}

module fabric_container_containerMappings 'replicationProtectionContainerMappings/deploy.bicep' = [for (mapping, index) in replicationContainerMappings: {
  name: '${deployment().name}-Map-${index}'
  params: {
    name: contains(mapping, 'name') ? mapping.name : ''
    policyId: contains(mapping, 'policyId') ? mapping.policyId : ''
    policyName: contains(mapping, 'policyName') ? mapping.policyName : ''
    recoveryVaultName: recoveryVaultName
    replicationFabricName: replicationFabricName
    sourceProtectionContainerName: name
    targetProtectionContainerId: contains(mapping, 'targetProtectionContainerId') ? mapping.targetProtectionContainerId : ''
    targetContainerFabricName: contains(mapping, 'targetContainerFabricName') ? mapping.targetContainerFabricName : replicationFabricName
    targetContainerName: contains(mapping, 'targetContainerName') ? mapping.targetContainerName : ''
    enableDefaultTelemetry: enableDefaultTelemetry
  }
  dependsOn: [
    replicationContainer
  ]
}]

@description('The name of the replication container.')
output name string = replicationContainer.name

@description('The resource ID of the replication container.')
output resourceId string = replicationContainer.id

@description('The name of the resource group the replication container was created in.')
output resourceGroupName string = resourceGroup().name
