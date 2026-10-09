using my.complaints from '../db/schema';

service ComplaintService @(requires: 'authenticated-user') {

    @restrict: [
        { grant: 'READ', to: 'viewer' },
        { grant: '*',    to: 'admin'  }
    ]
    entity Customers as projection on complaints.Customers;

    @restrict: [
        { grant: 'READ', to: 'viewer' },
        { grant: '*',    to: 'admin'  }
    ]
    entity Products as projection on complaints.Products;

    @odata.draft.enabled
    @restrict: [
        { grant: 'READ', to: 'viewer' },
        { grant: '*',    to: 'admin'  }
    ]
    entity Complaints as projection on complaints.Complaints;

    @restrict: [
        { grant: 'READ', to: 'viewer' },
        { grant: '*',    to: 'admin'  }
    ]
    entity Resolutions as projection on complaints.Resolutions;

}