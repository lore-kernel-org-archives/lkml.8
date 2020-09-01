Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42DFC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C0BF20767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbgIATVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:21:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:26016 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbgIATVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:21:35 -0400
IronPort-SDR: UyMh0sU6xUzNeZgjplgIGueUhJIXDmexn3rV81uVM9IzZS4RJJ5vMiiybToQPl+hjKcI+cUW69
 slEPnSrfa95g==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="144995650"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="144995650"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:21:28 -0700
IronPort-SDR: 6QGVQN8ISHZdA0h9VQvJyDudm33rkJN6DOg4xN/7QxCl1L7nmQN6mx+FkiLb9gu/Y7pBZyFnV/
 YmVLCE4WW0lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="325480448"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2020 12:21:28 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH v3 03/19] dlb2: add resource and device initialization
Date:   Tue,  1 Sep 2020 14:15:32 -0500
Message-Id: <20200901191548.31646-4-gage.eads@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20200901191548.31646-1-gage.eads@intel.com>
References: <20200901191548.31646-1-gage.eads@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the hardware resource data structures and functions for
their initialization/teardown and for device power-on. In subsequent
commits, dlb2_resource.c will be expanded to hold the dlb2
resource-management and configuration logic (using the data structures
defined in dlb2_hw_types.h).

This commit also introduces dlb2_bitmap_* functions, a thin convenience
layer wrapping the Linux bitmap interfaces, used by the bitmaps in the dlb2
hardware types.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/misc/dlb2/Makefile        |   7 +-
 drivers/misc/dlb2/dlb2_bitmap.h   | 121 +++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_hw_types.h | 173 +++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_main.c     |  51 ++++++++++
 drivers/misc/dlb2/dlb2_main.h     |  11 +++
 drivers/misc/dlb2/dlb2_pf_ops.c   |  68 +++++++++++++
 drivers/misc/dlb2/dlb2_regs.h     |  83 ++++++++++++++++
 drivers/misc/dlb2/dlb2_resource.c | 197 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_resource.h |  46 +++++++++
 9 files changed, 754 insertions(+), 3 deletions(-)
 create mode 100644 drivers/misc/dlb2/dlb2_bitmap.h
 create mode 100644 drivers/misc/dlb2/dlb2_regs.h
 create mode 100644 drivers/misc/dlb2/dlb2_resource.c
 create mode 100644 drivers/misc/dlb2/dlb2_resource.h

diff --git a/drivers/misc/dlb2/Makefile b/drivers/misc/dlb2/Makefile
index 95e67e5bd8ff..4fdf7ffc555b 100644
--- a/drivers/misc/dlb2/Makefile
+++ b/drivers/misc/dlb2/Makefile
@@ -4,6 +4,7 @@
 
 obj-$(CONFIG_INTEL_DLB2) := dlb2.o
 
