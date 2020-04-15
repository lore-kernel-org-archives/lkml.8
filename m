Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A05C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC1E2076B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WulsqM//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392238AbgDOAGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634552AbgDOAFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:05:00 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B01AC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:05:00 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b72so707910pfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=uKdGdqF/+GNBYDZWM+26jf4oQ2Rr7fsIm1TWA6uIlOA=;
        b=WulsqM//lOs3T2IowcDd43dAEvBgL4u222+/xORDx+a8LvPRVm9cY3NQfEqWuqqkRE
         fddXnxLsqPjFuz+CPoWBTB8apYtNoHXOQr1BMMmRpLV7dNnC3oqa9jAKPo4I75G9fmxX
         vxIvzftwroSPfYRM3wdT2E9nLqgIiLSp0XqVxu/DRz7vgc9i7nNMvX4hZTJUfN/+MQZz
         xmgPx5BX1IhgddUd+tTNj4GfKchRjGq2Gt9BlPgSbAinptlRGRVjGLnuJRX6JfZuYjkF
         BHPYE2cp2yWj3CPx4BwmlSXUVx78saZsmeirZ+/ojUj2pYZHiQ23RBo1UqOGX/T7WQLX
         FrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=uKdGdqF/+GNBYDZWM+26jf4oQ2Rr7fsIm1TWA6uIlOA=;
        b=PRC/iq7m9/0sdcNBxGy3cVa2lFzyDAtlZL1uaope8Higxru6yIeUwKuv8PZ4izgRaS
         dFrXUMxrTsLszeVNnaN1NwMdwcslCXz+oQ1qMlTyN2zPFRdGqm7mNNZXnmZAY77A77eO
         CdyEqPDCCNF2QK2ytMCPrvolqEGGPUmQ2+xLISXceC169vCdnJguwW6B8WpX+KWaQ4w+
         4LmBrbC2RobovNqQNVzzhnKlVbNedX8IP9L10t00haqTz4l+QOBhHKkvakTw9oHNM5Nj
         3aNpbfrHS6ECi7FrOW6Jg/Nr1Y+G3bZxBvZp4bdiJFBKg7X78VywWi/7uN/1FdqS1pBk
         e9Mg==
X-Gm-Message-State: AGi0Pub/41pVlLXilQxh0Mfhycr/yRwd4Erx/7f1dEGBJi8n0r5bKrXd
        cRnfBArSJ8VahFXXnAAsPnh/znAzCVE=
X-Google-Smtp-Source: APiQypIj29iY072qqzgGUgL65ji+DU+sBEh3m0c+CHuHnlHrGiB7UdLUrPRezwGWOyVMchjIpB4MhQ==
X-Received: by 2002:a65:44cb:: with SMTP id g11mr16665800pgs.436.1586909099611;
        Tue, 14 Apr 2020 17:04:59 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id q131sm7247530pfq.115.2020.04.14.17.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 17:04:59 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:04:58 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Jon Grimm <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: [patch 4/7] dma-direct: atomic allocations must come from atomic
 coherent pools
In-Reply-To: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.22.394.2004141703510.68516@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a device requires unencrypted memory and the context does not allow
blocking, memory must be returned from the atomic coherent pools.

This avoids the remap when CONFIG_DMA_DIRECT_REMAP is not enabled and the
config only requires CONFIG_DMA_COHERENT_POOL.  This will be used for
CONFIG_AMD_MEM_ENCRYPT in a subsequent patch.

Keep all memory in these pools unencrypted.  When set_memory_decrypted()
fails, this prohibits the memory from being added.  If adding memory to
the genpool fails, and set_memory_encrypted() subsequently fails, there
is no alternative other than leaking the memory.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/direct.c | 46 ++++++++++++++++++++++++++++++++++++++-------
 kernel/dma/pool.c   | 27 +++++++++++++++++++++++---
 2 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index a834ee22f8ff..07ecc5c4d134 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -76,6 +76,39 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 			min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit);
 }
 
+/*
+ * Decrypting memory is allowed to block, so if this device requires
+ * unencrypted memory it must come from atomic pools.
+ */
+static inline bool dma_should_alloc_from_pool(struct device *dev, gfp_t gfp,
+					      unsigned long attrs)
+{
+	if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
+		return false;
+	if (gfpflags_allow_blocking(gfp))
+		return false;
+	if (force_dma_unencrypted(dev))
+		return true;
+	if (!IS_ENABLED(CONFIG_DMA_DIRECT_REMAP))
+		return false;
+	if (dma_alloc_need_uncached(dev, attrs))
+		return true;
+	return false;
+}
+
+static inline bool dma_should_free_from_pool(struct device *dev,
+					     unsigned long attrs)
+{
+	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
+		return true;
+	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
+	    !force_dma_unencrypted(dev))
+		return false;
+	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP))
+		return true;
+	return false;
+}
+
 struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		gfp_t gfp, unsigned long attrs)
 {
@@ -125,9 +158,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	struct page *page;
 	void *ret;
 
-	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    dma_alloc_need_uncached(dev, attrs) &&
-	    !gfpflags_allow_blocking(gfp)) {
+	if (dma_should_alloc_from_pool(dev, gfp, attrs)) {
 		ret = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &page, gfp);
 		if (!ret)
 			return NULL;
@@ -204,6 +235,11 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 {
 	unsigned int page_order = get_order(size);
 
+	/* If cpu_addr is not from an atomic pool, dma_free_from_pool() fails */
+	if (dma_should_free_from_pool(dev, attrs) &&
+	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
+		return;
+
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
 	    !force_dma_unencrypted(dev)) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
@@ -211,10 +247,6 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 		return;
 	}
 
-	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
-		return;
-
 	if (force_dma_unencrypted(dev))
 		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
 
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 9e2da17ed17b..cf052314d9e4 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -7,6 +7,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/init.h>
 #include <linux/genalloc.h>
+#include <linux/set_memory.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/workqueue.h>
@@ -53,22 +54,42 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 
 	arch_dma_prep_coherent(page, pool_size);
 
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	addr = dma_common_contiguous_remap(page, pool_size,
 					   pgprot_dmacoherent(PAGE_KERNEL),
 					   __builtin_return_address(0));
 	if (!addr)
 		goto free_page;
-
+#else
+	addr = page_to_virt(page);
+#endif
+	/*
+	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
+	 * shrink so no re-encryption occurs in dma_direct_free_pages().
+	 */
+	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
+				   1 << order);
+	if (ret)
+		goto remove_mapping;
 	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
 				pool_size, NUMA_NO_NODE);
 	if (ret)
-		goto remove_mapping;
+		goto encrypt_mapping;
 
 	return 0;
 
+encrypt_mapping:
+	ret = set_memory_encrypted((unsigned long)page_to_virt(page),
+				   1 << order);
+	if (WARN_ON_ONCE(ret)) {
+		/* Decrypt succeeded but encrypt failed, purposely leak */
+		goto out;
+	}
 remove_mapping:
+#ifdef CONFIG_DMA_DIRECT_REMAP
 	dma_common_free_remap(addr, pool_size);
-free_page:
+#endif
+free_page: __maybe_unused
 	if (!dma_release_from_contiguous(NULL, page, 1 << order))
 		__free_pages(page, order);
 out:
