Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35429C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 056582080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgIGLUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:20:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56126 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728503AbgIGLRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:17:55 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AC6FFFEDE6F0647C125F;
        Mon,  7 Sep 2020 19:17:40 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 19:17:32 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH] PCI: Factor functions of PCI function reset
Date:   Mon, 7 Sep 2020 19:16:27 +0800
Message-ID: <1599477387-49777-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previosly we use pci_probe_reset_function() to probe whehter a function
can be reset and use __pci_reset_function_locked() to perform a function
reset. These two functions have lots of common lines.

Factor the two functions and reduce the redundancy.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/pci.c   | 61 ++++++++++++++++-------------------------------------
 drivers/pci/pci.h   |  2 +-
 drivers/pci/probe.c |  2 +-
 3 files changed, 20 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e39c549..e3e5f0f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5006,9 +5006,11 @@ static void pci_dev_restore(struct pci_dev *dev)
 }
 
 /**
- * __pci_reset_function_locked - reset a PCI device function while holding
- * the @dev mutex lock.
+ * pci_probe_reset_function - check whether the device can be safely reset
+ *                            or reset a PCI device function while holding
+ *                            the @dev mutex lock.
  * @dev: PCI device to reset
+ * @probe: Probe or not whether the device can be reset.
  *
  * Some devices allow an individual function to be reset without affecting
  * other functions in the same device.  The PCI device must be responsive
@@ -5022,10 +5024,10 @@ static void pci_dev_restore(struct pci_dev *dev)
  * device including MSI, bus mastering, BARs, decoding IO and memory spaces,
  * etc.
  *
- * Returns 0 if the device function was successfully reset or negative if the
- * device doesn't support resetting a single function.
+ * Returns 0 if the device function can be reset or was successfully reset.
+ * negative if the device doesn't support resetting a single function.
  */
-int __pci_reset_function_locked(struct pci_dev *dev)
+int pci_probe_reset_function(struct pci_dev *dev, int probe)
 {
 	int rc;
 
@@ -5039,61 +5041,34 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 	 * other error, we're also finished: this indicates that further
 	 * reset mechanisms might be broken on the device.
 	 */
-	rc = pci_dev_specific_reset(dev, 0);
+	rc = pci_dev_specific_reset(dev, probe);
 	if (rc != -ENOTTY)
 		return rc;
 	if (pcie_has_flr(dev)) {
+		if (probe)
+			return 0;
 		rc = pcie_flr(dev);
 		if (rc != -ENOTTY)
 			return rc;
 	}
-	rc = pci_af_flr(dev, 0);
+	rc = pci_af_flr(dev, probe);
 	if (rc != -ENOTTY)
 		return rc;
-	rc = pci_pm_reset(dev, 0);
+	rc = pci_pm_reset(dev, probe);
 	if (rc != -ENOTTY)
 		return rc;
-	rc = pci_dev_reset_slot_function(dev, 0);
+	rc = pci_dev_reset_slot_function(dev, probe);
 	if (rc != -ENOTTY)
 		return rc;
-	return pci_parent_bus_reset(dev, 0);
+
+	return pci_parent_bus_reset(dev, probe);
 }
-EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
 
-/**
- * pci_probe_reset_function - check whether the device can be safely reset
- * @dev: PCI device to reset
- *
- * Some devices allow an individual function to be reset without affecting
- * other functions in the same device.  The PCI device must be responsive
- * to PCI config space in order to use this function.
- *
- * Returns 0 if the device function can be reset or negative if the
- * device doesn't support resetting a single function.
- */
-int pci_probe_reset_function(struct pci_dev *dev)
+int __pci_reset_function_locked(struct pci_dev *dev)
 {
-	int rc;
-
-	might_sleep();
-
-	rc = pci_dev_specific_reset(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	if (pcie_has_flr(dev))
-		return 0;
-	rc = pci_af_flr(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_pm_reset(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-	rc = pci_dev_reset_slot_function(dev, 1);
-	if (rc != -ENOTTY)
-		return rc;
-
-	return pci_parent_bus_reset(dev, 1);
+	return pci_probe_reset_function(dev, 0);
 }
+EXPORT_SYMBOL_GPL(__pci_reset_function_locked);
 
 /**
  * pci_reset_function - quiesce and reset a PCI device function
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fa12f7c..73740dd 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -39,7 +39,7 @@ enum pci_mmap_api {
 int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
 		  enum pci_mmap_api mmap_api);
 
-int pci_probe_reset_function(struct pci_dev *dev);
+int pci_probe_reset_function(struct pci_dev *dev, int probe);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 03d3712..793cc8a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2403,7 +2403,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 
 	pcie_report_downtraining(dev);
 
-	if (pci_probe_reset_function(dev) == 0)
+	if (pci_probe_reset_function(dev, 1) == 0)
 		dev->reset_fn = 1;
 }
 
-- 
2.8.1

