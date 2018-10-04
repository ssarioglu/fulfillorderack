# FulfillOrder - TACK

A containerised Go swagger API to fulfill orders and commit them to MongoDB

## Environment Variables

The following environment variables need to be passed to the container:

### ACK Logging
```
ENV TEAMNAME=[YourTeamName]
ENV APPINSIGHTS_KEY=[YourCustomApplicationInsightsKey] # Optional, create your own App Insights resource
ENV CHALLENGEAPPINSIGHTS_KEY=[Challenge Application Insights Key] # Given by the proctors
```

### For Mongo
```
ENV MONGOURL="mongodb://[mongoinstance].[namespace]"
```

### File mount
```
/orders
```