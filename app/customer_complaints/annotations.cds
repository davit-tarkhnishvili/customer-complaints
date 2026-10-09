using ComplaintService as service from '../../srv/services';

annotate service.Complaints with @(
    UI.HeaderInfo : {
        $Type          : 'UI.HeaderInfoType',
        TypeName       : 'Complaint',
        TypeNamePlural : 'Complaints',
        TypeImageUrl   : 'sap-icon://complaint',
        Title          : { $Type : 'UI.DataField', Value : title },
        Description    : { $Type : 'UI.DataField', Value : customer.name },
    },
    UI.SelectionFields : [
        status,
        priority,
        customer_ID,
        product_ID,
    ],
    UI.LineItem : [
        { $Type : 'UI.DataField', Value : title,       Label : 'Title' },
        { $Type : 'UI.DataField', Value : customer_ID, Label : 'Customer' },
        { $Type : 'UI.DataField', Value : product_ID,  Label : 'Product' },
        { $Type : 'UI.DataField', Value : status,      Label : 'Status' },
        { $Type : 'UI.DataField', Value : priority,    Label : 'Priority' },
        { $Type : 'UI.DataField', Value : createdAt,   Label : 'Created On' },
    ],

    // Key facts shown in the object page header
    UI.HeaderFacets : [
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'HeaderStatus',
            Label  : 'Status',
            Target : '@UI.DataPoint#Status',
        },
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'HeaderPriority',
            Label  : 'Priority',
            Target : '@UI.DataPoint#Priority',
        },
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'HeaderProduct',
            Label  : 'Product',
            Target : '@UI.FieldGroup#HeaderProduct',
        },
    ],
    UI.DataPoint #Status : {
        $Type : 'UI.DataPointType',
        Title : 'Status',
        Value : status,
    },
    UI.DataPoint #Priority : {
        $Type : 'UI.DataPointType',
        Title : 'Priority',
        Value : priority,
    },
    UI.FieldGroup #HeaderProduct : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            { $Type : 'UI.DataField', Value : product_ID, Label : 'Product' },
        ],
    },

    UI.FieldGroup #General : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            { $Type : 'UI.DataField', Value : title,       Label : 'Title' },
            { $Type : 'UI.DataField', Value : status,      Label : 'Status' },
            { $Type : 'UI.DataField', Value : priority,    Label : 'Priority' },
            { $Type : 'UI.DataField', Value : product_ID,  Label : 'Product' },
        ],
    },
    UI.FieldGroup #Description : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            { $Type : 'UI.DataField', Value : description, Label : 'Description' },
        ],
    },
    UI.FieldGroup #Customer : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            { $Type : 'UI.DataField', Value : customer_ID,          Label : 'Existing Customer' },
            { $Type : 'UI.DataField', Value : customer.email,       Label : 'Email' },
            { $Type : 'UI.DataField', Value : customer.phone,       Label : 'Phone' },
        ],
    },
    UI.FieldGroup #NewCustomer : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            { $Type : 'UI.DataField', Value : newCustomerName,  Label : 'Name' },
            { $Type : 'UI.DataField', Value : newCustomerEmail, Label : 'Email' },
            { $Type : 'UI.DataField', Value : newCustomerPhone, Label : 'Phone' },
        ],
    },
    UI.FieldGroup #Admin : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            { $Type : 'UI.DataField', Value : createdAt,  Label : 'Created On' },
            { $Type : 'UI.DataField', Value : createdBy,  Label : 'Created By' },
            { $Type : 'UI.DataField', Value : modifiedAt, Label : 'Changed On' },
            { $Type : 'UI.DataField', Value : modifiedBy, Label : 'Changed By' },
        ],
    },

    UI.Facets : [
        {
            $Type  : 'UI.CollectionFacet',
            ID     : 'ComplaintDetails',
            Label  : 'Complaint Details',
            Facets : [
                {
                    $Type  : 'UI.ReferenceFacet',
                    ID     : 'GeneralFacet',
                    Label  : 'General',
                    Target : '@UI.FieldGroup#General',
                },
                {
                    $Type  : 'UI.ReferenceFacet',
                    ID     : 'DescriptionFacet',
                    Label  : 'Description',
                    Target : '@UI.FieldGroup#Description',
                },
            ],
        },
        {
            $Type  : 'UI.CollectionFacet',
            ID     : 'CustomerSection',
            Label  : 'Customer',
            Facets : [
                {
                    $Type  : 'UI.ReferenceFacet',
                    ID     : 'CustomerFacet',
                    Label  : 'Existing Customer',
                    Target : '@UI.FieldGroup#Customer',
                },
                {
                    $Type  : 'UI.ReferenceFacet',
                    ID     : 'NewCustomerFacet',
                    Label  : 'New Customer',
                    Target : '@UI.FieldGroup#NewCustomer',
                },
            ],
        },
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'ResolutionsFacet',
            Label  : 'Resolutions',
            Target : 'resolutions/@UI.LineItem',
        },
        {
            $Type               : 'UI.ReferenceFacet',
            ID                  : 'AdminFacet',
            Label               : 'Administrative Data',
            Target              : '@UI.FieldGroup#Admin',
            ![@UI.PartOfPreview] : false,
        },
    ],
);

annotate service.Complaints with {
    title            @Common.Label : 'Title';
    description      @Common.Label : 'Description'  @UI.MultiLineText;
    status           @Common.Label : 'Status';
    priority         @Common.Label : 'Priority';
    customer         @Common.Label : 'Customer'
                     @Common.Text : customer.name
                     @Common.TextArrangement : #TextOnly;
    product          @Common.Label : 'Product'
                     @Common.Text : product.name
                     @Common.TextArrangement : #TextOnly;
    newCustomerName  @Common.Label : 'Name';
    newCustomerEmail @Common.Label : 'Email';
    newCustomerPhone @Common.Label : 'Phone';
};

annotate service.Complaints with {
    customer @Common.ValueList : {
        $Type          : 'Common.ValueListType',
        CollectionPath : 'Customers',
        Parameters     : [
            { $Type : 'Common.ValueListParameterInOut',       LocalDataProperty : customer_ID, ValueListProperty : 'ID' },
            { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'name' },
            { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'email' },
            { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'phone' },
        ],
    }
};

annotate service.Complaints with {
    product @Common.ValueList : {
        $Type          : 'Common.ValueListType',
        CollectionPath : 'Products',
        Parameters     : [
            { $Type : 'Common.ValueListParameterInOut',       LocalDataProperty : product_ID, ValueListProperty : 'ID' },
            { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'name' },
            { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'description' },
            { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'sku' },
        ],
    }
};

annotate service.Resolutions with @(
    UI.HeaderInfo : {
        $Type          : 'UI.HeaderInfoType',
        TypeName       : 'Resolution',
        TypeNamePlural : 'Resolutions',
        Title          : { $Type : 'UI.DataField', Value : actionTaken },
        Description    : { $Type : 'UI.DataField', Value : agentName },
    },
    UI.LineItem : [
        { $Type : 'UI.DataField', Value : actionTaken, Label : 'Action Taken' },
        { $Type : 'UI.DataField', Value : description, Label : 'Description' },
        { $Type : 'UI.DataField', Value : agentName,   Label : 'Agent' },
        { $Type : 'UI.DataField', Value : createdAt,   Label : 'Created On' },
    ],
    UI.FieldGroup #General : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            { $Type : 'UI.DataField', Value : actionTaken, Label : 'Action Taken' },
            { $Type : 'UI.DataField', Value : agentName,   Label : 'Agent' },
            { $Type : 'UI.DataField', Value : description, Label : 'Description' },
        ],
    },
    UI.Facets : [
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'ResolutionGeneral',
            Label  : 'General Information',
            Target : '@UI.FieldGroup#General',
        },
    ],
);

annotate service.Resolutions with {
    actionTaken @Common.Label : 'Action Taken';
    agentName   @Common.Label : 'Agent';
    description @Common.Label : 'Description' @UI.MultiLineText;
};

annotate service.Customers with {
    ID    @Common.Text : name @Common.TextArrangement : #TextOnly;
    name  @Common.Label : 'Name';
    email @Common.Label : 'Email';
    phone @Common.Label : 'Phone';
};

annotate service.Products with {
    ID          @Common.Text : name @Common.TextArrangement : #TextOnly;
    name        @Common.Label : 'Name';
    description @Common.Label : 'Description';
    sku         @Common.Label : 'SKU';
};
