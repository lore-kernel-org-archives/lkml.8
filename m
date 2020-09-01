Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86216C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7224A20767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbgIATVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:21:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:6011 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727939AbgIATVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:21:34 -0400
IronPort-SDR: xBEwPdDDh9UhoaraTf6dGtsrAKlj1xXBpuyydRexE+hi9tpnUWjgtpAc7bqwQIFdIlzblTQOlp
 E8OpUhvEaORA==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="154764412"
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="154764412"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 12:21:30 -0700
IronPort-SDR: eUZ0PTm1F1sUhm2fSuv+q6SClprXZNafuxVy1jt9CkzHTPI+d2Mrw73b80ES909MHATikyf8E8
 0YQExCN7Oo4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,380,1592895600"; 
   d="scan'208";a="325480461"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2020 12:21:29 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH v3 06/19] dlb2: add runtime power-management support
Date:   Tue,  1 Sep 2020 14:15:35 -0500
Message-Id: <20200901191548.31646-7-gage.eads@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20200901191548.31646-1-gage.eads@intel.com>
References: <20200901191548.31646-1-gage.eads@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver's power-management policy is to put the device in D0 when in use
(when there are any open device files or memory mappings, or there are any
virtual devices), and leave it in D3Hot otherwise. This includes
resume/suspend callbacks; when the device resumes, the driver resets the
hardware to a known good state.

Signed-off-by: Gage Eads <gage.eads@intel.com>
Reviewed-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 drivers/misc/dlb2/dlb2_main.c   | 72 +++++++++++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_main.h   |  2 ++
 drivers/misc/dlb2/dlb2_pf_ops.c | 30 +++++++++++++++++
 3 files changed, 104 insertions(+)

diff --git a/drivers/misc/dlb2/dlb2_main.c b/drivers/misc/dlb2/dlb2_main.c
index 2e9b8c2d479c..17a26e6856d1 100644
--- a/drivers/misc/dlb2/dlb2_main.c
+++ b/drivers/misc/dlb2/dlb2_main.c
@@ -61,11 +61,19 @@ static int dlb2_open(struct inode *i, struct file *f)
 
 	f->private_data = dev;
 
+	dev->ops->inc_pm_refcnt(dev->pdev, true);
+
 	return 0;
 }
 
 static int dlb2_close(struct inode *i, struct file *f)
 {
+	struct dlb2_dev *dev;
+
+	dev = container_of(f->f_inode->i_cdev, struct dlb2_dev, cdev);
+
+	dev->ops->dec_pm_refcnt(dev->pdev);
+
 	return 0;
 }
 
@@ -94,6 +102,8 @@ int dlb2_init_domain(struct dlb2_dev *dlb2_dev, u32 domain_id)
 
 	dlb2_dev->sched_domains[domain_id] = domain;
 
+	dlb2_dev->ops->inc_pm_refcnt(dlb2_dev->pdev, true);
+
 	return 0;
 }
 
@@ -134,6 +144,8 @@ static int dlb2_domain_close(struct inode *i, struct file *f)
 
 	kref_put(&domain->refcnt, dlb2_free_domain);
 
+	dev->ops->dec_pm_refcnt(dev->pdev);
+
 	mutex_unlock(&dev->resource_mutex);
 
 	return ret;
@@ -262,6 +274,15 @@ static int dlb2_probe(struct pci_dev *pdev,
 	list_add(&dlb2_dev->list, &dlb2_dev_list);
 	mutex_unlock(&dlb2_driver_lock);
 
+	/*
+	 * The driver puts the device to sleep (D3hot) while there are no
+	 * scheduling domains to service. The usage counter of a PCI device at
+	 * probe time is 2, so decrement it twice here. (The PCI layer has
+	 * already called pm_runtime_enable().)
+	 */
+	dlb2_dev->ops->dec_pm_refcnt(pdev);
+	dlb2_dev->ops->dec_pm_refcnt(pdev);
+
 	return 0;
 
 init_driver_state_fail:
@@ -298,6 +319,10 @@ static void dlb2_remove(struct pci_dev *pdev)
 	list_del(&dlb2_dev->list);
 	mutex_unlock(&dlb2_driver_lock);
 
+	/* Undo the PM operations in dlb2_probe(). */
+	dlb2_dev->ops->inc_pm_refcnt(pdev, false);
+	dlb2_dev->ops->inc_pm_refcnt(pdev, false);
+
 	dlb2_dev->ops->free_driver_state(dlb2_dev);
 
 	dlb2_resource_free(&dlb2_dev->hw);
@@ -319,17 +344,64 @@ static void dlb2_remove(struct pci_dev *pdev)
 	devm_kfree(&pdev->dev, dlb2_dev);
 }
 
