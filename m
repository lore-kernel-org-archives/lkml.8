Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2E5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 220B322B49
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgHZJ1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:27:13 -0400
Received: from inva021.nxp.com ([92.121.34.21]:43532 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgHZJ0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:26:10 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 23F8A2007A9;
        Wed, 26 Aug 2020 11:26:05 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 17A092005B7;
        Wed, 26 Aug 2020 11:26:05 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B731A202CA;
        Wed, 26 Aug 2020 11:26:04 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, bharatb.linux@gmail.com,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v4 07/13] bus/fsl-mc: Export dprc_scan/dprc_remove functions to be used by multiple entities
Date:   Wed, 26 Aug 2020 12:25:21 +0300
Message-Id: <20200826092527.4992-8-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826092527.4992-1-diana.craciun@oss.nxp.com>
References: <20200826092527.4992-1-diana.craciun@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the DPRC scan function is used only by the bus driver.
But the same functionality will be needed by the VFIO driver.
To support this, the dprc scan function was exported and a little
bit adjusted to fit both scenarios. Also the scan mutex initialization
is done when the bus object is created, not in dprc_probe in order
to be used by both VFIO and bus driver.
Similarily dprc_remove_devices is exported to be used by VFIO.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 26 +++++++++++---------------
 drivers/bus/fsl-mc/fsl-mc-bus.c  |  1 +
 include/linux/fsl/mc.h           |  7 +++++++
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 3d850515e3e5..dde8fe965e30 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -81,9 +81,9 @@ static int __fsl_mc_device_remove(struct device *dev, void *data)
  * the MC by removing devices that represent MC objects that have
  * been dynamically removed in the physical DPRC.
  */
-static void dprc_remove_devices(struct fsl_mc_device *mc_bus_dev,
-				struct fsl_mc_obj_desc *obj_desc_array,
-				int num_child_objects_in_mc)
+void dprc_remove_devices(struct fsl_mc_device *mc_bus_dev,
+			 struct fsl_mc_obj_desc *obj_desc_array,
+			 int num_child_objects_in_mc)
 {
 	if (num_child_objects_in_mc != 0) {
 		/*
@@ -105,6 +105,7 @@ static void dprc_remove_devices(struct fsl_mc_device *mc_bus_dev,
 				      __fsl_mc_device_remove);
 	}
 }
+EXPORT_SYMBOL_GPL(dprc_remove_devices);
 
 static int __fsl_mc_device_match(struct device *dev, void *data)
 {
@@ -354,9 +355,10 @@ static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
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
@@ -365,16 +367,12 @@ static int dprc_scan_container(struct fsl_mc_device *mc_bus_dev)
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
@@ -683,12 +681,10 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
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
index 1bb70a92167e..32f194814b08 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -678,6 +678,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 		if (!mc_bus)
 			return -ENOMEM;
 
+		mutex_init(&mc_bus->scan_mutex);
 		mc_dev = &mc_bus->mc_dev;
 	} else {
 		/*
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 1d8800acf21f..da11171bc38f 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -531,6 +531,13 @@ int dprc_reset_container(struct fsl_mc_io *mc_io,
 			 int child_container_id,
 			 u32 options);
 
+int dprc_scan_container(struct fsl_mc_device *mc_bus_dev,
+			bool alloc_interrupts);
+
+void dprc_remove_devices(struct fsl_mc_device *mc_bus_dev,
+			 struct fsl_mc_obj_desc *obj_desc_array,
+			 int num_child_objects_in_mc);
+
 /*
  * Data Path Buffer Pool (DPBP) API
  * Contains initialization APIs and runtime control APIs for DPBP
-- 
2.17.1

