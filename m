Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649D0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A3BF20773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgGGM2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:28:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:48080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgGGM2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:28:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 34EDBABF4;
        Tue,  7 Jul 2020 12:28:14 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>
Cc:     linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-pool: use single atomic pool for both DMA zones
Date:   Tue,  7 Jul 2020 14:28:04 +0200
Message-Id: <20200707122804.21262-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating atomic DMA memory for a device, the dma-pool core
queries __dma_direct_optimal_gfp_mask() to check which atomic pool to
use. It turns out the GFP flag returned is only an optimistic guess.
The pool selected might sometimes live in a zone higher than the
device's view of memory.

As there isn't a way to grantee a mapping between a device's DMA
constraints and correct GFP flags this unifies both DMA atomic pools.
The resulting pool is allocated in the lower DMA zone available, if any,
so as for devices to always get accessible memory while having the
flexibility of using dma_pool_kernel for the non constrained ones.

Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to gfp mask")
Reported-by: Jeremy Linton <jeremy.linton@arm.com>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 kernel/dma/pool.c | 47 +++++++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 8cfa01243ed2..883f7a583969 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -13,10 +13,11 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
+#define GFP_ATOMIC_POOL_DMA	(IS_ENABLED(CONFIG_ZONE_DMA) ? GFP_DMA : \
+				 IS_ENABLED(CONFIG_ZONE_DMA32) ? GFP_DMA32 : 0)
+
 static struct gen_pool *atomic_pool_dma __ro_after_init;
 static unsigned long pool_size_dma;
-static struct gen_pool *atomic_pool_dma32 __ro_after_init;
-static unsigned long pool_size_dma32;
 static struct gen_pool *atomic_pool_kernel __ro_after_init;
 static unsigned long pool_size_kernel;
 
@@ -42,16 +43,13 @@ static void __init dma_atomic_pool_debugfs_init(void)
 		return;
 
 	debugfs_create_ulong("pool_size_dma", 0400, root, &pool_size_dma);
-	debugfs_create_ulong("pool_size_dma32", 0400, root, &pool_size_dma32);
 	debugfs_create_ulong("pool_size_kernel", 0400, root, &pool_size_kernel);
 }
 
 static void dma_atomic_pool_size_add(gfp_t gfp, size_t size)
 {
-	if (gfp & __GFP_DMA)
+	if (gfp & GFP_ATOMIC_POOL_DMA)
 		pool_size_dma += size;
-	else if (gfp & __GFP_DMA32)
-		pool_size_dma32 += size;
 	else
 		pool_size_kernel += size;
 }
@@ -132,12 +130,11 @@ static void atomic_pool_resize(struct gen_pool *pool, gfp_t gfp)
 
 static void atomic_pool_work_fn(struct work_struct *work)
 {
-	if (IS_ENABLED(CONFIG_ZONE_DMA))
-		atomic_pool_resize(atomic_pool_dma,
-				   GFP_KERNEL | GFP_DMA);
-	if (IS_ENABLED(CONFIG_ZONE_DMA32))
-		atomic_pool_resize(atomic_pool_dma32,
-				   GFP_KERNEL | GFP_DMA32);
+	gfp_t dma_gfp = GFP_ATOMIC_POOL_DMA;
+
+	if (dma_gfp)
+		atomic_pool_resize(atomic_pool_dma, GFP_KERNEL | dma_gfp);
+
 	atomic_pool_resize(atomic_pool_kernel, GFP_KERNEL);
 }
 
@@ -168,6 +165,7 @@ static __init struct gen_pool *__dma_atomic_pool_init(size_t pool_size,
 
 static int __init dma_atomic_pool_init(void)
 {
+	gfp_t dma_gfp = GFP_ATOMIC_POOL_DMA;
 	int ret = 0;
 
 	/*
@@ -185,18 +183,13 @@ static int __init dma_atomic_pool_init(void)
 						    GFP_KERNEL);
 	if (!atomic_pool_kernel)
 		ret = -ENOMEM;
-	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
+
+	if (dma_gfp) {
 		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
-						GFP_KERNEL | GFP_DMA);
+							 GFP_KERNEL | dma_gfp);
 		if (!atomic_pool_dma)
 			ret = -ENOMEM;
 	}
-	if (IS_ENABLED(CONFIG_ZONE_DMA32)) {
-		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
-						GFP_KERNEL | GFP_DMA32);
-		if (!atomic_pool_dma32)
-			ret = -ENOMEM;
-	}
 
 	dma_atomic_pool_debugfs_init();
 	return ret;
@@ -206,14 +199,12 @@ postcore_initcall(dma_atomic_pool_init);
 static inline struct gen_pool *dev_to_pool(struct device *dev)
 {
 	u64 phys_mask;
-	gfp_t gfp;
-
-	gfp = dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
-					  &phys_mask);
-	if (IS_ENABLED(CONFIG_ZONE_DMA) && gfp == GFP_DMA)
-		return atomic_pool_dma;
-	if (IS_ENABLED(CONFIG_ZONE_DMA32) && gfp == GFP_DMA32)
-		return atomic_pool_dma32;
+
+	if (atomic_pool_dma &&
+	    dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
+					&phys_mask))
+			return atomic_pool_dma;
+
 	return atomic_pool_kernel;
 }
 
-- 
2.27.0

