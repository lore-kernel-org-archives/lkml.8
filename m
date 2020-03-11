Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,SUBJ_OBFU_PUNCT_FEW,
	SUBJ_OBFU_PUNCT_MANY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from bombadil.infradead.org ([198.137.202.133]:56310 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbgCKQHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:07:18 -0400
From: Christoph Hellwig <hch@lst.de>
To: torvalds@linux-foundation.org, gregkh@linuxfoundation.org
Cc: aros@gmx.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH] device core: fix dma_mask handling in platform_device_register_full
Date: Wed, 11 Mar 2020 17:07:10 +0100
Message-Id: <20200311160710.376090-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Ever since the generic platform device code started allocating DMA masks
itself the code to allocate and leak a private DMA mask in
platform_device_register_full has been superflous.  More so the fact that
it unconditionally frees the DMA mask allocation in the failure path
can lead to slab corruption if the function fails later on for a device
where it didn't allocate the mask.  Just remove the offending code.

Fixes: cdfee5623290 ("driver core: initialize a default DMA mask for platform device")
Reported-by: Artem S. Tashkinov <aros@gmx.com>
Tested-by: Artem S. Tashkinov <aros@gmx.com>
---
 drivers/base/platform.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 7fa654f1288b..47d3e6187a1c 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -662,19 +662,6 @@ struct platform_device *platform_device_register_full(
 	pdev->dev.of_node_reused = pdevinfo->of_node_reused;
 
 	if (pdevinfo->dma_mask) {
-		/*
-		 * This memory isn't freed when the device is put,
-		 * I don't have a nice idea for that though.  Conceptually
-		 * dma_mask in struct device should not be a pointer.
-		 * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
-		 */
-		pdev->dev.dma_mask =
-			kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
-		if (!pdev->dev.dma_mask)
-			goto err;
-
-		kmemleak_ignore(pdev->dev.dma_mask);
-
 		*pdev->dev.dma_mask = pdevinfo->dma_mask;
 		pdev->dev.coherent_dma_mask = pdevinfo->dma_mask;
 	}
@@ -700,7 +687,6 @@ struct platform_device *platform_device_register_full(
 	if (ret) {
 err:
 		ACPI_COMPANION_SET(&pdev->dev, NULL);
-		kfree(pdev->dev.dma_mask);
 		platform_device_put(pdev);
 		return ERR_PTR(ret);
 	}
-- 
2.24.1

