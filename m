Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA926C43459
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C0522472
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgGNMkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:40:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:54792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728456AbgGNMkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:40:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20B67AD85;
        Tue, 14 Jul 2020 12:40:02 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     hch@lst.de, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        iommu@lists.linux-foundation.org
Subject: [PATCH v2 2/4] dma-pool: Get rid of dma_in_atomic_pool()
Date:   Tue, 14 Jul 2020 14:39:26 +0200
Message-Id: <20200714123928.8581-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714123928.8581-1-nsaenzjulienne@suse.de>
References: <20200714123928.8581-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is only used once and can be simplified to a one-liner.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 kernel/dma/pool.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 39ca26fa41b5..318035e093fb 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -217,15 +217,6 @@ static inline struct gen_pool *dev_to_pool(struct device *dev)
 	return atomic_pool_kernel;
 }
 
-static bool dma_in_atomic_pool(struct device *dev, void *start, size_t size)
-{
-	struct gen_pool *pool = dev_to_pool(dev);
-
-	if (unlikely(!pool))
-		return false;
-	return gen_pool_has_addr(pool, (unsigned long)start, size);
-}
-
 void *dma_alloc_from_pool(struct device *dev, size_t size,
 			  struct page **ret_page, gfp_t flags)
 {
@@ -260,7 +251,7 @@ bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 {
 	struct gen_pool *pool = dev_to_pool(dev);
 
-	if (!dma_in_atomic_pool(dev, start, size))
+	if (!pool || !gen_pool_has_addr(pool, (unsigned long)start, size))
 		return false;
 	gen_pool_free(pool, (unsigned long)start, size);
 	return true;
-- 
2.27.0