-dlb2-objs :=    \
-  dlb2_main.o   \
-  dlb2_pf_ops.o \
+dlb2-objs :=      \
+  dlb2_main.o     \
+  dlb2_pf_ops.o   \
+  dlb2_resource.o \
diff --git a/drivers/misc/dlb2/dlb2_bitmap.h b/drivers/misc/dlb2/dlb2_bitmap.h
new file mode 100644
index 000000000000..c5bb4ba84d5c
--- /dev/null
+++ b/drivers/misc/dlb2/dlb2_bitmap.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ * Copyright(c) 2017-2020 Intel Corporation
+ */
+
+#ifndef __DLB2_OSDEP_BITMAP_H
+#define __DLB2_OSDEP_BITMAP_H
+
+#include <linux/bitmap.h>
+#include <linux/slab.h>
+
+#include "dlb2_main.h"
+
+/*************************/
+/*** Bitmap operations ***/
+/*************************/
+struct dlb2_bitmap {
+	unsigned long *map;
+	unsigned int len;
+};
+
+/**
+ * dlb2_bitmap_alloc() - alloc a bitmap data structure
+ * @bitmap: pointer to dlb2_bitmap structure pointer.
+ * @len: number of entries in the bitmap.
+ *
+ * This function allocates a bitmap and initializes it with length @len. All
+ * entries are initially zero.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise.
+ *
+ * Errors:
+ * EINVAL - bitmap is NULL or len is 0.
+ * ENOMEM - could not allocate memory for the bitmap data structure.
+ */
+static inline int dlb2_bitmap_alloc(struct dlb2_bitmap **bitmap,
+				    unsigned int len)
+{
+	struct dlb2_bitmap *bm;
+
+	if (!bitmap || len == 0)
+		return -EINVAL;
+
+	bm = kzalloc(sizeof(*bm), GFP_KERNEL);
+	if (!bm)
+		return -ENOMEM;
+
+	bm->map = kcalloc(BITS_TO_LONGS(len), sizeof(*bm->map), GFP_KERNEL);
+	if (!bm->map) {
+		kfree(bm);
+		return -ENOMEM;
+	}
+
+	bm->len = len;
+
+	*bitmap = bm;
+
+	return 0;
+}
+
+/**
+ * dlb2_bitmap_free() - free a previously allocated bitmap data structure
+ * @bitmap: pointer to dlb2_bitmap structure.
+ *
+ * This function frees a bitmap that was allocated with dlb2_bitmap_alloc().
+ */
+static inline void dlb2_bitmap_free(struct dlb2_bitmap *bitmap)
+{
+	if (!bitmap)
+		return;
+
+	kfree(bitmap->map);
+
+	kfree(bitmap);
+}
+
+/**
+ * dlb2_bitmap_fill() - fill a bitmap with all 1s
+ * @bitmap: pointer to dlb2_bitmap structure.
+ *
+ * This function sets all bitmap values to 1.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise.
+ *
+ * Errors:
+ * EINVAL - bitmap is NULL or is uninitialized.
+ */
+static inline int dlb2_bitmap_fill(struct dlb2_bitmap *bitmap)
+{
+	if (!bitmap || !bitmap->map)
+		return -EINVAL;
+
+	bitmap_fill(bitmap->map, bitmap->len);
+
+	return 0;
+}
+
+/**
+ * dlb2_bitmap_zero() - fill a bitmap with all 0s
+ * @bitmap: pointer to dlb2_bitmap structure.
+ *
+ * This function sets all bitmap values to 0.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise.
+ *
+ * Errors:
+ * EINVAL - bitmap is NULL or is uninitialized.
+ */
+static inline int dlb2_bitmap_zero(struct dlb2_bitmap *bitmap)
+{
+	if (!bitmap || !bitmap->map)
+		return -EINVAL;
+
+	bitmap_zero(bitmap->map, bitmap->len);
+
+	return 0;
+}
+
+#endif /*  __DLB2_OSDEP_BITMAP_H */
diff --git a/drivers/misc/dlb2/dlb2_hw_types.h b/drivers/misc/dlb2/dlb2_hw_types.h
index 10b26356535f..0db398aeccd5 100644
--- a/drivers/misc/dlb2/dlb2_hw_types.h
+++ b/drivers/misc/dlb2/dlb2_hw_types.h
@@ -6,6 +6,9 @@
 #define __DLB2_HW_TYPES_H
 
 #include <linux/io.h>
+#include <linux/types.h>
+
+#include "dlb2_bitmap.h"
 
 #define DLB2_PCI_REG_READ(addr)        ioread32(addr)
 #define DLB2_PCI_REG_WRITE(reg, value) iowrite32(value, reg)
@@ -45,6 +48,169 @@
 #define DLB2_MAX_QID_EMPTY_CHECK_LOOPS		(32 * 64 * 1024 * (800 / 30))
 #define DLB2_HZ					800000000
 
