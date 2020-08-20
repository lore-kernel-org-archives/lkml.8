Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E86AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47281204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgHTPM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:12:58 -0400
Received: from foss.arm.com ([217.140.110.172]:40790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbgHTPJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:09:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C0E61045;
        Thu, 20 Aug 2020 08:09:05 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A3F923F6CF;
        Thu, 20 Aug 2020 08:09:01 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de, joro@8bytes.org, linux@armlinux.org.uk
Cc:     will@kernel.org, inki.dae@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        agross@kernel.org, bjorn.andersson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, vdumpa@nvidia.com,
        digetx@gmail.com, matthias.bgg@gmail.com, yong.wu@mediatek.com,
        geert+renesas@glider.be, magnus.damm@gmail.com, t-kristo@ti.com,
        s-anna@ti.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/18] ARM/dma-mapping: Merge IOMMU ops
Date:   Thu, 20 Aug 2020 16:08:22 +0100
Message-Id: <bcab0427a3e827f4a4c033fbdf61239c8449773c.1597931876.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1597931875.git.robin.murphy@arm.com>
References: <cover.1597931875.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dma_sync_* operations are now the only difference between the
coherent and non-coherent IOMMU ops. Some minor tweaks to make those
safe for coherent devices with minimal overhead, and we can condense
down to a single set of DMA ops.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm/mm/dma-mapping.c | 41 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 1bb7e9608f75..0537c97cebe1 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1677,6 +1677,9 @@ static void arm_iommu_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *s;
 	int i;
 
+	if (dev->dma_coherent)
+		return;
+
 	for_each_sg(sg, s, nents, i)
 		__dma_page_dev_to_cpu(sg_page(s), s->offset, s->length, dir);
 
@@ -1696,6 +1699,9 @@ static void arm_iommu_sync_sg_for_device(struct device *dev,
 	struct scatterlist *s;
 	int i;
 
+	if (dev->dma_coherent)
+		return;
+
 	for_each_sg(sg, s, nents, i)
 		__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
 }
@@ -1829,12 +1835,13 @@ static void arm_iommu_sync_single_for_cpu(struct device *dev,
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
-	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
+	struct page *page;
 	unsigned int offset = handle & ~PAGE_MASK;
 
-	if (!iova)
+	if (dev->dma_coherent || !iova)
 		return;
 
+	page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
 	__dma_page_dev_to_cpu(page, offset, size, dir);
 }
 
@@ -1843,12 +1850,13 @@ static void arm_iommu_sync_single_for_device(struct device *dev,
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
-	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
+	struct page *page;
 	unsigned int offset = handle & ~PAGE_MASK;
 
-	if (!iova)
+	if (dev->dma_coherent || !iova)
 		return;
 
+	page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
 	__dma_page_cpu_to_dev(page, offset, size, dir);
 }
 
@@ -1872,22 +1880,6 @@ static const struct dma_map_ops iommu_ops = {
 	.unmap_resource		= arm_iommu_unmap_resource,
 };
 
-static const struct dma_map_ops iommu_coherent_ops = {
-	.alloc		= arm_iommu_alloc_attrs,
-	.free		= arm_iommu_free_attrs,
-	.mmap		= arm_iommu_mmap_attrs,
-	.get_sgtable	= arm_iommu_get_sgtable,
-
-	.map_page	= arm_iommu_map_page,
-	.unmap_page	= arm_iommu_unmap_page,
-
-	.map_sg		= arm_iommu_map_sg,
-	.unmap_sg	= arm_iommu_unmap_sg,
-
-	.map_resource	= arm_iommu_map_resource,
-	.unmap_resource	= arm_iommu_unmap_resource,
-};
-
 /**
  * arm_iommu_create_mapping
  * @bus: pointer to the bus holding the client device (for IOMMU calls)
@@ -2067,11 +2059,6 @@ void arm_iommu_detach_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
 
-static const struct dma_map_ops *arm_get_iommu_dma_map_ops(bool coherent)
-{
-	return coherent ? &iommu_coherent_ops : &iommu_ops;
-}
-
 static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
 				    const struct iommu_ops *iommu)
 {
@@ -2118,8 +2105,6 @@ static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
 
 static void arm_teardown_iommu_dma_ops(struct device *dev) { }
 
-#define arm_get_iommu_dma_map_ops arm_get_dma_map_ops
-
 #endif	/* CONFIG_ARM_DMA_USE_IOMMU */
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
@@ -2141,7 +2126,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		return;
 
 	if (arm_setup_iommu_dma_ops(dev, dma_base, size, iommu))
-		dma_ops = arm_get_iommu_dma_map_ops(coherent);
+		dma_ops = &iommu_ops;
 	else
 		dma_ops = arm_get_dma_map_ops(coherent);
 
-- 
2.28.0.dirty

