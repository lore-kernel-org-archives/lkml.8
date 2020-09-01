Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EF5C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53AFD20767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbgIATYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:24:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:53433 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731931AbgIATYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:24:08 -0400
IronPort-SDR: ybaXYCwvseHId5YZUhIup817c9HbAkj8m5nVdVcCOW0hLhr7LEUw4SEGey4mYz7sc7eQDaLg7v
 DOyG7DxNG5tw==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="218807355"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="218807355"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:21:36 -0700
IronPort-SDR: vNr+I6PILI/SLJu/txfx28lOKq2FrhepqpxqF0WmPQR2RwnrncqKeUly4+sgVKe53jmS9kmeB+
 Tvl8y/B+DMEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="325480519"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2020 12:21:35 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH v3 18/19] dlb2: add basic PF sysfs interfaces
Date:   Tue,  1 Sep 2020 14:15:47 -0500
Message-Id: <20200901191548.31646-19-gage.eads@intel.com>
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

These interfaces include files for reading the total and available device
resources, getting and setting sequence number group allocations, and
reading the device ID.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Björn Töpel <bjorn.topel@intel.com>
---
 Documentation/ABI/testing/sysfs-driver-dlb2 | 165 +++++++++++
 drivers/misc/dlb2/dlb2_main.c               |  11 +
 drivers/misc/dlb2/dlb2_main.h               |   3 +
 drivers/misc/dlb2/dlb2_pf_ops.c             | 423 ++++++++++++++++++++++++++++
 4 files changed, 602 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-dlb2 b/Documentation/ABI/testing/sysfs-driver-dlb2
index 38d0d3d92670..c5cb1cbb70f4 100644
--- a/Documentation/ABI/testing/sysfs-driver-dlb2
+++ b/Documentation/ABI/testing/sysfs-driver-dlb2
@@ -20,3 +20,168 @@ Description:	Interface for setting the driver's reset timeout.
 		their device mappings can interfere with processes that use the
 		device after the reset completes. To ensure that user processes
 		have enough time to clean up, reset_timeout_s can be increased.
