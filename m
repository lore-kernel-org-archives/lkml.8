Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DFAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F009B207D0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgGIQTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:19:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:39170 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbgGIQTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:19:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B97DAED2;
        Thu,  9 Jul 2020 16:19:34 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     hch@lst.de, Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] dma-pool: Make sure atomic pool suits device
Date:   Thu,  9 Jul 2020 18:19:04 +0200
Message-Id: <20200709161903.26229-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709161903.26229-1-nsaenzjulienne@suse.de>
References: <20200709161903.26229-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating DMA memory from a pool, the core can only guess which
atomic pool will fit a device's constraints. If it doesn't, get a safer
atomic pool and try again.

Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to gfp mask")
Reported-by: Jeremy Linton <jeremy.linton@arm.com>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 kernel/dma/pool.c | 53 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 3d518de07617..d48d9acb585f 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -240,35 +240,56 @@ static inline struct gen_pool *dma_guess_pool(struct device *dev,
 void *dma_alloc_from_pool(struct device *dev, size_t size,
 			  struct page **ret_page, gfp_t flags)
 {
-	struct gen_pool *pool = dma_guess_pool(dev, NULL);
-	unsigned long val;
+	struct gen_pool *pool = NULL;
+	unsigned long val = 0;
 	void *ptr = NULL;
-
-	if (!pool) {
-		WARN(1, "%pGg atomic pool not initialised!\n", &flags);
-		return NULL;
+	phys_addr_t phys;
+
+	while (1) {
+		pool = dma_guess_pool(dev, pool);
+		if (!pool) {
+			WARN(1, "Failed to get suitable pool for %s\n",
+			     dev_name(dev));
+			break;
+		}
+
+		val = gen_pool_alloc(pool, size);
+		if (!val)
+			continue;
+
+		phys = gen_pool_virt_to_phys(pool, val);
+		if (dma_coherent_ok(dev, phys, size))
+			break;
+
+		gen_pool_free(pool, val, size);
+		val = 0;
 	}
 
-	val = gen_pool_alloc(pool, size);
-	if (val) {
-		phys_addr_t phys = gen_pool_virt_to_phys(pool, val);
 
+	if (val) {
 		*ret_page = pfn_to_page(__phys_to_pfn(phys));
 		ptr = (void *)val;
 		memset(ptr, 0, size);
+
+		if (gen_pool_avail(pool) < atomic_pool_size)
+			schedule_work(&atomic_pool_work);
 	}
-	if (gen_pool_avail(pool) < atomic_pool_size)
-		schedule_work(&atomic_pool_work);
 
 	return ptr;
 }
 
 bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 {
-	struct gen_pool *pool = dma_guess_pool(dev, NULL);
+	struct gen_pool *pool = NULL;
+
+	while (1) {
+		pool = dma_guess_pool(dev, pool);
+		if (!pool)
+			return false;
 
-	if (!pool || !gen_pool_has_addr(pool, (unsigned long)start, size))
-		return false;
-	gen_pool_free(pool, (unsigned long)start, size);
-	return true;
+		if (gen_pool_has_addr(pool, (unsigned long)start, size)) {
+			gen_pool_free(pool, (unsigned long)start, size);
+			return true;
+		}
+	}
 }
-- 
2.27.0

