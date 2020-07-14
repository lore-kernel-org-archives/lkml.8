Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87992C4345A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F268208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgGNMkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:40:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:54780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728455AbgGNMkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:40:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11DD0AD3A;
        Tue, 14 Jul 2020 12:40:02 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     hch@lst.de, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        iommu@lists.linux-foundation.org
Subject: [PATCH v2 1/4] dma-direct: Provide function to check physical memory area validity
Date:   Tue, 14 Jul 2020 14:39:25 +0200
Message-Id: <20200714123928.8581-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714123928.8581-1-nsaenzjulienne@suse.de>
References: <20200714123928.8581-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_coherent_ok() checks if a physical memory area fits a device's DMA
constraints.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 include/linux/dma-direct.h | 1 +
 kernel/dma/direct.c        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 5184735a0fe8..ab2e20cba951 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -69,6 +69,7 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
 u64 dma_direct_get_required_mask(struct device *dev);
 gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
 				  u64 *phys_mask);
+bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size);
 void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 95866b647581..67f060b86a73 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -70,7 +70,7 @@ gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
 	return 0;
 }
 
-static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
+bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
 	return phys_to_dma_direct(dev, phys) + size - 1 <=
 			min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit);
-- 
2.27.0

