Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B889AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE4220715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgGFMnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:43:21 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42762 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbgGFMnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:43:10 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3D0851A06AF;
        Mon,  6 Jul 2020 14:43:08 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 30C351A0650;
        Mon,  6 Jul 2020 14:43:08 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id CF154203C3;
        Mon,  6 Jul 2020 14:43:07 +0200 (CEST)
From:   Diana Craciun <diana.craciun@nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com,
        gregkh@linuxfoundation.org
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, bharatb.linux@gmail.com,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v3 08/13] bus/fsl-mc: Export a cleanup function for DPRC
Date:   Mon,  6 Jul 2020 15:42:38 +0300
Message-Id: <20200706124243.10697-9-diana.craciun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706124243.10697-1-diana.craciun@nxp.com>
References: <20200706124243.10697-1-diana.craciun@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Diana Craciun <diana.craciun@oss.nxp.com>

Create and export a cleanup function for DPRC. The function
is used by the DPRC driver, but it will be used by the VFIO
driver as well.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 52 ++++++++++++++++++++++++--------
 include/linux/fsl/mc.h           |  2 ++
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 4f7fa5127844..07012894cc9c 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -719,33 +719,25 @@ static void dprc_teardown_irq(struct fsl_mc_device *mc_dev)
 }
 
 /**
- * dprc_remove - callback invoked when a DPRC is being unbound from this driver
+ * dprc_cleanup - function that cleanups a DPRC
  *
  * @mc_dev: Pointer to fsl-mc device representing the DPRC
  *
- * It removes the DPRC's child objects from Linux (not from the MC) and
- * closes the DPRC device in the MC.
- * It tears down the interrupts that were configured for the DPRC device.
+ * It closes the DPRC device in the MC.
  * It destroys the interrupt pool associated with this MC bus.
  */
-static int dprc_remove(struct fsl_mc_device *mc_dev)
+
+int dprc_cleanup(struct fsl_mc_device *mc_dev)
 {
 	int error;
 	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_dev);
 
 	if (!is_fsl_mc_bus_dprc(mc_dev))
 		return -EINVAL;
-	if (!mc_dev->mc_io)
-		return -EINVAL;
 
-	if (!mc_bus->irq_resources)
+	if (!mc_dev->mc_io)
 		return -EINVAL;
 
-	if (dev_get_msi_domain(&mc_dev->dev))
-		dprc_teardown_irq(mc_dev);
-
-	device_for_each_child(&mc_dev->dev, NULL, __fsl_mc_device_remove);
-
 	if (dev_get_msi_domain(&mc_dev->dev)) {
 		fsl_mc_cleanup_irq_pool(mc_bus);
 		dev_set_msi_domain(&mc_dev->dev, NULL);
@@ -762,6 +754,40 @@ static int dprc_remove(struct fsl_mc_device *mc_dev)
 		mc_dev->mc_io = NULL;
 	}
 
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dprc_cleanup);
+
+/**
+ * dprc_remove - callback invoked when a DPRC is being unbound from this driver
+ *
+ * @mc_dev: Pointer to fsl-mc device representing the DPRC
+ *
+ * It removes the DPRC's child objects from Linux (not from the MC) and
+ * closes the DPRC device in the MC.
+ * It tears down the interrupts that were configured for the DPRC device.
+ * It destroys the interrupt pool associated with this MC bus.
+ */
+static int dprc_remove(struct fsl_mc_device *mc_dev)
+{
+	int error;
+	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_dev);
+
+	if (!is_fsl_mc_bus_dprc(mc_dev))
+		return -EINVAL;
+
+	if (!mc_bus->irq_resources)
+		return -EINVAL;
+
+	if (dev_get_msi_domain(&mc_dev->dev))
+		dprc_teardown_irq(mc_dev);
+
+	device_for_each_child(&mc_dev->dev, NULL, __fsl_mc_device_remove);
+
+	error = dprc_cleanup(mc_dev);
+	if (error < 0)
+		dev_err(&mc_dev->dev, "dprc_close() failed: %d\n", error);
+
 	dev_info(&mc_dev->dev, "DPRC device unbound from driver");
 	return 0;
 }
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 4bfe18fe8fea..ee5ffae043a3 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -504,6 +504,8 @@ int dprc_reset_container(struct fsl_mc_io *mc_io,
 int dprc_scan_container(struct fsl_mc_device *mc_bus_dev,
 			bool alloc_interrupts);
 
+int dprc_cleanup(struct fsl_mc_device *mc_dev);
+
 /*
  * Data Path Buffer Pool (DPBP) API
  * Contains initialization APIs and runtime control APIs for DPBP
-- 
2.17.1