+#ifdef CONFIG_PM
+static void dlb2_reset_hardware_state(struct dlb2_dev *dev)
+{
+	dlb2_reset_device(dev->pdev);
+
+	/* Reinitialize any other hardware state */
+	dev->ops->init_hardware(dev);
+}
+
+static int dlb2_runtime_suspend(struct device *dev)
+{
+	/* Return and let the PCI subsystem put the device in D3hot. */
+
+	return 0;
+}
+
+static int dlb2_runtime_resume(struct device *dev)
+{
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct dlb2_dev *dlb2_dev = pci_get_drvdata(pdev);
+	int ret;
+
+	/*
+	 * The PCI subsystem put the device in D0, but the device may not have
+	 * completed powering up. Wait until the device is ready before
+	 * proceeding.
+	 */
+	ret = dlb2_dev->ops->wait_for_device_ready(dlb2_dev, pdev);
+	if (ret)
+		return ret;
+
+	/* Now reinitialize the device state. */
+	dlb2_reset_hardware_state(dlb2_dev);
+
+	return 0;
+}
+#endif
+
 static struct pci_device_id dlb2_id_table[] = {
 	{ PCI_DEVICE_DATA(INTEL, DLB2_PF, DLB2_PF) },
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, dlb2_id_table);
 
+#ifdef CONFIG_PM
+static const struct dev_pm_ops dlb2_pm_ops = {
+	SET_RUNTIME_PM_OPS(dlb2_runtime_suspend, dlb2_runtime_resume, NULL)
+};
+#endif
+
 static struct pci_driver dlb2_pci_driver = {
 	.name		 = (char *)dlb2_driver_name,
 	.id_table	 = dlb2_id_table,
 	.probe		 = dlb2_probe,
 	.remove		 = dlb2_remove,
+#ifdef CONFIG_PM
+	.driver.pm	 = &dlb2_pm_ops,
+#endif
 };
 
 static int __init dlb2_init_module(void)
diff --git a/drivers/misc/dlb2/dlb2_main.h b/drivers/misc/dlb2/dlb2_main.h
index 79378a47127f..86344f223649 100644
--- a/drivers/misc/dlb2/dlb2_main.h
+++ b/drivers/misc/dlb2/dlb2_main.h
@@ -41,6 +41,8 @@ struct dlb2_device_ops {
 	int (*map_pci_bar_space)(struct dlb2_dev *dev, struct pci_dev *pdev);
 	void (*unmap_pci_bar_space)(struct dlb2_dev *dev,
 				    struct pci_dev *pdev);
+	void (*inc_pm_refcnt)(struct pci_dev *pdev, bool resume);
+	void (*dec_pm_refcnt)(struct pci_dev *pdev);
 	int (*init_driver_state)(struct dlb2_dev *dev);
 	void (*free_driver_state)(struct dlb2_dev *dev);
 	int (*device_create)(struct dlb2_dev *dlb2_dev,
diff --git a/drivers/misc/dlb2/dlb2_pf_ops.c b/drivers/misc/dlb2/dlb2_pf_ops.c
index d7bff677abda..6ca06406b0f2 100644
--- a/drivers/misc/dlb2/dlb2_pf_ops.c
+++ b/drivers/misc/dlb2/dlb2_pf_ops.c
@@ -2,11 +2,39 @@
 /* Copyright(c) 2017-2020 Intel Corporation */
 
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 
 #include "dlb2_main.h"
 #include "dlb2_regs.h"
 #include "dlb2_resource.h"
 
+/***********************************/
+/****** Runtime PM management ******/
+/***********************************/
+
+static void
+dlb2_pf_pm_inc_refcnt(struct pci_dev *pdev, bool resume)
+{
+	if (resume)
+		/*
+		 * Increment the device's usage count and immediately wake it
+		 * if it was suspended.
+		 */
+		pm_runtime_get_sync(&pdev->dev);
+	else
+		pm_runtime_get_noresume(&pdev->dev);
+}
+
+static void
+dlb2_pf_pm_dec_refcnt(struct pci_dev *pdev)
+{
+	/*
+	 * Decrement the device's usage count and suspend it if the
+	 * count reaches zero.
+	 */
+	pm_runtime_put_sync_suspend(&pdev->dev);
+}
+
 /********************************/
 /****** PCI BAR management ******/
 /********************************/
@@ -207,6 +235,8 @@ dlb2_pf_reset_domain(struct dlb2_hw *hw, u32 id)
 struct dlb2_device_ops dlb2_pf_ops = {
 	.map_pci_bar_space = dlb2_pf_map_pci_bar_space,
 	.unmap_pci_bar_space = dlb2_pf_unmap_pci_bar_space,
+	.inc_pm_refcnt = dlb2_pf_pm_inc_refcnt,
+	.dec_pm_refcnt = dlb2_pf_pm_dec_refcnt,
 	.init_driver_state = dlb2_pf_init_driver_state,
 	.free_driver_state = dlb2_pf_free_driver_state,
 	.device_create = dlb2_pf_device_create,
-- 
2.13.6

