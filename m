Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E45C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBC7320767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbgIATWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:22:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:53436 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731486AbgIATWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:22:07 -0400
IronPort-SDR: ZWAR4w2JeTkKZA6bopL4zlQhS7TThlWngFxXz0/jfPRWHC+veaPEm8oPwt09rKOUpllHZMisFG
 SWj2zJKqhhWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="218807359"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="218807359"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:21:36 -0700
IronPort-SDR: JCpbI0g/bbZ3DcRTWal9ZTxTJkk0brY/svwBjMaGp5OfysYBlFhqCTEbapDpcpghG6NaxlNf6+
 ZEhT1a8Zei7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="325480524"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2020 12:21:36 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH v3 19/19] dlb2: add ingress error handling
Date:   Tue,  1 Sep 2020 14:15:48 -0500
Message-Id: <20200901191548.31646-20-gage.eads@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20200901191548.31646-1-gage.eads@intel.com>
References: <20200901191548.31646-1-gage.eads@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DLB 2.0 detects that an application enqueued an illegal QE, it fires
an ingress error interrupt. The driver processes these errors and notifies
user-space through a domain alert.

A malicious application or virtual machine could attempt a
denial-of-service attack by enqueueing illegal QEs at a high rate and tying
up the PF driver, so the driver tracks the rate of ingress error alarms per
second. If they exceed a threshold of 1000/second, the driver simply
disables the interrupt. The interrupt is re-enabled when the device is
reset, the driver is reloaded, or by a user through a sysfs interface.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Björn Töpel <bjorn.topel@intel.com>
---
 Documentation/ABI/testing/sysfs-driver-dlb2 |  15 ++
 drivers/misc/dlb2/dlb2_hw_types.h           |  17 ++
 drivers/misc/dlb2/dlb2_main.h               |  16 ++
 drivers/misc/dlb2/dlb2_pf_ops.c             | 177 ++++++++++++++++++++
 drivers/misc/dlb2/dlb2_resource.c           | 251 +++++++++++++++++++++++++++-
 drivers/misc/dlb2/dlb2_resource.h           |  45 +++++
 6 files changed, 520 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-dlb2 b/Documentation/ABI/testing/sysfs-driver-dlb2
index c5cb1cbb70f4..3598ce9caa03 100644
--- a/Documentation/ABI/testing/sysfs-driver-dlb2
+++ b/Documentation/ABI/testing/sysfs-driver-dlb2
@@ -185,3 +185,18 @@ Description:	Device ID used in /dev, i.e. /dev/dlb<device ID>
 		/dev directory: /dev/dlb<device ID>. This sysfs file can be read
 		to determine a device's ID, which allows the user to map a
 		device file to a PCI BDF.
+
+What:		/sys/bus/pci/devices/.../ingress_err_en
+Date:		June 22, 2020
+KernelVersion:	5.9
+Contact:	gage.eads@intel.com
+Description:	Interface for re-enabling ingress error interrupts
+
+		If the PF driver detects an overload of ingress error
+		interrupts, it will -- to prevent a possible denial-of-service
+		attack -- disable them.
+
+		If the ingress error interrupt is disabled, they will be
+		re-enabled when the device is reset or the driver is reloaded.
+		This interface can be used to re-enable the interrupt as well,
+		and can be read to determine whether the interrupt is enabled.
diff --git a/drivers/misc/dlb2/dlb2_hw_types.h b/drivers/misc/dlb2/dlb2_hw_types.h
index 986d35cbeaf9..2a103e3e958e 100644
--- a/drivers/misc/dlb2/dlb2_hw_types.h
+++ b/drivers/misc/dlb2/dlb2_hw_types.h
@@ -61,6 +61,23 @@
 #define DLB2_PF_COMPRESSED_MODE_CQ_VECTOR_ID \
 	DLB2_PF_NUM_NON_CQ_INTERRUPT_VECTORS
 
