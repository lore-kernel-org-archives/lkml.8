Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E612C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E7320771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A2jYLkpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgDHVVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:21:13 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41310 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbgDHVVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:21:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id d24so2995319pll.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 14:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=XrwqZbZ6JyVYdyuo7IDIjfmWjlFwWYqBg8MJXvuP7Jc=;
        b=A2jYLkpGa0TCVu3kNy7L56iAgQwz3sQ513YQzo//e/Wc3fAPFs6p7v+WNGTHIO3KeU
         BeluFw3ZxMv09dOUmZf7M7NBt6RjPcjCW02G3bQ/bxNGs+fhqdNmNWa9H/0AAgRfCWPi
         PADq4pdWtj8LIkrAmyp+PXKyyLrBC+NR7bSfsVUploFgg07Mtttnv1b591p7vqTUakpp
         AQhZdZJ64dKSx0hvbr3C1VPDQeF8DdzjllK6umv12yPbTurhEo3xLdVTmVYhlQucCPCt
         IfSSBRrhsaic5yUufnGm5LnQLzntolBb1LU9wxzWfYVDpaVZ7chXGrXrhFCsNYDMFXlk
         mVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=XrwqZbZ6JyVYdyuo7IDIjfmWjlFwWYqBg8MJXvuP7Jc=;
        b=lYudSpfoS8uSpuVvpBQYTMXxM08rMh1mZRIQm1kI8jfQsvCnpBXXJO1fS7KLaXjoJN
         Rm3GS40CN+VihkQm42ey4DqFtQuGNoEqz8WlJPcTCUbk4D5E9yQjw9+tahRGQwS1bR6b
         lGMLKdpu1uarp939nDo8I5oVcoM1tdmrF5gzyBxsG6bn6MVRk5RWffq8mdrvzdXoK44w
         KlbNgOmlGLjz1SU+pIi8GhyNt7dHq5ZC/pp4jL2s2BMEBXFxHnd65n9IuJ06OcEOPCRo
         TDgVsm/c21HrZxmyP9RTX/+WmWIZ/jaY60RRspcLAnzVMGhj7XIe65Yms0ka4v9x/hlT
         75xA==
X-Gm-Message-State: AGi0PuYpK4FEseWhSuJVYkIQ3S5lxntXcAOPLtQPxpW+cphV5FREyRMu
        NzLYlJ/foZ5DS3dTmGNcjEXYZw==
X-Google-Smtp-Source: APiQypJbHyPTVqa91PsxIG/fkhTk5MssOnwIaFUlxeUKZl5SkSrG8Vblfvw7O0m0Pc1Ho/EM1StflQ==
X-Received: by 2002:a17:90a:3328:: with SMTP id m37mr7669217pjb.158.1586380868065;
        Wed, 08 Apr 2020 14:21:08 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a185sm17750579pfa.27.2020.04.08.14.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:21:07 -0700 (PDT)
Date:   Wed, 8 Apr 2020 14:21:06 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
cc:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: [rfc v2 3/6] dma-pool: dynamically expanding atomic pools
In-Reply-To: <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2004081419510.19661@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
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

This also allows __dma_atomic_pool_init to return a pointer to the pool
to make initialization cleaner.

Also switch over some node ids to the more appropriate NUMA_NO_NODE.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/pool.c | 120 +++++++++++++++++++++++++++++++---------------
 1 file changed, 82 insertions(+), 38 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 9b806f5eded8..e14c5a2da734 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -11,13 +11,17 @@
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
@@ -26,76 +30,114 @@ static int __init early_coherent_pool(char *p)
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
+		atomic_pool_resize(atomic_pool_dma, GFP_DMA);
+	if (IS_ENABLED(CONFIG_ZONE_DMA32))
+		atomic_pool_resize(atomic_pool_dma32, GFP_DMA32);
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
+							 GFP_DMA);
+		if (!atomic_pool_dma)
+			ret = -ENOMEM;
 	}
 	if (IS_ENABLED(CONFIG_ZONE_DMA32)) {
-		err = __dma_atomic_pool_init(&atomic_pool_dma32,
-					     atomic_pool_size, GFP_DMA32);
-		if (!ret && err)
-			ret = err;
+		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
+							   GFP_DMA32);
+		if (!atomic_pool_dma32)
+			ret = -ENOMEM;
 	}
 	return ret;
 }
@@ -144,6 +186,8 @@ void *dma_alloc_from_pool(struct device *dev, size_t size,
 		ptr = (void *)val;
 		memset(ptr, 0, size);
 	}
+	if (gen_pool_avail(pool) < atomic_pool_size)
+		schedule_work(&atomic_pool_work);
 
 	return ptr;
 }
