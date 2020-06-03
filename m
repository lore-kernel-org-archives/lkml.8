Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C436BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 02:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B39D20663
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 02:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgFCCo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 22:44:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5842 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbgFCCo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 22:44:26 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DE0E2348B6AB4E692FD1;
        Wed,  3 Jun 2020 10:44:23 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.201.193) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 3 Jun 2020 10:44:14 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <catalin.marinas@arm.com>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <Jonathan.Cameron@huawei.com>, <john.garry@huawei.com>,
        <prime.zeng@hisilicon.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 1/3] dma-direct: provide the ability to reserve per-numa CMA
Date:   Wed, 3 Jun 2020 14:42:29 +1200
Message-ID: <20200603024231.61748-2-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200603024231.61748-1-song.bao.hua@hisilicon.com>
References: <20200603024231.61748-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.201.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is useful for two scenarios:
1. ARM64 smmu will get memory from local numa node, it can save its
command queues and page tables locally. Tests show it can decrease
dma_unmap latency at lot. For example, without this patch, smmu on
node2 will get memory from node0 by calling dma_alloc_coherent(),
typically, it has to wait for more than 560ns for the completion of
CMD_SYNC in an empty command queue; with this patch, it needs 240ns
only.
2. when we set iommu passthrough, drivers will get memory from CMA,
local memory means much less latency.

Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 include/linux/dma-contiguous.h |  4 ++++
 kernel/dma/Kconfig             | 10 +++++++++
 kernel/dma/contiguous.c        | 41 +++++++++++++++++++++++++++++++++-
 3 files changed, 54 insertions(+), 1 deletion(-)

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
index 4c103a24e380..14f4a1fe4285 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -100,6 +100,16 @@ config DMA_CMA
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
index 8bc6f2d670f9..4b10d0ca0456 100644
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
+struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
 
 /*
  * Default global CMA area size can be defined in kernel's .config.
@@ -44,6 +51,8 @@ struct cma *dma_contiguous_default_area;
  */
 static const phys_addr_t size_bytes __initconst =
 	(phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
+static const phys_addr_t pernuma_size_bytes __initconst =
+	(phys_addr_t)CMA_SIZE_PERNUMA_MBYTES * SZ_1M;
 static phys_addr_t  size_cmdline __initdata = -1;
 static phys_addr_t base_cmdline __initdata;
 static phys_addr_t limit_cmdline __initdata;
@@ -96,6 +105,31 @@ static inline __maybe_unused phys_addr_t cma_early_percent_memory(void)
 
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
+
+		ret = cma_declare_contiguous_nid(0, pernuma_size_bytes, 0, 0,
+						 0, false, "pernuma",
+						 &dma_contiguous_pernuma_area[nid],
+						 nid);
+		if (ret) {
+			pr_warn("%s: reservation failed: err %d, node %d", __func__,
+				ret, nid);
+			continue;
+		}
+
+		pr_debug("%s: reserved %llu MiB on node %d\n", __func__,
+			pernuma_size_bytes / SZ_1M, nid);
+	}
+}
+
 /**
  * dma_contiguous_reserve() - reserve area(s) for contiguous memory handling
  * @limit: End address of the reserved memory (optional, 0 for any).
@@ -223,7 +257,8 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
  *
  * This function allocates contiguous memory buffer for specified device. It
  * first tries to use device specific contiguous memory area if available or
- * the default global one, then tries a fallback allocation of normal pages.
+ * the per-numa ones and default global one, then tries a fallback allocation
+ * of normal pages. per-numa memory areas don't support address limit
  *
  * Note that it byapss one-page size of allocations from the global area as
  * the addresses within one page are always contiguous, so there is no need
@@ -234,9 +269,13 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 	size_t count = size >> PAGE_SHIFT;
 	struct page *page = NULL;
 	struct cma *cma = NULL;
+	int nid = dev_to_node(dev);
 
 	if (dev && dev->cma_area)
 		cma = dev->cma_area;
+	else if ((nid != NUMA_NO_NODE) && dma_contiguous_pernuma_area[nid]
+		&& !(gfp & (GFP_DMA | GFP_DMA32)))
+		cma = dma_contiguous_pernuma_area[nid];
 	else if (count > 1)
 		cma = dma_contiguous_default_area;
 
-- 
2.23.0


