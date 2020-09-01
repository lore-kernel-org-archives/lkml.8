Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C953C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A7A20767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbgIATWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:22:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:53437 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731667AbgIATVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:21:50 -0400
IronPort-SDR: ZUEN0q/gTU7Wdip9BrNAhE7MNPqasDyXbG7XrIsVlNXZiNSrhNRbCk77Cs34AATrAFxWDgu20E
 +1kuYiRZDRAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="218807339"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="218807339"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:21:33 -0700
IronPort-SDR: Hnm16z57UXjdPGOV03Vnmzr6a0Vii7T4s0qcBdhZYrNuKZRTq//khZ7KK2hdujZm0qTwzg1m4h
 Qf7aQhtUtbDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="325480497"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2020 12:21:33 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH v3 13/19] dlb2: add CQ interrupt support
Date:   Tue,  1 Sep 2020 14:15:42 -0500
Message-Id: <20200901191548.31646-14-gage.eads@intel.com>
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

DLB 2.0 supports interrupt-driven applications with per-CQ interrupts. A CQ
interrupt is armed by user-space software by enqueueing a special command
to the device through the port's MMIO window, and the interrupt fires when
the armed CQ becomes non-empty.

All CQ interrupts use a single MSI-X interrupt vector, and the ISR reads
bitmap registers to determine which CQ(s)'s interrupt fired. For each of
these CQs, the driver wakes up a wait-queue -- on which user-space threads
may be blocking waiting for the interrupt. User-space software calls a
block-on-CQ-interrupt ioctl in order to block on the wait queue.

A CQ's interrupt is enabled when its port is configured, and interrupts are
enabled/disabled when a port is enabled/disabled. If a port is disabled and
a thread is blocked on the wait queue, the thread is woken and returned to
user-space.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Björn Töpel <bjorn.topel@intel.com>
---
 drivers/misc/dlb2/Makefile        |   1 +
 drivers/misc/dlb2/dlb2_hw_types.h |  13 ++
 drivers/misc/dlb2/dlb2_intr.c     | 130 ++++++++++++++++
 drivers/misc/dlb2/dlb2_intr.h     |  29 ++++
 drivers/misc/dlb2/dlb2_ioctl.c    |  70 +++++++++
 drivers/misc/dlb2/dlb2_main.c     |  20 ++-
 drivers/misc/dlb2/dlb2_main.h     |  43 ++++++
 drivers/misc/dlb2/dlb2_pf_ops.c   | 211 ++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_resource.c | 306 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_resource.h | 128 ++++++++++++++++
 include/uapi/linux/dlb2_user.h    |  37 +++++
 11 files changed, 987 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/dlb2/dlb2_intr.c
 create mode 100644 drivers/misc/dlb2/dlb2_intr.h

diff --git a/drivers/misc/dlb2/Makefile b/drivers/misc/dlb2/Makefile
index 12361461dcff..64ec27489b73 100644
--- a/drivers/misc/dlb2/Makefile
+++ b/drivers/misc/dlb2/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_INTEL_DLB2) := dlb2.o
 
 dlb2-objs :=      \
   dlb2_main.o     \
+  dlb2_intr.o     \
   dlb2_file.o     \
   dlb2_ioctl.o    \
   dlb2_pf_ops.o   \
diff --git a/drivers/misc/dlb2/dlb2_hw_types.h b/drivers/misc/dlb2/dlb2_hw_types.h
index 7db59157da15..986d35cbeaf9 100644
--- a/drivers/misc/dlb2/dlb2_hw_types.h
+++ b/drivers/misc/dlb2/dlb2_hw_types.h
@@ -48,6 +48,19 @@
 #define DLB2_MAX_QID_EMPTY_CHECK_LOOPS		(32 * 64 * 1024 * (800 / 30))
 #define DLB2_HZ					800000000
 
