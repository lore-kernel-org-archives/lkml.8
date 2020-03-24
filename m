Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCFDC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080AF20774
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L//iPNPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgCXQ1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:27:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59632 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbgCXQ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QOhFdVghmzzWBFVIiktpLtHySxmXru0IZ3ItHpXYenQ=; b=L//iPNPELyfOf0VDWA5mQyD/aY
        IEy8hwAzXXvWMKLdRF2IAn7xWfqOyskU3rSmm6MjYPwY2kALV7hKtNhiB66TO8U1Ix73cAtOUWhqY
        ow1XH2L7lrRL5hbJebQlx4IIna90a35d0bTlkzeOVwVBIkBxnoxwRS+cIjh11HVHPQhpaXVXiUbcX
        gOocYbSLBXTXBJvOrIrN+xt2ArGxibCXKTjFH4Yo7D9bsctObJkMVaazQtYsk3S/IafluQR8Sw0xy
        U7CnynU+plFi6dzqqt5YpefHeQOxnqxTOdklmIQJ4DJOwom5B8f0g2ZEOvr6fI2wmT/YrTzIMkFOx
        0CPngV6w==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGmOI-0007fl-S2; Tue, 24 Mar 2020 16:26:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] sh: use the generic dma coherent remap allocator
Date:   Tue, 24 Mar 2020 17:26:33 +0100
Message-Id: <20200324162633.754714-11-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324162633.754714-1-hch@lst.de>
References: <20200324162633.754714-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
index b97d9712c252..57cf54e29684 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -157,7 +157,9 @@ config DMA_COHERENT
 
 config DMA_NONCOHERENT
 	def_bool !NO_DMA && !DMA_COHERENT
+	select ARCH_HAS_DMA_PREP_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select DMA_DIRECT_REMAP
 
 config PGTABLE_LEVELS
 	default 3 if X2TLB
diff --git a/arch/sh/kernel/dma-coherent.c b/arch/sh/kernel/dma-coherent.c
index d4811691b93c..cd46a9825e3c 100644
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
2.25.1

