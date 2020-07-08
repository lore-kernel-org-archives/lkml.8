Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF70C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 366CF206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbgGHRNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:13:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:43606 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgGHRNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:13:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E9F5BAE02;
        Wed,  8 Jul 2020 16:55:29 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>
Cc:     linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dma-pool: Do not allocate pool memory from CMA
Date:   Wed,  8 Jul 2020 18:49:39 +0200
Message-Id: <20200708164936.9340-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no guarantee to CMA's placement, so allocating a zone specific
atomic pool from CMA might return memory from a completely different
memory zone. So stop using it.

Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to gfp mask")
Reported-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

An more costly alternative would be adding an option to
dma_alloc_from_contiguous() so it fails when the allocation doesn't fall
in a specific zone.

 kernel/dma/pool.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 8cfa01243ed2..4bc1c46ae6ef 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -6,7 +6,6 @@
 #include <linux/debugfs.h>
 #include <linux/dma-direct.h>
 #include <linux/dma-noncoherent.h>
-#include <linux/dma-contiguous.h>
 #include <linux/init.h>
 #include <linux/genalloc.h>
 #include <linux/set_memory.h>
@@ -69,12 +68,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 
 	do {
 		pool_size = 1 << (PAGE_SHIFT + order);
-
-		if (dev_get_cma_area(NULL))
-			page = dma_alloc_from_contiguous(NULL, 1 << order,
-							 order, false);
-		else
-			page = alloc_pages(gfp, order);
+		page = alloc_pages(gfp, order);
 	} while (!page && order-- > 0);
 	if (!page)
 		goto out;
@@ -118,8 +112,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	dma_common_free_remap(addr, pool_size);
 #endif
 free_page: __maybe_unused
-	if (!dma_release_from_contiguous(NULL, page, 1 << order))
-		__free_pages(page, order);
+	__free_pages(page, order);
 out:
 	return ret;
 }
-- 
2.27.0

