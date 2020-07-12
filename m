Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D308C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C4D206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgGLNqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:46:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:8462 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728914AbgGLNqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:46:45 -0400
IronPort-SDR: dNPBaezSzNbNaFPcIN/pab5NtWywPGboSCZr99g5erexot9gwVt7OTrWZH++x56rwuKOeytvQB
 vjJfDEvuNW6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="146540890"
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
   d="scan'208";a="146540890"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 06:46:43 -0700
IronPort-SDR: K8I2aa2jvrDx1+YFRRi+xnU7x7VDgiEfeTobct1fnBb4YiYjpXw78uBr+rllt6896tojCfXpi6
 +hkKyS+G1e8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
   d="scan'208";a="307148593"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2020 06:46:42 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH 02/20] dlb2: initialize PF device
Date:   Sun, 12 Jul 2020 08:43:13 -0500
Message-Id: <20200712134331.8169-3-gage.eads@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20200712134331.8169-1-gage.eads@intel.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver detects the device type (PF/VF) at probe time, and assigns the
corresponding 'ops' callbacks from that. These callbacks include mapping
and unmapping the PCI BAR space, creating/destroying the device, and
adding/deleting a char device.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/misc/dlb2/Makefile        |   5 +-
 drivers/misc/dlb2/dlb2_hw_types.h |  28 ++++++++
 drivers/misc/dlb2/dlb2_main.c     |  49 ++++++++++++-
 drivers/misc/dlb2/dlb2_main.h     |  30 ++++++++
 drivers/misc/dlb2/dlb2_pf_ops.c   | 140 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 249 insertions(+), 3 deletions(-)
 create mode 100644 drivers/misc/dlb2/dlb2_pf_ops.c

diff --git a/drivers/misc/dlb2/Makefile b/drivers/misc/dlb2/Makefile
index 90ae953d2a8f..95e67e5bd8ff 100644
--- a/drivers/misc/dlb2/Makefile
+++ b/drivers/misc/dlb2/Makefile
@@ -4,5 +4,6 @@
 
 obj-$(CONFIG_INTEL_DLB2) := dlb2.o
 
-dlb2-objs :=  \
-  dlb2_main.o \
+dlb2-objs :=    \
+  dlb2_main.o   \
+  dlb2_pf_ops.o \
diff --git a/drivers/misc/dlb2/dlb2_hw_types.h b/drivers/misc/dlb2/dlb2_hw_types.h
index 558099db50b8..860d81bf3103 100644
--- a/drivers/misc/dlb2/dlb2_hw_types.h
+++ b/drivers/misc/dlb2/dlb2_hw_types.h
@@ -5,6 +5,25 @@
 #ifndef __DLB2_HW_TYPES_H
 #define __DLB2_HW_TYPES_H
 
+#include <linux/io.h>
+
+#define DLB2_PCI_REG_READ(addr)        ioread32(addr)
+#define DLB2_PCI_REG_WRITE(reg, value) iowrite32(value, reg)
+
+/* Read/write register 'reg' in the CSR BAR space */
+#define DLB2_CSR_REG_ADDR(a, reg) ((a)->csr_kva + (reg))
+#define DLB2_CSR_RD(hw, reg) \
+	DLB2_PCI_REG_READ(DLB2_CSR_REG_ADDR((hw), (reg)))
+#define DLB2_CSR_WR(hw, reg, value) \
+	DLB2_PCI_REG_WRITE(DLB2_CSR_REG_ADDR((hw), (reg)), (value))
+
+/* Read/write register 'reg' in the func BAR space */
+#define DLB2_FUNC_REG_ADDR(a, reg) ((a)->func_kva + (reg))
+#define DLB2_FUNC_RD(hw, reg) \
+	DLB2_PCI_REG_READ(DLB2_FUNC_REG_ADDR((hw), (reg)))
+#define DLB2_FUNC_WR(hw, reg, value) \
+	DLB2_PCI_REG_WRITE(DLB2_FUNC_REG_ADDR((hw), (reg)), (value))
+
 #define DLB2_MAX_NUM_VDEVS 16
 #define DLB2_MAX_NUM_DOMAINS 32
 #define DLB2_MAX_NUM_LDB_QUEUES 32 /* LDB == load-balanced */
