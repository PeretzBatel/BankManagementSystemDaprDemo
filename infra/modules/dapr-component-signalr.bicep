param environmentName string
param signalRConnectionStringSecretName string
param signalRName string
param appScope array
@secure()
param secretStoreName string

resource daprComponentSignalR 'Microsoft.App/managedEnvironments/daprComponents@2022-06-01-preview' = {
  name: '${environmentName}/${signalRName}'
  properties: {
    componentType: 'bindings.azure.signalr'
    version: 'v1'
    secrets: [
      {
        name: 'signalrkeyref'
        value:  signalRConnectionStringSecretName
      }
    ]
    metadata: [
      {
        name: 'connectionString'
        secretRef: 'signalrkeyref'
      }
      {
        name: 'hub'
        value: 'accountmanagercallback'
      }
    ]
    secretStoreComponent: secretStoreName
    // Application scopes
    scopes: appScope
  }
}

