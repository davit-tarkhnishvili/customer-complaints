sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/customercomplaints/customercomplaints/test/integration/pages/ComplaintsList.gen",
	"com/customercomplaints/customercomplaints/test/integration/pages/ComplaintsObjectPage.gen"
], function (JourneyRunner, ComplaintsListGenerated, ComplaintsObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/customercomplaints/customercomplaints') + '/test/flpSandbox.html#comcustomercomplaintscustomerc-tile',
        pages: {
			onTheComplaintsListGenerated: ComplaintsListGenerated,
			onTheComplaintsObjectPageGenerated: ComplaintsObjectPageGenerated
        },
        async: true
    });

    return runner;
});

