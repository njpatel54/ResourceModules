# Operationalinsights Workspaces Linked Services `[Microsoft.OperationalInsights/workspaces/linkedServices]`

This template deploys a linked service for a Log Analytics workspace.

## Navigation

- [Resource Types](#Resource-Types)
- [Parameters](#Parameters)
- [Outputs](#Outputs)

## Resource Types

| Resource Type | API Version |
| :-- | :-- |
| `Microsoft.OperationalInsights/workspaces/linkedServices` | [2020-08-01](https://docs.microsoft.com/en-us/azure/templates/Microsoft.OperationalInsights/2020-08-01/workspaces/linkedServices) |

## Parameters

**Required parameters**
| Parameter Name | Type | Default Value | Description |
| :-- | :-- | :-- | :-- |
| `logAnalyticsWorkspaceName` | string |  | Name of the Log Analytics workspace |
| `name` | string |  | Name of the link |
| `resourceId` | string | `''` | The resource ID of the resource that will be linked to the workspace. This should be used for linking resources which require read access. |

**Optional parameters**
| Parameter Name | Type | Default Value | Description |
| :-- | :-- | :-- | :-- |
| `enableDefaultTelemetry` | bool | `True` | Enable telemetry via the Customer Usage Attribution ID (GUID). |
| `tags` | object | `{object}` | Tags to configure in the resource. |
| `writeAccessResourceId` | string | `''` | The resource ID of the resource that will be linked to the workspace. This should be used for linking resources which require write access.  |


### Parameter Usage: `tags`

Tag names and tag values can be provided as needed. A tag can be left without a value.

```json
"tags": {
    "value": {
        "Environment": "Non-Prod",
        "Contact": "test.user@testcompany.com",
        "PurchaseOrder": "1234",
        "CostCenter": "7890",
        "ServiceName": "DeploymentValidation",
        "Role": "DeploymentValidation"
    }
}
```

## Outputs

| Output Name | Type | Description |
| :-- | :-- | :-- |
| `name` | string | The name of the deployed linked service |
| `resourceGroupName` | string | The resource group where the linked service is deployed |
| `resourceId` | string | The resource ID of the deployed linked service |
