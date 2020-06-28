Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACB4C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 11:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3347D21531
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 11:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgF1LO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 07:14:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48778 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726231AbgF1LO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 07:14:56 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AF7234EC6771B2A72DB5;
        Sun, 28 Jun 2020 19:14:53 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.201.68) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Sun, 28 Jun 2020 19:14:43 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <will@kernel.org>, <ganapatrao.kulkarni@cavium.com>,
        <catalin.marinas@arm.com>
CC:     <iommu@lists.linux-foundation.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Barry Song" <song.bao.hua@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v3 1/2] dma-direct: provide the ability to reserve per-numa CMA
Date:   Sun, 28 Jun 2020 23:12:50 +1200
Message-ID: <20200628111251.19108-2-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200628111251.19108-1-song.bao.hua@hisilicon.com>
References: <20200628111251.19108-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.201.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is useful for at least two scenarios:
1. ARM64 smmu will get memory from local numa node, it can save its
command queues and page tables locally. Tests show it can decrease
dma_unmap latency at lot. For example, without this patch, smmu on
node2 will get memory from node0 by calling dma_alloc_coherent(),
typically, it has to wait for more than 560ns for the completion of
CMD_SYNC in an empty command queue; with this patch, it needs 240ns
only.
2. when we set iommu passthrough, drivers will get memory from CMA,
local memory means much less latency.

Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
-v3:
  * move to use page_to_nid() while freeing cma with respect to Robin's
  comment, but this will only work after applying my below patch:
  "mm/cma.c: use exact_nid true to fix possible per-numa cma leak"
  https://marc.info/?l=linux-mm&m=159333034726647&w=2

  * handle the case count <= 1 more properly according to Robin's
  comment;

  * add pernuma_cma parameter to support dynamic setting of per-numa
  cma size;
  ideally we can leverage the CMA_SIZE_MBYTES, CMA_SIZE_PERCENTAGE and
  "cma=" kernel parameter and avoid a new paramter separately for per-
  numa cma. Practically, it is really too complicated considering the
  below problems:
  (1) if we leverage the size of default numa for per-numa, we have to
  avoid creating two cma with same size in node0 since default cma is
  probably on node0.
  (2) default cma can consider the address limitation for old devices
  while per-numa cma doesn't support GFP_DMA and GFP_DMA32. all
  allocations with limitation flags will fallback to default one.
  (3) hard to apply CMA_SIZE_PERCENTAGE to per-numa. it is hard to
  decide if the percentage should apply to the whole memory size
  or only apply to the memory size of a specific numa node.
  (4) default cma size has CMA_SIZE_SEL_MIN and CMA_SIZE_SEL_MAX, it
  makes things even more complicated to per-numa cma.

  I haven't figured out a good way to leverage the size of default cma
  for per-numa cma. it seems a separate parameter for per-numa could
  make life easier.

 .../admin-guide/kernel-parameters.txt         |  9 ++
 include/linux/dma-contiguous.h                |  4 +
 kernel/dma/Kconfig                            | 10 ++
 kernel/dma/contiguous.c                       | 98 +++++++++++++++++--
 4 files changed, 112 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad81c79..c52c22fa6de6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -599,6 +599,15 @@
 			altogether. For more information, see
 			include/linux/dma-contiguous.h
 
+	pernuma_cma=nn[MG]@[start[MG][-end[MG]]]
+			[ARM,X86,KNL]
+			Sets the size of kernel per-numa memory area for
+			contiguous memory allocations. A value of 0 disables
+			per-numa CMA altogether. DMA users on node nid will
+			first try to allocate buffer from the pernuma area
+			which is located in node nid, if the allocation fails,
+			they will fallback to the global default memory area.
+
 	cmo_free_hint=	[PPC] Format: { yes | no }
 			Specify whether pages are marked as being inactive
 			when they are freed.  This is used in CMO environments
diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
index 03f8e98e3bcc..278a80a40456 100644
--- a/include/linux/dma-contiguous.h
+++ b/include/linux/dma-contiguous.h
@@ -79,6 +79,8 @@ static inline void dma_contiguous_set_default(struct cma *cma)
 
 void dma_contiguous_reserve(phys_addr_t addr_limit);
 
+void dma_pernuma_cma_reserve(void);
+
 int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 				       phys_addr_t limit, struct cma **res_cma,
 				       bool fixed);
@@ -128,6 +130,8 @@ static inline void dma_contiguous_set_default(struct cma *cma) { }
 
 static inline void dma_contiguous_reserve(phys_addr_t limit) { }
 
+static inline void dma_pernuma_cma_reserve(void) { }
+
 static inline int dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 				       phys_addr_t limit, struct cma **res_cma,
 				       bool fixed)
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index d006668c0027..aeb976b1d21c 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -104,6 +104,16 @@ config DMA_CMA
 if  DMA_CMA
 comment "Default contiguous memory area size:"
 
+config CMA_PERNUMA_SIZE_MBYTES
+	int "Size in Mega Bytes for per-numa CMA areas"
+	depends on NUMA
+	default 16 if ARM64
+	default 0
+	help
+	  Defines the size (in MiB) of the per-numa memory area for Contiguous
+	  Memory Allocator. Every numa node will get a separate CMA with this
+	  size. If the size of 0 is selected, per-numa CMA is disabled.
+
 config CMA_SIZE_MBYTES
 	int "Size in Mega Bytes"
 	depends on !CMA_SIZE_SEL_PERCENTAGE
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 15bc5026c485..d0bb694c2f4d 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -30,7 +30,14 @@
 #define CMA_SIZE_MBYTES 0
 #endif
 
+#ifdef CONFIG_CMA_PERNUMA_SIZE_MBYTES
+#define CMA_SIZE_PERNUMA_MBYTES CONFIG_CMA_PERNUMA_SIZE_MBYTES
+#else
+#define CMA_SIZE_PERNUMA_MBYTES 0
+#endif
+
 struct cma *dma_contiguous_default_area;
+static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
 
 /*
  * Default global CMA area size can be defined in kernel's .config.
@@ -44,6 +51,8 @@ struct cma *dma_contiguous_default_area;
  */
 static const phys_addr_t size_bytes __initconst =
 	(phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
+static phys_addr_t pernuma_size_bytes __initdata =
+	(phys_addr_t)CMA_SIZE_PERNUMA_MBYTES * SZ_1M;
 static phys_addr_t  size_cmdline __initdata = -1;
 static phys_addr_t base_cmdline __initdata;
 static phys_addr_t limit_cmdline __initdata;
@@ -69,6 +78,13 @@ static int __init early_cma(char *p)
 }
 early_param("cma", early_cma);
 
+static int __init early_pernuma_cma(char *p)
+{
+	pernuma_size_bytes = memparse(p, &p);
+	return 0;
+}
+early_param("pernuma_cma", early_pernuma_cma);
+
 #ifdef CONFIG_CMA_SIZE_PERCENTAGE
 
 static phys_addr_t __init __maybe_unused cma_early_percent_memory(void)
@@ -96,6 +112,33 @@ static inline __maybe_unused phys_addr_t cma_early_percent_memory(void)
 
 #endif
 
