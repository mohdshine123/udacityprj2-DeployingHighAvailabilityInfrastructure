# Infrastructure

## AWS Zones
Zone 1-
us-east-2


Zone 2-
us-west-1

## Servers and Clusters

### Table 1.1 Summary

| Asset name | Brief description | AWS size eg. t3.micro (if applicable, not all assets will have a size) | Number of nodes/replicas or just how many of a particular asset | Identify if this asset
| Asset      | Purpose           | Size                                                                   | Qty                                                             | DR                                                                                                           |
|---

appserver-instance-awdbmbWebserver1  t3.micro  1 replica is in us-west1---------|------ -------------|-----t3.micro------------------------------------------------------1-------------|------1 replica is in us-west1-----------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|
 is deployed to DR, replicated, created in multiple locations or just stored elsewhere |


### Descriptions

appserver-instance-aw5y9t  -webserver on zone us-east-2


Api  appserver-instance-awdbmb- Api server on zone us-east2  (both are attached to alb which have target groups on multiple availablity zones)

**Cluster -P  udacity-db-cluster** with reader and writer instance on us-east-2 region with 2 azs
           2 db instances (reader and writer on different azs)

 ****Replica cluster udacity-db-cluster-s** **with reader and writer instance on us-west-1 region with 2 azs
 2 db instances (reader and writer on different azs)

More detailed descriptions of each asset identified above.

## DR Plan
### Pre-Steps:
List steps you would perform to setup the infrastructure in the other region. It doesn't have to be super detailed, but high-level should suffice.

1.Make sure specify two subnets from atleast two Availability Zones to increase avalibility of ALB.

2. Do initial checks on EC2 machine ,database and check components are online

   
4. Check server and application staus, check for https status code like 500 from web application

**DR Plan -> Steps**
1. Initiate terraform code from Zone2(us-west-1) which will create excat replicas of all infra compoonents
   
2.Make sure all components are deployed properly via terraform frrom zone2

3. test application /servers from Zone2 Availbality region
4. Complete sanity checks on app/DB servers

## Steps:
The DR process can be initiated manually or automatically based on certain metrics like status checks, error rates, etc. If the established thresholds are reached for these metrics, it signifies the workloads in the primary Region are failing. for example using  Route 53 health checks 
