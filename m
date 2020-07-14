Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54AFC433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C0321D79
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rhW3oST8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgGNMc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgGNMcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:32:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55340C061755;
        Tue, 14 Jul 2020 05:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=z8wFYHvpj2g2xFS5/YiBc7GW6FsSmiP4taX5UIm0p3w=; b=rhW3oST8/y1BlKYN4rh7cG1jEz
        1KIOM3rEqWQ5YAhi4KL4haHmbBcbZNDCyyyUVlz23N2sJw3PpAjWuOH15jpNMcEhHwblReMX6beZG
        2QIt4pfW+PcDuJcQinbQ2Y6FmUmnQwfywqcIm3OIFgskhPV03aAQ5ZUtsJ6j1v+m4SKS70cIXTbdr
        Dj4n66Y4ueQDZ/lnjPkNh8yWz3n+fuJ1OtWFpTB0TCnAtyHD+Y/cUlGwOd9k2olCN1JPO6ZF65KH1
        DCyqWzlmTKO4jJZuIvM4ht9+0HtGwJahUg/edM0hYXI7Xs9rqZmouT2PXOB+bwvde5SlRNBX7Iy8l
        frjQoWKQ==;
Received: from [2001:4bb8:188:5f50:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvK6X-00026k-F4; Tue, 14 Jul 2020 12:32:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] sh: use the generic dma coherent remap allocator
Date:   Tue, 14 Jul 2020 14:18:56 +0200
Message-Id: <20200714121856.955680-11-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714121856.955680-1-hch@lst.de>
References: <20200714121856.955680-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches to using common code for the DMA allocations, including
potential use of the CMA allocator if configured.

Switching to the generic code enables DMA allocations from atomic
context, which is required by the DMA API documentation, and also
adds various other minor features drivers start relying upon.  It
also makes sure we have on tested code base for all architectures
that require uncached pte bits for coherent DMA allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/Kconfig               |  2 ++
 arch/sh/kernel/dma-coherent.c | 51 ++---------------------------------
 2 files changed, 4 insertions(+), 49 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 337eb496c45a0a..32d959849df9bc 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -137,7 +137,9 @@ config DMA_COHERENT
 
 config DMA_NONCOHERENT
 	def_bool !NO_DMA && !DMA_COHERENT
+	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select DMA_DIRECT_REMAP
 
 config PGTABLE_LEVELS
 	default 3 if X2TLB
diff --git a/arch/sh/kernel/dma-coherent.c b/arch/sh/kernel/dma-coherent.c
index d4811691b93cc1..cd46a9825e3c59 100644
--- a/arch/sh/kernel/dma-coherent.c
+++ b/arch/sh/kernel/dma-coherent.c
@@ -3,60 +3,13 @@
  * Copyright (C) 2004 - 2007  Paul Mundt
  */
 #include <linux/mm.h>
-#include <linux/init.h>
 #include <linux/dma-noncoherent.h>
-#include <linux/module.h>
 #include <asm/cacheflush.h>
 #include <asm/addrspace.h>
 
-void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t gfp, unsigned long attrs)
+void arch_dma_prep_coherent(struct page *page, size_t size)
 {
-	void *ret, *ret_nocache;
-	int order = get_order(size);
-
-	gfp |= __GFP_ZERO;
-
-	ret = (void *)__get_free_pages(gfp, order);
-	if (!ret)
-		return NULL;
-
-	/*
-	 * Pages from the page allocator may have data present in
-	 * cache. So flush the cache before using uncached memory.
-	 */
-	arch_sync_dma_for_device(virt_to_phys(ret), size,
-			DMA_BIDIRECTIONAL);
-
-	ret_nocache = (void __force *)ioremap(virt_to_phys(ret), size);
-	if (!ret_nocache) {
-		free_pages((unsigned long)ret, order);
-		return NULL;
-	}
-
-	split_page(pfn_to_page(virt_to_phys(ret) >> PAGE_SHIFT), order);
-
-	*dma_handle = virt_to_phys(ret);
-	if (!WARN_ON(!dev))
-		*dma_handle -= PFN_PHYS(dev->dma_pfn_offset);
-
-	return ret_nocache;
-}
-
-void arch_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, unsigned long attrs)
-{
-	int order = get_order(size);
-	unsigned long pfn = (dma_handle >> PAGE_SHIFT);
-	int k;
-
-	if (!WARN_ON(!dev))
-		pfn += dev->dma_pfn_offset;
-
-	for (k = 0; k < (1 << order); k++)
-		__free_pages(pfn_to_page(pfn + k), 0);
-
-	iounmap(vaddr);
+	__flush_purge_region(page_address(page), size);
 }
 
 void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
-- 
2.26.2

