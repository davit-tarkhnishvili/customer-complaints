namespace my.complaints;

using { managed, cuid } from '@sap/cds/common';

entity Customers : cuid, managed {
  name       : String(100);
  email      : String(100);
  phone      : String(20);
  // A customer can have multiple complaints
  complaints : Association to many Complaints on complaints.customer = $self;
}

entity Products : cuid, managed {
  name        : String(100);
  description : String(255);
  sku         : String(50);
}

entity Complaints : cuid, managed {
  title       : String(100) @mandatory;
  description : String;
  
  status      : String(20) enum {
                  New = 'New';
                  InProgress = 'In Progress';
                  Resolved = 'Resolved';
                  Closed = 'Closed';
                } default 'New';
                
  priority    : String(20) enum {
                  High = 'High';
                  Medium = 'Medium';
                  Low = 'Low';
                } default 'Medium';

  // Foreign keys linking to the related entities
  customer    : Association to Customers;
  product     : Association to Products @mandatory;

  // Transient input used to create a new customer on save; cleared afterwards
  newCustomerName  : String(100);
  newCustomerEmail : String(100);
  newCustomerPhone : String(20);

  // A single complaint owns its resolution steps/logs
  resolutions : Composition of many Resolutions on resolutions.complaint = $self;
}

entity Resolutions : cuid, managed {
  complaint   : Association to Complaints;
  description : String;
  actionTaken : String(255);
  agentName   : String(100); // Tracks who resolved it
}