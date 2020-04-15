Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EF6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A50332076B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oofQEgIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732539AbgDOAFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634548AbgDOAE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:04:58 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC747C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:04:56 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a32so6003254pje.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=nJBTLfg7pY1GPUaJKmjqZGjaM9kWalZWIE7fqxWaxYU=;
        b=oofQEgINKJuLumQsP5ehGOF/wpY9J0YBdmXTWN4lkyCi3hQx7VH09n6F1y+auWWrN6
         QKtR7mVg5Cr5hWIyWQCZ3waYlXGwYRTUE48L11lk8mv0Nu582KKRFCD6rGNDesYNu9D7
         qxohwg9plhUhIrAsxumXDmqJVSJY6fpzWSwiuYMi2H2RliMXArPt0djKsqqfr0bVF1Dc
         sc4Hb6SSJWeJXJ2nS5YQPcCIkdIPYRR5USC767oceu6l0mIN0ZpGtB3OyvI6TmYeLgUY
         skFI7Q+Fbpcoqfmj7iITHmvcO+CRgMu78pHd4rsugwqBC4TIe29WlNX3Kt4t6pDgor7y
         ikxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=nJBTLfg7pY1GPUaJKmjqZGjaM9kWalZWIE7fqxWaxYU=;
        b=NrzWZyNlNFS/dRNjQUOedXp0eclpkVtDEMxxqzwFKX3BSSNHdImhaQtDfV8X+aE5OP
         3uNrDKzMkBwAv0dRmD53yJ1t5j5BsllKfxp4FNE17lJstV8OBhczJ+x82mDamajdehDq
         BQ6/WjDqGbnus2p7e3V7vCmf4uDyxD7EfXQ6bQXkNoqYmjwO+It3wqdpZy3S+7/8Zc2j
         /2DjH8KszgOo5qS4RQpfQz3L+wMyDpd2ThD7uWZZWVjiv4LIvHDg6J8RW22rWCA8sYuS
         a3BSfgIeOCDZ3xrTFESvEBJJUSDlcUfRPMz8Ai56NZcZ5sdRkoC2cx0OyOdJGmS0Ll4J
         fV2w==
X-Gm-Message-State: AGi0PuZVlETR72sVNxFjf6+68+k58iJFMpBXX8HKdzlgYxfek/YE7heo
        ELmhUhlR/rJda2ifwsM3hpztiw==
X-Google-Smtp-Source: APiQypJKQ3pjwNQsTjccqA29UdOhjLARlNG773jYDuOLiOfTM0KZnBpCiF7IeFaM0pDtkMGqbKcjtw==
X-Received: by 2002:a17:90a:d350:: with SMTP id i16mr2890367pjx.121.1586909096074;
        Tue, 14 Apr 2020 17:04:56 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id g6sm12085678pfr.56.2020.04.14.17.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 17:04:55 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:04:55 -0700 (PDT)
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
Subject: [patch 2/7] dma-pool: add additional coherent pools to map to gfp
 mask
In-Reply-To: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.22.394.2004141703190.68516@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The single atomic pool is allocated from the lowest zone possible since
it is guaranteed to be applicable for any DMA allocation.

Devices may allocate through the DMA API but not have a strict reliance
on GFP_DMA memory.  Since the atomic pool will be used for all
non-blockable allocations, returning all memory from ZONE_DMA may
unnecessarily deplete the zone.

Provision for multiple atomic pools that will map to the optimal gfp
mask of the device.

When allocating non-blockable memory, determine the optimal gfp mask of
the device and use the appropriate atomic pool.

The coherent DMA mask will remain the same between allocation and free
and, thus, memory will be freed to the same atomic pool it was allocated
from.

__dma_atomic_pool_init() will be changed to return struct gen_pool *
later once dynamic expansion is added.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 drivers/iommu/dma-iommu.c   |   5 +-
 include/linux/dma-direct.h  |   2 +
 include/linux/dma-mapping.h |   6 +-
 kernel/dma/direct.c         |  12 ++--
 kernel/dma/pool.c           | 120 +++++++++++++++++++++++-------------
 5 files changed, 91 insertions(+), 54 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ba128d1cdaee..4959f5df21bd 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -952,7 +952,7 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
 
 	/* Non-coherent atomic allocation? Easy */
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    dma_free_from_pool(cpu_addr, alloc_size))
+	    dma_free_from_pool(dev, cpu_addr, alloc_size))
 		return;
 
 	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
@@ -1035,7 +1035,8 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    !gfpflags_allow_blocking(gfp) && !coherent)
-		cpu_addr = dma_alloc_from_pool(PAGE_ALIGN(size), &page, gfp);
+		cpu_addr = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &page,
+					       gfp);
 	else
 		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
 	if (!cpu_addr)
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 24b8684aa21d..136f984df0d9 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -67,6 +67,8 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
 }
 
 u64 dma_direct_get_required_mask(struct device *dev);
+gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
+				  u64 *phys_mask);
 void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 330ad58fbf4d..b43116a6405d 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -630,9 +630,9 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
 			pgprot_t prot, const void *caller);
 void dma_common_free_remap(void *cpu_addr, size_t size);
 
-bool dma_in_atomic_pool(void *start, size_t size);
-void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags);
-bool dma_free_from_pool(void *start, size_t size);
+void *dma_alloc_from_pool(struct device *dev, size_t size,
+			  struct page **ret_page, gfp_t flags);
+bool dma_free_from_pool(struct device *dev, void *start, size_t size);
 
 int
 dma_common_get_sgtable(struct device *dev, struct sg_table *sgt, void *cpu_addr,
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8f4bbdaf965e..a834ee22f8ff 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -45,8 +45,8 @@ u64 dma_direct_get_required_mask(struct device *dev)
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
 
-static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
-		u64 *phys_limit)
+gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
+				  u64 *phys_limit)
 {
 	u64 dma_limit = min_not_zero(dma_mask, dev->bus_dma_limit);
 
@@ -89,8 +89,8 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	/* we always manually zero the memory once we are done: */
 	gfp &= ~__GFP_ZERO;
-	gfp |= __dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
-			&phys_limit);
+	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
+					   &phys_limit);
 	page = dma_alloc_contiguous(dev, alloc_size, gfp);
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 		dma_free_contiguous(dev, page, alloc_size);
@@ -128,7 +128,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    dma_alloc_need_uncached(dev, attrs) &&
 	    !gfpflags_allow_blocking(gfp)) {
-		ret = dma_alloc_from_pool(PAGE_ALIGN(size), &page, gfp);
+		ret = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &page, gfp);
 		if (!ret)
 			return NULL;
 		goto done;
@@ -212,7 +212,7 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 	}
 
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    dma_free_from_pool(cpu_addr, PAGE_ALIGN(size)))
+	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
 		return;
 
 	if (force_dma_unencrypted(dev))
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 6612c2d51d3c..5c98ab991b16 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -10,7 +10,9 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
-static struct gen_pool *atomic_pool __ro_after_init;
+static struct gen_pool *atomic_pool_dma __ro_after_init;
+static struct gen_pool *atomic_pool_dma32 __ro_after_init;
+static struct gen_pool *atomic_pool_kernel __ro_after_init;
 
 #define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
 static size_t atomic_pool_size __initdata = DEFAULT_DMA_COHERENT_POOL_SIZE;
@@ -22,89 +24,119 @@ static int __init early_coherent_pool(char *p)
 }
 early_param("coherent_pool", early_coherent_pool);
 
