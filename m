Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0D0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C9F320786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgHZJ03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:26:29 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56510 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbgHZJ0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:26:10 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CAC3A1A08DD;
        Wed, 26 Aug 2020 11:26:06 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BC42A1A08B7;
        Wed, 26 Aug 2020 11:26:06 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 67665202CA;
        Wed, 26 Aug 2020 11:26:06 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, bharatb.linux@gmail.com,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v4 11/13] bus/fsl-mc: Export IRQ pool handling functions to be used by VFIO
Date:   Wed, 26 Aug 2020 12:25:25 +0300
Message-Id: <20200826092527.4992-12-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826092527.4992-1-diana.craciun@oss.nxp.com>
References: <20200826092527.4992-1-diana.craciun@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRQ pool handling functions can be used by both DPRC
driver and VFIO. Adapt and export those functions.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc-driver.c      |  7 +++----
 drivers/bus/fsl-mc/fsl-mc-allocator.c | 12 ++++++++----
 drivers/bus/fsl-mc/fsl-mc-private.h   | 10 ----------
 include/linux/fsl/mc.h                | 11 +++++++++++
 4 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 471386e9b46c..3521515a4ac2 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -327,8 +327,8 @@ static int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
 		}
 
 		if (alloc_interrupts && !mc_bus->irq_resources) {
-			error = fsl_mc_populate_irq_pool(mc_bus,
-				FSL_MC_IRQ_POOL_MAX_TOTAL_IRQS);
+			error = fsl_mc_populate_irq_pool(mc_bus_dev,
+					 FSL_MC_IRQ_POOL_MAX_TOTAL_IRQS);
 			if (error < 0)
 				return error;
 		}
@@ -766,7 +766,6 @@ static void dprc_teardown_irq(struct fsl_mc_device *mc_dev)
 int dprc_cleanup(struct fsl_mc_device *mc_dev)
 {
 	int error;
-	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_dev);
 
 	if (!is_fsl_mc_bus_dprc(mc_dev))
 		return -EINVAL;
@@ -775,7 +774,7 @@ int dprc_cleanup(struct fsl_mc_device *mc_dev)
 		return -EINVAL;
 
 	if (dev_get_msi_domain(&mc_dev->dev)) {
-		fsl_mc_cleanup_irq_pool(mc_bus);
+		fsl_mc_cleanup_irq_pool(mc_dev);
 		dev_set_msi_domain(&mc_dev->dev, NULL);
 	}
 
diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
index cc7bb900f524..e71a6f52ea0c 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -344,7 +344,7 @@ EXPORT_SYMBOL_GPL(fsl_mc_object_free);
  * Initialize the interrupt pool associated with an fsl-mc bus.
  * It allocates a block of IRQs from the GIC-ITS.
  */
-int fsl_mc_populate_irq_pool(struct fsl_mc_bus *mc_bus,
+int fsl_mc_populate_irq_pool(struct fsl_mc_device *mc_bus_dev,
 			     unsigned int irq_count)
 {
 	unsigned int i;
@@ -352,10 +352,14 @@ int fsl_mc_populate_irq_pool(struct fsl_mc_bus *mc_bus,
 	struct fsl_mc_device_irq *irq_resources;
 	struct fsl_mc_device_irq *mc_dev_irq;
 	int error;
-	struct fsl_mc_device *mc_bus_dev = &mc_bus->mc_dev;
+	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_bus_dev);
 	struct fsl_mc_resource_pool *res_pool =
 			&mc_bus->resource_pools[FSL_MC_POOL_IRQ];
 
+	/* do nothing if the IRQ pool is already populated */
+	if (mc_bus->irq_resources)
+		return 0;
+
 	if (irq_count == 0 ||
 	    irq_count > FSL_MC_IRQ_POOL_MAX_TOTAL_IRQS)
 		return -EINVAL;
@@ -407,9 +411,9 @@ EXPORT_SYMBOL_GPL(fsl_mc_populate_irq_pool);
  * Teardown the interrupt pool associated with an fsl-mc bus.
  * It frees the IRQs that were allocated to the pool, back to the GIC-ITS.
  */
-void fsl_mc_cleanup_irq_pool(struct fsl_mc_bus *mc_bus)
+void fsl_mc_cleanup_irq_pool(struct fsl_mc_device *mc_bus_dev)
 {
-	struct fsl_mc_device *mc_bus_dev = &mc_bus->mc_dev;
+	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_bus_dev);
 	struct fsl_mc_resource_pool *res_pool =
 			&mc_bus->resource_pools[FSL_MC_POOL_IRQ];
 
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index 5f7e762d517c..ffe709a3f0f8 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -519,11 +519,6 @@ struct dpcon_cmd_set_notification {
 	__le64 user_ctx;
 };
 
-/**
- * Maximum number of total IRQs that can be pre-allocated for an MC bus'
- * IRQ pool
- */
-#define FSL_MC_IRQ_POOL_MAX_TOTAL_IRQS	256
 
 /**
  * struct fsl_mc_resource_pool - Pool of MC resources of a given
@@ -598,11 +593,6 @@ void fsl_mc_msi_domain_free_irqs(struct device *dev);
 
 struct irq_domain *fsl_mc_find_msi_domain(struct device *dev);
 
-int fsl_mc_populate_irq_pool(struct fsl_mc_bus *mc_bus,
-			     unsigned int irq_count);
-
-void fsl_mc_cleanup_irq_pool(struct fsl_mc_bus *mc_bus);
-
 int __must_check fsl_create_mc_io(struct device *dev,
 				  phys_addr_t mc_portal_phys_addr,
 				  u32 mc_portal_size,
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index e99d181ee4cd..f791fe38c251 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -542,6 +542,17 @@ int dprc_cleanup(struct fsl_mc_device *mc_dev);
 
 int dprc_setup(struct fsl_mc_device *mc_dev);
 
+/**
+ * Maximum number of total IRQs that can be pre-allocated for an MC bus'
+ * IRQ pool
+ */
+#define FSL_MC_IRQ_POOL_MAX_TOTAL_IRQS	256
+
+int fsl_mc_populate_irq_pool(struct fsl_mc_device *mc_bus_dev,
+			     unsigned int irq_count);
+
+void fsl_mc_cleanup_irq_pool(struct fsl_mc_device *mc_bus_dev);
+
 /*
  * Data Path Buffer Pool (DPBP) API
  * Contains initialization APIs and runtime control APIs for DPBP
-- 
2.17.1

