import cds from '@sap/cds';

export default class ComplaintService extends cds.ApplicationService {
  init() {
    const { Complaints } = this.entities;

    // SAVE runs on draft activation, before CREATE/UPDATE of the active entity
    this.before('SAVE', Complaints, async (req) => {
      const d = req.data;
      const name = d.newCustomerName?.trim();

      if (name && d.customer_ID) {
        return req.error(400, 'Select an existing customer or enter a new one, not both', 'in/newCustomerName');
      }

      if (name) {
        const { Customers } = cds.entities('my.complaints');
        const ID = cds.utils.uuid();
        await INSERT.into(Customers).entries({
          ID, name, email: d.newCustomerEmail, phone: d.newCustomerPhone
        });
        d.customer_ID = ID;
      }

      d.newCustomerName = d.newCustomerEmail = d.newCustomerPhone = null;
    });

    this.before('SAVE', Complaints, (req) => {
      const d = req.data;
      if (!d.customer_ID && !d.newCustomerName?.trim()) {
        req.error(400, 'Select an existing customer or enter a new one', 'in/customer_ID');
      }
    });

    return super.init();
  }
}
