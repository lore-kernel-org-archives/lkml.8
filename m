Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3FDC352B6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D4ED20732
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P+S81egH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440113AbgDNMZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440077AbgDNMZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:25:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16079C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kom/CIBRWnlOW1ThqBKL6yDK2u3DAQkIEIUVL4MSjp8=; b=P+S81egH/6p3TTiviqato/Qh1X
        topOKY0ScT/FBNqgXkUuxl84aRXvtxKC/4mDynnAXp7RwbLwVF/6SqilFkbJWt0HbCgF3Xi/Rq4FA
        aH1SB2uRnfkxcMD1a94eH3lcoZUw21i2OJFk8J66TVvX+Eevz9IprPMXYTDQFvFBygqrEZWVZ9lhw
        qBwvK7fvCQbvlRAfH3m7++0eKG0zHrQ0yBc/c4fCgFwi2kOdpTebtiTXhXHff5sDR5owqv2Vbr+kM
        iQk+VUBpDMoJBepQqs9ERe3LE5cRBUb9C/zphHz/Ii77aX/eg4wnklF0GpkZJDLAarrSD/WOIERUL
        vFtchf5A==;
Received: from [2001:4bb8:180:384b:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOKcu-00055O-Nw; Tue, 14 Apr 2020 12:25:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linuxppc-dev@lists.ozlabs.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dma-mapping: inline the fast path dma-direct calls
Date:   Tue, 14 Apr 2020 14:25:04 +0200
Message-Id: <20200414122506.438134-3-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414122506.438134-1-hch@lst.de>
References: <20200414122506.438134-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inline the single page map/unmap/sync dma-direct calls into the now
out of line generic wrappers.  This restores the behavior of a single
function call that we had before moving the generic calls out of line.
Besides the dma-mapping callers there are just a few callers in IOMMU
drivers that have a bypass mode, and more of those are going to be
switched to the generic bypass soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-direct.h | 88 ++++++++++++++++++++++++++++----------
 kernel/dma/direct.c        | 65 ----------------------------
 2 files changed, 65 insertions(+), 88 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index da689ad5fffd..d653070d515b 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -3,8 +3,10 @@
 #define _LINUX_DMA_DIRECT_H 1
 
 #include <linux/dma-mapping.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/memblock.h> /* for min_low_pfn */
 #include <linux/mem_encrypt.h>
+#include <linux/swiotlb.h>
 
 extern unsigned int zone_dma_bits;
 
@@ -85,25 +87,17 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs);
 int dma_direct_supported(struct device *dev, u64 mask);
-dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs);
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
 dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
+size_t dma_direct_max_mapping_size(struct device *dev);
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_SWIOTLB)
-void dma_direct_sync_single_for_device(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir);
-void dma_direct_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
+void dma_direct_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir);
 #else
-static inline void dma_direct_sync_single_for_device(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir)
-{
-}
 static inline void dma_direct_sync_sg_for_device(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
 {
@@ -113,34 +107,82 @@ static inline void dma_direct_sync_sg_for_device(struct device *dev,
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL) || \
     defined(CONFIG_SWIOTLB)
-void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs);
 void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir, unsigned long attrs);
-void dma_direct_sync_single_for_cpu(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir);
 void dma_direct_sync_sg_for_cpu(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
 #else
-static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
-{
-}
 static inline void dma_direct_unmap_sg(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir,
 		unsigned long attrs)
 {
 }
+static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+}
+#endif
+
+static inline void dma_direct_sync_single_for_device(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+	phys_addr_t paddr = dma_to_phys(dev, addr);
+
+	if (unlikely(is_swiotlb_buffer(paddr)))
+		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
+
+	if (!dev_is_dma_coherent(dev))
+		arch_sync_dma_for_device(paddr, size, dir);
+}
+
 static inline void dma_direct_sync_single_for_cpu(struct device *dev,
 		dma_addr_t addr, size_t size, enum dma_data_direction dir)
 {
+	phys_addr_t paddr = dma_to_phys(dev, addr);
+
+	if (!dev_is_dma_coherent(dev)) {
+		arch_sync_dma_for_cpu(paddr, size, dir);
+		arch_sync_dma_for_cpu_all();
+	}
+
+	if (unlikely(is_swiotlb_buffer(paddr)))
+		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
 }
