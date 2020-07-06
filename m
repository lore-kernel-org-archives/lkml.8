Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175CCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC73020773
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgGFMnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:43:52 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37984 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729043AbgGFMnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:43:08 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A2652004BE;
        Mon,  6 Jul 2020 14:43:06 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7DE5B20068B;
        Mon,  6 Jul 2020 14:43:06 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 278C2203C3;
        Mon,  6 Jul 2020 14:43:06 +0200 (CEST)
From:   Diana Craciun <diana.craciun@nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com,
        gregkh@linuxfoundation.org
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, bharatb.linux@gmail.com,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v3 04/13] bus/fsl-mc: Set the QMAN/BMAN region flags
Date:   Mon,  6 Jul 2020 15:42:34 +0300
Message-Id: <20200706124243.10697-5-diana.craciun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706124243.10697-1-diana.craciun@nxp.com>
References: <20200706124243.10697-1-diana.craciun@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Diana Craciun <diana.craciun@oss.nxp.com>

The QMAN region is memory mapped, so it should be of type
IORESOURCE_MEM. The region flags bits were wrongly used to
pass additional information. Use the bus specific bits for
this purpose.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c     | 7 ++-----
 drivers/bus/fsl-mc/fsl-mc-private.h | 6 ------
 include/linux/fsl/mc.h              | 8 ++++++++
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 3a86f5087717..df96f1602361 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -573,11 +573,8 @@ static int fsl_mc_device_get_mmio_regions(struct fsl_mc_device *mc_dev,
 
 		regions[i].end = regions[i].start + region_desc.size - 1;
 		regions[i].name = "fsl-mc object MMIO region";
-		regions[i].flags = IORESOURCE_IO;
-		if (region_desc.flags & DPRC_REGION_CACHEABLE)
-			regions[i].flags |= IORESOURCE_CACHEABLE;
-		if (region_desc.flags & DPRC_REGION_SHAREABLE)
-			regions[i].flags |= IORESOURCE_MEM;
+		regions[i].flags = region_desc.flags & IORESOURCE_BITS;
+		regions[i].flags |= IORESOURCE_MEM;
 	}
 
 	mc_dev->regions = regions;
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index 21ca8c756ee7..c2a688c07ee2 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -358,12 +358,6 @@ int dprc_set_obj_irq(struct fsl_mc_io *mc_io,
 		     int obj_id,
 		     u8 irq_index,
 		     struct dprc_irq_cfg *irq_cfg);
-
-/* Region flags */
-/* Cacheable - Indicates that region should be mapped as cacheable */
-#define DPRC_REGION_CACHEABLE	0x00000001
-#define DPRC_REGION_SHAREABLE	0x00000002
-
 /**
  * enum dprc_region_type - Region type
  * @DPRC_REGION_TYPE_MC_PORTAL: MC portal region
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 4e9b570a1845..651ffeff8c13 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -3,6 +3,7 @@
  * Freescale Management Complex (MC) bus public interface
  *
  * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
+ * Copyright 2019-2020 NXP
  * Author: German Rivera <German.Rivera@freescale.com>
  *
  */
@@ -148,6 +149,13 @@ struct fsl_mc_obj_desc {
  */
 #define FSL_MC_IS_DPRC	0x0001
 
+/* Region flags */
+/* Indicates that region can be mapped as cacheable */
+#define FSL_MC_REGION_CACHEABLE	0x00000001
+
+/* Indicates that region can be mapped as shareable */
+#define FSL_MC_REGION_SHAREABLE	0x00000002
+
 /**
  * struct fsl_mc_device - MC object device object
  * @dev: Linux driver model device object
-- 
2.17.1

