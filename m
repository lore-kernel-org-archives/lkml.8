Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7A3C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 03:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CB3206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 03:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d3HmNF+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgAKDoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 22:44:25 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:35189 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728195AbgAKDoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 22:44:25 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 4E2E9482;
        Fri, 10 Jan 2020 22:44:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 10 Jan 2020 22:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=6uIvn1
        HcLzYl+j8NNQCQcaaAEZy0NhPLBJ6H1hgc4oQ=; b=d3HmNF+tZAqXdGHgMoOsm5
        csPReTqgFRcVG5qAUr2JErqog6Bluu9GNaLurCXNzOAOOobmtz/Ye7x6tVJzhQSK
        1HzSx21JZXyRvlipN32KTvcDqLiMP/hpK2wUqaFte27uXTpChagdIrG/ABQsjnxS
        eQuGJpNu1tf0ShIdg/tDreTORuBPEhDE96+xL4ujM7a+i/CzavZlXG5W06owGo4C
        hv5RDbLUKd1O2fZsMIL3a7GMt9Y0hQmFTl/Oy+He2pKfLrN8w638npJOHjWhsnSc
        pbTEMK6rYr4pOQ9kjQ41i0iSHd007j2eGYtLIeYfr0ZAel2yhNyB2UQ2RbIST/TA
        ==
X-ME-Sender: <xms:lUQZXvIjP21HtfIE0xdBMdbNu8AhS1qzLDsWqK-eAvpu7INnbRgj0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdeigedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffogggtohfgsehtkeertdertdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucffohhmrghinhepmhgrrhhkmhgr
    ihhlrdhorhhgpdhinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomhenucfkpheple
    durdeihedrfeegrdeffeenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghk
    sehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomhenucevlhhushhtvghrufhiii
    gvpedt
X-ME-Proxy: <xmx:lkQZXrFwPEFNOPwEbEyhLZy0OJCxAX7AoD07QVw834Dq4lYfvfi4xA>
    <xmx:lkQZXu4KzYrEzlGxBLDwd1wW16ujFfQY0O4pg6t8JkSwSwVMpUPeUA>
    <xmx:lkQZXu3Yat10gqbPktCwZ5hC9rCLcbKiniC7Sst8y6wua7wpli9oPQ>
    <xmx:lkQZXhZpCpIW93IC-blgymPVf-0rRxQezxyDHR-nPAIdrZVPYjnfqA>
Received: from localhost.localdomain (ip5b412221.dynamic.kabel-deutschland.de [91.65.34.33])
        by mail.messagingengine.com (Postfix) with ESMTPA id AB58580063;
        Fri, 10 Jan 2020 22:44:20 -0500 (EST)
From:   =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     xen-devel@lists.xenproject.org
Cc:     =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, Jan Beulich <jbeulich@suse.com>,
        Simon Gaiser <simon@invisiblethingslab.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] xen-pciback: optionally allow interrupt enable flag writes
Date:   Sat, 11 Jan 2020 04:43:31 +0100
Message-Id: <20200111034347.5270-1-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Invisible Things Lab
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QEMU running in a stubdom needs to be able to set INTX_DISABLE, and the
MSI(-X) enable flags in the PCI config space. This adds an attribute
'allow_interrupt_control' which when set for a PCI device allows writes
to this flag(s). The toolstack will need to set this for stubdoms.
When enabled, guest (stubdomain) will be allowed to set relevant enable
flags, but only one at a time - i.e. it refuses to enable more than one
of INTx, MSI, MSI-X at a time.

This functionality is needed only for config space access done by device
model (stubdomain) serving a HVM with the actual PCI device. It is not
necessary and unsafe to enable direct access to those bits for PV domain
with the device attached. For PV domains, there are separate protocol
messages (XEN_PCI_OP_{enable,disable}_{msi,msix}) for this purpose.
Those ops in addition to setting enable bits, also configure MSI(-X) in
dom0 kernel - which is undesirable for PCI passthrough to HVM guests.