-static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
-		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+
+static inline dma_addr_t dma_direct_map_page(struct device *dev,
+		struct page *page, unsigned long offset, size_t size,
+		enum dma_data_direction dir, unsigned long attrs)
 {
+	phys_addr_t phys = page_to_phys(page) + offset;
+	dma_addr_t dma_addr = phys_to_dma(dev, phys);
+
+	if (unlikely(swiotlb_force == SWIOTLB_FORCE))
+		return swiotlb_map(dev, phys, size, dir, attrs);
+
+	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
+		if (swiotlb_force != SWIOTLB_NO_FORCE)
+			return swiotlb_map(dev, phys, size, dir, attrs);
+
+		dev_WARN_ONCE(dev, 1,
+			     "DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
+			     &dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
+		return DMA_MAPPING_ERROR;
+	}
+
+	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_device(phys, size, dir);
+	return dma_addr;
 }
-#endif
 
-size_t dma_direct_max_mapping_size(struct device *dev);
+static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	phys_addr_t phys = dma_to_phys(dev, addr);
 
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
+
+	if (unlikely(is_swiotlb_buffer(phys)))
+		swiotlb_tbl_unmap_single(dev, phys, size, size, dir, attrs);
+}
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index f1a9099a4b5b..0a320f9b837f 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -10,11 +10,9 @@
 #include <linux/dma-direct.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-contiguous.h>
-#include <linux/dma-noncoherent.h>
 #include <linux/pfn.h>
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
-#include <linux/swiotlb.h>
 
 /*
  * Most architectures use ZONE_DMA for the first 16 Megabytes, but some use it
@@ -249,18 +247,6 @@ void dma_direct_free(struct device *dev, size_t size,
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_SWIOTLB)
-void dma_direct_sync_single_for_device(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir)
-{
-	phys_addr_t paddr = dma_to_phys(dev, addr);
-
-	if (unlikely(is_swiotlb_buffer(paddr)))
-		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
-
-	if (!dev_is_dma_coherent(dev))
-		arch_sync_dma_for_device(paddr, size, dir);
-}
-
 void dma_direct_sync_sg_for_device(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
 {
@@ -284,20 +270,6 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL) || \
     defined(CONFIG_SWIOTLB)
-void dma_direct_sync_single_for_cpu(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir)
-{
-	phys_addr_t paddr = dma_to_phys(dev, addr);
-
-	if (!dev_is_dma_coherent(dev)) {
-		arch_sync_dma_for_cpu(paddr, size, dir);
-		arch_sync_dma_for_cpu_all();
-	}
-
-	if (unlikely(is_swiotlb_buffer(paddr)))
-		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
-}
-
 void dma_direct_sync_sg_for_cpu(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
 {
@@ -319,18 +291,6 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 		arch_sync_dma_for_cpu_all();
 }
 
-void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
-{
-	phys_addr_t phys = dma_to_phys(dev, addr);
-
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
-
-	if (unlikely(is_swiotlb_buffer(phys)))
-		swiotlb_tbl_unmap_single(dev, phys, size, size, dir, attrs);
-}
-
 void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
@@ -343,31 +303,6 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 }
 #endif
 
-dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	phys_addr_t phys = page_to_phys(page) + offset;
-	dma_addr_t dma_addr = phys_to_dma(dev, phys);
-
-	if (unlikely(swiotlb_force == SWIOTLB_FORCE))
-		return swiotlb_map(dev, phys, size, dir, attrs);
-
-	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
-		if (swiotlb_force != SWIOTLB_NO_FORCE)
-			return swiotlb_map(dev, phys, size, dir, attrs);
-
-		dev_WARN_ONCE(dev, 1,
-			     "DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
-			     &dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
-		return DMA_MAPPING_ERROR;
-	}
-
-	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		arch_sync_dma_for_device(phys, size, dir);
-	return dma_addr;
-}
-
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-- 
2.25.1