+void __init dma_pernuma_cma_reserve(void)
+{
+	int nid;
+
+	if (!pernuma_size_bytes || nr_online_nodes <= 1)
+		return;
+
+	for_each_node_state(nid, N_ONLINE) {
+		int ret;
+		char name[20];
+
+		snprintf(name, sizeof(name), "pernuma%d", nid);
+		ret = cma_declare_contiguous_nid(0, pernuma_size_bytes, 0, 0,
+						 0, false, name,
+						 &dma_contiguous_pernuma_area[nid],
+						 nid);
+		if (ret) {
+			pr_warn("%s: reservation failed: err %d, node %d", __func__,
+				ret, nid);
+			continue;
+		}
+
+		pr_debug("%s: reserved %llu MiB on node %d\n", __func__,
+			(unsigned long long)pernuma_size_bytes / SZ_1M, nid);
+	}
+}
+
 /**
  * dma_contiguous_reserve() - reserve area(s) for contiguous memory handling
  * @limit: End address of the reserved memory (optional, 0 for any).
@@ -222,23 +265,35 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
  * @gfp:   Allocation flags.
  *
  * This function allocates contiguous memory buffer for specified device. It
- * tries to use device specific contiguous memory area if available, or the
- * default global one.
+ * tries to use device specific contiguous memory area if available, or it
+ * tries to use per-numa cma, if the allocation fails, it will fallback to
+ * try default global one.
  *
- * Note that it byapss one-page size of allocations from the global area as
- * the addresses within one page are always contiguous, so there is no need
- * to waste CMA pages for that kind; it also helps reduce fragmentations.
+ * Note that it bypass one-page size of allocations from the per-numa and
+ * global area as the addresses within one page are always contiguous, so
+ * there is no need to waste CMA pages for that kind; it also helps reduce
+ * fragmentations.
  */
 struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 {
 	size_t count = size >> PAGE_SHIFT;
 	struct page *page = NULL;
 	struct cma *cma = NULL;
+	int nid = dev ? dev_to_node(dev) : NUMA_NO_NODE;
+	bool alloc_from_pernuma = false;
+
+	if ((count <= 1) && !(dev && dev->cma_area))
+		return NULL;
 
 	if (dev && dev->cma_area)
 		cma = dev->cma_area;
-	else if (count > 1)
+	else if ((nid != NUMA_NO_NODE) && dma_contiguous_pernuma_area[nid]
+		&& !(gfp & (GFP_DMA | GFP_DMA32))) {
+		cma = dma_contiguous_pernuma_area[nid];
+		alloc_from_pernuma = true;
+	} else {
 		cma = dma_contiguous_default_area;
+	}
 
 	/* CMA can be used only in the context which permits sleeping */
 	if (cma && gfpflags_allow_blocking(gfp)) {
@@ -246,6 +301,11 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 		size_t cma_align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
 
 		page = cma_alloc(cma, count, cma_align, gfp & __GFP_NOWARN);
+
+		/* fall back to default cma if failed in per-numa cma */
+		if (!page && alloc_from_pernuma)
+			page = cma_alloc(dma_contiguous_default_area, count,
+				cma_align, gfp & __GFP_NOWARN);
 	}
 
 	return page;
@@ -264,9 +324,29 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
  */
 void dma_free_contiguous(struct device *dev, struct page *page, size_t size)
 {
-	if (!cma_release(dev_get_cma_area(dev), page,
-			 PAGE_ALIGN(size) >> PAGE_SHIFT))
-		__free_pages(page, get_order(size));
+	/* if dev has its own cma, free page from there */
+	if (dev && dev->cma_area) {
+		if (cma_release(dev->cma_area, page, PAGE_ALIGN(size) >> PAGE_SHIFT))
+			return;
+	} else {
+		/*
+		 * otherwise, page is from either per-numa cma or default cma
+		 */
+		int nid = page_to_nid(page);
+
+		if (nid != NUMA_NO_NODE) {
+			if (cma_release(dma_contiguous_pernuma_area[nid], page,
+						PAGE_ALIGN(size) >> PAGE_SHIFT))
+				return;
+		}
+
+		if (cma_release(dma_contiguous_default_area, page,
+					PAGE_ALIGN(size) >> PAGE_SHIFT))
+			return;
+	}
+
+	/* not in any cma, free from buddy */
+	__free_pages(page, get_order(size));
 }
 
 /*
-- 
2.27.0


