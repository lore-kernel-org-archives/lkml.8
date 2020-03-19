Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F403C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0048920836
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgCSPlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:41:21 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41470 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728165AbgCSPlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:41:14 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EB0CF1A0113;
        Thu, 19 Mar 2020 16:41:12 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DEB5E1A010E;
        Thu, 19 Mar 2020 16:41:12 +0100 (CET)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 91415205C2;
        Thu, 19 Mar 2020 16:41:12 +0100 (CET)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com,
        stuyoder@gmail.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, bharatb.yadav@gmail.com
Cc:     Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH 09/10] bus/fsl-mc: Add a container setup function
Date:   Thu, 19 Mar 2020 17:40:50 +0200
Message-Id: <20200319154051.30609-10-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319154051.30609-1-diana.craciun@oss.nxp.com>
References: <20200319154051.30609-1-diana.craciun@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both DPRC driver and VFIO driver use a initialization code
for the DPRC. Introduced a new function which groups this
initialization code. The function is exported and may be
used by VFIO as well.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 77 +++++++++++++++++++++-----------
 drivers/bus/fsl-mc/mc-io.c       |  7 ++-
 include/linux/fsl/mc.h           |  2 +
 3 files changed, 60 insertions(+), 26 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index a655e3fee291..0fe45c301858 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -570,16 +570,15 @@ static int dprc_setup_irq(struct fsl_mc_device *mc_dev)
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
@@ -589,12 +588,6 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
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
@@ -678,35 +671,69 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
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
 	error = dprc_scan_container(mc_dev, NULL, true);
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
 
diff --git a/drivers/bus/fsl-mc/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
index 6ae48ad80409..e1dfe4a76519 100644
--- a/drivers/bus/fsl-mc/mc-io.c
+++ b/drivers/bus/fsl-mc/mc-io.c
@@ -129,7 +129,12 @@ int __must_check fsl_create_mc_io(struct device *dev,
  */
 void fsl_destroy_mc_io(struct fsl_mc_io *mc_io)
 {
-	struct fsl_mc_device *dpmcp_dev = mc_io->dpmcp_dev;
+	struct fsl_mc_device *dpmcp_dev;
+
+	if (!mc_io)
+		return;
+
+	dpmcp_dev = mc_io->dpmcp_dev;
 
 	if (dpmcp_dev)
 		fsl_mc_io_unset_dpmcp(mc_io);
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index e3ba273a1122..59b39c635ec9 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -480,6 +480,8 @@ int dprc_scan_container(struct fsl_mc_device *mc_bus_dev,
 		   const char *driver_override,
 		   bool alloc_interrupts);
 
+int dprc_setup(struct fsl_mc_device *mc_dev);
+
 int dprc_cleanup(struct fsl_mc_device *mc_dev);
 
 /*
-- 
2.17.1

