Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7896DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A9282076B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SSTyKD1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392202AbgDOAF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634549AbgDOAE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:04:58 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84E6C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:04:58 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ng8so6013977pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fvE20WzTia3PlpbcEfRbKcopfOLGLyEeBU9i4s4lrX4=;
        b=SSTyKD1ZOcNsQoBj+fiA3e0/x8UzcDU00xsOMVkGKWgsBra4CzHIlgIpM5Hf25JcYJ
         N/qXZzifsJVIT2txZ9eB32J1T3uYDtrmSa7fz4crymKibZkbe0E2hCMVOlwzxmPgRiUm
         LU/vvhYbR2uIblGEzuL3M44aCBywquALEEsELpTkuvTv7uZOS6UOMDJF3Fnhr5efNrlm
         RiLELA5A/NPj8qAoCj6PlduoIOOS0GVg7B7ZmDJd/pJpRt8OUidDJmSBYQufZSb+92AA
         cRPmvY2iBXxsWQhoScJYIX7VSN8VQWSxtgiZDslI/SNlCdpLKFbOqxEVLFhy3hvlZ8kN
         o0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fvE20WzTia3PlpbcEfRbKcopfOLGLyEeBU9i4s4lrX4=;
        b=CLFqqwlu7tfY6aZe72pi2nO6ZxMj6oXuFOMwaak3t+qRjsbtWpZoXMNZivqzJFMhQO
         SEm2Fz7f/BhdMt+lpcni3DwGu0EApNyBIPi+0KnEUxNgYYZd8BFTojnZwyLmp6TCQ0W3
         3N8AYzX+lExqgOrUQ13Eqx/IlX1+8KGTv9NElNwMI02zJXjctskRp5C22Ejb+4bJE3O5
         qV0JvOOGbYY1NvbKIXQMvPN8WxcfrHcsoimHwuBd+3nByh6PE/V6g3HkRG5lw+gKGL/Q
         DvRK1HLHhFR6lBncUd0h2nKo/Eb3Nvgg/ypxhxi4LNkSj7WDSiqlTuOSVQ6uI6S71a9c
         in6A==
X-Gm-Message-State: AGi0PubZHm4mUe3QHaSJ3AM4Qv0pcdAbBa7YIrOEDTHjDSi7cIgZSBvT
        GUwSiUyIqJBvkXaox85mR6guCmbqOpg=
X-Google-Smtp-Source: APiQypJ1PjAne6YwQhhUJSqljY5Gj4XVzm20bbfXP82ChUmZFArF2ZBb8adfZczpdeKQBgF/ZDKuvQ==
X-Received: by 2002:a17:902:a603:: with SMTP id u3mr2401722plq.105.1586909098036;
        Tue, 14 Apr 2020 17:04:58 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 11sm11848427pfz.91.2020.04.14.17.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 17:04:57 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:04:56 -0700 (PDT)
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
Subject: [patch 3/7] dma-pool: dynamically expanding atomic pools
In-Reply-To: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.22.394.2004141703350.68516@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an atomic pool becomes fully depleted because it is now relied upon
for all non-blocking allocations through the DMA API, allow background
expansion of each pool by a kworker.

When an atomic pool has less than the default size of memory left, kick
off a kworker to dynamically expand the pool in the background.  The pool
is doubled in size, up to MAX_ORDER-1.  If memory cannot be allocated at
the requested order, smaller allocation(s) are attempted.

This allows the default size to be kept quite low when one or more of the
atomic pools is not used.

Allocations for lowmem should also use GFP_KERNEL for the benefits of
reclaim, so use GFP_KERNEL | GFP_DMA and GFP_KERNEL | GFP_DMA32 for
lowmem allocations.

This also allows __dma_atomic_pool_init() to return a pointer to the pool
to make initialization cleaner.

Also switch over some node ids to the more appropriate NUMA_NO_NODE.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/pool.c | 122 +++++++++++++++++++++++++++++++---------------
 1 file changed, 84 insertions(+), 38 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 5c98ab991b16..9e2da17ed17b 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -9,13 +9,17 @@
 #include <linux/genalloc.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/workqueue.h>
 
 static struct gen_pool *atomic_pool_dma __ro_after_init;
 static struct gen_pool *atomic_pool_dma32 __ro_after_init;
 static struct gen_pool *atomic_pool_kernel __ro_after_init;
 
 #define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
-static size_t atomic_pool_size __initdata = DEFAULT_DMA_COHERENT_POOL_SIZE;
+static size_t atomic_pool_size = DEFAULT_DMA_COHERENT_POOL_SIZE;
+
+/* Dynamic background expansion when the atomic pool is near capacity */
+static struct work_struct atomic_pool_work;
 
 static int __init early_coherent_pool(char *p)
 {
@@ -24,76 +28,116 @@ static int __init early_coherent_pool(char *p)
 }
 early_param("coherent_pool", early_coherent_pool);
 