This should not introduce any new security issues since a malicious
guest (or stubdom) can already generate MSIs through other ways, see
[1] page 8. Additionally, when qemu runs in dom0, it already have direct
access to those bits.

This is the second iteration of this feature. First was proposed as a
direct Xen interface through a new hypercall, but ultimately it was
rejected by the maintainer, because of mixing pciback and hypercalls for
PCI config space access isn't a good design. Full discussion at [2].

[1]: https://invisiblethingslab.com/resources/2011/Software%20Attacks%20on%20Intel%20VT-d.pdf
[2]: https://xen.markmail.org/thread/smpgpws4umdzizze

[part of the commit message and sysfs handling]
Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
[the rest]
Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
Changes in v3:
 - return bitmap (or negative error) from
   xen_pcibk_get_interrupt_type(), to implicitly handle cases when
   multiple interrupt types are already enabled - disallow enabling in
   that case
 - add documentation
Changes in v2:
 - introduce xen_pcibk_get_interrupt_type() to deduplicate current
   INTx/MSI/MSI-X state check
 - fix checking MSI/MSI-X state on devices not supporting it

---
 .../ABI/testing/sysfs-driver-pciback          | 13 +++
 drivers/xen/xen-pciback/conf_space.c          | 36 ++++++++
 drivers/xen/xen-pciback/conf_space.h          |  7 ++
 .../xen/xen-pciback/conf_space_capability.c   | 88 +++++++++++++++++++
 drivers/xen/xen-pciback/conf_space_header.c   | 18 ++++
 drivers/xen/xen-pciback/pci_stub.c            | 66 ++++++++++++++
 drivers/xen/xen-pciback/pciback.h             |  1 +
 7 files changed, 229 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-pciback b/Documentation/ABI/testing/sysfs-driver-pciback
index 6a733bfa37e6..566a11f2c12f 100644
--- a/Documentation/ABI/testing/sysfs-driver-pciback
+++ b/Documentation/ABI/testing/sysfs-driver-pciback
@@ -11,3 +11,16 @@ Description:
                 #echo 00:19.0-E0:2:FF > /sys/bus/pci/drivers/pciback/quirks
                 will allow the guest to read and write to the configuration
                 register 0x0E.
+
+What:           /sys/bus/pci/drivers/pciback/allow_interrupt_control
+Date:           Jan 2020
+KernelVersion:  5.5
+Contact:        xen-devel@lists.xenproject.org
+Description:
+                List of devices which can have interrupt control flag (INTx,
+                MSI, MSI-X) set by a connected guest. It is meant to be set
+                only when the guest is a stubdomain hosting device model (qemu)
+                and the actual device is assigned to a HVM. It is not safe
+                (similar to permissive attribute) to set for a devices assigned
+                to a PV guest. The device is automatically removed from this
+                list when the connected pcifront terminates.
diff --git a/drivers/xen/xen-pciback/conf_space.c b/drivers/xen/xen-pciback/conf_space.c
index 60111719b01f..7697001e8ffc 100644
--- a/drivers/xen/xen-pciback/conf_space.c
+++ b/drivers/xen/xen-pciback/conf_space.c
@@ -286,6 +286,42 @@ int xen_pcibk_config_write(struct pci_dev *dev, int offset, int size, u32 value)
 	return xen_pcibios_err_to_errno(err);
 }
 
