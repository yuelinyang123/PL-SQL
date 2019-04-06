# PL-SQL
This is a project for basic retail business. 
Dark springs summary


We build this database system for Dark Springs, a company specializes in delivering bottled water, to increase their operation efficiency and implement required application to satisfy business need. There are several components of great importance.


Sales and Contracts
  

When customer sign new contract, they can choose multiple locations and buy some items before the regular deliver service. Therefore, we may have initial charge on the contract. Also, if the customer is referred by another customer, we will give discount to the that customer. When we calculate the bill for our customer, we need to search whether the customer refers a new customer in the month of that bill.  Employees with position of sales person will take charge of signing contract with customer. Deliver person will deliver items to the customer and record basis information about the service such as delivery service route and date. Furthermore, in each service, they can deliver multiple items and pick up multiple items. Deliver person have the right to give discount for the customer and have the responsibility to encourage the customer to refer new customers or buy more items. Deliver person and customer can both write some comments for this service in order to improve service in the future. 


 Bill


Employees with the position of accountants will calculate the bill for customer each month. The bill includes two parts. One is monthly fee, which is determined by the location and size of standard delivery. It is fixed for each location no matter how many additional items the customer has bought.  Another is the items bought by the customer. Accountants will need to refer the delivery service reports wrote by the delivery man to figure out how many items the customer bought for a specific location. In addition to these two parts, the accountant will have to check the number of referrals and past due. The customer has a current balance record, which stores the balance that customer have to pay currently. When they pay the balance, we will update the current balance value to zero. We will calculate the monthly bill for a customer at the first day of next month and the due date is set to be the last day of that month. In this case, the accountant just needs to check the current balance value of the customer to figure out past due.


Evaluation

Delivery managers will evaluate the delivery man every month based on the sales, deliveries as well as number of leads. This evaluation is also important to check the discrimination status of the company. We will summarize the evaluation for employees with different race, age, gender 