-static int __init __dma_atomic_pool_init(struct gen_pool **pool,
-					 size_t pool_size, gfp_t gfp)
+static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
+			      gfp_t gfp)
 {
-	const unsigned int order = get_order(pool_size);
-	const unsigned long nr_pages = pool_size >> PAGE_SHIFT;
+	unsigned int order;
 	struct page *page;
 	void *addr;
-	int ret;
+	int ret = -ENOMEM;
+
+	/* Cannot allocate larger than MAX_ORDER-1 */
+	order = min(get_order(pool_size), MAX_ORDER-1);
+
+	do {
+		pool_size = 1 << (PAGE_SHIFT + order);
 
-	if (dev_get_cma_area(NULL))
-		page = dma_alloc_from_contiguous(NULL, nr_pages, order, false);
-	else
-		page = alloc_pages(gfp, order);
+		if (dev_get_cma_area(NULL))
+			page = dma_alloc_from_contiguous(NULL, 1 << order,
+							 order, false);
+		else
+			page = alloc_pages(gfp, order);
+	} while (!page && order-- > 0);
 	if (!page)
 		goto out;
 
 	arch_dma_prep_coherent(page, pool_size);
 
-	*pool = gen_pool_create(PAGE_SHIFT, -1);
-	if (!*pool)
-		goto free_page;
-
 	addr = dma_common_contiguous_remap(page, pool_size,
 					   pgprot_dmacoherent(PAGE_KERNEL),
 					   __builtin_return_address(0));
 	if (!addr)
-		goto destroy_genpool;
+		goto free_page;
 
-	ret = gen_pool_add_virt(*pool, (unsigned long)addr, page_to_phys(page),
-				pool_size, -1);
+	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
+				pool_size, NUMA_NO_NODE);
 	if (ret)
 		goto remove_mapping;
-	gen_pool_set_algo(*pool, gen_pool_first_fit_order_align, NULL);
 
-	pr_info("DMA: preallocated %zu KiB %pGg pool for atomic allocations\n",
-		pool_size >> 10, &gfp);
 	return 0;
 
 remove_mapping:
 	dma_common_free_remap(addr, pool_size);
-destroy_genpool:
-	gen_pool_destroy(*pool);
-	*pool = NULL;
 free_page:
-	if (!dma_release_from_contiguous(NULL, page, nr_pages))
+	if (!dma_release_from_contiguous(NULL, page, 1 << order))
 		__free_pages(page, order);
 out:
-	pr_err("DMA: failed to allocate %zu KiB %pGg pool for atomic allocation\n",
-	       pool_size >> 10, &gfp);
-	return -ENOMEM;
+	return ret;
+}
+
+static void atomic_pool_resize(struct gen_pool *pool, gfp_t gfp)
+{
+	if (pool && gen_pool_avail(pool) < atomic_pool_size)
+		atomic_pool_expand(pool, gen_pool_size(pool), gfp);
+}
+
+static void atomic_pool_work_fn(struct work_struct *work)
+{
+	if (IS_ENABLED(CONFIG_ZONE_DMA))
+		atomic_pool_resize(atomic_pool_dma,
+				   GFP_KERNEL | GFP_DMA);
+	if (IS_ENABLED(CONFIG_ZONE_DMA32))
+		atomic_pool_resize(atomic_pool_dma32,
+				   GFP_KERNEL | GFP_DMA32);
+	atomic_pool_resize(atomic_pool_kernel, GFP_KERNEL);
+}
+
+static __init struct gen_pool *__dma_atomic_pool_init(size_t pool_size,
+						      gfp_t gfp)
+{
+	struct gen_pool *pool;
+	int ret;
+
+	pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
+	if (!pool)
+		return NULL;
+
+	gen_pool_set_algo(pool, gen_pool_first_fit_order_align, NULL);
+
+	ret = atomic_pool_expand(pool, pool_size, gfp);
+	if (ret) {
+		gen_pool_destroy(pool);
+		pr_err("DMA: failed to allocate %zu KiB %pGg pool for atomic allocation\n",
+		       pool_size >> 10, &gfp);
+		return NULL;
+	}
+
+	pr_info("DMA: preallocated %zu KiB %pGg pool for atomic allocations\n",
+		gen_pool_size(pool) >> 10, &gfp);
+	return pool;
 }
 
 static int __init dma_atomic_pool_init(void)
 {
 	int ret = 0;
-	int err;
 
-	ret = __dma_atomic_pool_init(&atomic_pool_kernel, atomic_pool_size,
-				     GFP_KERNEL);
+	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
+
+	atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
+						    GFP_KERNEL);
+	if (!atomic_pool_kernel)
+		ret = -ENOMEM;
 	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
-		err = __dma_atomic_pool_init(&atomic_pool_dma,
-					     atomic_pool_size, GFP_DMA);
-		if (!ret && err)
-			ret = err;
+		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
+						GFP_KERNEL | GFP_DMA);
+		if (!atomic_pool_dma)
+			ret = -ENOMEM;
 	}
 	if (IS_ENABLED(CONFIG_ZONE_DMA32)) {
-		err = __dma_atomic_pool_init(&atomic_pool_dma32,
-					     atomic_pool_size, GFP_DMA32);
-		if (!ret && err)
-			ret = err;
+		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
+						GFP_KERNEL | GFP_DMA32);
+		if (!atomic_pool_dma32)
+			ret = -ENOMEM;
 	}
 	return ret;
 }
@@ -142,6 +186,8 @@ void *dma_alloc_from_pool(struct device *dev, size_t size,
 		ptr = (void *)val;
 		memset(ptr, 0, size);
 	}
+	if (gen_pool_avail(pool) < atomic_pool_size)
+		schedule_work(&atomic_pool_work);
 
 	return ptr;
 }
