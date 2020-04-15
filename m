Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2E5C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A3320771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qiVMO4+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634560AbgDOAFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731580AbgDOAEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:04:54 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D14C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:04:54 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t11so685915pgg.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7RFyQdEIErgG1fTSGHuB9OTwvqhxhYtFRNnUGiVNx8Y=;
        b=qiVMO4+AkF6S05osVDfO7lKSnWKfW9jKv5edRy/7O3dPzngDUmK8yEBujFUCPaJuXP
         ZYIx5UtOueTeEMV3rKnUp1YF1I+epTpDbRAG/ZCidjKLxLd8TYX8Bz1L6QWh88fD3XKh
         WUuCs5S6rmRZJz8tA5+R6NC/Sl4kSbWi4qXetbTDEpFxI29DaKelcaf75lExsfjz8XMo
         bUif3iC57Ww3oL/I8MfME+7r5P/kqXtG9VUVRFD6U4b8q4rygCQD5SZRmn1CuMuhsXrt
         I601JkrNJLKIb3Rs3UC+Jo9eleHzGLwB3WLFE3+UdAe9VEacgYqNQx2Ad2VTgV7QPuxA
         eDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7RFyQdEIErgG1fTSGHuB9OTwvqhxhYtFRNnUGiVNx8Y=;
        b=MWRnnrQiNYgbCM5LZmTV8Mliarm9zYD9AxWZYbpy2rErAAH1CpPDUm3tHzs+wzm+rz
         SvmDYR7wVaHbWCLaEis/gefwCOOHSIFrmu9ZY4B1qQnF/vZmOAltVLGelJD9Qi4RTxTg
         dwqqjwdlxNU7nstSoUhZskNe3YfBLFQ7zmMUQnGSOIqTBcr+EUGDErewYFAi+wjz7jXm
         D16qlYo/SxK1UtvQDIqz+ljjAq4Teae5GLCE8LVGubFQbVnD45LiVHIS8lsAVGA4ITzD
         QiUUsHzz/0XvHE2WgHnRDemWgdnuDINFYemspAnZM3WR8iE2kR/YevTru7BJl2K6UWeE
         /d+Q==
X-Gm-Message-State: AGi0PuZLbZsHBaabgPJnWV+lr8yeGsbK4zofbTnGmNsZ4XWcLSZBs62Y
        sa7agQqO+F9bAoiv9Z3uyVoaeQ==
X-Google-Smtp-Source: APiQypKrzeSFn7eq1fDjF+jN1T7QnM3SGqlCKB2dr4yxJ1sBPPXs7QlyQCudLyT+c3JIudxjLJmNJg==
X-Received: by 2002:a63:31ca:: with SMTP id x193mr24044857pgx.146.1586909094050;
        Tue, 14 Apr 2020 17:04:54 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 3sm1509070pgh.75.2020.04.14.17.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 17:04:53 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:04:52 -0700 (PDT)
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
Subject: [patch 1/7] dma-remap: separate DMA atomic pools from direct remap
 code
In-Reply-To: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.22.394.2004141703030.68516@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/Kconfig  |   6 ++-
 kernel/dma/Makefile |   1 +
 kernel/dma/pool.c   | 123 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/dma/remap.c  | 114 ----------------------------------------
 4 files changed, 129 insertions(+), 115 deletions(-)
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
index 000000000000..6612c2d51d3c
--- /dev/null
+++ b/kernel/dma/pool.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
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