+/* Interrupt related macros */
+#define DLB2_PF_NUM_NON_CQ_INTERRUPT_VECTORS 1
+#define DLB2_PF_NUM_CQ_INTERRUPT_VECTORS     64
+#define DLB2_PF_TOTAL_NUM_INTERRUPT_VECTORS \
+	(DLB2_PF_NUM_NON_CQ_INTERRUPT_VECTORS + \
+	 DLB2_PF_NUM_CQ_INTERRUPT_VECTORS)
+#define DLB2_PF_NUM_COMPRESSED_MODE_VECTORS \
+	(DLB2_PF_NUM_NON_CQ_INTERRUPT_VECTORS + 1)
+#define DLB2_PF_NUM_PACKED_MODE_VECTORS \
+	DLB2_PF_TOTAL_NUM_INTERRUPT_VECTORS
+#define DLB2_PF_COMPRESSED_MODE_CQ_VECTOR_ID \
+	DLB2_PF_NUM_NON_CQ_INTERRUPT_VECTORS
+
 /*
  * Hardware-defined base addresses. Those prefixed 'DLB2_DRV' are only used by
  * the PF driver.
diff --git a/drivers/misc/dlb2/dlb2_intr.c b/drivers/misc/dlb2/dlb2_intr.c
new file mode 100644
index 000000000000..0e20197e96fb
--- /dev/null
+++ b/drivers/misc/dlb2/dlb2_intr.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2017-2020 Intel Corporation */
+
+#include <linux/interrupt.h>
+#include <linux/uaccess.h>
+
+#include "dlb2_intr.h"
+#include "dlb2_main.h"
+#include "dlb2_resource.h"
+
+void dlb2_wake_thread(struct dlb2_dev *dev,
+		      struct dlb2_cq_intr *intr,
+		      enum dlb2_wake_reason reason)
+{
+	switch (reason) {
+	case WAKE_CQ_INTR:
+		WRITE_ONCE(intr->wake, true);
+		break;
+	case WAKE_PORT_DISABLED:
+		WRITE_ONCE(intr->disabled, true);
+		break;
+	default:
+		break;
+	}
+
+	wake_up_interruptible(&intr->wq_head);
+}
+
+static inline bool wake_condition(struct dlb2_cq_intr *intr,
+				  struct dlb2_dev *dev,
+				  struct dlb2_domain *domain)
+{
+	return (READ_ONCE(intr->wake) || READ_ONCE(intr->disabled));
+}
+
+struct dlb2_dequeue_qe {
+	u8 rsvd0[15];
+	u8 cq_gen:1;
+	u8 rsvd1:7;
+} __packed;
+
+/**
+ * dlb2_cq_empty() - determine whether a CQ is empty
+ * @dev: struct dlb2_dev pointer.
+ * @user_cq_va: User VA pointing to next CQ entry.
+ * @cq_gen: Current CQ generation bit.
+ *
+ * Return:
+ * Returns 1 if empty, 0 if non-empty, or < 0 if an error occurs.
+ */
+static int dlb2_cq_empty(struct dlb2_dev *dev, u64 user_cq_va, u8 cq_gen)
+{
+	struct dlb2_dequeue_qe qe;
+
+	if (copy_from_user(&qe, (void __user *)user_cq_va, sizeof(qe)))
+		return -EFAULT;
+
+	return qe.cq_gen != cq_gen;
+}
+
+int dlb2_block_on_cq_interrupt(struct dlb2_dev *dev,
+			       struct dlb2_domain *dom,
+			       int port_id,
+			       bool is_ldb,
+			       u64 cq_va,
+			       u8 cq_gen,
+			       bool arm)
+{
+	struct dlb2_cq_intr *intr;
+	int ret = 0;
+
+	if (is_ldb && port_id >= DLB2_MAX_NUM_LDB_PORTS)
+		return -EINVAL;
+	if (!is_ldb && port_id >= DLB2_MAX_NUM_DIR_PORTS)
+		return -EINVAL;
+
+	if (is_ldb)
+		intr = &dev->intr.ldb_cq_intr[port_id];
+	else
+		intr = &dev->intr.dir_cq_intr[port_id];
+
+	if (!intr->configured || intr->domain_id != dom->id)
+		return -EINVAL;
+
+	/*
+	 * This function requires that only one thread process the CQ at a time.
+	 * Otherwise, the wake condition could become false in the time between
+	 * the ISR calling wake_up_interruptible() and the thread checking its
+	 * wake condition.
+	 */
+	mutex_lock(&intr->mutex);
+
+	/* Return early if the port's interrupt is disabled */
+	if (READ_ONCE(intr->disabled)) {
+		mutex_unlock(&intr->mutex);
+		return -EACCES;
+	}
+
+	dev_dbg(dev->dlb2_device,
+		"Thread is blocking on %s port %d's interrupt\n",
+		(is_ldb) ? "LDB" : "DIR", port_id);
+
+	/* Don't block if the CQ is non-empty */
+	ret = dlb2_cq_empty(dev, cq_va, cq_gen);
+	if (ret != 1)
+		goto error;
+
+	if (arm) {
+		ret = dev->ops->arm_cq_interrupt(dev, dom->id, port_id, is_ldb);
+		if (ret)
+			goto error;
+	}
+
+	ret = wait_event_interruptible(intr->wq_head,
+				       wake_condition(intr, dev, dom));
+
+	if (ret == 0 && READ_ONCE(intr->disabled))
+		ret = -EACCES;
+
+	WRITE_ONCE(intr->wake, false);
+
+	dev_dbg(dev->dlb2_device,
+		"Thread is unblocked from %s port %d's interrupt\n",
+		(is_ldb) ? "LDB" : "DIR", port_id);
+
+error:
+	mutex_unlock(&intr->mutex);
+
+	return ret;
+}
diff --git a/drivers/misc/dlb2/dlb2_intr.h b/drivers/misc/dlb2/dlb2_intr.h
new file mode 100644
index 000000000000..613179795d8f
--- /dev/null
+++ b/drivers/misc/dlb2/dlb2_intr.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ * Copyright(c) 2017-2020 Intel Corporation
+ */
+
+#ifndef __DLB2_INTR_H
+#define __DLB2_INTR_H
+
+#include <linux/pci.h>
+
+#include "dlb2_main.h"
+
+int dlb2_block_on_cq_interrupt(struct dlb2_dev *dev,
+			       struct dlb2_domain *domain,
+			       int port_id,
+			       bool is_ldb,
+			       u64 cq_va,
+			       u8 cq_gen,
+			       bool arm);
+
+enum dlb2_wake_reason {
+	WAKE_CQ_INTR,
+	WAKE_PORT_DISABLED,
+};
+
+void dlb2_wake_thread(struct dlb2_dev *dev,
+		      struct dlb2_cq_intr *intr,
+		      enum dlb2_wake_reason reason);
+
+#endif /* __DLB2_INTR_H */
diff --git a/drivers/misc/dlb2/dlb2_ioctl.c b/drivers/misc/dlb2/dlb2_ioctl.c
index 490c380670cc..010e67941cf9 100644
--- a/drivers/misc/dlb2/dlb2_ioctl.c
+++ b/drivers/misc/dlb2/dlb2_ioctl.c
@@ -7,6 +7,7 @@
 #include <uapi/linux/dlb2_user.h>
 
 #include "dlb2_file.h"
+#include "dlb2_intr.h"
 #include "dlb2_ioctl.h"
 #include "dlb2_main.h"
 
