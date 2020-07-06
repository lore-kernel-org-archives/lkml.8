Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8DFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 950AF20722
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgGFMn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:43:56 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37938 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729005AbgGFMnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:43:07 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AB36C2004AF;
        Mon,  6 Jul 2020 14:43:05 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9EBE82004AA;
        Mon,  6 Jul 2020 14:43:05 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 48C8F203C3;
        Mon,  6 Jul 2020 14:43:05 +0200 (CEST)
From:   Diana Craciun <diana.craciun@nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com,
        gregkh@linuxfoundation.org
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, bharatb.linux@gmail.com,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v3 02/13] bus/fsl-mc: Add a new parameter to dprc_scan_objects function
Date:   Mon,  6 Jul 2020 15:42:32 +0300
Message-Id: <20200706124243.10697-3-diana.craciun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706124243.10697-1-diana.craciun@nxp.com>
References: <20200706124243.10697-1-diana.craciun@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Diana Craciun <diana.craciun@oss.nxp.com>

Prepare the dprc_scan_objects function to be used by
the VFIO mc driver code. The function is used to scan the mc
objects by the bus driver. The same functionality is
needed by the VFIO mc driver, but in this case the
interrupt configuration is delayed until the userspace
configures the interrupts. In order to use the same function
in both drivers add a new parameter.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 035b220779d0..7a8061224df8 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -198,6 +198,8 @@ static void dprc_add_new_devices(struct fsl_mc_device *mc_bus_dev,
  * dprc_scan_objects - Discover objects in a DPRC
  *
  * @mc_bus_dev: pointer to the fsl-mc device that represents a DPRC object
+ * @alloc_interrupts: if true the function allocates the interrupt pool,
+ * otherwise the interrupt allocation is delayed
  *
  * Detects objects added and removed from a DPRC and synchronizes the
  * state of the Linux bus driver, MC by adding and removing
@@ -211,7 +213,8 @@ static void dprc_add_new_devices(struct fsl_mc_device *mc_bus_dev,
  * populated before they can get allocation requests from probe callbacks
  * of the device drivers for the non-allocatable devices.
  */
-static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev)
+static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
+			    bool alloc_interrupts)
 {
 	int num_child_objects;
 	int dprc_get_obj_failures;
@@ -299,7 +302,7 @@ static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev)
 				 irq_count, FSL_MC_IRQ_POOL_MAX_TOTAL_IRQS);
 		}
 
-		if (!mc_bus->irq_resources) {
+		if (alloc_interrupts && !mc_bus->irq_resources) {
 			error = fsl_mc_populate_irq_pool(mc_bus,
 				FSL_MC_IRQ_POOL_MAX_TOTAL_IRQS);
 			if (error < 0)
@@ -339,7 +342,7 @@ static int dprc_scan_container(struct fsl_mc_device *mc_bus_dev)
 	 * Discover objects in the DPRC:
 	 */
 	mutex_lock(&mc_bus->scan_mutex);
-	error = dprc_scan_objects(mc_bus_dev);
+	error = dprc_scan_objects(mc_bus_dev, true);
 	mutex_unlock(&mc_bus->scan_mutex);
 	if (error < 0) {
 		fsl_mc_cleanup_all_resource_pools(mc_bus_dev);
@@ -409,7 +412,7 @@ static irqreturn_t dprc_irq0_handler_thread(int irq_num, void *arg)
 		      DPRC_IRQ_EVENT_OBJ_DESTROYED |
 		      DPRC_IRQ_EVENT_OBJ_CREATED)) {
 
-		error = dprc_scan_objects(mc_dev);
+		error = dprc_scan_objects(mc_dev, true);
 		if (error < 0) {
 			/*
 			 * If the error is -ENXIO, we ignore it, as it indicates
-- 
2.17.1