+struct dlb2_resource_id {
+	u32 phys_id;
+	u32 virt_id;
+	u8 vdev_owned;
+	u8 vdev_id;
+};
+
+struct dlb2_freelist {
+	u32 base;
+	u32 bound;
+	u32 offset;
+};
+
+static inline u32 dlb2_freelist_count(struct dlb2_freelist *list)
+{
+	return list->bound - list->base - list->offset;
+}
+
+struct dlb2_ldb_queue {
+	struct list_head domain_list;
+	struct list_head func_list;
+	struct dlb2_resource_id id;
+	struct dlb2_resource_id domain_id;
+	u32 num_qid_inflights;
+	u32 aqed_limit;
+	u32 sn_group; /* sn == sequence number */
+	u32 sn_slot;
+	u32 num_mappings;
+	u8 sn_cfg_valid;
+	u8 num_pending_additions;
+	u8 owned;
+	u8 configured;
+};
+
+/*
+ * Directed ports and queues are paired by nature, so the driver tracks them
+ * with a single data structure.
+ */
+struct dlb2_dir_pq_pair {
+	struct list_head domain_list;
+	struct list_head func_list;
+	struct dlb2_resource_id id;
+	struct dlb2_resource_id domain_id;
+	u32 ref_cnt;
+	u8 init_tkn_cnt;
+	u8 queue_configured;
+	u8 port_configured;
+	u8 owned;
+	u8 enabled;
+};
+
+enum dlb2_qid_map_state {
+	/* The slot doesn't contain a valid queue mapping */
+	DLB2_QUEUE_UNMAPPED,
+	/* The slot contains a valid queue mapping */
+	DLB2_QUEUE_MAPPED,
+	/* The driver is mapping a queue into this slot */
+	DLB2_QUEUE_MAP_IN_PROG,
+	/* The driver is unmapping a queue from this slot */
+	DLB2_QUEUE_UNMAP_IN_PROG,
+	/*
+	 * The driver is unmapping a queue from this slot, and once complete
+	 * will replace it with another mapping.
+	 */
+	DLB2_QUEUE_UNMAP_IN_PROG_PENDING_MAP,
+};
+
+struct dlb2_ldb_port_qid_map {
+	enum dlb2_qid_map_state state;
+	u16 qid;
+	u16 pending_qid;
+	u8 priority;
+	u8 pending_priority;
+};
+
+struct dlb2_ldb_port {
+	struct list_head domain_list;
+	struct list_head func_list;
+	struct dlb2_resource_id id;
+	struct dlb2_resource_id domain_id;
+	/* The qid_map represents the hardware QID mapping state. */
+	struct dlb2_ldb_port_qid_map qid_map[DLB2_MAX_NUM_QIDS_PER_LDB_CQ];
+	u32 hist_list_entry_base;
+	u32 hist_list_entry_limit;
+	u32 ref_cnt;
+	u8 init_tkn_cnt;
+	u8 num_pending_removals;
+	u8 num_mappings;
+	u8 owned;
+	u8 enabled;
+	u8 configured;
+};
+
+struct dlb2_sn_group {
+	u32 mode;
+	u32 sequence_numbers_per_queue;
+	u32 slot_use_bitmap;
+	u32 id;
+};
+
+struct dlb2_hw_domain {
+	struct dlb2_function_resources *parent_func;
+	struct list_head func_list;
+	struct list_head used_ldb_queues;
+	struct list_head used_ldb_ports[DLB2_NUM_COS_DOMAINS];
+	struct list_head used_dir_pq_pairs;
+	struct list_head avail_ldb_queues;
+	struct list_head avail_ldb_ports[DLB2_NUM_COS_DOMAINS];
+	struct list_head avail_dir_pq_pairs;
+	u32 total_hist_list_entries;
+	u32 avail_hist_list_entries;
+	u32 hist_list_entry_base;
+	u32 hist_list_entry_offset;
+	u32 num_ldb_credits;
+	u32 num_dir_credits;
+	u32 num_avail_aqed_entries;
+	u32 num_used_aqed_entries;
+	struct dlb2_resource_id id;
+	int num_pending_removals;
+	int num_pending_additions;
+	u8 configured;
+	u8 started;
+};
+
+struct dlb2_function_resources {
+	struct list_head avail_domains;
+	struct list_head used_domains;
+	struct list_head avail_ldb_queues;
+	struct list_head avail_ldb_ports[DLB2_NUM_COS_DOMAINS];
+	struct list_head avail_dir_pq_pairs;
+	struct dlb2_bitmap *avail_hist_list_entries;
+	u32 num_avail_domains;
+	u32 num_avail_ldb_queues;
+	u32 num_avail_ldb_ports[DLB2_NUM_COS_DOMAINS];
+	u32 num_avail_dir_pq_pairs;
+	u32 num_avail_qed_entries;
+	u32 num_avail_dqed_entries;
+	u32 num_avail_aqed_entries;
+	u8 locked; /* (VDEV only) */
+};
+
+/*
+ * After initialization, each resource in dlb2_hw_resources is located in one
+ * of the following lists:
+ * -- The PF's available resources list. These are unconfigured resources owned
+ *	by the PF and not allocated to a dlb2 scheduling domain.
+ * -- A VDEV's available resources list. These are VDEV-owned unconfigured
+ *	resources not allocated to a dlb2 scheduling domain.
+ * -- A domain's available resources list. These are domain-owned unconfigured
+ *	resources.
+ * -- A domain's used resources list. These are are domain-owned configured
+ *	resources.
+ *
+ * A resource moves to a new list when a VDEV or domain is created or destroyed,
+ * or when the resource is configured.
+ */
+struct dlb2_hw_resources {
+	struct dlb2_ldb_queue ldb_queues[DLB2_MAX_NUM_LDB_QUEUES];
+	struct dlb2_ldb_port ldb_ports[DLB2_MAX_NUM_LDB_PORTS];
+	struct dlb2_dir_pq_pair dir_pq_pairs[DLB2_MAX_NUM_DIR_PORTS];
+	struct dlb2_sn_group sn_groups[DLB2_MAX_NUM_SEQUENCE_NUMBER_GROUPS];
+};
+
 struct dlb2_hw {
 	/* BAR 0 address */
 	void __iomem *csr_kva;
@@ -52,6 +218,13 @@ struct dlb2_hw {
 	/* BAR 2 address */
 	void __iomem *func_kva;
 	unsigned long func_phys_addr;
+
+	/* Resource tracking */
+	struct dlb2_hw_resources rsrcs;
+	struct dlb2_function_resources pf;
+	struct dlb2_function_resources vdev[DLB2_MAX_NUM_VDEVS];
+	struct dlb2_hw_domain domains[DLB2_MAX_NUM_DOMAINS];
+	u8 cos_reservation[DLB2_NUM_COS_DOMAINS];
 };
 
 #endif /* __DLB2_HW_TYPES_H */
diff --git a/drivers/misc/dlb2/dlb2_main.c b/drivers/misc/dlb2/dlb2_main.c
index 5d530ea862a3..f6d78d1532b0 100644
--- a/drivers/misc/dlb2/dlb2_main.c
+++ b/drivers/misc/dlb2/dlb2_main.c
@@ -12,6 +12,7 @@
 #include <linux/uaccess.h>
 
 #include "dlb2_main.h"
+#include "dlb2_resource.h"
 
 static const char
 dlb2_driver_copyright[] = "Copyright(c) 2018-2020 Intel Corporation";
@@ -27,6 +28,23 @@ static struct list_head dlb2_dev_list = LIST_HEAD_INIT(dlb2_dev_list);
 static struct class *dlb2_class;
 static dev_t dlb2_dev_number_base;
 
+static int dlb2_reset_device(struct pci_dev *pdev)
+{
+	int ret;
+
+	ret = pci_save_state(pdev);
+	if (ret)
+		return ret;
+
+	ret = __pci_reset_function_locked(pdev);
+	if (ret)
+		return ret;
+
+	pci_restore_state(pdev);
+
+	return 0;
+}
+
 /*****************************/
 /****** Devfs callbacks ******/
 /*****************************/
@@ -137,12 +155,41 @@ static int dlb2_probe(struct pci_dev *pdev,
 	if (ret)
 		goto dma_set_mask_fail;
 
+	/*
+	 * PM enable must be done before any other MMIO accesses, and this
+	 * setting is persistent across device reset.
+	 */
+	dlb2_dev->ops->enable_pm(dlb2_dev);
+
+	ret = dlb2_dev->ops->wait_for_device_ready(dlb2_dev, pdev);
+	if (ret)
+		goto wait_for_device_ready_fail;
+
+	ret = dlb2_reset_device(pdev);
+	if (ret)
+		goto dlb2_reset_fail;
+
+	ret = dlb2_resource_init(&dlb2_dev->hw);
+	if (ret)
+		goto resource_init_fail;
+
+	ret = dlb2_dev->ops->init_driver_state(dlb2_dev);
+	if (ret)
+		goto init_driver_state_fail;
+
+	dlb2_dev->ops->init_hardware(dlb2_dev);
+
 	mutex_lock(&dlb2_driver_lock);
 	list_add(&dlb2_dev->list, &dlb2_dev_list);
 	mutex_unlock(&dlb2_driver_lock);
 
 	return 0;
 
+init_driver_state_fail:
+	dlb2_resource_free(&dlb2_dev->hw);
+resource_init_fail:
+dlb2_reset_fail:
+wait_for_device_ready_fail:
 dma_set_mask_fail:
 	dlb2_dev->ops->device_destroy(dlb2_dev, dlb2_class);
 device_add_fail:
@@ -172,6 +219,10 @@ static void dlb2_remove(struct pci_dev *pdev)
 	list_del(&dlb2_dev->list);
 	mutex_unlock(&dlb2_driver_lock);
 
+	dlb2_dev->ops->free_driver_state(dlb2_dev);
+
+	dlb2_resource_free(&dlb2_dev->hw);
+
 	dlb2_dev->ops->device_destroy(dlb2_dev, dlb2_class);
 
 	dlb2_dev->ops->cdev_del(dlb2_dev);
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index 7d04e0d8869d..115cfadc0f12 100644
--- a/drivers/misc/dlb2/dlb2_main.h
+++ b/drivers/misc/dlb2/dlb2_main.h
@@ -39,6 +39,8 @@ struct dlb2_device_ops {
 	int (*map_pci_bar_space)(struct dlb2_dev *dev, struct pci_dev *pdev);
 	void (*unmap_pci_bar_space)(struct dlb2_dev *dev,
 				    struct pci_dev *pdev);
+	int (*init_driver_state)(struct dlb2_dev *dev);
+	void (*free_driver_state)(struct dlb2_dev *dev);
 	int (*device_create)(struct dlb2_dev *dlb2_dev,
 			     struct pci_dev *pdev,
 			     struct class *dlb2_class);
@@ -48,6 +50,10 @@ struct dlb2_device_ops {
 			dev_t base,
 			const struct file_operations *fops);
 	void (*cdev_del)(struct dlb2_dev *dlb2_dev);
+	void (*enable_pm)(struct dlb2_dev *dev);
+	int (*wait_for_device_ready)(struct dlb2_dev *dev,
+				     struct pci_dev *pdev);
+	void (*init_hardware)(struct dlb2_dev *dev);
 };
 
 extern struct dlb2_device_ops dlb2_pf_ops;
@@ -59,6 +65,11 @@ struct dlb2_dev {
 	struct dlb2_device_ops *ops;
 	struct list_head list;
 	struct device *dlb2_device;
+	/*
+	 * The resource mutex serializes access to driver data structures and
+	 * hardware registers.
+	 */
+	struct mutex resource_mutex;
 	enum dlb2_device_type type;
 	int id;
 	dev_t dev_number;
diff --git a/drivers/misc/dlb2/dlb2_pf_ops.c b/drivers/misc/dlb2/dlb2_pf_ops.c
index 7920e491110f..cc35c3537507 100644
--- a/drivers/misc/dlb2/dlb2_pf_ops.c
+++ b/drivers/misc/dlb2/dlb2_pf_ops.c
@@ -1,7 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2017-2020 Intel Corporation */
 
+#include <linux/delay.h>
+
 #include "dlb2_main.h"
+#include "dlb2_regs.h"
+#include "dlb2_resource.h"
 
 /********************************/
 /****** PCI BAR management ******/
@@ -50,6 +54,19 @@ dlb2_pf_map_pci_bar_space(struct dlb2_dev *dlb2_dev,
 /*******************************/
 
 static int
+dlb2_pf_init_driver_state(struct dlb2_dev *dlb2_dev)
+{
+	mutex_init(&dlb2_dev->resource_mutex);
+
+	return 0;
+}
+
+static void
+dlb2_pf_free_driver_state(struct dlb2_dev *dlb2_dev)
+{
+}
+
+static int
 dlb2_pf_cdev_add(struct dlb2_dev *dlb2_dev,
 		 dev_t base,
 		 const struct file_operations *fops)
@@ -112,6 +129,52 @@ dlb2_pf_device_destroy(struct dlb2_dev *dlb2_dev,
 	device_destroy(dlb2_class, dlb2_dev->dev_number);
 }
 
+static void
+dlb2_pf_enable_pm(struct dlb2_dev *dlb2_dev)
+{
+	dlb2_clr_pmcsr_disable(&dlb2_dev->hw);
+}
+
+#define DLB2_READY_RETRY_LIMIT 1000
+static int
+dlb2_pf_wait_for_device_ready(struct dlb2_dev *dlb2_dev,
+			      struct pci_dev *pdev)
+{
+	u32 retries = DLB2_READY_RETRY_LIMIT;
+
+	/* Allow at least 1s for the device to become active after power-on */
+	do {
+		union dlb2_cfg_mstr_cfg_diagnostic_idle_status idle;
+		union dlb2_cfg_mstr_cfg_pm_status pm_st;
+		u32 addr;
+
+		addr = DLB2_CFG_MSTR_CFG_PM_STATUS;
+
+		pm_st.val = DLB2_CSR_RD(&dlb2_dev->hw, addr);
+
+		addr = DLB2_CFG_MSTR_CFG_DIAGNOSTIC_IDLE_STATUS;
+
+		idle.val = DLB2_CSR_RD(&dlb2_dev->hw, addr);
+
+		if (pm_st.field.pmsm == 1 && idle.field.dlb_func_idle == 1)
+			break;
+
+		usleep_range(1000, 2000);
+	} while (--retries);
+
+	if (!retries) {
+		dev_err(&pdev->dev, "Device idle test failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void
+dlb2_pf_init_hardware(struct dlb2_dev *dlb2_dev)
+{
+}
+
 /********************************/
 /****** DLB2 PF Device Ops ******/
 /********************************/
@@ -119,8 +182,13 @@ dlb2_pf_device_destroy(struct dlb2_dev *dlb2_dev,
 struct dlb2_device_ops dlb2_pf_ops = {
 	.map_pci_bar_space = dlb2_pf_map_pci_bar_space,
 	.unmap_pci_bar_space = dlb2_pf_unmap_pci_bar_space,
+	.init_driver_state = dlb2_pf_init_driver_state,
+	.free_driver_state = dlb2_pf_free_driver_state,
 	.device_create = dlb2_pf_device_create,
 	.device_destroy = dlb2_pf_device_destroy,
 	.cdev_add = dlb2_pf_cdev_add,
 	.cdev_del = dlb2_pf_cdev_del,
+	.enable_pm = dlb2_pf_enable_pm,
+	.wait_for_device_ready = dlb2_pf_wait_for_device_ready,
+	.init_hardware = dlb2_pf_init_hardware,
 };
diff --git a/drivers/misc/dlb2/dlb2_regs.h b/drivers/misc/dlb2/dlb2_regs.h
new file mode 100644
index 000000000000..b1a3ef2f4537
--- /dev/null
+++ b/drivers/misc/dlb2/dlb2_regs.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ * Copyright(c) 2016-2020 Intel Corporation
+ */
+
+#ifndef __DLB2_REGS_H
+#define __DLB2_REGS_H
+
+#include "linux/types.h"
+
+#define DLB2_CFG_MSTR_CFG_DIAGNOSTIC_IDLE_STATUS 0xb4000004
+#define DLB2_CFG_MSTR_CFG_DIAGNOSTIC_IDLE_STATUS_RST 0x9d0fffff
+union dlb2_cfg_mstr_cfg_diagnostic_idle_status {
+	struct {
+		u32 chp_pipeidle : 1;
+		u32 rop_pipeidle : 1;
+		u32 lsp_pipeidle : 1;
+		u32 nalb_pipeidle : 1;
+		u32 ap_pipeidle : 1;
+		u32 dp_pipeidle : 1;
+		u32 qed_pipeidle : 1;
+		u32 dqed_pipeidle : 1;
+		u32 aqed_pipeidle : 1;
+		u32 sys_pipeidle : 1;
+		u32 chp_unit_idle : 1;
+		u32 rop_unit_idle : 1;
+		u32 lsp_unit_idle : 1;
+		u32 nalb_unit_idle : 1;
+		u32 ap_unit_idle : 1;
+		u32 dp_unit_idle : 1;
+		u32 qed_unit_idle : 1;
+		u32 dqed_unit_idle : 1;
+		u32 aqed_unit_idle : 1;
+		u32 sys_unit_idle : 1;
+		u32 rsvd1 : 4;
+		u32 mstr_cfg_ring_idle : 1;
+		u32 mstr_cfg_mstr_idle : 1;
+		u32 mstr_flr_clkreq_b : 1;
+		u32 mstr_proc_idle : 1;
+		u32 mstr_proc_idle_masked : 1;
+		u32 rsvd0 : 2;
+		u32 dlb_func_idle : 1;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CFG_MSTR_CFG_PM_STATUS 0xb4000014
+#define DLB2_CFG_MSTR_CFG_PM_STATUS_RST 0x100403e
+union dlb2_cfg_mstr_cfg_pm_status {
+	struct {
+		u32 prochot : 1;
+		u32 pgcb_dlb_idle : 1;
+		u32 pgcb_dlb_pg_rdy_ack_b : 1;
+		u32 pmsm_pgcb_req_b : 1;
+		u32 pgbc_pmc_pg_req_b : 1;
+		u32 pmc_pgcb_pg_ack_b : 1;
+		u32 pmc_pgcb_fet_en_b : 1;
+		u32 pgcb_fet_en_b : 1;
+		u32 rsvz0 : 1;
+		u32 rsvz1 : 1;
+		u32 fuse_force_on : 1;
+		u32 fuse_proc_disable : 1;
+		u32 rsvz2 : 1;
+		u32 rsvz3 : 1;
+		u32 pm_fsm_d0tod3_ok : 1;
+		u32 pm_fsm_d3tod0_ok : 1;
+		u32 dlb_in_d3 : 1;
+		u32 rsvz4 : 7;
+		u32 pmsm : 8;
+	} field;
+	u32 val;
+};
+
+#define DLB2_CFG_MSTR_CFG_PM_PMCSR_DISABLE 0xb4000018
+#define DLB2_CFG_MSTR_CFG_PM_PMCSR_DISABLE_RST 0x1
+union dlb2_cfg_mstr_cfg_pm_pmcsr_disable {
+	struct {
+		u32 disable : 1;
+		u32 rsvz0 : 31;
+	} field;
+	u32 val;
+};
+
+#endif /* __DLB2_REGS_H */
diff --git a/drivers/misc/dlb2/dlb2_resource.c b/drivers/misc/dlb2/dlb2_resource.c
new file mode 100644
index 000000000000..70036a2f5d60
--- /dev/null
+++ b/drivers/misc/dlb2/dlb2_resource.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2016-2020 Intel Corporation */
+
+#include "dlb2_bitmap.h"
+#include "dlb2_hw_types.h"
+#include "dlb2_regs.h"
+#include "dlb2_resource.h"
+
+static void dlb2_init_fn_rsrc_lists(struct dlb2_function_resources *rsrc)
+{
+	int i;
+
+	INIT_LIST_HEAD(&rsrc->avail_domains);
+	INIT_LIST_HEAD(&rsrc->used_domains);
+	INIT_LIST_HEAD(&rsrc->avail_ldb_queues);
+	INIT_LIST_HEAD(&rsrc->avail_dir_pq_pairs);
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++)
+		INIT_LIST_HEAD(&rsrc->avail_ldb_ports[i]);
+}
+
+static void dlb2_init_domain_rsrc_lists(struct dlb2_hw_domain *domain)
+{
+	int i;
+
+	INIT_LIST_HEAD(&domain->used_ldb_queues);
+	INIT_LIST_HEAD(&domain->used_dir_pq_pairs);
+	INIT_LIST_HEAD(&domain->avail_ldb_queues);
+	INIT_LIST_HEAD(&domain->avail_dir_pq_pairs);
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++)
+		INIT_LIST_HEAD(&domain->used_ldb_ports[i]);
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++)
+		INIT_LIST_HEAD(&domain->avail_ldb_ports[i]);
+}
+
+void dlb2_resource_free(struct dlb2_hw *hw)
+{
+	int i;
+
+	if (hw->pf.avail_hist_list_entries)
+		dlb2_bitmap_free(hw->pf.avail_hist_list_entries);
+
+	for (i = 0; i < DLB2_MAX_NUM_VDEVS; i++) {
+		if (hw->vdev[i].avail_hist_list_entries)
+			dlb2_bitmap_free(hw->vdev[i].avail_hist_list_entries);
+	}
+}
+
+int dlb2_resource_init(struct dlb2_hw *hw)
+{
+	struct list_head *list;
+	unsigned int i;
+	int ret;
+
+	/*
+	 * For optimal load-balancing, ports that map to one or more QIDs in
+	 * common should not be in numerical sequence. This is application
+	 * dependent, but the driver interleaves port IDs as much as possible
+	 * to reduce the likelihood of this. This initial allocation maximizes
+	 * the average distance between an ID and its immediate neighbors (i.e.
+	 * the distance from 1 to 0 and to 2, the distance from 2 to 1 and to
+	 * 3, etc.).
+	 */
+	u8 init_ldb_port_allocation[DLB2_MAX_NUM_LDB_PORTS] = {
+		0,  7,  14,  5, 12,  3, 10,  1,  8, 15,  6, 13,  4, 11,  2,  9,
+		16, 23, 30, 21, 28, 19, 26, 17, 24, 31, 22, 29, 20, 27, 18, 25,
+		32, 39, 46, 37, 44, 35, 42, 33, 40, 47, 38, 45, 36, 43, 34, 41,
+		48, 55, 62, 53, 60, 51, 58, 49, 56, 63, 54, 61, 52, 59, 50, 57,
+	};
+
+	/* Zero-out resource tracking data structures */
+	memset(&hw->rsrcs, 0, sizeof(hw->rsrcs));
+	memset(&hw->pf, 0, sizeof(hw->pf));
+
+	dlb2_init_fn_rsrc_lists(&hw->pf);
+
+	for (i = 0; i < DLB2_MAX_NUM_VDEVS; i++) {
+		memset(&hw->vdev[i], 0, sizeof(hw->vdev[i]));
+		dlb2_init_fn_rsrc_lists(&hw->vdev[i]);
+	}
+
+	for (i = 0; i < DLB2_MAX_NUM_DOMAINS; i++) {
+		memset(&hw->domains[i], 0, sizeof(hw->domains[i]));
+		dlb2_init_domain_rsrc_lists(&hw->domains[i]);
+		hw->domains[i].parent_func = &hw->pf;
+	}
+
+	/* Give all resources to the PF driver */
+	hw->pf.num_avail_domains = DLB2_MAX_NUM_DOMAINS;
+	for (i = 0; i < hw->pf.num_avail_domains; i++) {
+		list = &hw->domains[i].func_list;
+
+		list_add(list, &hw->pf.avail_domains);
+	}
+
+	hw->pf.num_avail_ldb_queues = DLB2_MAX_NUM_LDB_QUEUES;
+	for (i = 0; i < hw->pf.num_avail_ldb_queues; i++) {
+		list = &hw->rsrcs.ldb_queues[i].func_list;
+
+		list_add(list, &hw->pf.avail_ldb_queues);
+	}
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++)
+		hw->pf.num_avail_ldb_ports[i] =
+			DLB2_MAX_NUM_LDB_PORTS / DLB2_NUM_COS_DOMAINS;
+
+	for (i = 0; i < DLB2_MAX_NUM_LDB_PORTS; i++) {
+		int cos_id = i >> DLB2_NUM_COS_DOMAINS;
+		struct dlb2_ldb_port *port;
+
+		port = &hw->rsrcs.ldb_ports[init_ldb_port_allocation[i]];
+
+		list_add(&port->func_list, &hw->pf.avail_ldb_ports[cos_id]);
+	}
+
+	hw->pf.num_avail_dir_pq_pairs = DLB2_MAX_NUM_DIR_PORTS;
+	for (i = 0; i < hw->pf.num_avail_dir_pq_pairs; i++) {
+		list = &hw->rsrcs.dir_pq_pairs[i].func_list;
+
+		list_add(list, &hw->pf.avail_dir_pq_pairs);
+	}
+
+	hw->pf.num_avail_qed_entries = DLB2_MAX_NUM_LDB_CREDITS;
+	hw->pf.num_avail_dqed_entries = DLB2_MAX_NUM_DIR_CREDITS;
+	hw->pf.num_avail_aqed_entries = DLB2_MAX_NUM_AQED_ENTRIES;
+
+	ret = dlb2_bitmap_alloc(&hw->pf.avail_hist_list_entries,
+				DLB2_MAX_NUM_HIST_LIST_ENTRIES);
+	if (ret)
+		goto unwind;
+
+	ret = dlb2_bitmap_fill(hw->pf.avail_hist_list_entries);
+	if (ret)
+		goto unwind;
+
+	for (i = 0; i < DLB2_MAX_NUM_VDEVS; i++) {
+		ret = dlb2_bitmap_alloc(&hw->vdev[i].avail_hist_list_entries,
+					DLB2_MAX_NUM_HIST_LIST_ENTRIES);
+		if (ret)
+			goto unwind;
+
+		ret = dlb2_bitmap_zero(hw->vdev[i].avail_hist_list_entries);
+		if (ret)
+			goto unwind;
+	}
+
+	/* Initialize the hardware resource IDs */
+	for (i = 0; i < DLB2_MAX_NUM_DOMAINS; i++) {
+		hw->domains[i].id.phys_id = i;
+		hw->domains[i].id.vdev_owned = false;
+	}
+
+	for (i = 0; i < DLB2_MAX_NUM_LDB_QUEUES; i++) {
+		hw->rsrcs.ldb_queues[i].id.phys_id = i;
+		hw->rsrcs.ldb_queues[i].id.vdev_owned = false;
+	}
+
+	for (i = 0; i < DLB2_MAX_NUM_LDB_PORTS; i++) {
+		hw->rsrcs.ldb_ports[i].id.phys_id = i;
+		hw->rsrcs.ldb_ports[i].id.vdev_owned = false;
+	}
+
+	for (i = 0; i < DLB2_MAX_NUM_DIR_PORTS; i++) {
+		hw->rsrcs.dir_pq_pairs[i].id.phys_id = i;
+		hw->rsrcs.dir_pq_pairs[i].id.vdev_owned = false;
+	}
+
+	for (i = 0; i < DLB2_MAX_NUM_SEQUENCE_NUMBER_GROUPS; i++) {
+		hw->rsrcs.sn_groups[i].id = i;
+		/* Default mode (0) is 64 sequence numbers per queue */
+		hw->rsrcs.sn_groups[i].mode = 0;
+		hw->rsrcs.sn_groups[i].sequence_numbers_per_queue = 64;
+		hw->rsrcs.sn_groups[i].slot_use_bitmap = 0;
+	}
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++)
+		hw->cos_reservation[i] = 100 / DLB2_NUM_COS_DOMAINS;
+
+	return 0;
+
+unwind:
+	dlb2_resource_free(hw);
+
+	return ret;
+}
+
+void dlb2_clr_pmcsr_disable(struct dlb2_hw *hw)
+{
+	union dlb2_cfg_mstr_cfg_pm_pmcsr_disable r0;
+
+	r0.val = DLB2_CSR_RD(hw, DLB2_CFG_MSTR_CFG_PM_PMCSR_DISABLE);
+
+	r0.field.disable = 0;
+
+	DLB2_CSR_WR(hw, DLB2_CFG_MSTR_CFG_PM_PMCSR_DISABLE, r0.val);
+}
diff --git a/drivers/misc/dlb2/dlb2_resource.h b/drivers/misc/dlb2/dlb2_resource.h
new file mode 100644
index 000000000000..af20fcf0a0cb
--- /dev/null
+++ b/drivers/misc/dlb2/dlb2_resource.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ * Copyright(c) 2016-2020 Intel Corporation
+ */
+
+#ifndef __DLB2_RESOURCE_H
+#define __DLB2_RESOURCE_H
+
+#include <linux/types.h>
+
+#include "dlb2_hw_types.h"
+
+/**
+ * dlb2_resource_init() - initialize the device
+ * @hw: pointer to struct dlb2_hw.
+ *
+ * This function initializes the device's software state (pointed to by the hw
+ * argument) and programs global scheduling QoS registers. This function should
+ * be called during driver initialization.
+ *
+ * The dlb2_hw struct must be unique per DLB 2.0 device and persist until the
+ * device is reset.
+ *
+ * Return:
+ * Returns 0 upon success, <0 otherwise.
+ */
+int dlb2_resource_init(struct dlb2_hw *hw);
+
+/**
+ * dlb2_resource_free() - free device state memory
+ * @hw: dlb2_hw handle for a particular device.
+ *
+ * This function frees software state pointed to by dlb2_hw. This function
+ * should be called when resetting the device or unloading the driver.
+ */
+void dlb2_resource_free(struct dlb2_hw *hw);
+
+/**
+ * dlb2_clr_pmcsr_disable() - power on bulk of DLB 2.0 logic
+ * @hw: dlb2_hw handle for a particular device.
+ *
+ * Clearing the PMCSR must be done at initialization to make the device fully
+ * operational.
+ */
+void dlb2_clr_pmcsr_disable(struct dlb2_hw *hw);
+
+#endif /* __DLB2_RESOURCE_H */
-- 
2.13.6