+int xen_pcibk_get_interrupt_type(struct pci_dev *dev)
+{
+	int err;
+	u16 val;
+	int ret = 0;
+
+	err = pci_read_config_word(dev, PCI_COMMAND, &val);
+	if (err)
+		return err;
+	if (!(val & PCI_COMMAND_INTX_DISABLE))
+		ret |= INTERRUPT_TYPE_INTX;
+
+	/* Do not trust dev->msi(x)_enabled here, as enabling could be done
+	 * bypassing the pci_*msi* functions, by the qemu.
+	 */
+	if (dev->msi_cap) {
+		err = pci_read_config_word(dev,
+				dev->msi_cap + PCI_MSI_FLAGS,
+				&val);
+		if (err)
+			return err;
+		if (val & PCI_MSI_FLAGS_ENABLE)
+			ret |= INTERRUPT_TYPE_MSI;
+	}
+	if (dev->msix_cap) {
+		err = pci_read_config_word(dev,
+				dev->msix_cap + PCI_MSIX_FLAGS,
+				&val);
+		if (err)
+			return err;
+		if (val & PCI_MSIX_FLAGS_ENABLE)
+			ret |= INTERRUPT_TYPE_MSIX;
+	}
+	return ret;
+}
+
 void xen_pcibk_config_free_dyn_fields(struct pci_dev *dev)
 {
 	struct xen_pcibk_dev_data *dev_data = pci_get_drvdata(dev);
diff --git a/drivers/xen/xen-pciback/conf_space.h b/drivers/xen/xen-pciback/conf_space.h
index 22db630717ea..6ba6aa26dcee 100644
--- a/drivers/xen/xen-pciback/conf_space.h
+++ b/drivers/xen/xen-pciback/conf_space.h
@@ -65,6 +65,11 @@ struct config_field_entry {
 	void *data;
 };
 
+#define INTERRUPT_TYPE_NONE 0
+#define INTERRUPT_TYPE_INTX 1
+#define INTERRUPT_TYPE_MSI  2
+#define INTERRUPT_TYPE_MSIX 4
+
 extern bool xen_pcibk_permissive;
 
 #define OFFSET(cfg_entry) ((cfg_entry)->base_offset+(cfg_entry)->field->offset)
@@ -126,4 +131,6 @@ int xen_pcibk_config_capability_init(void);
 int xen_pcibk_config_header_add_fields(struct pci_dev *dev);
 int xen_pcibk_config_capability_add_fields(struct pci_dev *dev);
 
+int xen_pcibk_get_interrupt_type(struct pci_dev *dev);
+
 #endif				/* __XEN_PCIBACK_CONF_SPACE_H__ */
diff --git a/drivers/xen/xen-pciback/conf_space_capability.c b/drivers/xen/xen-pciback/conf_space_capability.c
index e5694133ebe5..d3a846119974 100644
--- a/drivers/xen/xen-pciback/conf_space_capability.c
+++ b/drivers/xen/xen-pciback/conf_space_capability.c
@@ -189,6 +189,84 @@ static const struct config_field caplist_pm[] = {
 	{}
 };
 
+static struct msi_msix_field_config {
+	u16 enable_bit; /* bit for enabling MSI/MSI-X */
+	int int_type; /* interrupt type for exclusiveness check */
+} msi_field_config = {
+	.enable_bit = PCI_MSI_FLAGS_ENABLE,
+	.int_type = INTERRUPT_TYPE_MSI,
+}, msix_field_config = {
+	.enable_bit = PCI_MSIX_FLAGS_ENABLE,
+	.int_type = INTERRUPT_TYPE_MSIX,
+};
+
+static void *msi_field_init(struct pci_dev *dev, int offset)
+{
+	return &msi_field_config;
+}
+
+static void *msix_field_init(struct pci_dev *dev, int offset)
+{
+	return &msix_field_config;
+}
+
+static int msi_msix_flags_write(struct pci_dev *dev, int offset, u16 new_value,
+				void *data)
+{
+	int err;
+	u16 old_value;
+	const struct msi_msix_field_config *field_config = data;
+	const struct xen_pcibk_dev_data *dev_data = pci_get_drvdata(dev);
+
+	if (xen_pcibk_permissive || dev_data->permissive)
+		goto write;
+
+	err = pci_read_config_word(dev, offset, &old_value);
+	if (err)
+		return err;
+
+	if (new_value == old_value)
+		return 0;
+
+	if (!dev_data->allow_interrupt_control ||
+	    (new_value ^ old_value) & ~field_config->enable_bit)
+		return PCIBIOS_SET_FAILED;
+
+	if (new_value & field_config->enable_bit) {
+		/* don't allow enabling together with other interrupt types */
+		int int_type = xen_pcibk_get_interrupt_type(dev);
+		if (int_type == INTERRUPT_TYPE_NONE ||
+		    int_type == field_config->int_type)
+			goto write;
+		return PCIBIOS_SET_FAILED;
+	}
+
+write:
+	return pci_write_config_word(dev, offset, new_value);
+}
+
+static const struct config_field caplist_msix[] = {
+	{
+		.offset    = PCI_MSIX_FLAGS,
+		.size      = 2,
+		.init      = msix_field_init,
+		.u.w.read  = xen_pcibk_read_config_word,
+		.u.w.write = msi_msix_flags_write,
+	},
+	{}
+};
+
+static const struct config_field caplist_msi[] = {
+	{
+		.offset    = PCI_MSI_FLAGS,
+		.size      = 2,
+		.init      = msi_field_init,
+		.u.w.read  = xen_pcibk_read_config_word,
+		.u.w.write = msi_msix_flags_write,
+	},
+	{}
+};
+
 static struct xen_pcibk_config_capability xen_pcibk_config_capability_pm = {
 	.capability = PCI_CAP_ID_PM,
 	.fields = caplist_pm,
@@ -197,11 +275,21 @@ static struct xen_pcibk_config_capability xen_pcibk_config_capability_vpd = {
 	.capability = PCI_CAP_ID_VPD,
 	.fields = caplist_vpd,
 };
+static struct xen_pcibk_config_capability xen_pcibk_config_capability_msi = {
+	.capability = PCI_CAP_ID_MSI,
+	.fields = caplist_msi,
+};
+static struct xen_pcibk_config_capability xen_pcibk_config_capability_msix = {
+	.capability = PCI_CAP_ID_MSIX,
+	.fields = caplist_msix,
+};
 
 int xen_pcibk_config_capability_init(void)
 {
 	register_capability(&xen_pcibk_config_capability_vpd);
 	register_capability(&xen_pcibk_config_capability_pm);
+	register_capability(&xen_pcibk_config_capability_msi);
+	register_capability(&xen_pcibk_config_capability_msix);
 
 	return 0;
 }
diff --git a/drivers/xen/xen-pciback/conf_space_header.c b/drivers/xen/xen-pciback/conf_space_header.c
index 10ae24b5a76e..ab60361d5a8a 100644
--- a/drivers/xen/xen-pciback/conf_space_header.c
+++ b/drivers/xen/xen-pciback/conf_space_header.c
@@ -117,6 +117,24 @@ static int command_write(struct pci_dev *dev, int offset, u16 value, void *data)
 		pci_clear_mwi(dev);
 	}
 
+	if (dev_data && dev_data->allow_interrupt_control) {
+		if ((cmd->val ^ val) & PCI_COMMAND_INTX_DISABLE) {
+			if (value & PCI_COMMAND_INTX_DISABLE) {
+				pci_intx(dev, 0);
+			} else {
+				/* Do not allow enabling INTx together with MSI or MSI-X. */
+				switch (xen_pcibk_get_interrupt_type(dev)) {
+				case INTERRUPT_TYPE_NONE:
+				case INTERRUPT_TYPE_INTX:
+					pci_intx(dev, 1);
+					break;
+				default:
+					return PCIBIOS_SET_FAILED;
+				}
+			}
+		}
+	}
+
 	cmd->val = value;
 
 	if (!xen_pcibk_permissive && (!dev_data || !dev_data->permissive))
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 097410a7cdb7..7af93d65ed51 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -304,6 +304,8 @@ void pcistub_put_pci_dev(struct pci_dev *dev)
 	xen_pcibk_config_reset_dev(dev);
 	xen_pcibk_config_free_dyn_fields(dev);
 
+	dev_data->allow_interrupt_control = 0;
+
 	xen_unregister_device_domain_owner(dev);
 
 	spin_lock_irqsave(&found_psdev->lock, flags);
@@ -1431,6 +1433,65 @@ static ssize_t permissive_show(struct device_driver *drv, char *buf)
 }
 static DRIVER_ATTR_RW(permissive);
 
