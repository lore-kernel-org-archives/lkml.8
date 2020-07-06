Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25365C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F29620715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgGFMnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:43:16 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42750 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbgGFMnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:43:10 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CCD011A06A8;
        Mon,  6 Jul 2020 14:43:07 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C05FB1A0650;
        Mon,  6 Jul 2020 14:43:07 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 6A63E203C3;
        Mon,  6 Jul 2020 14:43:07 +0200 (CEST)
From:   Diana Craciun <diana.craciun@nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com,
        gregkh@linuxfoundation.org
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, bharatb.linux@gmail.com,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v3 07/13] bus/fsl-mc: Export a dprc scan function to be used by multiple entities
Date:   Mon,  6 Jul 2020 15:42:37 +0300
Message-Id: <20200706124243.10697-8-diana.craciun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706124243.10697-1-diana.craciun@nxp.com>
References: <20200706124243.10697-1-diana.craciun@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Diana Craciun <diana.craciun@oss.nxp.com>

Currently the DPRC scan function is used only by the bus driver.
But the same functionality will be needed by the VFIO driver.
To support this, the dprc scan function was exported and a little
bit adjusted to fit both scenarios. Also the scan mutex initialization
is done when the bus object is created, not in dprc_probe in order
to be used by both VFIO and bus driver.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 19 +++++++------------
 drivers/bus/fsl-mc/fsl-mc-bus.c  |  1 +
 include/linux/fsl/mc.h           |  3 +++
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 7a8061224df8..4f7fa5127844 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -331,9 +331,10 @@ static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
  * bus driver with the actual state of the MC by adding and removing
  * devices as appropriate.
  */
-static int dprc_scan_container(struct fsl_mc_device *mc_bus_dev)
+int dprc_scan_container(struct fsl_mc_device *mc_bus_dev,
+			bool alloc_interrupts)
 {
-	int error;
+	int error = 0;
 	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_bus_dev);
 
 	fsl_mc_init_all_resource_pools(mc_bus_dev);
@@ -342,16 +343,12 @@ static int dprc_scan_container(struct fsl_mc_device *mc_bus_dev)
 	 * Discover objects in the DPRC:
 	 */
 	mutex_lock(&mc_bus->scan_mutex);
-	error = dprc_scan_objects(mc_bus_dev, true);
+	error = dprc_scan_objects(mc_bus_dev, alloc_interrupts);
 	mutex_unlock(&mc_bus->scan_mutex);
-	if (error < 0) {
-		fsl_mc_cleanup_all_resource_pools(mc_bus_dev);
-		return error;
-	}
 
-	return 0;
+	return error;
 }
-
+EXPORT_SYMBOL_GPL(dprc_scan_container);
 /**
  * dprc_irq0_handler - Regular ISR for DPRC interrupt 0
  *
@@ -675,12 +672,10 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
 		goto error_cleanup_open;
 	}
 
-	mutex_init(&mc_bus->scan_mutex);
-
 	/*
 	 * Discover MC objects in DPRC object:
 	 */
-	error = dprc_scan_container(mc_dev);
+	error = dprc_scan_container(mc_dev, true);
 	if (error < 0)
 		goto error_cleanup_open;
 
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index df96f1602361..bf4f01ddf846 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -636,6 +636,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 		if (!mc_bus)
 			return -ENOMEM;
 
+		mutex_init(&mc_bus->scan_mutex);
 		mc_dev = &mc_bus->mc_dev;
 	} else {
 		/*
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 6339f33c7390..4bfe18fe8fea 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -501,6 +501,9 @@ int dprc_reset_container(struct fsl_mc_io *mc_io,
 			 int child_container_id,
 			 u32 options);
 
+int dprc_scan_container(struct fsl_mc_device *mc_bus_dev,
+			bool alloc_interrupts);
+
 /*
  * Data Path Buffer Pool (DPBP) API
  * Contains initialization APIs and runtime control APIs for DPBP
-- 
2.17.1

