Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1D1C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F767206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 13:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgGLNrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 09:47:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:8461 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728970AbgGLNrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:47:17 -0400
IronPort-SDR: V9qtZth8hWlLce4PfSPwPbxmEtBoqIePt4r6dpFMAPxdeIb2hO7iNUIn4ZbHHhfcMA1hvUJPbc
 exnNkm6gEILA==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="146540898"
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
   d="scan'208";a="146540898"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 06:46:46 -0700
IronPort-SDR: UMgfe8EheEmPKH6JHfOSFPPjyCtWglGWnREENK4Eq0dtABXm4O9g1s/U7vehXu4TPKYO0LN8q+
 W4eXTldPmmmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,343,1589266800"; 
   d="scan'208";a="307148612"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2020 06:46:46 -0700
From:   Gage Eads <gage.eads@intel.com>
To:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH 07/20] dlb2: add runtime power-management support
Date:   Sun, 12 Jul 2020 08:43:18 -0500
Message-Id: <20200712134331.8169-8-gage.eads@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20200712134331.8169-1-gage.eads@intel.com>
References: <20200712134331.8169-1-gage.eads@intel.com>
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
 drivers/misc/dlb2/dlb2_ioctl.c  |  2 ++
 drivers/misc/dlb2/dlb2_main.c   | 79 +++++++++++++++++++++++++++++++++++++++++
 drivers/misc/dlb2/dlb2_main.h   |  2 ++
 drivers/misc/dlb2/dlb2_pf_ops.c | 30 ++++++++++++++++
 4 files changed, 113 insertions(+)

diff --git a/drivers/misc/dlb2/dlb2_ioctl.c b/drivers/misc/dlb2/dlb2_ioctl.c
index eef9b824b276..b36e255e8d35 100644
--- a/drivers/misc/dlb2/dlb2_ioctl.c
+++ b/drivers/misc/dlb2/dlb2_ioctl.c
@@ -197,6 +197,8 @@ static int dlb2_ioctl_get_sched_domain_fd(struct dlb2_dev *dev,
 	if (ret >= 0) {
 		kref_get(&domain->refcnt);
 
+		dev->ops->inc_pm_refcnt(dev->pdev, true);
+
 		ret = 0;
 	}
 
diff --git a/drivers/misc/dlb2/dlb2_main.c b/drivers/misc/dlb2/dlb2_main.c
index eb716587e738..8ace8e1edbcb 100644
--- a/drivers/misc/dlb2/dlb2_main.c
+++ b/drivers/misc/dlb2/dlb2_main.c
@@ -69,11 +69,21 @@ static int dlb2_open(struct inode *i, struct file *f)
 
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
+	dev_dbg(dev->dlb2_device, "Closing DLB device file\n");
+
+	dev->ops->dec_pm_refcnt(dev->pdev);
+
 	return 0;
 }
 
@@ -120,6 +130,8 @@ int dlb2_init_domain(struct dlb2_dev *dlb2_dev, u32 domain_id)
 
 	dlb2_dev->sched_domains[domain_id] = domain;
 
+	dlb2_dev->ops->inc_pm_refcnt(dlb2_dev->pdev, true);
+
 	return 0;
 }
 
@@ -293,6 +305,15 @@ static int dlb2_probe(struct pci_dev *pdev,
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
@@ -330,6 +351,10 @@ static void dlb2_remove(struct pci_dev *pdev)
 	list_del(&dlb2_dev->list);
 	mutex_unlock(&dlb2_driver_lock);
 
+	/* Undo the PM operations in dlb2_probe(). */
+	dlb2_dev->ops->inc_pm_refcnt(pdev, false);
+	dlb2_dev->ops->inc_pm_refcnt(pdev, false);
+
 	dlb2_dev->ops->free_driver_state(dlb2_dev);
 
 	dlb2_resource_free(&dlb2_dev->hw);
@@ -351,17 +376,71 @@ static void dlb2_remove(struct pci_dev *pdev)
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
+	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct dlb2_dev *dlb2_dev = pci_get_drvdata(pdev);
+
+	dev_dbg(dlb2_dev->dlb2_device, "Suspending device operation\n");
+
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
+	dev_dbg(dlb2_dev->dlb2_device, "Resuming device operation\n");
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
index 81795754c070..76380f0ca51b 100644
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
index ae83a2feb3f9..e4de46eccf87 100644
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
@@ -226,6 +254,8 @@ dlb2_pf_reset_domain(struct dlb2_hw *hw, u32 id)
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

