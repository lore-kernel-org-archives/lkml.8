Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6484CC2BA80
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3147820771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCD1KXRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgDHVVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:21:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37966 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbgDHVVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:21:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id c21so3034675pfo.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 14:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=34Kn/eu0N7rYRcQksHLSyYAck8Jvs1iQ8jdTQOhf4Ck=;
        b=jCD1KXRGvc81zHGNV/YZL1/fM8jq8zVdMP7whm5j15FWS1pYB8zRmLnmnFArQ3DsQE
         Iu+5rSzL1Y586/poD0+AjOFifPtJAMhCHUMC+ai5SLQDEmhKAoUbBVrYwoEcBLNgFMtr
         o0+KpP8pJ8G4KPrGqeTwIcPnk9Wkbweecz948ztQU5lKSO1d3n0zufuXFlzdMAElQgkl
         BywzgakieQjRsJf7G0nnCx6Kb5an76l/ttNbOC+ERZlU7puJBzxyBAoTPSTzT/gNEu8W
         R2jyPA8LJ/zszRi2zDnxfD8jw43BpsSgZmt6mpQPyu34ze+ctwFmQAehvtvsrqNJlB3p
         Sosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=34Kn/eu0N7rYRcQksHLSyYAck8Jvs1iQ8jdTQOhf4Ck=;
        b=J0KX46uZ4cY1P5qSgwvu9+PNBiOz24Av4J0/BPz6qXiXZWncoj/YnjeFK7OG4+xf1m
         bbD5x+b54IHjZ2irdZd/7TcVqwJ+d2oBSPsp2e/LF1Tu8g437uU0bUnDkSnlC6955VNd
         +NTJ6xNEsGyaB/qgY9gSARhhqD6QLFmY7nV5ETO4jiMsZJMA0VXLC58sanMLLsQFSCwC
         4rGZkExog58bT6JpnCXXraErYcGeP8P+NUUXGIR69H3CHNByRr/K+11wDFTAjP4G2J0f
         bupEfh2F+v6g1hiWDlekOHul2uXHNHqSDiFq/jwuBnxQmfVo7nOaqyTFgZBmmT0kh/6v
         SqzA==
X-Gm-Message-State: AGi0PuYaWDpkBq2ESTS9MNLLotjAy3G+FpwEGoPgBQ1eI/Svg387H1CJ
        7mieGrKPoiay9p6+Z/2gkGdJsGg2/vg=
X-Google-Smtp-Source: APiQypKtS/LFVS198NdDuc3ZtVm87KjhUpjqfAcswscSsZzCMTJ3ghCkfuC8xCZ71NfUFWli5mGQYw==
X-Received: by 2002:aa7:9f49:: with SMTP id h9mr9824804pfr.217.1586380864725;
        Wed, 08 Apr 2020 14:21:04 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id q6sm405407pja.34.2020.04.08.14.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:21:04 -0700 (PDT)
Date:   Wed, 8 Apr 2020 14:21:03 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
cc:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: [rfc v2 1/6] dma-remap: separate DMA atomic pools from direct remap
 code
In-Reply-To: <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2004081419190.19661@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA atomic pools will be needed beyond only CONFIG_DMA_DIRECT_REMAP so
separate them out into their own file.

This also adds a new Kconfig option that can be subsequently used for
options, such as CONFIG_AMD_MEM_ENCRYPT, that will utilize the coherent
pools but do not have a dependency on direct remapping.

For this patch alone, there is no functional change introduced.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/Kconfig  |   6 ++-
 kernel/dma/Makefile |   1 +
 kernel/dma/pool.c   | 125 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/dma/remap.c  | 114 ----------------------------------------
 4 files changed, 131 insertions(+), 115 deletions(-)
 create mode 100644 kernel/dma/pool.c

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 4c103a24e380..d006668c0027 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -79,10 +79,14 @@ config DMA_REMAP
 	select DMA_NONCOHERENT_MMAP
 	bool
 
-config DMA_DIRECT_REMAP
+config DMA_COHERENT_POOL
 	bool
 	select DMA_REMAP
 
+config DMA_DIRECT_REMAP
+	bool
+	select DMA_COHERENT_POOL
+
 config DMA_CMA
 	bool "DMA Contiguous Memory Allocator"
 	depends on HAVE_DMA_CONTIGUOUS && CMA
diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
index d237cf3dc181..370f63344e9c 100644
--- a/kernel/dma/Makefile
+++ b/kernel/dma/Makefile
@@ -6,4 +6,5 @@ obj-$(CONFIG_DMA_DECLARE_COHERENT)	+= coherent.o
 obj-$(CONFIG_DMA_VIRT_OPS)		+= virt.o
 obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
 obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
+obj-$(CONFIG_DMA_COHERENT_POOL)		+= pool.o
 obj-$(CONFIG_DMA_REMAP)			+= remap.o
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
new file mode 100644
index 000000000000..64cbe5852cf6
--- /dev/null
+++ b/kernel/dma/pool.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (c) 2014 The Linux Foundation
+ * Copyright (C) 2020 Google LLC
+ */
+#include <linux/dma-direct.h>
+#include <linux/dma-noncoherent.h>
+#include <linux/dma-contiguous.h>
+#include <linux/init.h>
+#include <linux/genalloc.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+static struct gen_pool *atomic_pool __ro_after_init;
+
+#define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
+static size_t atomic_pool_size __initdata = DEFAULT_DMA_COHERENT_POOL_SIZE;
+
+static int __init early_coherent_pool(char *p)
+{
+	atomic_pool_size = memparse(p, &p);
+	return 0;
+}
+early_param("coherent_pool", early_coherent_pool);
+
+static gfp_t dma_atomic_pool_gfp(void)
+{
+	if (IS_ENABLED(CONFIG_ZONE_DMA))
+		return GFP_DMA;
+	if (IS_ENABLED(CONFIG_ZONE_DMA32))
+		return GFP_DMA32;
+	return GFP_KERNEL;
+}
+
+static int __init dma_atomic_pool_init(void)
+{
+	unsigned int pool_size_order = get_order(atomic_pool_size);
+	unsigned long nr_pages = atomic_pool_size >> PAGE_SHIFT;
+	struct page *page;
+	void *addr;
+	int ret;
+
+	if (dev_get_cma_area(NULL))
+		page = dma_alloc_from_contiguous(NULL, nr_pages,
+						 pool_size_order, false);
+	else
+		page = alloc_pages(dma_atomic_pool_gfp(), pool_size_order);
+	if (!page)
+		goto out;
+
+	arch_dma_prep_coherent(page, atomic_pool_size);
+
+	atomic_pool = gen_pool_create(PAGE_SHIFT, -1);
+	if (!atomic_pool)
+		goto free_page;
+
+	addr = dma_common_contiguous_remap(page, atomic_pool_size,
+					   pgprot_dmacoherent(PAGE_KERNEL),
+					   __builtin_return_address(0));
+	if (!addr)
+		goto destroy_genpool;
+
+	ret = gen_pool_add_virt(atomic_pool, (unsigned long)addr,
+				page_to_phys(page), atomic_pool_size, -1);
+	if (ret)
+		goto remove_mapping;
+	gen_pool_set_algo(atomic_pool, gen_pool_first_fit_order_align, NULL);
+
+	pr_info("DMA: preallocated %zu KiB pool for atomic allocations\n",
+		atomic_pool_size / 1024);
+	return 0;
+
+remove_mapping:
+	dma_common_free_remap(addr, atomic_pool_size);
+destroy_genpool:
+	gen_pool_destroy(atomic_pool);
+	atomic_pool = NULL;
+free_page:
+	if (!dma_release_from_contiguous(NULL, page, nr_pages))
+		__free_pages(page, pool_size_order);
+out:
+	pr_err("DMA: failed to allocate %zu KiB pool for atomic coherent allocation\n",
+		atomic_pool_size / 1024);
+	return -ENOMEM;
+}
+postcore_initcall(dma_atomic_pool_init);
+
+bool dma_in_atomic_pool(void *start, size_t size)
+{
+	if (unlikely(!atomic_pool))
+		return false;
+
+	return gen_pool_has_addr(atomic_pool, (unsigned long)start, size);
+}
+
+void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags)
+{
+	unsigned long val;
+	void *ptr = NULL;
+
+	if (!atomic_pool) {
+		WARN(1, "coherent pool not initialised!\n");
+		return NULL;
+	}
+
+	val = gen_pool_alloc(atomic_pool, size);
+	if (val) {
+		phys_addr_t phys = gen_pool_virt_to_phys(atomic_pool, val);
+
+		*ret_page = pfn_to_page(__phys_to_pfn(phys));
+		ptr = (void *)val;
+		memset(ptr, 0, size);
+	}
+
+	return ptr;
+}
+
+bool dma_free_from_pool(void *start, size_t size)
+{
+	if (!dma_in_atomic_pool(start, size))
+		return false;
+	gen_pool_free(atomic_pool, (unsigned long)start, size);
+	return true;
+}
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index d14cbc83986a..081486007342 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -97,117 +97,3 @@ void dma_common_free_remap(void *cpu_addr, size_t size)
 	unmap_kernel_range((unsigned long)cpu_addr, PAGE_ALIGN(size));
 	vunmap(cpu_addr);
 }