-static gfp_t dma_atomic_pool_gfp(void)
+static int __init __dma_atomic_pool_init(struct gen_pool **pool,
+					 size_t pool_size, gfp_t gfp)
 {
-	if (IS_ENABLED(CONFIG_ZONE_DMA))
-		return GFP_DMA;
-	if (IS_ENABLED(CONFIG_ZONE_DMA32))
-		return GFP_DMA32;
-	return GFP_KERNEL;
-}
-
-static int __init dma_atomic_pool_init(void)
-{
-	unsigned int pool_size_order = get_order(atomic_pool_size);
-	unsigned long nr_pages = atomic_pool_size >> PAGE_SHIFT;
+	const unsigned int order = get_order(pool_size);
+	const unsigned long nr_pages = pool_size >> PAGE_SHIFT;
 	struct page *page;
 	void *addr;
 	int ret;
 
 	if (dev_get_cma_area(NULL))
-		page = dma_alloc_from_contiguous(NULL, nr_pages,
-						 pool_size_order, false);
+		page = dma_alloc_from_contiguous(NULL, nr_pages, order, false);
 	else
-		page = alloc_pages(dma_atomic_pool_gfp(), pool_size_order);
+		page = alloc_pages(gfp, order);
 	if (!page)
 		goto out;
 
-	arch_dma_prep_coherent(page, atomic_pool_size);
+	arch_dma_prep_coherent(page, pool_size);
 
-	atomic_pool = gen_pool_create(PAGE_SHIFT, -1);
-	if (!atomic_pool)
+	*pool = gen_pool_create(PAGE_SHIFT, -1);
+	if (!*pool)
 		goto free_page;
 
-	addr = dma_common_contiguous_remap(page, atomic_pool_size,
+	addr = dma_common_contiguous_remap(page, pool_size,
 					   pgprot_dmacoherent(PAGE_KERNEL),
 					   __builtin_return_address(0));
 	if (!addr)
 		goto destroy_genpool;
 
-	ret = gen_pool_add_virt(atomic_pool, (unsigned long)addr,
-				page_to_phys(page), atomic_pool_size, -1);
+	ret = gen_pool_add_virt(*pool, (unsigned long)addr, page_to_phys(page),
+				pool_size, -1);
 	if (ret)
 		goto remove_mapping;
-	gen_pool_set_algo(atomic_pool, gen_pool_first_fit_order_align, NULL);
+	gen_pool_set_algo(*pool, gen_pool_first_fit_order_align, NULL);
 
-	pr_info("DMA: preallocated %zu KiB pool for atomic allocations\n",
-		atomic_pool_size / 1024);
+	pr_info("DMA: preallocated %zu KiB %pGg pool for atomic allocations\n",
+		pool_size >> 10, &gfp);
 	return 0;
 
 remove_mapping:
-	dma_common_free_remap(addr, atomic_pool_size);
+	dma_common_free_remap(addr, pool_size);
 destroy_genpool:
-	gen_pool_destroy(atomic_pool);
-	atomic_pool = NULL;
+	gen_pool_destroy(*pool);
+	*pool = NULL;
 free_page:
 	if (!dma_release_from_contiguous(NULL, page, nr_pages))
-		__free_pages(page, pool_size_order);
+		__free_pages(page, order);
 out:
-	pr_err("DMA: failed to allocate %zu KiB pool for atomic coherent allocation\n",
-		atomic_pool_size / 1024);
+	pr_err("DMA: failed to allocate %zu KiB %pGg pool for atomic allocation\n",
+	       pool_size >> 10, &gfp);
 	return -ENOMEM;
 }
+
+static int __init dma_atomic_pool_init(void)
+{
+	int ret = 0;
+	int err;
+
+	ret = __dma_atomic_pool_init(&atomic_pool_kernel, atomic_pool_size,
+				     GFP_KERNEL);
+	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
+		err = __dma_atomic_pool_init(&atomic_pool_dma,
+					     atomic_pool_size, GFP_DMA);
+		if (!ret && err)
+			ret = err;
+	}
+	if (IS_ENABLED(CONFIG_ZONE_DMA32)) {
+		err = __dma_atomic_pool_init(&atomic_pool_dma32,
+					     atomic_pool_size, GFP_DMA32);
+		if (!ret && err)
+			ret = err;
+	}
+	return ret;
+}
 postcore_initcall(dma_atomic_pool_init);
 
-bool dma_in_atomic_pool(void *start, size_t size)
+static inline struct gen_pool *dev_to_pool(struct device *dev)
 {
-	if (unlikely(!atomic_pool))
-		return false;
+	u64 phys_mask;
+	gfp_t gfp;
+
+	gfp = dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
+					  &phys_mask);
+	if (IS_ENABLED(CONFIG_ZONE_DMA) && gfp == GFP_DMA)
+		return atomic_pool_dma;
+	if (IS_ENABLED(CONFIG_ZONE_DMA32) && gfp == GFP_DMA32)
+		return atomic_pool_dma32;
+	return atomic_pool_kernel;
+}
 
-	return gen_pool_has_addr(atomic_pool, (unsigned long)start, size);
+static bool dma_in_atomic_pool(struct device *dev, void *start, size_t size)
+{
+	struct gen_pool *pool = dev_to_pool(dev);
+
+	if (unlikely(!pool))
+		return false;
+	return gen_pool_has_addr(pool, (unsigned long)start, size);
 }
 
-void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags)
+void *dma_alloc_from_pool(struct device *dev, size_t size,
+			  struct page **ret_page, gfp_t flags)
 {
+	struct gen_pool *pool = dev_to_pool(dev);
 	unsigned long val;
 	void *ptr = NULL;
 
-	if (!atomic_pool) {
-		WARN(1, "coherent pool not initialised!\n");
+	if (!pool) {
+		WARN(1, "%pGg atomic pool not initialised!\n", &flags);
 		return NULL;
 	}
 
-	val = gen_pool_alloc(atomic_pool, size);
+	val = gen_pool_alloc(pool, size);
 	if (val) {
-		phys_addr_t phys = gen_pool_virt_to_phys(atomic_pool, val);
+		phys_addr_t phys = gen_pool_virt_to_phys(pool, val);
 
 		*ret_page = pfn_to_page(__phys_to_pfn(phys));
 		ptr = (void *)val;
@@ -114,10 +146,12 @@ void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags)
 	return ptr;
 }
 
-bool dma_free_from_pool(void *start, size_t size)
+bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 {
-	if (!dma_in_atomic_pool(start, size))
+	struct gen_pool *pool = dev_to_pool(dev);
+
+	if (!dma_in_atomic_pool(dev, start, size))
 		return false;
-	gen_pool_free(atomic_pool, (unsigned long)start, size);
+	gen_pool_free(pool, (unsigned long)start, size);
 	return true;
 }