+
+What:		/sys/bus/pci/devices/.../sequence_numbers/group<N>_sns_per_queue
+Date:		June 22, 2020
+KernelVersion:	5.9
+Contact:	gage.eads@intel.com
+Description:	Interface for configuring dlb2 load-balanced sequence numbers.
+
+		The DLB 2.0 has a fixed number of sequence numbers used for
+		ordered scheduling. They are divided among two sequence number
+		groups. A group can be configured to contain one queue with
+		1,024 sequence numbers, or two queues with 512 sequence numbers
+		each, and so on, down to 16 queues with 64 sequence numbers
+		each.
+
+		When a load-balanced queue is configured with non-zero sequence
+		numbers, the driver finds a group configured for the same
+		number of sequence numbers and an available slot. If no such
+		groups are found, the queue cannot be configured.
+
+		Once the first ordered queue is configured, the sequence number
+		configurations are locked. The driver returns an error on writes
+		to locked sequence number configurations. When all ordered
+		queues are unconfigured, the sequence number configurations can
+		be changed again.
+
+		This file is only accessible for physical function DLB 2.0
+		devices.
+
+What:		/sys/bus/pci/devices/.../total_resources/num_atomic_inflights
+What:		/sys/bus/pci/devices/.../total_resources/num_dir_credits
+What:		/sys/bus/pci/devices/.../total_resources/num_dir_ports
+What:		/sys/bus/pci/devices/.../total_resources/num_hist_list_entries
+What:		/sys/bus/pci/devices/.../total_resources/num_ldb_credits
+What:		/sys/bus/pci/devices/.../total_resources/num_ldb_ports
+What:		/sys/bus/pci/devices/.../total_resources/num_cos0_ldb_ports
+What:		/sys/bus/pci/devices/.../total_resources/num_cos1_ldb_ports
+What:		/sys/bus/pci/devices/.../total_resources/num_cos2_ldb_ports
+What:		/sys/bus/pci/devices/.../total_resources/num_cos3_ldb_ports
+What:		/sys/bus/pci/devices/.../total_resources/num_ldb_queues
+What:		/sys/bus/pci/devices/.../total_resources/num_sched_domains
+Date:		June 22, 2020
+KernelVersion:	5.9
+Contact:	gage.eads@intel.com
+Description:
+		The total_resources subdirectory contains read-only files that
+		indicate the total number of resources in the device.
+
+		num_atomic_inflights:  Total number of atomic inflights in the
+				       device. Atomic inflights refers to the
+				       on-device storage used by the atomic
+				       scheduler.
+
+		num_dir_credits:       Total number of directed credits in the
+				       device.
+
+		num_dir_ports:	       Total number of directed ports (and
+				       queues) in the device.
+
+		num_hist_list_entries: Total number of history list entries in
+				       the device.
+
+		num_ldb_credits:       Total number of load-balanced credits in
+				       the device.
+
+		num_ldb_ports:	       Total number of load-balanced ports in
+				       the device.
+
+		num_cos<M>_ldb_ports:  Total number of load-balanced ports
+				       belonging to class-of-service M in the
+				       device.
+
+		num_ldb_queues:	       Total number of load-balanced queues in
+				       the device.
+
+		num_sched_domains:     Total number of scheduling domains in the
+				       device.
+
+What:		/sys/bus/pci/devices/.../avail_resources/num_atomic_inflights
+What:		/sys/bus/pci/devices/.../avail_resources/num_dir_credits
+What:		/sys/bus/pci/devices/.../avail_resources/num_dir_ports
+What:		/sys/bus/pci/devices/.../avail_resources/num_hist_list_entries
+What:		/sys/bus/pci/devices/.../avail_resources/num_ldb_credits
+What:		/sys/bus/pci/devices/.../avail_resources/num_ldb_ports
+What:		/sys/bus/pci/devices/.../avail_resources/num_cos0_ldb_ports
+What:		/sys/bus/pci/devices/.../avail_resources/num_cos1_ldb_ports
+What:		/sys/bus/pci/devices/.../avail_resources/num_cos2_ldb_ports
+What:		/sys/bus/pci/devices/.../avail_resources/num_cos3_ldb_ports
+What:		/sys/bus/pci/devices/.../avail_resources/num_ldb_queues
+What:		/sys/bus/pci/devices/.../avail_resources/num_sched_domains
+What:		/sys/bus/pci/devices/.../avail_resources/max_ctg_hl_entries
+Date:		June 22, 2020
+KernelVersion:	5.9
+Contact:	gage.eads@intel.com
+Description:
+		The avail_resources subdirectory contains read-only files that
+		indicate the available number of resources in the device.
+		"Available" here means resources that are not currently in use
+		by an application or, in the case of a physical function
+		device, assigned to a virtual function.
+
+		num_atomic_inflights:  Available number of atomic inflights in
+				       the device.
+
+		num_dir_ports:	       Available number of directed ports (and
+				       queues) in the device.
+
+		num_hist_list_entries: Available number of history list entries
+				       in the device.
+
+		num_ldb_credits:       Available number of load-balanced credits
+				       in the device.
+
+		num_ldb_ports:	       Available number of load-balanced ports
+				       in the device.
+
+		num_cos<M>_ldb_ports:  Available number of load-balanced ports
+				       belonging to class-of-service M in the
+				       device.
+
+		num_ldb_queues:	       Available number of load-balanced queues
+				       in the device.
+
+		num_sched_domains:     Available number of scheduling domains in
+				       the device.
+
+		max_ctg_hl_entries:    Maximum contiguous history list entries
+				       available in the device.
+
+				       Each scheduling domain is created with
+				       an allocation of history list entries,
+				       and each domain's allocation of entries
+				       must be contiguous.
+
+What:		/sys/bus/pci/devices/.../cos_bw/cos<N>_bw_percent
+Date:		June 22, 2020
+KernelVersion:	5.9
+Contact:	gage.eads@intel.com
+Description:	Interface for configuring dlb2 class-of-service bandwidths.
+
+		The DLB 2.0 supports four load-balanced port classes of service
+		(CoS). Each CoS receives a guaranteed percentage of the
+		load-balanced scheduler's bandwidth, and any unreserved
+		bandwidth is divided among the four CoS.
+
+		By default, each CoS is guaranteed 25% of the bandwidth. Writing
+		these files allows the user to change the CoS, subject to the
+		constraint that the total reserved bandwidth of all CoS cannot
+		exceed 100%.
+
+		Bandwidth reservations can be modified during run-time.
+
+		These files are only accessible for physical function DLB 2.0
+		devices.
+
+What:		/sys/bus/pci/devices/.../dev_id
+Date:		June 22, 2020
+KernelVersion:	5.9
+Contact:	gage.eads@intel.com
+Description:	Device ID used in /dev, i.e. /dev/dlb<device ID>
+
+		Each DLB 2.0 PF and VF device is granted a unique ID by the
+		kernel driver, and this ID is used to construct the device's
+		/dev directory: /dev/dlb<device ID>. This sysfs file can be read
+		to determine a device's ID, which allows the user to map a
+		device file to a PCI BDF.
diff --git a/drivers/misc/dlb2/dlb2_main.c b/drivers/misc/dlb2/dlb2_main.c
index bc065788061a..b000319599aa 100644
--- a/drivers/misc/dlb2/dlb2_main.c
+++ b/drivers/misc/dlb2/dlb2_main.c
@@ -603,6 +603,10 @@ static int dlb2_probe(struct pci_dev *pdev,
 	if (ret)
 		goto dma_set_mask_fail;
 
+	ret = dlb2_dev->ops->sysfs_create(dlb2_dev);
+	if (ret)
+		goto sysfs_create_fail;
+
 	/*
 	 * PM enable must be done before any other MMIO accesses, and this
 	 * setting is persistent across device reset.
@@ -653,6 +657,8 @@ static int dlb2_probe(struct pci_dev *pdev,
 init_interrupts_fail:
 dlb2_reset_fail:
 wait_for_device_ready_fail:
+	dlb2_dev->ops->sysfs_destroy(dlb2_dev);
+sysfs_create_fail:
 dma_set_mask_fail:
 	dlb2_dev->ops->device_destroy(dlb2_dev, dlb2_class);
 device_add_fail:
@@ -694,6 +700,8 @@ static void dlb2_remove(struct pci_dev *pdev)
 
 	dlb2_release_device_memory(dlb2_dev);
 
+	dlb2_dev->ops->sysfs_destroy(dlb2_dev);
+
 	dlb2_dev->ops->device_destroy(dlb2_dev, dlb2_class);
 
 	dlb2_dev->ops->cdev_del(dlb2_dev);
@@ -719,6 +727,9 @@ static void dlb2_reset_hardware_state(struct dlb2_dev *dev, bool issue_flr)
 	/* Reinitialize interrupt configuration */
 	dev->ops->reinit_interrupts(dev);
 
+	/* Reset configuration done through the sysfs */
+	dev->ops->sysfs_reapply(dev);
+
 	/* Reinitialize any other hardware state */
 	dev->ops->init_hardware(dev);
 }
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index 45050403a4be..ab8cebe6220f 100644
--- a/drivers/misc/dlb2/dlb2_main.h
+++ b/drivers/misc/dlb2/dlb2_main.h
@@ -57,6 +57,9 @@ struct dlb2_device_ops {
 			dev_t base,
 			const struct file_operations *fops);
 	void (*cdev_del)(struct dlb2_dev *dlb2_dev);
