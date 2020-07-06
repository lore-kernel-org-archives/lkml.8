Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7C9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0904F20773
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbgGFMng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:43:36 -0400
Received: from inva021.nxp.com ([92.121.34.21]:38076 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729175AbgGFMnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:43:11 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A2D93201534;
        Mon,  6 Jul 2020 14:43:08 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 95DC7200685;
        Mon,  6 Jul 2020 14:43:08 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 3FF97203C3;
        Mon,  6 Jul 2020 14:43:08 +0200 (CEST)
From:   Diana Craciun <diana.craciun@nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com,
        gregkh@linuxfoundation.org
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, bharatb.linux@gmail.com,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v3 09/13] bus/fsl-mc: Add a container setup function
Date:   Mon,  6 Jul 2020 15:42:39 +0300
Message-Id: <20200706124243.10697-10-diana.craciun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706124243.10697-1-diana.craciun@nxp.com>
References: <20200706124243.10697-1-diana.craciun@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Diana Craciun <diana.craciun@oss.nxp.com>

Both DPRC driver and VFIO driver use the same initialization code
for the DPRC. Introduced a new function which groups this
initialization code. The function is exported and may be
used by VFIO as well.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 78 ++++++++++++++++++++++----------
 include/linux/fsl/mc.h           |  2 +
 2 files changed, 55 insertions(+), 25 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 07012894cc9c..ec44d025f623 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -564,16 +564,15 @@ static int dprc_setup_irq(struct fsl_mc_device *mc_dev)
 }
 
 /**
- * dprc_probe - callback invoked when a DPRC is being bound to this driver
+ * dprc_setup - opens and creates a mc_io for DPRC
  *
  * @mc_dev: Pointer to fsl-mc device representing a DPRC
  *
  * It opens the physical DPRC in the MC.
- * It scans the DPRC to discover the MC objects contained in it.
- * It creates the interrupt pool for the MC bus associated with the DPRC.
- * It configures the interrupts for the DPRC device itself.
+ * It configures the DPRC portal used to communicate with MC
  */
-static int dprc_probe(struct fsl_mc_device *mc_dev)
+
+int dprc_setup(struct fsl_mc_device *mc_dev)
 {
 	int error;
 	size_t region_size;
@@ -583,12 +582,6 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
 	bool msi_domain_set = false;
 	u16 major_ver, minor_ver;
 
-	if (!is_fsl_mc_bus_dprc(mc_dev))
-		return -EINVAL;
-
-	if (dev_get_msi_domain(&mc_dev->dev))
-		return -EINVAL;
-
 	if (!mc_dev->mc_io) {
 		/*
 		 * This is a child DPRC:
@@ -635,6 +628,7 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
 		} else {
 			dev_set_msi_domain(&mc_dev->dev, mc_msi_domain);
 			msi_domain_set = true;
+
 		}
 	}
 
@@ -672,35 +666,69 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
 		goto error_cleanup_open;
 	}
 
+	return 0;
+
+error_cleanup_open:
+	(void)dprc_close(mc_dev->mc_io, 0, mc_dev->mc_handle);
+
+error_cleanup_msi_domain:
+	if (msi_domain_set)
+		dev_set_msi_domain(&mc_dev->dev, NULL);
+
+	if (mc_io_created) {
+		fsl_destroy_mc_io(mc_dev->mc_io);
+		mc_dev->mc_io = NULL;
+	}
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(dprc_setup);
+
+/**
+ * dprc_probe - callback invoked when a DPRC is being bound to this driver
+ *
+ * @mc_dev: Pointer to fsl-mc device representing a DPRC
+ *
+ * It opens the physical DPRC in the MC.
+ * It scans the DPRC to discover the MC objects contained in it.
+ * It creates the interrupt pool for the MC bus associated with the DPRC.
+ * It configures the interrupts for the DPRC device itself.
+ */
+static int dprc_probe(struct fsl_mc_device *mc_dev)
+{
+	int error;
+
+	if (!is_fsl_mc_bus_dprc(mc_dev))
+		return -EINVAL;
+
+	if (dev_get_msi_domain(&mc_dev->dev))
+		return -EINVAL;
+
+	error = dprc_setup(mc_dev);
+	if (error < 0)
+		return error;
+
 	/*
 	 * Discover MC objects in DPRC object:
 	 */
 	error = dprc_scan_container(mc_dev, true);
 	if (error < 0)
-		goto error_cleanup_open;
+		goto dprc_cleanup;
 
 	/*
 	 * Configure interrupt for the DPRC object associated with this MC bus:
 	 */
 	error = dprc_setup_irq(mc_dev);
 	if (error < 0)
-		goto error_cleanup_open;
+		goto scan_cleanup;
 
 	dev_info(&mc_dev->dev, "DPRC device bound to driver");
 	return 0;
 
-error_cleanup_open:
-	(void)dprc_close(mc_dev->mc_io, 0, mc_dev->mc_handle);
-
-error_cleanup_msi_domain:
-	if (msi_domain_set)
-		dev_set_msi_domain(&mc_dev->dev, NULL);
-
-	if (mc_io_created) {
-		fsl_destroy_mc_io(mc_dev->mc_io);
-		mc_dev->mc_io = NULL;
-	}
-
+scan_cleanup:
+	device_for_each_child(&mc_dev->dev, NULL, __fsl_mc_device_remove);
+dprc_cleanup:
+	dprc_cleanup(mc_dev);
 	return error;
 }
 
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index ee5ffae043a3..7cfe3b304602 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -506,6 +506,8 @@ int dprc_scan_container(struct fsl_mc_device *mc_bus_dev,
 
 int dprc_cleanup(struct fsl_mc_device *mc_dev);
 
+int dprc_setup(struct fsl_mc_device *mc_dev);
+
 /*
  * Data Path Buffer Pool (DPBP) API
  * Contains initialization APIs and runtime control APIs for DPBP
-- 
2.17.1