@@ -75,6 +76,10 @@ static int dlb2_domain_ioctl_enable_ldb_port(struct dlb2_dev *dev,
 
 	ret = dev->ops->enable_ldb_port(&dev->hw, domain->id, &arg, &response);
 
+	/* Allow threads to block on this port's CQ interrupt */
+	if (!ret)
+		WRITE_ONCE(dev->intr.ldb_cq_intr[arg.port_id].disabled, false);
+
 	mutex_unlock(&dev->resource_mutex);
 
 	BUILD_BUG_ON(offsetof(typeof(arg), response) != 0);
@@ -100,6 +105,10 @@ static int dlb2_domain_ioctl_enable_dir_port(struct dlb2_dev *dev,
 
 	ret = dev->ops->enable_dir_port(&dev->hw, domain->id, &arg, &response);
 
+	/* Allow threads to block on this port's CQ interrupt */
+	if (!ret)
+		WRITE_ONCE(dev->intr.dir_cq_intr[arg.port_id].disabled, false);
+
 	mutex_unlock(&dev->resource_mutex);
 
 	BUILD_BUG_ON(offsetof(typeof(arg), response) != 0);
@@ -125,6 +134,15 @@ static int dlb2_domain_ioctl_disable_ldb_port(struct dlb2_dev *dev,
 
 	ret = dev->ops->disable_ldb_port(&dev->hw, domain->id, &arg, &response);
 
+	/*
+	 * Wake threads blocked on this port's CQ interrupt, and prevent
+	 * subsequent attempts to block on it.
+	 */
+	if (!ret)
+		dlb2_wake_thread(dev,
+				 &dev->intr.ldb_cq_intr[arg.port_id],
+				 WAKE_PORT_DISABLED);
+
 	mutex_unlock(&dev->resource_mutex);
 
 	BUILD_BUG_ON(offsetof(typeof(arg), response) != 0);
@@ -150,6 +168,15 @@ static int dlb2_domain_ioctl_disable_dir_port(struct dlb2_dev *dev,
 
 	ret = dev->ops->disable_dir_port(&dev->hw, domain->id, &arg, &response);
 
+	/*
+	 * Wake threads blocked on this port's CQ interrupt, and prevent
+	 * subsequent attempts to block on it.
+	 */
+	if (!ret)
+		dlb2_wake_thread(dev,
+				 &dev->intr.dir_cq_intr[arg.port_id],
+				 WAKE_PORT_DISABLED);
+
 	mutex_unlock(&dev->resource_mutex);
 
 	BUILD_BUG_ON(offsetof(typeof(arg), response) != 0);
@@ -197,6 +224,13 @@ static int dlb2_domain_ioctl_create_ldb_port(struct dlb2_dev *dev,
 	if (ret)
 		goto unlock;
 
+	ret = dev->ops->enable_ldb_cq_interrupts(dev,
+						 domain->id,
+						 response.id,
+						 arg.cq_depth_threshold);
+	if (ret)
+		goto unlock; /* Internal error, don't unwind port creation */
+
 	/* Fill out the per-port data structure */
 	dev->ldb_port[response.id].id = response.id;
 	dev->ldb_port[response.id].is_ldb = true;
@@ -255,6 +289,13 @@ static int dlb2_domain_ioctl_create_dir_port(struct dlb2_dev *dev,
 	if (ret)
 		goto unlock;
 
+	dev->ops->enable_dir_cq_interrupts(dev,
+					   domain->id,
+					   response.id,
+					   arg.cq_depth_threshold);
+	if (ret)
+		goto unlock; /* Internal error, don't unwind port creation */
+
 	/* Fill out the per-port data structure */
 	dev->dir_port[response.id].id = response.id;
 	dev->dir_port[response.id].is_ldb = false;
@@ -280,6 +321,33 @@ static int dlb2_domain_ioctl_create_dir_port(struct dlb2_dev *dev,
 	return ret;
 }
 
+static int dlb2_domain_ioctl_block_on_cq_interrupt(struct dlb2_dev *dev,
+						   struct dlb2_domain *domain,
+						   unsigned long user_arg)
+{
+	struct dlb2_block_on_cq_interrupt_args arg;
+	struct dlb2_cmd_response response = {0};
+	int ret = 0;
+
+	if (copy_from_user(&arg, (void __user *)user_arg, sizeof(arg)))
+		return -EFAULT;
+
+	ret = dlb2_block_on_cq_interrupt(dev,
+					 domain,
+					 arg.port_id,
+					 arg.is_ldb,
+					 arg.cq_va,
+					 arg.cq_gen,
+					 arg.arm);
+
+	BUILD_BUG_ON(offsetof(typeof(arg), response) != 0);
+
+	if (copy_to_user((void __user *)user_arg, &response, sizeof(response)))
+		return -EFAULT;
+
+	return ret;
+}
+
 static int dlb2_create_port_fd(struct dlb2_dev *dev,
 			       struct dlb2_domain *domain,
 			       const char *prefix,
@@ -467,6 +535,8 @@ long dlb2_domain_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 		return dlb2_domain_ioctl_disable_ldb_port(dev, dom, arg);
 	case DLB2_IOC_DISABLE_DIR_PORT:
 		return dlb2_domain_ioctl_disable_dir_port(dev, dom, arg);
+	case DLB2_IOC_BLOCK_ON_CQ_INTERRUPT:
+		return dlb2_domain_ioctl_block_on_cq_interrupt(dev, dom, arg);
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/misc/dlb2/dlb2_main.c b/drivers/misc/dlb2/dlb2_main.c
index 3fe59e99b402..b542c2c081a5 100644
--- a/drivers/misc/dlb2/dlb2_main.c
+++ b/drivers/misc/dlb2/dlb2_main.c
@@ -174,13 +174,20 @@ static void dlb2_release_device_memory(struct dlb2_dev *dev)
 
 static int __dlb2_free_domain(struct dlb2_dev *dev, struct dlb2_domain *domain)
 {
-	int ret = 0;
+	int i, ret = 0;
 
 	ret = dev->ops->reset_domain(&dev->hw, domain->id);
 
 	/* Unpin and free all memory pages associated with the domain */
 	dlb2_release_domain_memory(dev, domain->id);
 
+	for (i = 0; i < DLB2_MAX_NUM_LDB_PORTS; i++)
+		if (dev->intr.ldb_cq_intr[i].domain_id == domain->id)
+			dev->intr.ldb_cq_intr[i].configured = false;
+	for (i = 0; i < DLB2_MAX_NUM_DIR_PORTS; i++)
+		if (dev->intr.dir_cq_intr[i].domain_id == domain->id)
+			dev->intr.dir_cq_intr[i].configured = false;
+
 	if (ret) {
 		dev->domain_reset_failed = true;
 		dev_err(dev->dlb2_device,
@@ -430,6 +437,10 @@ static int dlb2_probe(struct pci_dev *pdev,
 	if (ret)
 		goto dlb2_reset_fail;
 
+	ret = dlb2_dev->ops->init_interrupts(dlb2_dev, pdev);
+	if (ret)
+		goto init_interrupts_fail;
+
 	ret = dlb2_resource_init(&dlb2_dev->hw);
 	if (ret)
 		goto resource_init_fail;
@@ -458,6 +469,8 @@ static int dlb2_probe(struct pci_dev *pdev,
 init_driver_state_fail:
 	dlb2_resource_free(&dlb2_dev->hw);
 resource_init_fail:
+	dlb2_dev->ops->free_interrupts(dlb2_dev, pdev);
+init_interrupts_fail:
 dlb2_reset_fail:
 wait_for_device_ready_fail:
 dma_set_mask_fail:
@@ -497,6 +510,8 @@ static void dlb2_remove(struct pci_dev *pdev)
 
 	dlb2_resource_free(&dlb2_dev->hw);
 
+	dlb2_dev->ops->free_interrupts(dlb2_dev, pdev);
+
 	dlb2_release_device_memory(dlb2_dev);
 
 	dlb2_dev->ops->device_destroy(dlb2_dev, dlb2_class);
@@ -521,6 +536,9 @@ static void dlb2_reset_hardware_state(struct dlb2_dev *dev)
 {
 	dlb2_reset_device(dev->pdev);
 
+	/* Reinitialize interrupt configuration */
+	dev->ops->reinit_interrupts(dev);
+
 	/* Reinitialize any other hardware state */
 	dev->ops->init_hardware(dev);
 }
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index 92e182603445..db462209fa6a 100644
--- a/drivers/misc/dlb2/dlb2_main.h
+++ b/drivers/misc/dlb2/dlb2_main.h
@@ -54,6 +54,21 @@ struct dlb2_device_ops {
 			dev_t base,
 			const struct file_operations *fops);
 	void (*cdev_del)(struct dlb2_dev *dlb2_dev);
+	int (*init_interrupts)(struct dlb2_dev *dev, struct pci_dev *pdev);
+	int (*enable_ldb_cq_interrupts)(struct dlb2_dev *dev,
+					int domain_id,
+					int port_id,
+					u16 thresh);
+	int (*enable_dir_cq_interrupts)(struct dlb2_dev *dev,
+					int domain_id,
+					int port_id,
+					u16 thresh);
+	int (*arm_cq_interrupt)(struct dlb2_dev *dev,
+				int domain_id,
+				int port_id,
+				bool is_ldb);
+	void (*reinit_interrupts)(struct dlb2_dev *dev);
+	void (*free_interrupts)(struct dlb2_dev *dev, struct pci_dev *pdev);
 	void (*enable_pm)(struct dlb2_dev *dev);
 	int (*wait_for_device_ready)(struct dlb2_dev *dev,
 				     struct pci_dev *pdev);
@@ -152,6 +167,33 @@ struct dlb2_domain {
 	u8 id;
 };
 
+struct dlb2_cq_intr {
+	wait_queue_head_t wq_head;
+	/*
+	 * The CQ interrupt mutex guarantees one thread is blocking on a CQ's
+	 * interrupt at a time.
+	 */
+	struct mutex mutex;
+	u8 wake;
+	u8 configured;
+	u8 domain_id;
+	/*
+	 * disabled is true if the port is disabled. In that
+	 * case, the driver doesn't allow applications to block on the
+	 * port's interrupt.
+	 */
+	u8 disabled;
+} ____cacheline_aligned;
+
+struct dlb2_intr {
+	struct dlb2_cq_intr ldb_cq_intr[DLB2_MAX_NUM_LDB_PORTS];
+	struct dlb2_cq_intr dir_cq_intr[DLB2_MAX_NUM_DIR_PORTS];
+	u8 isr_registered[DLB2_PF_NUM_CQ_INTERRUPT_VECTORS];
+	int num_vectors;
+	int base_vector;
+	int mode;
+};
+
 struct dlb2_dev {
 	struct pci_dev *pdev;
 	struct dlb2_hw hw;
@@ -167,6 +209,7 @@ struct dlb2_dev {
 	 * device file mappings.
 	 */
 	struct inode *inode;
+	struct dlb2_intr intr;
 	/*
 	 * The resource mutex serializes access to driver data structures and
 	 * hardware registers.
diff --git a/drivers/misc/dlb2/dlb2_pf_ops.c b/drivers/misc/dlb2/dlb2_pf_ops.c
index 8b1aac196073..23a1e9ba0226 100644
--- a/drivers/misc/dlb2/dlb2_pf_ops.c
+++ b/drivers/misc/dlb2/dlb2_pf_ops.c
@@ -4,6 +4,7 @@
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
 
+#include "dlb2_intr.h"
 #include "dlb2_main.h"
 #include "dlb2_regs.h"
 #include "dlb2_resource.h"
@@ -77,6 +78,210 @@ dlb2_pf_map_pci_bar_space(struct dlb2_dev *dlb2_dev,
 	return 0;
 }
 
+/**********************************/
+/****** Interrupt management ******/
+/**********************************/
+
+static irqreturn_t
+dlb2_compressed_cq_intr_handler(int irq, void *hdlr_ptr)
+{
+	struct dlb2_dev *dev = (struct dlb2_dev *)hdlr_ptr;
+	u32 ldb_cq_interrupts[DLB2_MAX_NUM_LDB_PORTS / 32];
+	u32 dir_cq_interrupts[DLB2_MAX_NUM_DIR_PORTS / 32];
+	int i;
+
+	dlb2_read_compressed_cq_intr_status(&dev->hw,
+					    ldb_cq_interrupts,
+					    dir_cq_interrupts);
+
+	dlb2_ack_compressed_cq_intr(&dev->hw,
+				    ldb_cq_interrupts,
+				    dir_cq_interrupts);
+
+	for (i = 0; i < DLB2_MAX_NUM_LDB_PORTS; i++) {
+		if (!(ldb_cq_interrupts[i / 32] & (1 << (i % 32))))
+			continue;
+
+		dlb2_wake_thread(dev, &dev->intr.ldb_cq_intr[i], WAKE_CQ_INTR);
+	}
+
+	for (i = 0; i < DLB2_MAX_NUM_DIR_PORTS; i++) {
+		if (!(dir_cq_interrupts[i / 32] & (1 << (i % 32))))
+			continue;
+
+		dlb2_wake_thread(dev, &dev->intr.dir_cq_intr[i], WAKE_CQ_INTR);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int
+dlb2_init_compressed_mode_interrupts(struct dlb2_dev *dev,
+				     struct pci_dev *pdev)
+{
+	int ret, irq;
+
+	irq = pci_irq_vector(pdev, DLB2_PF_COMPRESSED_MODE_CQ_VECTOR_ID);
+
+	ret = devm_request_irq(&pdev->dev,
+			       irq,
+			       dlb2_compressed_cq_intr_handler,
+			       0,
+			       "dlb2_compressed_cq",
+			       dev);
+	if (ret)
+		return ret;
+
+	dev->intr.isr_registered[DLB2_PF_COMPRESSED_MODE_CQ_VECTOR_ID] = true;
+
+	dev->intr.mode = DLB2_MSIX_MODE_COMPRESSED;
+
+	dlb2_set_msix_mode(&dev->hw, DLB2_MSIX_MODE_COMPRESSED);
+
+	return 0;
+}
+
+static void
+dlb2_pf_free_interrupts(struct dlb2_dev *dev,
+			struct pci_dev *pdev)
+{
+	int i;
+
+	for (i = 0; i < dev->intr.num_vectors; i++) {
+		if (dev->intr.isr_registered[i])
+			devm_free_irq(&pdev->dev, pci_irq_vector(pdev, i), dev);
+	}
+
+	pci_free_irq_vectors(pdev);
+}
+
+static int
+dlb2_pf_init_interrupts(struct dlb2_dev *dev, struct pci_dev *pdev)
+{
+	int ret, i;
+
+	/*
+	 * DLB supports two modes for CQ interrupts:
+	 * - "compressed mode": all CQ interrupts are packed into a single
+	 *	vector. The ISR reads six interrupt status registers to
+	 *	determine the source(s).
+	 * - "packed mode" (unused): the hardware supports up to 64 vectors.
+	 */
+
+	ret = pci_alloc_irq_vectors(pdev,
+				    DLB2_PF_NUM_COMPRESSED_MODE_VECTORS,
+				    DLB2_PF_NUM_COMPRESSED_MODE_VECTORS,
+				    PCI_IRQ_MSIX);
+	if (ret < 0)
+		return ret;
+
+	dev->intr.num_vectors = ret;
+	dev->intr.base_vector = pci_irq_vector(pdev, 0);
+
+	ret = dlb2_init_compressed_mode_interrupts(dev, pdev);
+	if (ret) {
+		dlb2_pf_free_interrupts(dev, pdev);
+		return ret;
+	}
+
+	/*
+	 * Initialize per-CQ interrupt structures, such as wait queues that
+	 * threads will wait on until the CQ's interrupt fires.
+	 */
+	for (i = 0; i < DLB2_MAX_NUM_LDB_PORTS; i++) {
+		init_waitqueue_head(&dev->intr.ldb_cq_intr[i].wq_head);
+		mutex_init(&dev->intr.ldb_cq_intr[i].mutex);
+	}
+
+	for (i = 0; i < DLB2_MAX_NUM_DIR_PORTS; i++) {
+		init_waitqueue_head(&dev->intr.dir_cq_intr[i].wq_head);
+		mutex_init(&dev->intr.dir_cq_intr[i].mutex);
+	}
+
+	return 0;
+}
+
+/*
+ * If the device is reset during use, its interrupt registers need to be
+ * reinitialized.
+ */
+static void
+dlb2_pf_reinit_interrupts(struct dlb2_dev *dev)
+{
+	dlb2_set_msix_mode(&dev->hw, DLB2_MSIX_MODE_COMPRESSED);
+}
+
+static int
+dlb2_pf_enable_ldb_cq_interrupts(struct dlb2_dev *dev,
+				 int domain_id,
+				 int id,
+				 u16 thresh)
+{
+	int mode, vec;
+
+	if (dev->intr.mode == DLB2_MSIX_MODE_COMPRESSED) {
+		mode = DLB2_CQ_ISR_MODE_MSIX;
+		vec = 0;
+	} else {
+		mode = DLB2_CQ_ISR_MODE_MSIX;
+		vec = id % 64;
+	}
+
+	dev->intr.ldb_cq_intr[id].disabled = false;
+	dev->intr.ldb_cq_intr[id].configured = true;
+	dev->intr.ldb_cq_intr[id].domain_id = domain_id;
+
+	return dlb2_configure_ldb_cq_interrupt(&dev->hw, id, vec,
+					       mode, 0, 0, thresh);
+}
+
+static int
+dlb2_pf_enable_dir_cq_interrupts(struct dlb2_dev *dev,
+				 int domain_id,
+				 int id,
+				 u16 thresh)
+{
+	int mode, vec;
+
+	if (dev->intr.mode == DLB2_MSIX_MODE_COMPRESSED) {
+		mode = DLB2_CQ_ISR_MODE_MSIX;
+		vec = 0;
+	} else {
+		mode = DLB2_CQ_ISR_MODE_MSIX;
+		vec = id % 64;
+	}
+
+	dev->intr.dir_cq_intr[id].disabled = false;
+	dev->intr.dir_cq_intr[id].configured = true;
+	dev->intr.dir_cq_intr[id].domain_id = domain_id;
+
+	return dlb2_configure_dir_cq_interrupt(&dev->hw, id, vec,
+					       mode, 0, 0, thresh);
+}
+
+static int
+dlb2_pf_arm_cq_interrupt(struct dlb2_dev *dev,
+			 int domain_id,
+			 int port_id,
+			 bool is_ldb)
+{
+	int ret;
+
+	if (is_ldb)
+		ret = dev->ops->ldb_port_owned_by_domain(&dev->hw,
+							 domain_id,
+							 port_id);
+	else
+		ret = dev->ops->dir_port_owned_by_domain(&dev->hw,
+							 domain_id,
+							 port_id);
+
+	if (ret != 1)
+		return -EINVAL;
+
+	return dlb2_arm_cq_interrupt(&dev->hw, port_id, is_ldb, false, 0);
+}
+
 /*******************************/
 /****** Driver management ******/
 /*******************************/
@@ -414,6 +619,12 @@ struct dlb2_device_ops dlb2_pf_ops = {
 	.device_destroy = dlb2_pf_device_destroy,
 	.cdev_add = dlb2_pf_cdev_add,
 	.cdev_del = dlb2_pf_cdev_del,
+	.init_interrupts = dlb2_pf_init_interrupts,
+	.enable_ldb_cq_interrupts = dlb2_pf_enable_ldb_cq_interrupts,
+	.enable_dir_cq_interrupts = dlb2_pf_enable_dir_cq_interrupts,
+	.arm_cq_interrupt = dlb2_pf_arm_cq_interrupt,
+	.reinit_interrupts = dlb2_pf_reinit_interrupts,
+	.free_interrupts = dlb2_pf_free_interrupts,
 	.enable_pm = dlb2_pf_enable_pm,
 	.wait_for_device_ready = dlb2_pf_wait_for_device_ready,
 	.create_sched_domain = dlb2_pf_create_sched_domain,
diff --git a/drivers/misc/dlb2/dlb2_resource.c b/drivers/misc/dlb2/dlb2_resource.c
index 665841ca7919..bfe20864515d 100644
--- a/drivers/misc/dlb2/dlb2_resource.c
+++ b/drivers/misc/dlb2/dlb2_resource.c
@@ -237,6 +237,41 @@ static struct dlb2_hw_domain *dlb2_get_domain_from_id(struct dlb2_hw *hw,
 	return NULL;
 }
 
+static struct dlb2_ldb_port *dlb2_get_ldb_port_from_id(struct dlb2_hw *hw,
+						       u32 id,
+						       bool vdev_req,
+						       unsigned int vdev_id)
+{
+	struct dlb2_function_resources *rsrcs;
+	struct dlb2_hw_domain *domain;
+	struct dlb2_ldb_port *port;
+	int i;
+
+	if (id >= DLB2_MAX_NUM_LDB_PORTS)
+		return NULL;
+
+	rsrcs = (vdev_req) ? &hw->vdev[vdev_id] : &hw->pf;
+
+	if (!vdev_req)
+		return &hw->rsrcs.ldb_ports[id];
+
+	DLB2_FUNC_LIST_FOR(rsrcs->used_domains, domain) {
+		for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+			DLB2_DOM_LIST_FOR(domain->used_ldb_ports[i], port)
+				if (port->id.virt_id == id)
+					return port;
+		}
+	}
+
+	for (i = 0; i < DLB2_NUM_COS_DOMAINS; i++) {
+		DLB2_FUNC_LIST_FOR(rsrcs->avail_ldb_ports[i], port)
+			if (port->id.virt_id == id)
+				return port;
+	}
+
+	return NULL;
+}
+
 static struct dlb2_ldb_port *
 dlb2_get_domain_used_ldb_port(u32 id,
 			      bool vdev_req,
@@ -289,6 +324,36 @@ dlb2_get_domain_ldb_port(u32 id,
 	return NULL;
 }
 
+static struct dlb2_dir_pq_pair *dlb2_get_dir_pq_from_id(struct dlb2_hw *hw,
+							u32 id,
+							bool vdev_req,
+							unsigned int vdev_id)
+{
+	struct dlb2_function_resources *rsrcs;
+	struct dlb2_dir_pq_pair *port;
+	struct dlb2_hw_domain *domain;
+
+	if (id >= DLB2_MAX_NUM_DIR_PORTS)
+		return NULL;
+
+	rsrcs = (vdev_req) ? &hw->vdev[vdev_id] : &hw->pf;
+
+	if (!vdev_req)
+		return &hw->rsrcs.dir_pq_pairs[id];
+
+	DLB2_FUNC_LIST_FOR(rsrcs->used_domains, domain) {
+		DLB2_DOM_LIST_FOR(domain->used_dir_pq_pairs, port)
+			if (port->id.virt_id == id)
+				return port;
+	}
+
+	DLB2_FUNC_LIST_FOR(rsrcs->avail_dir_pq_pairs, port)
+		if (port->id.virt_id == id)
+			return port;
+
+	return NULL;
+}
+
 static struct dlb2_dir_pq_pair *
 dlb2_get_domain_used_dir_pq(u32 id,
 			    bool vdev_req,
@@ -4685,6 +4750,247 @@ int dlb2_hw_disable_dir_port(struct dlb2_hw *hw,
 	return 0;
 }
 
+void dlb2_set_msix_mode(struct dlb2_hw *hw, int mode)
+{
+	union dlb2_sys_msix_mode r0 = { {0} };
+
+	r0.field.mode = mode;
+
+	DLB2_CSR_WR(hw, DLB2_SYS_MSIX_MODE, r0.val);
+}
+
+int dlb2_configure_ldb_cq_interrupt(struct dlb2_hw *hw,
+				    int port_id,
+				    int vector,
+				    int mode,
+				    unsigned int vf,
+				    unsigned int owner_vf,
+				    u16 threshold)
+{
+	union dlb2_chp_ldb_cq_int_depth_thrsh r0 = { {0} };
+	union dlb2_chp_ldb_cq_int_enb r1 = { {0} };
+	union dlb2_sys_ldb_cq_isr r2 = { {0} };
+	struct dlb2_ldb_port *port;
+	bool vdev_req;
+
+	vdev_req = (mode == DLB2_CQ_ISR_MODE_MSI ||
+		    mode == DLB2_CQ_ISR_MODE_ADI);
+
+	port = dlb2_get_ldb_port_from_id(hw, port_id, vdev_req, vf);
+	if (!port) {
+		DLB2_HW_ERR(hw,
+			    "[%s()]: Internal error: failed to enable LDB CQ int\n\tport_id: %u, vdev_req: %u, vdev: %u\n",
+			    __func__, port_id, vdev_req, vf);
+		return -EINVAL;
+	}
+
+	/* Trigger the interrupt when threshold or more QEs arrive in the CQ */
+	r0.field.depth_threshold = threshold - 1;
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_LDB_CQ_INT_DEPTH_THRSH(port->id.phys_id),
+		    r0.val);
+
+	r1.field.en_depth = 1;
+
+	DLB2_CSR_WR(hw, DLB2_CHP_LDB_CQ_INT_ENB(port->id.phys_id), r1.val);
+
+	r2.field.vector = vector;
+	r2.field.vf = owner_vf;
+	r2.field.en_code = mode;
+
+	DLB2_CSR_WR(hw, DLB2_SYS_LDB_CQ_ISR(port->id.phys_id), r2.val);
+
+	return 0;
+}
+
+int dlb2_configure_dir_cq_interrupt(struct dlb2_hw *hw,
+				    int port_id,
+				    int vector,
+				    int mode,
+				    unsigned int vf,
+				    unsigned int owner_vf,
+				    u16 threshold)
+{
+	union dlb2_chp_dir_cq_int_depth_thrsh r0 = { {0} };
+	union dlb2_chp_dir_cq_int_enb r1 = { {0} };
+	union dlb2_sys_dir_cq_isr r2 = { {0} };
+	struct dlb2_dir_pq_pair *port;
+	bool vdev_req;
+
+	vdev_req = (mode == DLB2_CQ_ISR_MODE_MSI ||
+		    mode == DLB2_CQ_ISR_MODE_ADI);
+
+	port = dlb2_get_dir_pq_from_id(hw, port_id, vdev_req, vf);
+	if (!port) {
+		DLB2_HW_ERR(hw,
+			    "[%s()]: Internal error: failed to enable DIR CQ int\n\tport_id: %u, vdev_req: %u, vdev: %u\n",
+			    __func__, port_id, vdev_req, vf);
+		return -EINVAL;
+	}
+
+	/* Trigger the interrupt when threshold or more QEs arrive in the CQ */
+	r0.field.depth_threshold = threshold - 1;
+
+	DLB2_CSR_WR(hw,
+		    DLB2_CHP_DIR_CQ_INT_DEPTH_THRSH(port->id.phys_id),
+		    r0.val);
+
+	r1.field.en_depth = 1;
+
+	DLB2_CSR_WR(hw, DLB2_CHP_DIR_CQ_INT_ENB(port->id.phys_id), r1.val);
+
+	r2.field.vector = vector;
+	r2.field.vf = owner_vf;
+	r2.field.en_code = mode;
+
+	DLB2_CSR_WR(hw, DLB2_SYS_DIR_CQ_ISR(port->id.phys_id), r2.val);
+
+	return 0;
+}
+
+int dlb2_arm_cq_interrupt(struct dlb2_hw *hw,
+			  int port_id,
+			  bool is_ldb,
+			  bool vdev_req,
+			  unsigned int vdev_id)
+{
+	u32 val;
+	u32 reg;
+
+	if (vdev_req && is_ldb) {
+		struct dlb2_ldb_port *ldb_port;
+
+		ldb_port = dlb2_get_ldb_port_from_id(hw, port_id,
+						     true, vdev_id);
+
+		if (!ldb_port || !ldb_port->configured)
+			return -EINVAL;
+
+		port_id = ldb_port->id.phys_id;
+	} else if (vdev_req && !is_ldb) {
+		struct dlb2_dir_pq_pair *dir_port;
+
+		dir_port = dlb2_get_dir_pq_from_id(hw, port_id, true, vdev_id);
+
+		if (!dir_port || !dir_port->port_configured)
+			return -EINVAL;
+
+		port_id = dir_port->id.phys_id;
+	}
+
+	val = 1 << (port_id % 32);
+
+	if (is_ldb && port_id < 32)
+		reg = DLB2_CHP_LDB_CQ_INTR_ARMED0;
+	else if (is_ldb && port_id < 64)
+		reg = DLB2_CHP_LDB_CQ_INTR_ARMED1;
+	else if (!is_ldb && port_id < 32)
+		reg = DLB2_CHP_DIR_CQ_INTR_ARMED0;
+	else
+		reg = DLB2_CHP_DIR_CQ_INTR_ARMED1;
+
+	DLB2_CSR_WR(hw, reg, val);
+
+	dlb2_flush_csr(hw);
+
+	return 0;
+}
+
+void dlb2_read_compressed_cq_intr_status(struct dlb2_hw *hw,
+					 u32 *ldb_interrupts,
+					 u32 *dir_interrupts)
+{
+	/* Read every CQ's interrupt status */
+
+	ldb_interrupts[0] = DLB2_CSR_RD(hw,
+					DLB2_SYS_LDB_CQ_31_0_OCC_INT_STS);
+	ldb_interrupts[1] = DLB2_CSR_RD(hw,
+					DLB2_SYS_LDB_CQ_63_32_OCC_INT_STS);
+
+	dir_interrupts[0] = DLB2_CSR_RD(hw,
+					DLB2_SYS_DIR_CQ_31_0_OCC_INT_STS);
+	dir_interrupts[1] = DLB2_CSR_RD(hw,
+					DLB2_SYS_DIR_CQ_63_32_OCC_INT_STS);
+}
+
+static void dlb2_ack_msix_interrupt(struct dlb2_hw *hw, int vector)
+{
+	union dlb2_sys_msix_ack r0 = { {0} };
+
+	switch (vector) {
+	case 0:
+		r0.field.msix_0_ack = 1;
+		break;
+	case 1:
+		r0.field.msix_1_ack = 1;
+		/*
+		 * CSSY-1650
+		 * workaround h/w bug for lost MSI-X interrupts
+		 *
+		 * The recommended workaround for acknowledging
+		 * vector 1 interrupts is :
+		 *   1: set   MSI-X mask
+		 *   2: set   MSIX_PASSTHROUGH
+		 *   3: clear MSIX_ACK
+		 *   4: clear MSIX_PASSTHROUGH
+		 *   5: clear MSI-X mask
+		 *
+		 * The MSIX-ACK (step 3) is cleared for all vectors
+		 * below. We handle steps 1 & 2 for vector 1 here.
+		 *
+		 * The bitfields for MSIX_ACK and MSIX_PASSTHRU are
+		 * defined the same, so we just use the MSIX_ACK
+		 * value when writing to PASSTHRU.
+		 */
+
+		/* set MSI-X mask and passthrough for vector 1 */
+		DLB2_FUNC_WR(hw, DLB2_MSIX_MEM_VECTOR_CTRL(1), 1);
+		DLB2_CSR_WR(hw, DLB2_SYS_MSIX_PASSTHRU, r0.val);
+		break;
+	}
+
+	/* clear MSIX_ACK (write one to clear) */
+	DLB2_CSR_WR(hw, DLB2_SYS_MSIX_ACK, r0.val);
+
+	if (vector == 1) {
+		/*
+		 * finish up steps 4 & 5 of the workaround -
+		 * clear pasthrough and mask
+		 */
+		DLB2_CSR_WR(hw, DLB2_SYS_MSIX_PASSTHRU, 0);
+		DLB2_FUNC_WR(hw, DLB2_MSIX_MEM_VECTOR_CTRL(1), 0);
+	}
+
+	dlb2_flush_csr(hw);
+}
+
+void dlb2_ack_compressed_cq_intr(struct dlb2_hw *hw,
+				 u32 *ldb_interrupts,
+				 u32 *dir_interrupts)
+{
+	/* Write back the status regs to ack the interrupts */
+	if (ldb_interrupts[0])
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_LDB_CQ_31_0_OCC_INT_STS,
+			    ldb_interrupts[0]);
+	if (ldb_interrupts[1])
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_LDB_CQ_63_32_OCC_INT_STS,
+			    ldb_interrupts[1]);
+
+	if (dir_interrupts[0])
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_DIR_CQ_31_0_OCC_INT_STS,
+			    dir_interrupts[0]);
+	if (dir_interrupts[1])
+		DLB2_CSR_WR(hw,
+			    DLB2_SYS_DIR_CQ_63_32_OCC_INT_STS,
+			    dir_interrupts[1]);
+
+	dlb2_ack_msix_interrupt(hw, DLB2_PF_COMPRESSED_MODE_CQ_VECTOR_ID);
+}
+
 static u32 dlb2_ldb_cq_inflight_count(struct dlb2_hw *hw,
 				      struct dlb2_ldb_port *port)
 {
diff --git a/drivers/misc/dlb2/dlb2_resource.h b/drivers/misc/dlb2/dlb2_resource.h
index a78a8664eabc..5fd7a30a1c1b 100644
--- a/drivers/misc/dlb2/dlb2_resource.h
+++ b/drivers/misc/dlb2/dlb2_resource.h
@@ -445,6 +445,134 @@ int dlb2_hw_disable_dir_port(struct dlb2_hw *hw,
 			     unsigned int vdev_id);
 
 /**
+ * dlb2_configure_ldb_cq_interrupt() - configure load-balanced CQ for
+ *					interrupts
+ * @hw: dlb2_hw handle for a particular device.
+ * @port_id: load-balanced port ID.
+ * @vector: interrupt vector ID. Should be 0 for MSI or compressed MSI-X mode,
+ *	    else a value up to 64.
+ * @mode: interrupt type (DLB2_CQ_ISR_MODE_MSI or DLB2_CQ_ISR_MODE_MSIX)
+ * @vf: If the port is VF-owned, the VF's ID. This is used for translating the
+ *	virtual port ID to a physical port ID. Ignored if mode is not MSI.
+ * @owner_vf: the VF to route the interrupt to. Ignore if mode is not MSI.
+ * @threshold: the minimum CQ depth at which the interrupt can fire. Must be
+ *	greater than 0.
+ *
+ * This function configures the DLB registers for load-balanced CQ's
+ * interrupts. This doesn't enable the CQ's interrupt; that can be done with
+ * dlb2_arm_cq_interrupt() or through an interrupt arm QE.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise.
+ *
+ * Errors:
+ * EINVAL - The port ID is invalid.
+ */
+int dlb2_configure_ldb_cq_interrupt(struct dlb2_hw *hw,
+				    int port_id,
+				    int vector,
+				    int mode,
+				    unsigned int vf,
+				    unsigned int owner_vf,
+				    u16 threshold);
+
+/**
+ * dlb2_configure_dir_cq_interrupt() - configure directed CQ for interrupts
+ * @hw: dlb2_hw handle for a particular device.
+ * @port_id: load-balanced port ID.
+ * @vector: interrupt vector ID. Should be 0 for MSI or compressed MSI-X mode,
+ *	    else a value up to 64.
+ * @mode: interrupt type (DLB2_CQ_ISR_MODE_MSI or DLB2_CQ_ISR_MODE_MSIX)
+ * @vf: If the port is VF-owned, the VF's ID. This is used for translating the
+ *	virtual port ID to a physical port ID. Ignored if mode is not MSI.
+ * @owner_vf: the VF to route the interrupt to. Ignore if mode is not MSI.
+ * @threshold: the minimum CQ depth at which the interrupt can fire. Must be
+ *	greater than 0.
+ *
+ * This function configures the DLB registers for directed CQ's interrupts.
+ * This doesn't enable the CQ's interrupt; that can be done with
+ * dlb2_arm_cq_interrupt() or through an interrupt arm QE.
+ *
+ * Return:
+ * Returns 0 upon success, < 0 otherwise.
+ *
+ * Errors:
+ * EINVAL - The port ID is invalid.
+ */
+int dlb2_configure_dir_cq_interrupt(struct dlb2_hw *hw,
+				    int port_id,
+				    int vector,
+				    int mode,
+				    unsigned int vf,
+				    unsigned int owner_vf,
+				    u16 threshold);
+
+/**
+ * dlb2_set_msix_mode() - enable certain hardware alarm interrupts
+ * @hw: dlb2_hw handle for a particular device.
+ * @mode: MSI-X mode (DLB2_MSIX_MODE_PACKED or DLB2_MSIX_MODE_COMPRESSED)
+ *
+ * This function configures the hardware to use either packed or compressed
+ * mode. This function should not be called if using MSI interrupts.
+ */
+void dlb2_set_msix_mode(struct dlb2_hw *hw, int mode);
+
+/**
+ * dlb2_arm_cq_interrupt() - arm a CQ's interrupt
+ * @hw: dlb2_hw handle for a particular device.
+ * @port_id: port ID
+ * @is_ldb: true for load-balanced port, false for a directed port
+ * @vdev_request: indicates whether this request came from a vdev.
+ * @vdev_id: If vdev_request is true, this contains the vdev's ID.
+ *
+ * This function arms the CQ's interrupt. The CQ must be configured prior to
+ * calling this function.
+ *
+ * The function does no parameter validation; that is the caller's
+ * responsibility.
+ *
+ * A vdev can be either an SR-IOV virtual function or a Scalable IOV virtual
+ * device.
+ *
+ * Return: returns 0 upon success, <0 otherwise.
+ *
+ * EINVAL - Invalid port ID.
+ */
+int dlb2_arm_cq_interrupt(struct dlb2_hw *hw,
+			  int port_id,
+			  bool is_ldb,
+			  bool vdev_request,
+			  unsigned int vdev_id);
+
+/**
+ * dlb2_read_compressed_cq_intr_status() - read compressed CQ interrupt status
+ * @hw: dlb2_hw handle for a particular device.
+ * @ldb_interrupts: 2-entry array of u32 bitmaps
+ * @dir_interrupts: 4-entry array of u32 bitmaps
+ *
+ * This function can be called from a compressed CQ interrupt handler to
+ * determine which CQ interrupts have fired. The caller should take appropriate
+ * (such as waking threads blocked on a CQ's interrupt) then ack the interrupts
+ * with dlb2_ack_compressed_cq_intr().
+ */
+void dlb2_read_compressed_cq_intr_status(struct dlb2_hw *hw,
+					 u32 *ldb_interrupts,
+					 u32 *dir_interrupts);
+
+/**
+ * dlb2_ack_compressed_cq_intr_status() - ack compressed CQ interrupts
+ * @hw: dlb2_hw handle for a particular device.
+ * @ldb_interrupts: 2-entry array of u32 bitmaps
+ * @dir_interrupts: 4-entry array of u32 bitmaps
+ *
+ * This function ACKs compressed CQ interrupts. Its arguments should be the
+ * same ones passed to dlb2_read_compressed_cq_intr_status().
+ */
+void dlb2_ack_compressed_cq_intr(struct dlb2_hw *hw,
+				 u32 *ldb_interrupts,
+				 u32 *dir_interrupts);
+
+/**
  * dlb2_reset_domain() - reset a scheduling domain
  * @hw: dlb2_hw handle for a particular device.
  * @domain_id: domain ID.
diff --git a/include/uapi/linux/dlb2_user.h b/include/uapi/linux/dlb2_user.h
index 00e9833bae1b..9edeff826e15 100644
--- a/include/uapi/linux/dlb2_user.h
+++ b/include/uapi/linux/dlb2_user.h
@@ -609,6 +609,38 @@ struct dlb2_disable_dir_port_args {
 	__u32 padding0;
 };
 
+/*
+ * DLB2_DOMAIN_CMD_BLOCK_ON_CQ_INTERRUPT: Block on a CQ interrupt until a QE
+ *	arrives for the specified port. If a QE is already present, the ioctl
+ *	will immediately return.
+ *
+ *	Note: Only one thread can block on a CQ's interrupt at a time. Doing
+ *	otherwise can result in hung threads.
+ *
+ * Input parameters:
+ * - port_id: Port ID.
+ * - is_ldb: True if the port is load-balanced, false otherwise.
+ * - arm: Tell the driver to arm the interrupt.
+ * - cq_gen: Current CQ generation bit.
+ * - padding0: Reserved for future use.
+ * - cq_va: VA of the CQ entry where the next QE will be placed.
+ *
+ * Output parameters:
+ * - response.status: Detailed error code. In certain cases, such as if the
+ *	ioctl request arg is invalid, the driver won't set status.
+ */
+struct dlb2_block_on_cq_interrupt_args {
+	/* Output parameters */
+	struct dlb2_cmd_response response;
+	/* Input parameters */
+	__u32 port_id;
+	__u8 is_ldb;
+	__u8 arm;
+	__u8 cq_gen;
+	__u8 padding0;
+	__u64 cq_va;
+};
+
 enum dlb2_domain_user_interface_commands {
 	DLB2_DOMAIN_CMD_CREATE_LDB_QUEUE,
 	DLB2_DOMAIN_CMD_CREATE_DIR_QUEUE,
@@ -628,6 +660,7 @@ enum dlb2_domain_user_interface_commands {
 	DLB2_DOMAIN_CMD_ENABLE_DIR_PORT,
 	DLB2_DOMAIN_CMD_DISABLE_LDB_PORT,
 	DLB2_DOMAIN_CMD_DISABLE_DIR_PORT,
+	DLB2_DOMAIN_CMD_BLOCK_ON_CQ_INTERRUPT,
 
 	/* NUM_DLB2_DOMAIN_CMD must be last */
 	NUM_DLB2_DOMAIN_CMD,
@@ -734,5 +767,9 @@ enum dlb2_domain_user_interface_commands {
 		_IOWR(DLB2_IOC_MAGIC,				\
 		      DLB2_DOMAIN_CMD_DISABLE_DIR_PORT,		\
 		      struct dlb2_disable_dir_port_args)
+#define DLB2_IOC_BLOCK_ON_CQ_INTERRUPT				\
+		_IOWR(DLB2_IOC_MAGIC,				\
+		      DLB2_DOMAIN_CMD_BLOCK_ON_CQ_INTERRUPT,	\
+		      struct dlb2_block_on_cq_interrupt_args)
 
 #endif /* __DLB2_USER_H */
-- 
2.13.6

