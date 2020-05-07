Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A4EC47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17E7520870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 07:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEGHgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 03:36:22 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40440 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgEGHfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 03:35:46 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E36FC1A0FD7;
        Thu,  7 May 2020 09:35:44 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D70411A0F14;
        Thu,  7 May 2020 09:35:44 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 88E8C203C5;
        Thu,  7 May 2020 09:35:44 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org
Cc:     laurentiu.tudor@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v2 04/12] bus/fsl-mc: Set the QMAN/BMAN region flags
Date:   Thu,  7 May 2020 10:34:23 +0300
Message-Id: <20200507073431.2710-5-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507073431.2710-1-diana.craciun@oss.nxp.com>
References: <20200507073431.2710-1-diana.craciun@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QMAN region is memory mapped, so it should be of type
IORESOURCE_MEM. The region flags bits were wrongly used to
pass additional information. Use the bus specific bits for
this purpose.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c     | 7 ++-----
 drivers/bus/fsl-mc/fsl-mc-private.h | 6 ------
 2 files changed, 2 insertions(+), 11 deletions(-)

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
-- 
2.17.1