+	int (*sysfs_create)(struct dlb2_dev *dlb2_dev);
+	void (*sysfs_destroy)(struct dlb2_dev *dlb2_dev);
+	void (*sysfs_reapply)(struct dlb2_dev *dev);
 	int (*init_interrupts)(struct dlb2_dev *dev, struct pci_dev *pdev);
 	int (*enable_ldb_cq_interrupts)(struct dlb2_dev *dev,
 					int domain_id,
diff --git a/drivers/misc/dlb2/dlb2_pf_ops.c b/drivers/misc/dlb2/dlb2_pf_ops.c
index 771fd793870b..4f0f0e41ab8d 100644
--- a/drivers/misc/dlb2/dlb2_pf_ops.c
+++ b/drivers/misc/dlb2/dlb2_pf_ops.c
@@ -416,6 +416,426 @@ dlb2_pf_init_hardware(struct dlb2_dev *dlb2_dev)
 }
 
 /*****************************/
+/****** Sysfs callbacks ******/
+/*****************************/
+
+#define DLB2_TOTAL_SYSFS_SHOW(name, macro)		\
+static ssize_t total_##name##_show(			\
+	struct device *dev,				\
+	struct device_attribute *attr,			\
+	char *buf)					\
+{							\
+	int val = DLB2_MAX_NUM_##macro;			\
+							\
+	return scnprintf(buf, PAGE_SIZE, "%d\n", val);	\
+}
+
+DLB2_TOTAL_SYSFS_SHOW(num_sched_domains, DOMAINS)
+DLB2_TOTAL_SYSFS_SHOW(num_ldb_queues, LDB_QUEUES)
+DLB2_TOTAL_SYSFS_SHOW(num_ldb_ports, LDB_PORTS)
+DLB2_TOTAL_SYSFS_SHOW(num_cos0_ldb_ports, LDB_PORTS / DLB2_NUM_COS_DOMAINS)
+DLB2_TOTAL_SYSFS_SHOW(num_cos1_ldb_ports, LDB_PORTS / DLB2_NUM_COS_DOMAINS)
+DLB2_TOTAL_SYSFS_SHOW(num_cos2_ldb_ports, LDB_PORTS / DLB2_NUM_COS_DOMAINS)
+DLB2_TOTAL_SYSFS_SHOW(num_cos3_ldb_ports, LDB_PORTS / DLB2_NUM_COS_DOMAINS)
+DLB2_TOTAL_SYSFS_SHOW(num_dir_ports, DIR_PORTS)
+DLB2_TOTAL_SYSFS_SHOW(num_ldb_credits, LDB_CREDITS)
+DLB2_TOTAL_SYSFS_SHOW(num_dir_credits, DIR_CREDITS)
+DLB2_TOTAL_SYSFS_SHOW(num_atomic_inflights, AQED_ENTRIES)
+DLB2_TOTAL_SYSFS_SHOW(num_hist_list_entries, HIST_LIST_ENTRIES)
+
+#define DLB2_AVAIL_SYSFS_SHOW(name)			     \
+static ssize_t avail_##name##_show(			     \
+	struct device *dev,				     \
+	struct device_attribute *attr,			     \
+	char *buf)					     \
+{							     \
+	struct dlb2_dev *dlb2_dev = dev_get_drvdata(dev);    \
+	struct dlb2_get_num_resources_args arg;		     \
+	struct dlb2_hw *hw = &dlb2_dev->hw;		     \
+	int val;					     \
+							     \
+	mutex_lock(&dlb2_dev->resource_mutex);		     \
+							     \
+	val = dlb2_hw_get_num_resources(hw, &arg, false, 0); \
+							     \
+	mutex_unlock(&dlb2_dev->resource_mutex);	     \
+							     \
+	if (val)					     \
+		return -1;				     \
+							     \
+	val = arg.name;					     \
+							     \
+	return scnprintf(buf, PAGE_SIZE, "%d\n", val);	     \
+}
+
+#define DLB2_AVAIL_SYSFS_SHOW_COS(name, idx)		     \
+static ssize_t avail_##name##_show(			     \
+	struct device *dev,				     \
+	struct device_attribute *attr,			     \
+	char *buf)					     \
+{							     \
+	struct dlb2_dev *dlb2_dev = dev_get_drvdata(dev);    \
+	struct dlb2_get_num_resources_args arg;		     \
+	struct dlb2_hw *hw = &dlb2_dev->hw;		     \
+	int val;					     \
+							     \
+	mutex_lock(&dlb2_dev->resource_mutex);		     \
+							     \
+	val = dlb2_hw_get_num_resources(hw, &arg, false, 0); \
+							     \
+	mutex_unlock(&dlb2_dev->resource_mutex);	     \
+							     \
+	if (val)					     \
+		return -1;				     \
+							     \
+	val = arg.num_cos_ldb_ports[idx];		     \
+							     \
+	return scnprintf(buf, PAGE_SIZE, "%d\n", val);	     \
+}
+
+DLB2_AVAIL_SYSFS_SHOW(num_sched_domains)
+DLB2_AVAIL_SYSFS_SHOW(num_ldb_queues)
+DLB2_AVAIL_SYSFS_SHOW(num_ldb_ports)
+DLB2_AVAIL_SYSFS_SHOW_COS(num_cos0_ldb_ports, 0)
+DLB2_AVAIL_SYSFS_SHOW_COS(num_cos1_ldb_ports, 1)
+DLB2_AVAIL_SYSFS_SHOW_COS(num_cos2_ldb_ports, 2)
+DLB2_AVAIL_SYSFS_SHOW_COS(num_cos3_ldb_ports, 3)
+DLB2_AVAIL_SYSFS_SHOW(num_dir_ports)
+DLB2_AVAIL_SYSFS_SHOW(num_ldb_credits)
+DLB2_AVAIL_SYSFS_SHOW(num_dir_credits)
+DLB2_AVAIL_SYSFS_SHOW(num_atomic_inflights)
+DLB2_AVAIL_SYSFS_SHOW(num_hist_list_entries)
+
+static ssize_t max_ctg_hl_entries_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct dlb2_dev *dlb2_dev = dev_get_drvdata(dev);
+	struct dlb2_get_num_resources_args arg;
+	struct dlb2_hw *hw = &dlb2_dev->hw;
+	int val;
+
+	mutex_lock(&dlb2_dev->resource_mutex);
+
+	val = dlb2_hw_get_num_resources(hw, &arg, false, 0);
+
+	mutex_unlock(&dlb2_dev->resource_mutex);
+
+	if (val)
+		return -1;
+
+	val = arg.max_contiguous_hist_list_entries;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+
+/*
+ * Device attribute name doesn't match the show function name, so we define our
+ * own DEVICE_ATTR macro.
+ */
+#define DLB2_DEVICE_ATTR_RO(_prefix, _name) \
+struct device_attribute dev_attr_##_prefix##_##_name = {\
+	.attr = { .name = __stringify(_name), .mode = 0444 },\
+	.show = _prefix##_##_name##_show,\
+}
+
+static DLB2_DEVICE_ATTR_RO(total, num_sched_domains);
+static DLB2_DEVICE_ATTR_RO(total, num_ldb_queues);
+static DLB2_DEVICE_ATTR_RO(total, num_ldb_ports);
+static DLB2_DEVICE_ATTR_RO(total, num_cos0_ldb_ports);
+static DLB2_DEVICE_ATTR_RO(total, num_cos1_ldb_ports);
+static DLB2_DEVICE_ATTR_RO(total, num_cos2_ldb_ports);
+static DLB2_DEVICE_ATTR_RO(total, num_cos3_ldb_ports);
+static DLB2_DEVICE_ATTR_RO(total, num_dir_ports);
+static DLB2_DEVICE_ATTR_RO(total, num_ldb_credits);
+static DLB2_DEVICE_ATTR_RO(total, num_dir_credits);
+static DLB2_DEVICE_ATTR_RO(total, num_atomic_inflights);
+static DLB2_DEVICE_ATTR_RO(total, num_hist_list_entries);
+
+static struct attribute *dlb2_total_attrs[] = {
+	&dev_attr_total_num_sched_domains.attr,
+	&dev_attr_total_num_ldb_queues.attr,
+	&dev_attr_total_num_ldb_ports.attr,
+	&dev_attr_total_num_cos0_ldb_ports.attr,
+	&dev_attr_total_num_cos1_ldb_ports.attr,
+	&dev_attr_total_num_cos2_ldb_ports.attr,
+	&dev_attr_total_num_cos3_ldb_ports.attr,
+	&dev_attr_total_num_dir_ports.attr,
+	&dev_attr_total_num_ldb_credits.attr,
+	&dev_attr_total_num_dir_credits.attr,
+	&dev_attr_total_num_atomic_inflights.attr,
+	&dev_attr_total_num_hist_list_entries.attr,
+	NULL
+};
+
+static const struct attribute_group dlb2_total_attr_group = {
+	.attrs = dlb2_total_attrs,
+	.name = "total_resources",
+};
+
+static DLB2_DEVICE_ATTR_RO(avail, num_sched_domains);
+static DLB2_DEVICE_ATTR_RO(avail, num_ldb_queues);
+static DLB2_DEVICE_ATTR_RO(avail, num_ldb_ports);
+static DLB2_DEVICE_ATTR_RO(avail, num_cos0_ldb_ports);
+static DLB2_DEVICE_ATTR_RO(avail, num_cos1_ldb_ports);
+static DLB2_DEVICE_ATTR_RO(avail, num_cos2_ldb_ports);
+static DLB2_DEVICE_ATTR_RO(avail, num_cos3_ldb_ports);
+static DLB2_DEVICE_ATTR_RO(avail, num_dir_ports);
+static DLB2_DEVICE_ATTR_RO(avail, num_ldb_credits);
+static DLB2_DEVICE_ATTR_RO(avail, num_dir_credits);
+static DLB2_DEVICE_ATTR_RO(avail, num_atomic_inflights);
+static DLB2_DEVICE_ATTR_RO(avail, num_hist_list_entries);
+static DEVICE_ATTR_RO(max_ctg_hl_entries);
+
+static struct attribute *dlb2_avail_attrs[] = {
+	&dev_attr_avail_num_sched_domains.attr,
+	&dev_attr_avail_num_ldb_queues.attr,
+	&dev_attr_avail_num_ldb_ports.attr,
+	&dev_attr_avail_num_cos0_ldb_ports.attr,
+	&dev_attr_avail_num_cos1_ldb_ports.attr,
+	&dev_attr_avail_num_cos2_ldb_ports.attr,
+	&dev_attr_avail_num_cos3_ldb_ports.attr,
+	&dev_attr_avail_num_dir_ports.attr,
+	&dev_attr_avail_num_ldb_credits.attr,
+	&dev_attr_avail_num_dir_credits.attr,
+	&dev_attr_avail_num_atomic_inflights.attr,
+	&dev_attr_avail_num_hist_list_entries.attr,
+	&dev_attr_max_ctg_hl_entries.attr,
+	NULL
+};
+
+static const struct attribute_group dlb2_avail_attr_group = {
+	.attrs = dlb2_avail_attrs,
+	.name = "avail_resources",
+};
+
+#define DLB2_GROUP_SNS_PER_QUEUE_SHOW(id)	       \
+static ssize_t group##id##_sns_per_queue_show(	       \
+	struct device *dev,			       \
+	struct device_attribute *attr,		       \
+	char *buf)				       \
+{						       \
+	struct dlb2_dev *dlb2_dev =		       \
+		dev_get_drvdata(dev);		       \
+	struct dlb2_hw *hw = &dlb2_dev->hw;	       \
+	int val;				       \
+						       \
+	mutex_lock(&dlb2_dev->resource_mutex);	       \
+						       \
+	val = dlb2_get_group_sequence_numbers(hw, id); \
+						       \
+	mutex_unlock(&dlb2_dev->resource_mutex);       \
+						       \
+	return scnprintf(buf, PAGE_SIZE, "%d\n", val); \
+}
+
+DLB2_GROUP_SNS_PER_QUEUE_SHOW(0)
+DLB2_GROUP_SNS_PER_QUEUE_SHOW(1)
+
+#define DLB2_GROUP_SNS_PER_QUEUE_STORE(id)		    \
+static ssize_t group##id##_sns_per_queue_store(		    \
+	struct device *dev,				    \
+	struct device_attribute *attr,			    \
+	const char *buf,				    \
+	size_t count)					    \
+{							    \
+	struct dlb2_dev *dlb2_dev = dev_get_drvdata(dev);   \
+	struct dlb2_hw *hw = &dlb2_dev->hw;		    \
+	unsigned long val;				    \
+	int err;					    \
+							    \
+	err = kstrtoul(buf, 0, &val);			    \
+	if (err)					    \
+		return -1;				    \
+							    \
+	mutex_lock(&dlb2_dev->resource_mutex);		    \
+							    \
+	err = dlb2_set_group_sequence_numbers(hw, id, val); \
+							    \
+	mutex_unlock(&dlb2_dev->resource_mutex);	    \
+							    \
+	return err ? err : count;			    \
+}
+
+DLB2_GROUP_SNS_PER_QUEUE_STORE(0)
+DLB2_GROUP_SNS_PER_QUEUE_STORE(1)
+
+/* RW sysfs files in the sequence_numbers/ subdirectory */
+static DEVICE_ATTR_RW(group0_sns_per_queue);
+static DEVICE_ATTR_RW(group1_sns_per_queue);
+
+static struct attribute *dlb2_sequence_number_attrs[] = {
+	&dev_attr_group0_sns_per_queue.attr,
+	&dev_attr_group1_sns_per_queue.attr,
+	NULL
+};
+
+static const struct attribute_group dlb2_sequence_number_attr_group = {
+	.attrs = dlb2_sequence_number_attrs,
+	.name = "sequence_numbers"
+};
+
+#define DLB2_COS_BW_PERCENT_SHOW(id)		       \
+static ssize_t cos##id##_bw_percent_show(	       \
+	struct device *dev,			       \
+	struct device_attribute *attr,		       \
+	char *buf)				       \
+{						       \
+	struct dlb2_dev *dlb2_dev =		       \
+		dev_get_drvdata(dev);		       \
+	struct dlb2_hw *hw = &dlb2_dev->hw;	       \
+	int val;				       \
+						       \
+	mutex_lock(&dlb2_dev->resource_mutex);	       \
+						       \
+	val = dlb2_hw_get_cos_bandwidth(hw, id);       \
+						       \
+	mutex_unlock(&dlb2_dev->resource_mutex);       \
+						       \
+	return scnprintf(buf, PAGE_SIZE, "%d\n", val); \
+}
+
+DLB2_COS_BW_PERCENT_SHOW(0)
+DLB2_COS_BW_PERCENT_SHOW(1)
+DLB2_COS_BW_PERCENT_SHOW(2)
+DLB2_COS_BW_PERCENT_SHOW(3)
+
+#define DLB2_COS_BW_PERCENT_STORE(id)		      \
+static ssize_t cos##id##_bw_percent_store(	      \
+	struct device *dev,			      \
+	struct device_attribute *attr,		      \
+	const char *buf,			      \
+	size_t count)				      \
+{						      \
+	struct dlb2_dev *dlb2_dev =		      \
+		dev_get_drvdata(dev);		      \
+	struct dlb2_hw *hw = &dlb2_dev->hw;	      \
+	unsigned long val;			      \
+	int err;				      \
+						      \
+	err = kstrtoul(buf, 0, &val);		      \
+	if (err)				      \
+		return -1;			      \
+						      \
+	mutex_lock(&dlb2_dev->resource_mutex);	      \
+						      \
+	err = dlb2_hw_set_cos_bandwidth(hw, id, val); \
+						      \
+	mutex_unlock(&dlb2_dev->resource_mutex);      \
+						      \
+	return err ? err : count;		      \
+}
+
+DLB2_COS_BW_PERCENT_STORE(0)
+DLB2_COS_BW_PERCENT_STORE(1)
+DLB2_COS_BW_PERCENT_STORE(2)
+DLB2_COS_BW_PERCENT_STORE(3)
+
+/* RW sysfs files in the sequence_numbers/ subdirectory */
+static DEVICE_ATTR_RW(cos0_bw_percent);
+static DEVICE_ATTR_RW(cos1_bw_percent);
+static DEVICE_ATTR_RW(cos2_bw_percent);
+static DEVICE_ATTR_RW(cos3_bw_percent);
+
+static struct attribute *dlb2_cos_bw_percent_attrs[] = {
+	&dev_attr_cos0_bw_percent.attr,
+	&dev_attr_cos1_bw_percent.attr,
+	&dev_attr_cos2_bw_percent.attr,
+	&dev_attr_cos3_bw_percent.attr,
+	NULL
+};
+
+static const struct attribute_group dlb2_cos_bw_percent_attr_group = {
+	.attrs = dlb2_cos_bw_percent_attrs,
+	.name = "cos_bw"
+};
+
+static ssize_t dev_id_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct dlb2_dev *dlb2_dev = dev_get_drvdata(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", dlb2_dev->id);
+}
+
+static DEVICE_ATTR_RO(dev_id);
+
+static int
+dlb2_pf_sysfs_create(struct dlb2_dev *dlb2_dev)
+{
+	struct kobject *kobj;
+	int ret;
+
+	kobj = &dlb2_dev->pdev->dev.kobj;
+
+	ret = sysfs_create_file(kobj, &dev_attr_dev_id.attr);
+	if (ret)
+		goto dlb2_dev_id_attr_group_fail;
+
+	ret = sysfs_create_group(kobj, &dlb2_total_attr_group);
+	if (ret)
+		goto dlb2_total_attr_group_fail;
+
+	ret = sysfs_create_group(kobj, &dlb2_avail_attr_group);
+	if (ret)
+		goto dlb2_avail_attr_group_fail;
+
+	ret = sysfs_create_group(kobj, &dlb2_sequence_number_attr_group);
+	if (ret)
+		goto dlb2_sn_attr_group_fail;
+
+	ret = sysfs_create_group(kobj, &dlb2_cos_bw_percent_attr_group);
+	if (ret)
+		goto dlb2_cos_bw_percent_attr_group_fail;
+
+	return 0;
+
+dlb2_cos_bw_percent_attr_group_fail:
+	sysfs_remove_group(kobj, &dlb2_sequence_number_attr_group);
+dlb2_sn_attr_group_fail:
+	sysfs_remove_group(kobj, &dlb2_avail_attr_group);
+dlb2_avail_attr_group_fail:
+	sysfs_remove_group(kobj, &dlb2_total_attr_group);
+dlb2_total_attr_group_fail:
+	sysfs_remove_file(kobj, &dev_attr_dev_id.attr);
+dlb2_dev_id_attr_group_fail:
+	return ret;
+}
+
+static void
+dlb2_pf_sysfs_destroy(struct dlb2_dev *dlb2_dev)
+{
+	struct kobject *kobj;
+
+	kobj = &dlb2_dev->pdev->dev.kobj;
+
+	sysfs_remove_group(kobj, &dlb2_cos_bw_percent_attr_group);
+	sysfs_remove_group(kobj, &dlb2_sequence_number_attr_group);
+	sysfs_remove_group(kobj, &dlb2_avail_attr_group);
+	sysfs_remove_group(kobj, &dlb2_total_attr_group);
+	sysfs_remove_file(kobj, &dev_attr_dev_id.attr);
+}
+
+static void
+dlb2_pf_sysfs_reapply_configuration(struct dlb2_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < DLB2_MAX_NUM_SEQUENCE_NUMBER_GROUPS; i++) {
+		int num_sns = dlb2_get_group_sequence_numbers(&dev->hw, i);
+
+		dlb2_set_group_sequence_numbers(&dev->hw, i, num_sns);
+	}
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		int bw = dlb2_hw_get_cos_bandwidth(&dev->hw, i);
+
+		dlb2_hw_set_cos_bandwidth(&dev->hw, i, bw);
+	}
+}
+
+/*****************************/
 /****** IOCTL callbacks ******/
 /*****************************/
 
@@ -649,6 +1069,9 @@ struct dlb2_device_ops dlb2_pf_ops = {
 	.device_destroy = dlb2_pf_device_destroy,
 	.cdev_add = dlb2_pf_cdev_add,
 	.cdev_del = dlb2_pf_cdev_del,
+	.sysfs_create = dlb2_pf_sysfs_create,
+	.sysfs_destroy = dlb2_pf_sysfs_destroy,
+	.sysfs_reapply = dlb2_pf_sysfs_reapply_configuration,
 	.init_interrupts = dlb2_pf_init_interrupts,
 	.enable_ldb_cq_interrupts = dlb2_pf_enable_ldb_cq_interrupts,
 	.enable_dir_cq_interrupts = dlb2_pf_enable_dir_cq_interrupts,
-- 
2.13.6

