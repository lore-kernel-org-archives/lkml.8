Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F40FC43445
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A3D22472
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgGNMkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:40:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:54810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728461AbgGNMkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:40:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B6D5AB02E;
        Tue, 14 Jul 2020 12:40:02 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     hch@lst.de, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        iommu@lists.linux-foundation.org
Subject: [PATCH v2 3/4] dma-pool: Introduce dma_guess_pool()
Date:   Tue, 14 Jul 2020 14:39:27 +0200
Message-Id: <20200714123928.8581-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714123928.8581-1-nsaenzjulienne@suse.de>
References: <20200714123928.8581-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma-pool's dev_to_pool() creates the false impression that there is a
way to grantee a mapping between a device's DMA constraints and an
atomic pool. It tuns out it's just a guess, and the device might need to
use an atomic pool containing memory from a 'safer' (or lower) memory
zone.

To help mitigate this, introduce dma_guess_pool() which can be fed a
device's DMA constraints and atomic pools already known to be faulty, in
order for it to provide an better guess on which pool to use.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 kernel/dma/pool.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 318035e093fb..5b9eaa2b498d 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -203,7 +203,7 @@ static int __init dma_atomic_pool_init(void)
 }
 postcore_initcall(dma_atomic_pool_init);
 
-static inline struct gen_pool *dev_to_pool(struct device *dev)
+static inline struct gen_pool *dma_guess_pool_from_device(struct device *dev)
 {
 	u64 phys_mask;
 	gfp_t gfp;
@@ -217,10 +217,30 @@ static inline struct gen_pool *dev_to_pool(struct device *dev)
 	return atomic_pool_kernel;
 }
 
+static inline struct gen_pool *dma_get_safer_pool(struct gen_pool *bad_pool)
+{
+	if (bad_pool == atomic_pool_kernel)
+		return atomic_pool_dma32 ? : atomic_pool_dma;
+
+	if (bad_pool == atomic_pool_dma32)
+		return atomic_pool_dma;
+
+	return NULL;
+}
+
+static inline struct gen_pool *dma_guess_pool(struct device *dev,
+					      struct gen_pool *bad_pool)
+{
+	if (bad_pool)
+		return dma_get_safer_pool(bad_pool);
+
+	return dma_guess_pool_from_device(dev);
+}
+
 void *dma_alloc_from_pool(struct device *dev, size_t size,
 			  struct page **ret_page, gfp_t flags)
 {
-	struct gen_pool *pool = dev_to_pool(dev);
+	struct gen_pool *pool = dma_guess_pool(dev, NULL);
 	unsigned long val;
 	void *ptr = NULL;
 
@@ -249,7 +269,7 @@ void *dma_alloc_from_pool(struct device *dev, size_t size,
 
 bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 {
-	struct gen_pool *pool = dev_to_pool(dev);
+	struct gen_pool *pool = dma_guess_pool(dev, NULL);
 
 	if (!pool || !gen_pool_has_addr(pool, (unsigned long)start, size))
 		return false;
-- 
2.27.0