-
-#ifdef CONFIG_DMA_DIRECT_REMAP
-static struct gen_pool *atomic_pool __ro_after_init;
-
-#define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
-static size_t atomic_pool_size __initdata = DEFAULT_DMA_COHERENT_POOL_SIZE;
-
-static int __init early_coherent_pool(char *p)
-{
-	atomic_pool_size = memparse(p, &p);
-	return 0;
-}
-early_param("coherent_pool", early_coherent_pool);
-
-static gfp_t dma_atomic_pool_gfp(void)
-{
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
-	struct page *page;
-	void *addr;
-	int ret;
-
-	if (dev_get_cma_area(NULL))
-		page = dma_alloc_from_contiguous(NULL, nr_pages,
-						 pool_size_order, false);
-	else
-		page = alloc_pages(dma_atomic_pool_gfp(), pool_size_order);
-	if (!page)
-		goto out;
-
-	arch_dma_prep_coherent(page, atomic_pool_size);
-
-	atomic_pool = gen_pool_create(PAGE_SHIFT, -1);
-	if (!atomic_pool)
-		goto free_page;
-
-	addr = dma_common_contiguous_remap(page, atomic_pool_size,
-					   pgprot_dmacoherent(PAGE_KERNEL),
-					   __builtin_return_address(0));
-	if (!addr)
-		goto destroy_genpool;
-
-	ret = gen_pool_add_virt(atomic_pool, (unsigned long)addr,
-				page_to_phys(page), atomic_pool_size, -1);
-	if (ret)
-		goto remove_mapping;
-	gen_pool_set_algo(atomic_pool, gen_pool_first_fit_order_align, NULL);
-
-	pr_info("DMA: preallocated %zu KiB pool for atomic allocations\n",
-		atomic_pool_size / 1024);
-	return 0;
-
-remove_mapping:
-	dma_common_free_remap(addr, atomic_pool_size);
-destroy_genpool:
-	gen_pool_destroy(atomic_pool);
-	atomic_pool = NULL;
-free_page:
-	if (!dma_release_from_contiguous(NULL, page, nr_pages))
-		__free_pages(page, pool_size_order);
-out:
-	pr_err("DMA: failed to allocate %zu KiB pool for atomic coherent allocation\n",
-		atomic_pool_size / 1024);
-	return -ENOMEM;
-}
-postcore_initcall(dma_atomic_pool_init);
-
-bool dma_in_atomic_pool(void *start, size_t size)
-{
-	if (unlikely(!atomic_pool))
-		return false;
-
-	return gen_pool_has_addr(atomic_pool, (unsigned long)start, size);
-}
-
-void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags)
-{
-	unsigned long val;
-	void *ptr = NULL;
-
-	if (!atomic_pool) {
-		WARN(1, "coherent pool not initialised!\n");
-		return NULL;
-	}
-
-	val = gen_pool_alloc(atomic_pool, size);
-	if (val) {
-		phys_addr_t phys = gen_pool_virt_to_phys(atomic_pool, val);
-
-		*ret_page = pfn_to_page(__phys_to_pfn(phys));
-		ptr = (void *)val;
-		memset(ptr, 0, size);
-	}
-
-	return ptr;
-}
-
-bool dma_free_from_pool(void *start, size_t size)
-{
-	if (!dma_in_atomic_pool(start, size))
-		return false;
-	gen_pool_free(atomic_pool, (unsigned long)start, size);
-	return true;
-}
-#endif /* CONFIG_DMA_DIRECT_REMAP */