+/* DLB non-CQ interrupts (alarm, mailbox, WDT) */
+#define DLB2_INT_NON_CQ 0
+
+#define DLB2_ALARM_HW_SOURCE_SYS 0
+#define DLB2_ALARM_HW_SOURCE_DLB 1
+
+#define DLB2_ALARM_HW_UNIT_CHP 4
+
+#define DLB2_ALARM_SYS_AID_ILLEGAL_QID		3
+#define DLB2_ALARM_SYS_AID_DISABLED_QID		4
+#define DLB2_ALARM_SYS_AID_ILLEGAL_HCW		5
+#define DLB2_ALARM_HW_CHP_AID_ILLEGAL_ENQ	1
+#define DLB2_ALARM_HW_CHP_AID_EXCESS_TOKEN_POPS 2
+
+#define DLB2_VF_NUM_NON_CQ_INTERRUPT_VECTORS 1
+#define DLB2_VF_NUM_CQ_INTERRUPT_VECTORS     31
+
 /*
  * Hardware-defined base addresses. Those prefixed 'DLB2_DRV' are only used by
  * the PF driver.
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index ab8cebe6220f..cf7e187d11c6 100644
--- a/drivers/misc/dlb2/dlb2_main.h
+++ b/drivers/misc/dlb2/dlb2_main.h
@@ -217,6 +217,21 @@ struct dlb2_intr {
 	int mode;
 };
 
+/*
+ * ISR overload is defined as more than DLB2_ISR_OVERLOAD_THRESH interrupts
+ * (of a particular type) occurring in a 1s period. If overload is detected,
+ * the driver blocks that interrupt (exact mechanism depending on the
+ * interrupt) from overloading the PF driver.
+ */
+#define DLB2_ISR_OVERLOAD_THRESH 1000
+#define DLB2_ISR_OVERLOAD_PERIOD_S 1
+
+struct dlb2_alarm {
+	ktime_t ts;
+	unsigned int enabled;
+	u32 count;
+};
+
 struct dlb2_dev {
 	struct pci_dev *pdev;
 	struct dlb2_hw hw;
@@ -239,6 +254,7 @@ struct dlb2_dev {
 	 */
 	struct mutex resource_mutex;
 	struct work_struct work;
+	struct dlb2_alarm ingress_err;
 	enum dlb2_device_type type;
 	int id;
 	dev_t dev_number;
diff --git a/drivers/misc/dlb2/dlb2_pf_ops.c b/drivers/misc/dlb2/dlb2_pf_ops.c
index 4f0f0e41ab8d..d719a977a763 100644
--- a/drivers/misc/dlb2/dlb2_pf_ops.c
+++ b/drivers/misc/dlb2/dlb2_pf_ops.c
@@ -82,6 +82,109 @@ dlb2_pf_map_pci_bar_space(struct dlb2_dev *dlb2_dev,
 /****** Interrupt management ******/
 /**********************************/
 
+static void dlb2_detect_ingress_err_overload(struct dlb2_dev *dev)
+{
+	s64 delta_us;
+
+	if (dev->ingress_err.count == 0)
+		dev->ingress_err.ts = ktime_get();
+
+	dev->ingress_err.count++;
+
+	/* Don't check for overload until OVERLOAD_THRESH ISRs have run */
+	if (dev->ingress_err.count < DLB2_ISR_OVERLOAD_THRESH)
+		return;
+
+	delta_us = ktime_us_delta(ktime_get(), dev->ingress_err.ts);
+
+	/* Reset stats for next measurement period */
+	dev->ingress_err.count = 0;
+	dev->ingress_err.ts = ktime_get();
+
+	/* Check for overload during this measurement period */
+	if (delta_us > DLB2_ISR_OVERLOAD_PERIOD_S * USEC_PER_SEC)
+		return;
+
+	/*
+	 * Alarm interrupt overload: disable software-generated alarms,
+	 * so only hardware problems (e.g. ECC errors) interrupt the PF.
+	 */
+	dlb2_disable_ingress_error_alarms(&dev->hw);
+
+	dev->ingress_err.enabled = false;
+
+	dev_err(dev->dlb2_device,
+		"[%s()] Overloaded detected: disabling ingress error interrupts",
+		__func__);
+}
+
+/*
+ * The alarm handler logs the alarm syndrome and, for user-caused errors,
+ * reports the alarm to user-space through the per-domain device file interface.
+ *
+ * This function runs as a bottom-half handler because it can call printk
+ * and/or acquire a mutex. These alarms don't need to be handled immediately --
+ * they represent a serious, unexpected error (either in hardware or software)
+ * that can't be recovered without restarting the application or resetting the
+ * device. The VF->PF operations are also non-trivial and require running in a
+ * bottom-half handler.
+ */
+static irqreturn_t
+dlb2_service_intr_handler(int irq, void *hdlr_ptr)
+{
+	struct dlb2_dev *dev = (struct dlb2_dev *)hdlr_ptr;
+	union dlb2_sys_alarm_hw_synd r0;
+
+	dev_dbg(dev->dlb2_device, "DLB service interrupt fired\n");
+
+	mutex_lock(&dev->resource_mutex);
+
+	r0.val = DLB2_CSR_RD(&dev->hw, DLB2_SYS_ALARM_HW_SYND);
+
+	/*
+	 * Clear the MSI-X ack bit before processing the VF->PF or watchdog
+	 * timer interrupts. This order is necessary so that if an interrupt
+	 * event arrives after reading the corresponding bit vector, the event
+	 * won't be lost.
+	 */
+	dlb2_ack_msix_interrupt(&dev->hw, DLB2_INT_NON_CQ);
+
+	if (r0.field.alarm & r0.field.valid)
+		dlb2_process_alarm_interrupt(&dev->hw);
+
+	if (dlb2_process_ingress_error_interrupt(&dev->hw))
+		dlb2_detect_ingress_err_overload(dev);
+
+	mutex_unlock(&dev->resource_mutex);
+
+	return IRQ_HANDLED;
+}
+
+static int
+dlb2_init_alarm_interrupts(struct dlb2_dev *dev,
+			   struct pci_dev *pdev)
+{
+	int i, ret;
+
+	for (i = 0; i < DLB2_PF_NUM_NON_CQ_INTERRUPT_VECTORS; i++) {
+		ret = devm_request_threaded_irq(&pdev->dev,
+						pci_irq_vector(pdev, i),
+						NULL,
+						dlb2_service_intr_handler,
+						IRQF_ONESHOT,
+						"dlb2_alarm",
+						dev);
+		if (ret)
+			return ret;
+
+		dev->intr.isr_registered[i] = true;
+	}
+
+	dlb2_enable_ingress_error_alarms(&dev->hw);
+
+	return 0;
+}
+
 static irqreturn_t
 dlb2_compressed_cq_intr_handler(int irq, void *hdlr_ptr)
 {
@@ -178,6 +281,12 @@ dlb2_pf_init_interrupts(struct dlb2_dev *dev, struct pci_dev *pdev)
 	dev->intr.num_vectors = ret;
 	dev->intr.base_vector = pci_irq_vector(pdev, 0);
 
+	ret = dlb2_init_alarm_interrupts(dev, pdev);
+	if (ret) {
+		dlb2_pf_free_interrupts(dev, pdev);
+		return ret;
+	}
+
 	ret = dlb2_init_compressed_mode_interrupts(dev, pdev);
 	if (ret) {
 		dlb2_pf_free_interrupts(dev, pdev);
@@ -208,6 +317,16 @@ dlb2_pf_init_interrupts(struct dlb2_dev *dev, struct pci_dev *pdev)
 static void
 dlb2_pf_reinit_interrupts(struct dlb2_dev *dev)
 {
+	/* Re-enable alarms after device reset */
+	dlb2_enable_ingress_error_alarms(&dev->hw);
+
+	if (!dev->ingress_err.enabled)
+		dev_err(dev->dlb2_device,
+			"[%s()] Re-enabling ingress error interrupts",
+			__func__);
+
+	dev->ingress_err.enabled = true;
+
 	dlb2_set_msix_mode(&dev->hw, DLB2_MSIX_MODE_COMPRESSED);
 }
 
@@ -289,6 +408,9 @@ dlb2_pf_arm_cq_interrupt(struct dlb2_dev *dev,
 static int
 dlb2_pf_init_driver_state(struct dlb2_dev *dlb2_dev)
 {
+	dlb2_dev->ingress_err.count = 0;
+	dlb2_dev->ingress_err.enabled = true;
+
 	mutex_init(&dlb2_dev->resource_mutex);
 
 	return 0;
@@ -761,6 +883,54 @@ static ssize_t dev_id_show(struct device *dev,
 
 static DEVICE_ATTR_RO(dev_id);
 
+static ssize_t ingress_err_en_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct dlb2_dev *dlb2_dev = dev_get_drvdata(dev);
+	ssize_t ret;
+
+	mutex_lock(&dlb2_dev->resource_mutex);
+
+	ret = scnprintf(buf, PAGE_SIZE, "%d\n", dlb2_dev->ingress_err.enabled);
+
+	mutex_unlock(&dlb2_dev->resource_mutex);
+
+	return ret;
+}
+
+static ssize_t ingress_err_en_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf,
+				    size_t count)
+{
+	struct dlb2_dev *dlb2_dev = dev_get_drvdata(dev);
+	unsigned long num;
+	ssize_t ret;
+
+	ret = kstrtoul(buf, 0, &num);
+	if (ret)
+		return -1;
+
+	mutex_lock(&dlb2_dev->resource_mutex);
+
+	if (!dlb2_dev->ingress_err.enabled && num) {
+		dlb2_enable_ingress_error_alarms(&dlb2_dev->hw);
+
+		dev_err(dlb2_dev->dlb2_device,
+			"[%s()] Re-enabling ingress error interrupts",
+			__func__);
+
+		dlb2_dev->ingress_err.enabled = true;
+	}
+
+	mutex_unlock(&dlb2_dev->resource_mutex);
+
+	return (ret == 0) ? count : ret;
+}
+
+static DEVICE_ATTR_RW(ingress_err_en);
+
 static int
 dlb2_pf_sysfs_create(struct dlb2_dev *dlb2_dev)
 {
@@ -769,6 +939,10 @@ dlb2_pf_sysfs_create(struct dlb2_dev *dlb2_dev)
 
 	kobj = &dlb2_dev->pdev->dev.kobj;
 
+	ret = sysfs_create_file(kobj, &dev_attr_ingress_err_en.attr);
+	if (ret)
+		goto dlb2_ingress_err_en_attr_group_fail;
+
 	ret = sysfs_create_file(kobj, &dev_attr_dev_id.attr);
 	if (ret)
 		goto dlb2_dev_id_attr_group_fail;
@@ -800,6 +974,8 @@ dlb2_pf_sysfs_create(struct dlb2_dev *dlb2_dev)
 dlb2_total_attr_group_fail:
 	sysfs_remove_file(kobj, &dev_attr_dev_id.attr);
 dlb2_dev_id_attr_group_fail:
+	sysfs_remove_file(kobj, &dev_attr_ingress_err_en.attr);
+dlb2_ingress_err_en_attr_group_fail:
 	return ret;
 }
 
@@ -815,6 +991,7 @@ dlb2_pf_sysfs_destroy(struct dlb2_dev *dlb2_dev)
 	sysfs_remove_group(kobj, &dlb2_avail_attr_group);
 	sysfs_remove_group(kobj, &dlb2_total_attr_group);
 	sysfs_remove_file(kobj, &dev_attr_dev_id.attr);
+	sysfs_remove_file(kobj, &dev_attr_ingress_err_en.attr);
 }
 
 static void
diff --git a/drivers/misc/dlb2/dlb2_resource.c b/drivers/misc/dlb2/dlb2_resource.c
index 4d751a0ce1db..2e0399ed455d 100644
--- a/drivers/misc/dlb2/dlb2_resource.c
+++ b/drivers/misc/dlb2/dlb2_resource.c
@@ -4917,7 +4917,7 @@ void dlb2_read_compressed_cq_intr_status(struct dlb2_hw *hw,
 					DLB2_SYS_DIR_CQ_63_32_OCC_INT_STS);
 }
 
-static void dlb2_ack_msix_interrupt(struct dlb2_hw *hw, int vector)
+void dlb2_ack_msix_interrupt(struct dlb2_hw *hw, int vector)
 {
 	union dlb2_sys_msix_ack r0 = { {0} };
 
@@ -4994,6 +4994,255 @@ void dlb2_ack_compressed_cq_intr(struct dlb2_hw *hw,
 	dlb2_ack_msix_interrupt(hw, DLB2_PF_COMPRESSED_MODE_CQ_VECTOR_ID);
 }
 
+void dlb2_enable_ingress_error_alarms(struct dlb2_hw *hw)
+{
+	union dlb2_sys_ingress_alarm_enbl r0;
+
+	r0.val = DLB2_CSR_RD(hw, DLB2_SYS_INGRESS_ALARM_ENBL);
+
+	r0.field.illegal_hcw = 1;
+	r0.field.illegal_pp = 1;
+	r0.field.illegal_pasid = 1;
+	r0.field.illegal_qid = 1;
+	r0.field.disabled_qid = 1;
+	r0.field.illegal_ldb_qid_cfg = 1;
+
+	DLB2_CSR_WR(hw, DLB2_SYS_INGRESS_ALARM_ENBL, r0.val);
+}
+
+void dlb2_disable_ingress_error_alarms(struct dlb2_hw *hw)
+{
+	union dlb2_sys_ingress_alarm_enbl r0;
+
+	r0.val = DLB2_CSR_RD(hw, DLB2_SYS_INGRESS_ALARM_ENBL);
+
+	r0.field.illegal_hcw = 0;
+	r0.field.illegal_pp = 0;
+	r0.field.illegal_pasid = 0;
+	r0.field.illegal_qid = 0;
+	r0.field.disabled_qid = 0;
+	r0.field.illegal_ldb_qid_cfg = 0;
+
+	DLB2_CSR_WR(hw, DLB2_SYS_INGRESS_ALARM_ENBL, r0.val);
+}
+
+static void dlb2_log_alarm_syndrome(struct dlb2_hw *hw,
+				    const char *str,
+				    union dlb2_sys_alarm_hw_synd r0)
+{
+	DLB2_HW_ERR(hw, "%s:\n", str);
+	DLB2_HW_ERR(hw, "\tsyndrome: 0x%x\n", r0.field.syndrome);
+	DLB2_HW_ERR(hw, "\trtype:    0x%x\n", r0.field.rtype);
+	DLB2_HW_ERR(hw, "\talarm:    0x%x\n", r0.field.alarm);
+	DLB2_HW_ERR(hw, "\tcwd:      0x%x\n", r0.field.cwd);
+	DLB2_HW_ERR(hw, "\tvf_pf_mb: 0x%x\n", r0.field.vf_pf_mb);
+	DLB2_HW_ERR(hw, "\tcls:      0x%x\n", r0.field.cls);
+	DLB2_HW_ERR(hw, "\taid:      0x%x\n", r0.field.aid);
+	DLB2_HW_ERR(hw, "\tunit:     0x%x\n", r0.field.unit);
+	DLB2_HW_ERR(hw, "\tsource:   0x%x\n", r0.field.source);
+	DLB2_HW_ERR(hw, "\tmore:     0x%x\n", r0.field.more);
+	DLB2_HW_ERR(hw, "\tvalid:    0x%x\n", r0.field.valid);
+}
+
+/* Note: this array's contents must match dlb2_alert_id() */
+static const char dlb2_alert_strings[NUM_DLB2_DOMAIN_ALERTS][128] = {
+	[DLB2_DOMAIN_ALERT_PP_ILLEGAL_ENQ] = "Illegal enqueue",
+	[DLB2_DOMAIN_ALERT_PP_EXCESS_TOKEN_POPS] = "Excess token pops",
+	[DLB2_DOMAIN_ALERT_ILLEGAL_HCW] = "Illegal HCW",
+	[DLB2_DOMAIN_ALERT_ILLEGAL_QID] = "Illegal QID",
+	[DLB2_DOMAIN_ALERT_DISABLED_QID] = "Disabled QID",
+};
+
+static void dlb2_log_pf_vf_syndrome(struct dlb2_hw *hw,
+				    const char *str,
+				    union dlb2_sys_alarm_pf_synd0 r0,
+				    union dlb2_sys_alarm_pf_synd1 r1,
+				    union dlb2_sys_alarm_pf_synd2 r2,
+				    u32 alert_id)
+{
+	DLB2_HW_ERR(hw, "%s:\n", str);
+	if (alert_id < NUM_DLB2_DOMAIN_ALERTS)
+		DLB2_HW_ERR(hw, "Alert: %s\n", dlb2_alert_strings[alert_id]);
+	DLB2_HW_ERR(hw, "\tsyndrome:     0x%x\n", r0.field.syndrome);
+	DLB2_HW_ERR(hw, "\trtype:        0x%x\n", r0.field.rtype);
+	DLB2_HW_ERR(hw, "\tis_ldb:       0x%x\n", r0.field.is_ldb);
+	DLB2_HW_ERR(hw, "\tcls:          0x%x\n", r0.field.cls);
+	DLB2_HW_ERR(hw, "\taid:          0x%x\n", r0.field.aid);
+	DLB2_HW_ERR(hw, "\tunit:         0x%x\n", r0.field.unit);
+	DLB2_HW_ERR(hw, "\tsource:       0x%x\n", r0.field.source);
+	DLB2_HW_ERR(hw, "\tmore:         0x%x\n", r0.field.more);
+	DLB2_HW_ERR(hw, "\tvalid:        0x%x\n", r0.field.valid);
+	DLB2_HW_ERR(hw, "\tdsi:          0x%x\n", r1.field.dsi);
+	DLB2_HW_ERR(hw, "\tqid:          0x%x\n", r1.field.qid);
+	DLB2_HW_ERR(hw, "\tqtype:        0x%x\n", r1.field.qtype);
+	DLB2_HW_ERR(hw, "\tqpri:         0x%x\n", r1.field.qpri);
+	DLB2_HW_ERR(hw, "\tmsg_type:     0x%x\n", r1.field.msg_type);
+	DLB2_HW_ERR(hw, "\tlock_id:      0x%x\n", r2.field.lock_id);
+	DLB2_HW_ERR(hw, "\tmeas:         0x%x\n", r2.field.meas);
+	DLB2_HW_ERR(hw, "\tdebug:        0x%x\n", r2.field.debug);
+	DLB2_HW_ERR(hw, "\tcq_pop:       0x%x\n", r2.field.cq_pop);
+	DLB2_HW_ERR(hw, "\tqe_uhl:       0x%x\n", r2.field.qe_uhl);
+	DLB2_HW_ERR(hw, "\tqe_orsp:      0x%x\n", r2.field.qe_orsp);
+	DLB2_HW_ERR(hw, "\tqe_valid:     0x%x\n", r2.field.qe_valid);
+	DLB2_HW_ERR(hw, "\tcq_int_rearm: 0x%x\n", r2.field.cq_int_rearm);
+	DLB2_HW_ERR(hw, "\tdsi_error:    0x%x\n", r2.field.dsi_error);
+}
+
+static void dlb2_clear_syndrome_register(struct dlb2_hw *hw, u32 offset)
+{
+	union dlb2_sys_alarm_hw_synd r0 = { {0} };
+
+	r0.field.valid = 1;
+	r0.field.more = 1;
+
+	DLB2_CSR_WR(hw, offset, r0.val);
+}
+
+void dlb2_process_alarm_interrupt(struct dlb2_hw *hw)
+{
+	union dlb2_sys_alarm_hw_synd r0;
+
+	DLB2_HW_DBG(hw, "Processing alarm interrupt\n");
+
+	r0.val = DLB2_CSR_RD(hw, DLB2_SYS_ALARM_HW_SYND);
+
+	dlb2_log_alarm_syndrome(hw, "HW alarm syndrome", r0);
+
+	dlb2_clear_syndrome_register(hw, DLB2_SYS_ALARM_HW_SYND);
+}
+
+static void dlb2_process_ingress_error(struct dlb2_hw *hw,
+				       union dlb2_sys_alarm_pf_synd0 r0,
+				       u32 alert_id,
+				       bool vf_error,
+				       unsigned int vf_id)
+{
+	struct dlb2_dev *dev;
+	u32 domain_id;
+	bool is_ldb;
+	u8 port_id;
+	int ret;
+
+	port_id = r0.field.syndrome & 0x7F;
+	if (r0.field.source == DLB2_ALARM_HW_SOURCE_SYS)
+		is_ldb = r0.field.is_ldb;
+	else
+		is_ldb = (r0.field.syndrome & 0x80) != 0;
+
+	/* Get the domain ID and, if it's a VF domain, the virtual port ID */
+	if (is_ldb) {
+		struct dlb2_ldb_port *port;
+
+		port = dlb2_get_ldb_port_from_id(hw, port_id, vf_error, vf_id);
+		if (!port) {
+			DLB2_HW_ERR(hw,
+				    "[%s()]: Internal error: unable to find LDB port\n\tport: %u, vf_error: %u, vf_id: %u\n",
+				    __func__, port_id, vf_error, vf_id);
+			return;
+		}
+
+		domain_id = port->domain_id.phys_id;
+	} else {
+		struct dlb2_dir_pq_pair *port;
+
+		port = dlb2_get_dir_pq_from_id(hw, port_id, vf_error, vf_id);
+		if (!port) {
+			DLB2_HW_ERR(hw,
+				    "[%s()]: Internal error: unable to find DIR port\n\tport: %u, vf_error: %u, vf_id: %u\n",
+				    __func__, port_id, vf_error, vf_id);
+			return;
+		}
+
+		domain_id = port->domain_id.phys_id;
+	}
+
+	dev = container_of(hw, struct dlb2_dev, hw);
+
+	ret = dlb2_write_domain_alert(dev,
+				      dev->sched_domains[domain_id],
+				      alert_id,
+				      (is_ldb << 8) | port_id);
+	if (ret)
+		DLB2_HW_ERR(hw,
+			    "[%s()] Internal error: failed to notify\n",
+			    __func__);
+}
+
+static u32 dlb2_alert_id(union dlb2_sys_alarm_pf_synd0 r0)
+{
+	if (r0.field.unit == DLB2_ALARM_HW_UNIT_CHP &&
+	    r0.field.aid == DLB2_ALARM_HW_CHP_AID_ILLEGAL_ENQ)
+		return DLB2_DOMAIN_ALERT_PP_ILLEGAL_ENQ;
+	else if (r0.field.unit == DLB2_ALARM_HW_UNIT_CHP &&
+		 r0.field.aid == DLB2_ALARM_HW_CHP_AID_EXCESS_TOKEN_POPS)
+		return DLB2_DOMAIN_ALERT_PP_EXCESS_TOKEN_POPS;
+	else if (r0.field.source == DLB2_ALARM_HW_SOURCE_SYS &&
+		 r0.field.aid == DLB2_ALARM_SYS_AID_ILLEGAL_HCW)
+		return DLB2_DOMAIN_ALERT_ILLEGAL_HCW;
+	else if (r0.field.source == DLB2_ALARM_HW_SOURCE_SYS &&
+		 r0.field.aid == DLB2_ALARM_SYS_AID_ILLEGAL_QID)
+		return DLB2_DOMAIN_ALERT_ILLEGAL_QID;
+	else if (r0.field.source == DLB2_ALARM_HW_SOURCE_SYS &&
+		 r0.field.aid == DLB2_ALARM_SYS_AID_DISABLED_QID)
+		return DLB2_DOMAIN_ALERT_DISABLED_QID;
+	else
+		return NUM_DLB2_DOMAIN_ALERTS;
+}
+
+bool dlb2_process_ingress_error_interrupt(struct dlb2_hw *hw)
+{
+	union dlb2_sys_alarm_pf_synd0 r0;
+	union dlb2_sys_alarm_pf_synd1 r1;
+	union dlb2_sys_alarm_pf_synd2 r2;
+	u32 alert_id;
+	bool valid;
+	int i;
+
+	r0.val = DLB2_CSR_RD(hw, DLB2_SYS_ALARM_PF_SYND0);
+
+	valid = r0.field.valid;
+
+	if (r0.field.valid) {
+		r1.val = DLB2_CSR_RD(hw, DLB2_SYS_ALARM_PF_SYND1);
+		r2.val = DLB2_CSR_RD(hw, DLB2_SYS_ALARM_PF_SYND2);
+
+		alert_id = dlb2_alert_id(r0);
+
+		dlb2_log_pf_vf_syndrome(hw,
+					"PF Ingress error alarm",
+					r0, r1, r2, alert_id);
+
+		dlb2_clear_syndrome_register(hw, DLB2_SYS_ALARM_PF_SYND0);
+
+		dlb2_process_ingress_error(hw, r0, alert_id, false, 0);
+	}
+
+	for (i = 0; i < DLB2_MAX_NUM_VDEVS; i++) {
+		r0.val = DLB2_CSR_RD(hw, DLB2_SYS_ALARM_VF_SYND0(i));
+
+		valid |= r0.field.valid;
+
+		if (!r0.field.valid)
+			continue;
+
+		r1.val = DLB2_CSR_RD(hw, DLB2_SYS_ALARM_VF_SYND1(i));
+		r2.val = DLB2_CSR_RD(hw, DLB2_SYS_ALARM_VF_SYND2(i));
+
+		alert_id = dlb2_alert_id(r0);
+
+		dlb2_log_pf_vf_syndrome(hw,
+					"VF Ingress error alarm",
+					r0, r1, r2, alert_id);
+
+		dlb2_clear_syndrome_register(hw,
+					     DLB2_SYS_ALARM_VF_SYND0(i));
+
+		dlb2_process_ingress_error(hw, r0, alert_id, true, i);
+	}
+
+	return valid;
+}
+
 int dlb2_get_group_sequence_numbers(struct dlb2_hw *hw, unsigned int group_id)
 {
 	if (group_id >= DLB2_MAX_NUM_SEQUENCE_NUMBER_GROUPS)
diff --git a/drivers/misc/dlb2/dlb2_resource.h b/drivers/misc/dlb2/dlb2_resource.h
index 258ec1c11032..ac7347852662 100644
--- a/drivers/misc/dlb2/dlb2_resource.h
+++ b/drivers/misc/dlb2/dlb2_resource.h
@@ -517,6 +517,18 @@ int dlb2_configure_dir_cq_interrupt(struct dlb2_hw *hw,
 				    u16 threshold);
 
 /**
+ * dlb2_enable_ingress_error_alarms() - enable ingress error alarm interrupts
+ * @hw: dlb2_hw handle for a particular device.
+ */
+void dlb2_enable_ingress_error_alarms(struct dlb2_hw *hw);
+
+/**
+ * dlb2_disable_ingress_error_alarms() - disable ingress error alarm interrupts
+ * @hw: dlb2_hw handle for a particular device.
+ */
+void dlb2_disable_ingress_error_alarms(struct dlb2_hw *hw);
+
+/**
  * dlb2_set_msix_mode() - enable certain hardware alarm interrupts
  * @hw: dlb2_hw handle for a particular device.
  * @mode: MSI-X mode (DLB2_MSIX_MODE_PACKED or DLB2_MSIX_MODE_COMPRESSED)
@@ -527,6 +539,16 @@ int dlb2_configure_dir_cq_interrupt(struct dlb2_hw *hw,
 void dlb2_set_msix_mode(struct dlb2_hw *hw, int mode);
 
 /**
+ * dlb2_ack_msix_interrupt() - Ack an MSI-X interrupt
+ * @hw: dlb2_hw handle for a particular device.
+ * @vector: interrupt vector.
+ *
+ * Note: Only needed for PF service interrupts (vector 0). CQ interrupts are
+ * acked in dlb2_ack_compressed_cq_intr().
+ */
+void dlb2_ack_msix_interrupt(struct dlb2_hw *hw, int vector);
+
+/**
  * dlb2_arm_cq_interrupt() - arm a CQ's interrupt
  * @hw: dlb2_hw handle for a particular device.
  * @port_id: port ID
@@ -582,6 +604,29 @@ void dlb2_ack_compressed_cq_intr(struct dlb2_hw *hw,
 				 u32 *dir_interrupts);
 
 /**
+ * dlb2_process_alarm_interrupt() - process an alarm interrupt
+ * @hw: dlb2_hw handle for a particular device.
+ *
+ * This function reads the alarm syndrome, logs its, and acks the interrupt.
+ * This function should be called from the alarm interrupt handler when
+ * interrupt vector DLB2_INT_ALARM fires.
+ */
+void dlb2_process_alarm_interrupt(struct dlb2_hw *hw);
+
+/**
+ * dlb2_process_ingress_error_interrupt() - process ingress error interrupts
+ * @hw: dlb2_hw handle for a particular device.
+ *
+ * This function reads the alarm syndrome, logs it, notifies user-space, and
+ * acks the interrupt. This function should be called from the alarm interrupt
+ * handler when interrupt vector DLB2_INT_INGRESS_ERROR fires.
+ *
+ * Return:
+ * Returns true if an ingress error interrupt occurred, false otherwise
+ */
+bool dlb2_process_ingress_error_interrupt(struct dlb2_hw *hw);
+
+/**
  * dlb2_get_group_sequence_numbers() - return a group's number of SNs per queue
  * @hw: dlb2_hw handle for a particular device.
  * @group_id: sequence number group ID.
-- 
2.13.6

