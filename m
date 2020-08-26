Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18339C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F12AD2087D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgHZJ1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:27:20 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56472 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbgHZJ0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:26:09 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EDB281A16BA;
        Wed, 26 Aug 2020 11:26:05 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E0A091A1559;
        Wed, 26 Aug 2020 11:26:05 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A5A7202CA;
        Wed, 26 Aug 2020 11:26:05 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, bharatb.linux@gmail.com,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v4 09/13] bus/fsl-mc: Add a container setup function
Date:   Wed, 26 Aug 2020 12:25:23 +0300
Message-Id: <20200826092527.4992-10-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826092527.4992-1-diana.craciun@oss.nxp.com>
References: <20200826092527.4992-1-diana.craciun@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both DPRC driver and VFIO driver use the same initialization code
for the DPRC. Introduced a new function which groups this
initialization code. The function is exported and may be
used by VFIO as well.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 65 ++++++++++++++++++++++----------
 include/linux/fsl/mc.h           |  2 +
 2 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 6d7b9412fb77..471386e9b46c 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -588,16 +588,15 @@ static int dprc_setup_irq(struct fsl_mc_device *mc_dev)
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
@@ -681,35 +680,63 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
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
index 5519a510b8c9..e99d181ee4cd 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -540,6 +540,8 @@ void dprc_remove_devices(struct fsl_mc_device *mc_bus_dev,
 
 int dprc_cleanup(struct fsl_mc_device *mc_dev);
 
+int dprc_setup(struct fsl_mc_device *mc_dev);
+
 /*
  * Data Path Buffer Pool (DPBP) API
  * Contains initialization APIs and runtime control APIs for DPBP
-- 
2.17.1

