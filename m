Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A383CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA2820786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgHZJ0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:26:09 -0400
Received: from inva021.nxp.com ([92.121.34.21]:43220 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727884AbgHZJ0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:26:04 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9D3062007BB;
        Wed, 26 Aug 2020 11:26:02 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9075D2007B7;
        Wed, 26 Aug 2020 11:26:02 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 39EA62030A;
        Wed, 26 Aug 2020 11:26:02 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, bharatb.linux@gmail.com,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v4 01/13] bus/fsl-mc: Do no longer export the total number of irqs outside dprc_scan_objects
Date:   Wed, 26 Aug 2020 12:25:15 +0300
Message-Id: <20200826092527.4992-2-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826092527.4992-1-diana.craciun@oss.nxp.com>
References: <20200826092527.4992-1-diana.craciun@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The total number of interrupts is only used for some checks
outside the dprc_scan_objects function. Furthermore, in some
situations the check is made twice. Move the bounds check inside
the function for all situations.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 2a473c09bc33..54c576d68122 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -3,6 +3,7 @@
  * Freescale data path resource container (DPRC) driver
  *
  * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
+ * Copyright 2019-2020 NXP
  * Author: German Rivera <German.Rivera@freescale.com>
  *
  */
@@ -220,8 +221,6 @@ static void dprc_add_new_devices(struct fsl_mc_device *mc_bus_dev,
  * dprc_scan_objects - Discover objects in a DPRC
  *
  * @mc_bus_dev: pointer to the fsl-mc device that represents a DPRC object
- * @total_irq_count: If argument is provided the function populates the
- * total number of IRQs created by objects in the DPRC.
  *
  * Detects objects added and removed from a DPRC and synchronizes the
  * state of the Linux bus driver, MC by adding and removing
@@ -235,8 +234,7 @@ static void dprc_add_new_devices(struct fsl_mc_device *mc_bus_dev,
  * populated before they can get allocation requests from probe callbacks
  * of the device drivers for the non-allocatable devices.
  */
-static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
-			     unsigned int *total_irq_count)
+static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev)
 {
 	int num_child_objects;
 	int dprc_get_obj_failures;
@@ -317,22 +315,21 @@ static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
 	 * Allocate IRQ's before binding the scanned devices with their
 	 * respective drivers.
 	 */
-	if (dev_get_msi_domain(&mc_bus_dev->dev) && !mc_bus->irq_resources) {
+	if (dev_get_msi_domain(&mc_bus_dev->dev)) {
 		if (irq_count > FSL_MC_IRQ_POOL_MAX_TOTAL_IRQS) {
 			dev_warn(&mc_bus_dev->dev,
 				 "IRQs needed (%u) exceed IRQs preallocated (%u)\n",
 				 irq_count, FSL_MC_IRQ_POOL_MAX_TOTAL_IRQS);
 		}
 
-		error = fsl_mc_populate_irq_pool(mc_bus,
+		if (!mc_bus->irq_resources) {
+			error = fsl_mc_populate_irq_pool(mc_bus,
 				FSL_MC_IRQ_POOL_MAX_TOTAL_IRQS);
-		if (error < 0)
-			return error;
+			if (error < 0)
+				return error;
+		}
 	}
 
-	if (total_irq_count)
-		*total_irq_count = irq_count;
-
 	dprc_remove_devices(mc_bus_dev, child_obj_desc_array,
 			    num_child_objects);
 
@@ -365,7 +362,7 @@ static int dprc_scan_container(struct fsl_mc_device *mc_bus_dev)
 	 * Discover objects in the DPRC:
 	 */
 	mutex_lock(&mc_bus->scan_mutex);
-	error = dprc_scan_objects(mc_bus_dev, NULL);
+	error = dprc_scan_objects(mc_bus_dev);
 	mutex_unlock(&mc_bus->scan_mutex);
 	if (error < 0) {
 		fsl_mc_cleanup_all_resource_pools(mc_bus_dev);
@@ -434,9 +431,8 @@ static irqreturn_t dprc_irq0_handler_thread(int irq_num, void *arg)
 		      DPRC_IRQ_EVENT_CONTAINER_DESTROYED |
 		      DPRC_IRQ_EVENT_OBJ_DESTROYED |
 		      DPRC_IRQ_EVENT_OBJ_CREATED)) {
-		unsigned int irq_count;
 
-		error = dprc_scan_objects(mc_dev, &irq_count);
+		error = dprc_scan_objects(mc_dev);
 		if (error < 0) {
 			/*
 			 * If the error is -ENXIO, we ignore it, as it indicates
@@ -451,12 +447,6 @@ static irqreturn_t dprc_irq0_handler_thread(int irq_num, void *arg)
 
 			goto out;
 		}
-
-		if (irq_count > FSL_MC_IRQ_POOL_MAX_TOTAL_IRQS) {
-			dev_warn(dev,
-				 "IRQs needed (%u) exceed IRQs preallocated (%u)\n",
-				 irq_count, FSL_MC_IRQ_POOL_MAX_TOTAL_IRQS);
-		}
 	}
 
 out:
-- 
2.17.1