+static ssize_t allow_interrupt_control_store(struct device_driver *drv,
+					     const char *buf, size_t count)
+{
+	int domain, bus, slot, func;
+	int err;
+	struct pcistub_device *psdev;
+	struct xen_pcibk_dev_data *dev_data;
+
+	err = str_to_slot(buf, &domain, &bus, &slot, &func);
+	if (err)
+		goto out;
+
+	psdev = pcistub_device_find(domain, bus, slot, func);
+	if (!psdev) {
+		err = -ENODEV;
+		goto out;
+	}
+
+	dev_data = pci_get_drvdata(psdev->dev);
+	/* the driver data for a device should never be null at this point */
+	if (!dev_data) {
+		err = -ENXIO;
+		goto release;
+	}
+	dev_data->allow_interrupt_control = 1;
+release:
+	pcistub_device_put(psdev);
+out:
+	if (!err)
+		err = count;
+	return err;
+}
+
+static ssize_t allow_interrupt_control_show(struct device_driver *drv,
+					    char *buf)
+{
+	struct pcistub_device *psdev;
+	struct xen_pcibk_dev_data *dev_data;
+	size_t count = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pcistub_devices_lock, flags);
+	list_for_each_entry(psdev, &pcistub_devices, dev_list) {
+		if (count >= PAGE_SIZE)
+			break;
+		if (!psdev->dev)
+			continue;
+		dev_data = pci_get_drvdata(psdev->dev);
+		if (!dev_data || !dev_data->allow_interrupt_control)
+			continue;
+		count +=
+		    scnprintf(buf + count, PAGE_SIZE - count, "%s\n",
+			      pci_name(psdev->dev));
+	}
+	spin_unlock_irqrestore(&pcistub_devices_lock, flags);
+	return count;
+}
+static DRIVER_ATTR_RW(allow_interrupt_control);
+
 static void pcistub_exit(void)
 {
 	driver_remove_file(&xen_pcibk_pci_driver.driver, &driver_attr_new_slot);
@@ -1440,6 +1501,8 @@ static void pcistub_exit(void)
 	driver_remove_file(&xen_pcibk_pci_driver.driver, &driver_attr_quirks);
 	driver_remove_file(&xen_pcibk_pci_driver.driver,
 			   &driver_attr_permissive);
+	driver_remove_file(&xen_pcibk_pci_driver.driver,
+			   &driver_attr_allow_interrupt_control);
 	driver_remove_file(&xen_pcibk_pci_driver.driver,
 			   &driver_attr_irq_handlers);
 	driver_remove_file(&xen_pcibk_pci_driver.driver,
@@ -1530,6 +1593,9 @@ static int __init pcistub_init(void)
 	if (!err)
 		err = driver_create_file(&xen_pcibk_pci_driver.driver,
 					 &driver_attr_permissive);
+	if (!err)
+		err = driver_create_file(&xen_pcibk_pci_driver.driver,
+					 &driver_attr_allow_interrupt_control);
 
 	if (!err)
 		err = driver_create_file(&xen_pcibk_pci_driver.driver,
diff --git a/drivers/xen/xen-pciback/pciback.h b/drivers/xen/xen-pciback/pciback.h
index 263c059bff90..ce1077e32466 100644
--- a/drivers/xen/xen-pciback/pciback.h
+++ b/drivers/xen/xen-pciback/pciback.h
@@ -45,6 +45,7 @@ struct xen_pcibk_dev_data {
 	struct list_head config_fields;
 	struct pci_saved_state *pci_saved_state;
 	unsigned int permissive:1;
+	unsigned int allow_interrupt_control:1;
 	unsigned int warned_on_write:1;
 	unsigned int enable_intx:1;
 	unsigned int isr_on:1; /* Whether the IRQ handler is installed. */
-- 
2.21.0

