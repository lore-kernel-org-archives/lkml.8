Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D6EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF158207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgGJOKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:10:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:48432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbgGJOK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:10:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BBBD9AD6A;
        Fri, 10 Jul 2020 14:10:27 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     hch@lst.de, Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>
Cc:     linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-pool: Only allocate from CMA when in same memory zone
Date:   Fri, 10 Jul 2020 16:10:15 +0200
Message-Id: <20200710141016.15495-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no guarantee to CMA's placement, so allocating a zone specific
atomic pool from CMA might return memory from a completely different
memory zone. To get around this double check CMA's placement before
allocating from it.

Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to gfp mask")
Reported-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

This is a code intensive alternative to "dma-pool: Do not allocate pool
memory from CMA"[1].

[1] https://lkml.org/lkml/2020/7/8/1108

 kernel/dma/pool.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 8cfa01243ed2..ccf3eeb77e00 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2012 ARM Ltd.
  * Copyright (C) 2020 Google LLC
  */
+#include <linux/cma.h>
 #include <linux/debugfs.h>
 #include <linux/dma-direct.h>
 #include <linux/dma-noncoherent.h>
@@ -56,6 +57,39 @@ static void dma_atomic_pool_size_add(gfp_t gfp, size_t size)
 		pool_size_kernel += size;
 }
 
+static bool cma_in_zone(gfp_t gfp)
+{
+	u64 zone_dma_end, zone_dma32_end;
+	phys_addr_t base, end;
+	unsigned long size;
+	struct cma *cma;
+
+	cma = dev_get_cma_area(NULL);
+	if (!cma)
+		return false;
+
+	size = cma_get_size(cma);
+	if (!size)
+		return false;
+	base = cma_get_base(cma) - memblock_start_of_DRAM();
+	end = base + size - 1;
+
+	zone_dma_end = IS_ENABLED(CONFIG_ZONE_DMA) ? DMA_BIT_MASK(zone_dma_bits) : 0;
+	zone_dma32_end = IS_ENABLED(CONFIG_ZONE_DMA32) ? DMA_BIT_MASK(32) : 0;
+
+	/* CMA can't cross zone boundaries, see cma_activate_area() */
+	if (IS_ENABLED(CONFIG_ZONE_DMA) && gfp & GFP_DMA &&
+	   end <= zone_dma_end)
+		return true;
+	else if (IS_ENABLED(CONFIG_ZONE_DMA32) && gfp & GFP_DMA32 &&
+		base > zone_dma_end && end <= zone_dma32_end)
+		return true;
+	else if (base > zone_dma32_end)
+		return true;
+
+	return false;
+}
+
 static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 			      gfp_t gfp)
 {
@@ -70,7 +104,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	do {
 		pool_size = 1 << (PAGE_SHIFT + order);
 
-		if (dev_get_cma_area(NULL))
+		if (cma_in_zone(gfp))
 			page = dma_alloc_from_contiguous(NULL, 1 << order,
 							 order, false);
 		else
-- 
2.27.0