@@ -26,4 +45,13 @@
 #define DLB2_MAX_QID_EMPTY_CHECK_LOOPS (32 * 64 * 1024 * (800 / 30))
 #define DLB2_HZ 800000000
 
+struct dlb2_hw {
+	/* BAR 0 address */
+	void __iomem *csr_kva;
+	unsigned long csr_phys_addr;
+	/* BAR 2 address */
+	void __iomem *func_kva;
+	unsigned long func_phys_addr;
+};
+
 #endif /* __DLB2_HW_TYPES_H */
diff --git a/drivers/misc/dlb2/dlb2_main.c b/drivers/misc/dlb2/dlb2_main.c
index fd953a1c4cb5..d6fb46c05985 100644
--- a/drivers/misc/dlb2/dlb2_main.c
+++ b/drivers/misc/dlb2/dlb2_main.c
@@ -51,6 +51,18 @@ static const struct file_operations dlb2_fops = {
 /****** PCI driver callbacks ******/
 /**********************************/
 
+static void dlb2_assign_ops(struct dlb2_dev *dlb2_dev,
+			    const struct pci_device_id *pdev_id)
+{
+	dlb2_dev->type = pdev_id->driver_data;
+
+	switch (pdev_id->driver_data) {
+	case DLB2_PF:
+		dlb2_dev->ops = &dlb2_pf_ops;
+		break;
+	}
+}
+
 static DEFINE_IDA(dlb2_ids);
 
 static int dlb2_alloc_id(void)
@@ -75,6 +87,8 @@ static int dlb2_probe(struct pci_dev *pdev,
 	if (!dlb2_dev)
 		return -ENOMEM;
 
+	dlb2_assign_ops(dlb2_dev, pdev_id);
+
 	pci_set_drvdata(pdev, dlb2_dev);
 
 	dlb2_dev->pdev = pdev;
@@ -107,12 +121,39 @@ static int dlb2_probe(struct pci_dev *pdev,
 	if (pci_enable_pcie_error_reporting(pdev))
 		dev_info(&pdev->dev, "[%s()] Failed to enable AER\n", __func__);
 
+	ret = dlb2_dev->ops->map_pci_bar_space(dlb2_dev, pdev);
+	if (ret)
+		goto map_pci_bar_fail;
+
+	ret = dlb2_dev->ops->cdev_add(dlb2_dev,
+				      dlb2_dev_number_base,
+				      &dlb2_fops);
+	if (ret)
+		goto cdev_add_fail;
+
+	ret = dlb2_dev->ops->device_create(dlb2_dev, pdev, dlb2_class);
+	if (ret)
+		goto device_add_fail;
+
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret)
+		goto dma_set_mask_fail;
+
 	mutex_lock(&dlb2_driver_lock);
 	list_add(&dlb2_dev->list, &dlb2_dev_list);
 	mutex_unlock(&dlb2_driver_lock);
 
 	return 0;
 
+dma_set_mask_fail:
+	dlb2_dev->ops->device_destroy(dlb2_dev, dlb2_class);
+device_add_fail:
+	dlb2_dev->ops->cdev_del(dlb2_dev);
+cdev_add_fail:
+	dlb2_dev->ops->unmap_pci_bar_space(dlb2_dev, pdev);
+map_pci_bar_fail:
+	pci_disable_pcie_error_reporting(pdev);
+	pci_release_regions(pdev);
 pci_request_regions_fail:
 	pci_disable_device(pdev);
 pci_enable_device_fail:
@@ -134,6 +175,12 @@ static void dlb2_remove(struct pci_dev *pdev)
 	list_del(&dlb2_dev->list);
 	mutex_unlock(&dlb2_driver_lock);
 
+	dlb2_dev->ops->device_destroy(dlb2_dev, dlb2_class);
+
+	dlb2_dev->ops->cdev_del(dlb2_dev);
+
+	dlb2_dev->ops->unmap_pci_bar_space(dlb2_dev, pdev);
+
 	pci_disable_pcie_error_reporting(pdev);
 
 	pci_release_regions(pdev);
@@ -146,7 +193,7 @@ static void dlb2_remove(struct pci_dev *pdev)
 }
 
 static struct pci_device_id dlb2_id_table[] = {
-	{ PCI_DEVICE_DATA(INTEL, DLB2_PF, NULL) },
+	{ PCI_DEVICE_DATA(INTEL, DLB2_PF, DLB2_PF) },
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, dlb2_id_table);
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index cf3d37b0f0ae..5e35d1e7c251 100644
--- a/drivers/misc/dlb2/dlb2_main.h
+++ b/drivers/misc/dlb2/dlb2_main.h
@@ -28,10 +28,40 @@ static const char dlb2_driver_name[] = KBUILD_MODNAME;
 #define DLB2_NUM_FUNCS_PER_DEVICE (1 + DLB2_MAX_NUM_VDEVS)
 #define DLB2_MAX_NUM_DEVICES (DLB2_MAX_NUM_PFS * DLB2_NUM_FUNCS_PER_DEVICE)
 
+enum dlb2_device_type {
+	DLB2_PF,
+	DLB2_VF,
+};
+
+struct dlb2_dev;
+
+struct dlb2_device_ops {
+	int (*map_pci_bar_space)(struct dlb2_dev *dev, struct pci_dev *pdev);
+	void (*unmap_pci_bar_space)(struct dlb2_dev *dev,
+				    struct pci_dev *pdev);
+	int (*device_create)(struct dlb2_dev *dlb2_dev,
+			     struct pci_dev *pdev,
+			     struct class *dlb2_class);
+	void (*device_destroy)(struct dlb2_dev *dlb2_dev,
+			       struct class *dlb2_class);
+	int (*cdev_add)(struct dlb2_dev *dlb2_dev,
+			dev_t base,
+			const struct file_operations *fops);
+	void (*cdev_del)(struct dlb2_dev *dlb2_dev);
+};
+
+extern struct dlb2_device_ops dlb2_pf_ops;
+
 struct dlb2_dev {
 	struct pci_dev *pdev;
+	struct dlb2_hw hw;
+	struct cdev cdev;
+	struct dlb2_device_ops *ops;
 	struct list_head list;
+	struct device *dlb2_device;
+	enum dlb2_device_type type;
 	int id;
+	dev_t dev_number;
 };
 
 #endif /* __DLB2_MAIN_H */
diff --git a/drivers/misc/dlb2/dlb2_pf_ops.c b/drivers/misc/dlb2/dlb2_pf_ops.c
new file mode 100644
index 000000000000..14a50a778675
--- /dev/null
+++ b/drivers/misc/dlb2/dlb2_pf_ops.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2017-2020 Intel Corporation */
+
+#include "dlb2_main.h"
+
+/********************************/
+/****** PCI BAR management ******/
+/********************************/
+
+static void
+dlb2_pf_unmap_pci_bar_space(struct dlb2_dev *dlb2_dev,
+			    struct pci_dev *pdev)
+{
+	pci_iounmap(pdev, dlb2_dev->hw.csr_kva);
+	pci_iounmap(pdev, dlb2_dev->hw.func_kva);
+}
+
+static int
+dlb2_pf_map_pci_bar_space(struct dlb2_dev *dlb2_dev,
+			  struct pci_dev *pdev)
+{
+	/* BAR 0: PF FUNC BAR space */
+	dlb2_dev->hw.func_kva = pci_iomap(pdev, 0, 0);
+	dlb2_dev->hw.func_phys_addr = pci_resource_start(pdev, 0);
+
+	if (!dlb2_dev->hw.func_kva) {
+		dev_err(&pdev->dev, "Cannot iomap BAR 0 (size %llu)\n",
+			pci_resource_len(pdev, 0));
+
+		return -EIO;
+	}
+
+	dev_dbg(&pdev->dev, "BAR 0 iomem base: %p\n",
+		dlb2_dev->hw.func_kva);
+	dev_dbg(&pdev->dev, "BAR 0 start: 0x%llx\n",
+		pci_resource_start(pdev, 0));
+	dev_dbg(&pdev->dev, "BAR 0 len: %llu\n",
+		pci_resource_len(pdev, 0));
+
+	/* BAR 2: PF CSR BAR space */
+	dlb2_dev->hw.csr_kva = pci_iomap(pdev, 2, 0);
+	dlb2_dev->hw.csr_phys_addr = pci_resource_start(pdev, 2);
+
+	if (!dlb2_dev->hw.csr_kva) {
+		dev_err(&pdev->dev, "Cannot iomap BAR 2 (size %llu)\n",
+			pci_resource_len(pdev, 2));
+
+		pci_iounmap(pdev, dlb2_dev->hw.func_kva);
+		return -EIO;
+	}
+
+	dev_dbg(&pdev->dev, "BAR 2 iomem base: %p\n",
+		dlb2_dev->hw.csr_kva);
+	dev_dbg(&pdev->dev, "BAR 2 start: 0x%llx\n",
+		pci_resource_start(pdev, 2));
+	dev_dbg(&pdev->dev, "BAR 2 len: %llu\n",
+		pci_resource_len(pdev, 2));
+
+	return 0;
+}
+
+/*******************************/
+/****** Driver management ******/
+/*******************************/
+
+static int
+dlb2_pf_cdev_add(struct dlb2_dev *dlb2_dev,
+		 dev_t base,
+		 const struct file_operations *fops)
+{
+	int ret;
+
+	dlb2_dev->dev_number = MKDEV(MAJOR(base), MINOR(base) + dlb2_dev->id);
+
+	cdev_init(&dlb2_dev->cdev, fops);
+
+	dlb2_dev->cdev.dev   = dlb2_dev->dev_number;
+	dlb2_dev->cdev.owner = THIS_MODULE;
+
+	ret = cdev_add(&dlb2_dev->cdev, dlb2_dev->cdev.dev, 1);
+	if (ret < 0)
+		dev_err(dlb2_dev->dlb2_device,
+			"%s: cdev_add() returned %d\n",
+			dlb2_driver_name, ret);
+
+	return ret;
+}
+
+static void
+dlb2_pf_cdev_del(struct dlb2_dev *dlb2_dev)
+{
+	cdev_del(&dlb2_dev->cdev);
+}
+
+static int
+dlb2_pf_device_create(struct dlb2_dev *dlb2_dev,
+		      struct pci_dev *pdev,
+		      struct class *dlb2_class)
+{
+	/*
+	 * Create a new device in order to create a /dev/dlb node. This device
+	 * is a child of the DLB PCI device.
+	 */
+	dlb2_dev->dlb2_device = device_create(dlb2_class,
+					      &pdev->dev,
+					      dlb2_dev->dev_number,
+					      dlb2_dev,
+					      "dlb%d",
+					      dlb2_dev->id);
+
+	if (IS_ERR(dlb2_dev->dlb2_device)) {
+		dev_err(&pdev->dev,
+			"%s: device_create() returned %ld\n",
+			dlb2_driver_name, PTR_ERR(dlb2_dev->dlb2_device));
+
+		return PTR_ERR(dlb2_dev->dlb2_device);
+	}
+
+	return 0;
+}
+
+static void
+dlb2_pf_device_destroy(struct dlb2_dev *dlb2_dev,
+		       struct class *dlb2_class)
+{
+	device_destroy(dlb2_class, dlb2_dev->dev_number);
+}
+
+/********************************/
+/****** DLB2 PF Device Ops ******/
+/********************************/
+
+struct dlb2_device_ops dlb2_pf_ops = {
+	.map_pci_bar_space = dlb2_pf_map_pci_bar_space,
+	.unmap_pci_bar_space = dlb2_pf_unmap_pci_bar_space,
+	.device_create = dlb2_pf_device_create,
+	.device_destroy = dlb2_pf_device_destroy,
+	.cdev_add = dlb2_pf_cdev_add,
+	.cdev_del = dlb2_pf_cdev_del,
+};
-- 
2.13.6

