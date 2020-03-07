Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2D2C10F26
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 06:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6E92073B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 06:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgCGGXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 01:23:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:29697 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgCGGX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 01:23:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 22:23:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,525,1574150400"; 
   d="scan'208";a="352915184"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2020 22:23:25 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        kevin.tian@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 6/6] iommu/vt-d: Apply per-device dma_ops
Date:   Sat,  7 Mar 2020 14:20:14 +0800
Message-Id: <20200307062014.3288-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200307062014.3288-1-baolu.lu@linux.intel.com>
References: <20200307062014.3288-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current Intel IOMMU driver sets the system level dma_ops. This
causes each dma API to go through the IOMMU driver even the
devices are using identity mapped domains. This sets per-device
dma_ops only if a device is using a DMA domain. Otherwise, use
the default system level dma_ops for direct dma.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 77 ++++++++++---------------------------
 1 file changed, 21 insertions(+), 56 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d86f4626cda5..7c7720b5784a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2712,17 +2712,6 @@ static int __init si_domain_init(int hw)
 	return 0;
 }
 
-static int identity_mapping(struct device *dev)
-{
-	struct device_domain_info *info;
-
-	info = dev->archdata.iommu;
-	if (info)
-		return (info->domain == si_domain);
-
-	return 0;
-}
-
 static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 {
 	struct dmar_domain *ndomain;
@@ -3307,18 +3296,6 @@ static unsigned long intel_alloc_iova(struct device *dev,
 	return iova_pfn;
 }
 
-/* Check if the dev needs to go through non-identity map and unmap process.*/
-static bool iommu_need_mapping(struct device *dev)
-{
-	if (iommu_dummy(dev))
-		return false;
-
-	if (unlikely(attach_deferred(dev)))
-		do_deferred_attach(dev);
-
-	return !identity_mapping(dev);
-}
-
 static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 				     size_t size, int dir, u64 dma_mask)
 {
@@ -3332,6 +3309,9 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 
 	BUG_ON(dir == DMA_NONE);
 
+	if (unlikely(attach_deferred(dev)))
+		do_deferred_attach(dev);
+
 	domain = find_domain(dev);
 	if (!domain)
 		return DMA_MAPPING_ERROR;
@@ -3383,20 +3363,15 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 				 enum dma_data_direction dir,
 				 unsigned long attrs)
 {
-	if (iommu_need_mapping(dev))
-		return __intel_map_single(dev, page_to_phys(page) + offset,
-				size, dir, *dev->dma_mask);
-	return dma_direct_map_page(dev, page, offset, size, dir, attrs);
+	return __intel_map_single(dev, page_to_phys(page) + offset,
+				  size, dir, *dev->dma_mask);
 }
 
 static dma_addr_t intel_map_resource(struct device *dev, phys_addr_t phys_addr,
 				     size_t size, enum dma_data_direction dir,
 				     unsigned long attrs)
 {
-	if (iommu_need_mapping(dev))
-		return __intel_map_single(dev, phys_addr, size, dir,
-				*dev->dma_mask);
-	return dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
+	return __intel_map_single(dev, phys_addr, size, dir, *dev->dma_mask);
 }
 
 static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
@@ -3447,17 +3422,13 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			     size_t size, enum dma_data_direction dir,
 			     unsigned long attrs)
 {
-	if (iommu_need_mapping(dev))
-		intel_unmap(dev, dev_addr, size);
-	else
-		dma_direct_unmap_page(dev, dev_addr, size, dir, attrs);
+	intel_unmap(dev, dev_addr, size);
 }
 
 static void intel_unmap_resource(struct device *dev, dma_addr_t dev_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	if (iommu_need_mapping(dev))
-		intel_unmap(dev, dev_addr, size);
+	intel_unmap(dev, dev_addr, size);
 }
 
 static void *intel_alloc_coherent(struct device *dev, size_t size,
@@ -3467,8 +3438,8 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 	struct page *page = NULL;
 	int order;
 
-	if (!iommu_need_mapping(dev))
-		return dma_direct_alloc(dev, size, dma_handle, flags, attrs);
+	if (unlikely(attach_deferred(dev)))
+		do_deferred_attach(dev);
 
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
@@ -3503,9 +3474,6 @@ static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
 	int order;
 	struct page *page = virt_to_page(vaddr);
 
-	if (!iommu_need_mapping(dev))
-		return dma_direct_free(dev, size, vaddr, dma_handle, attrs);
-
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
@@ -3523,9 +3491,6 @@ static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	struct scatterlist *sg;
 	int i;
 
-	if (!iommu_need_mapping(dev))
-		return dma_direct_unmap_sg(dev, sglist, nelems, dir, attrs);
-
 	for_each_sg(sglist, sg, nelems, i) {
 		nrpages += aligned_nrpages(sg_dma_address(sg), sg_dma_len(sg));
 	}
@@ -3549,8 +3514,9 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	struct intel_iommu *iommu;
 
 	BUG_ON(dir == DMA_NONE);
-	if (!iommu_need_mapping(dev))
-		return dma_direct_map_sg(dev, sglist, nelems, dir, attrs);
+
+	if (unlikely(attach_deferred(dev)))
+		do_deferred_attach(dev);
 
 	domain = find_domain(dev);
 	if (!domain)
@@ -3597,8 +3563,6 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 
 static u64 intel_get_required_mask(struct device *dev)
 {
-	if (!iommu_need_mapping(dev))
-		return dma_direct_get_required_mask(dev);
 	return DMA_BIT_MASK(32);
 }
 
@@ -4873,8 +4837,6 @@ int __init intel_iommu_init(void)
 	}
 	up_write(&dmar_global_lock);
 
-	dma_ops = &intel_dma_ops;
-
 	init_iommu_pm_ops();
 
 	for_each_active_iommu(iommu, drhd) {
@@ -5452,6 +5414,7 @@ static bool intel_iommu_capable(enum iommu_cap cap)
 
 static int intel_iommu_add_device(struct device *dev)
 {
+	struct iommu_domain *domain;
 	struct intel_iommu *iommu;
 	struct iommu_group *group;
 	u8 bus, devfn;
@@ -5476,10 +5439,13 @@ static int intel_iommu_add_device(struct device *dev)
 
 	iommu_group_put(group);
 
-	if (device_needs_bounce(dev)) {
-		dev_info(dev, "Use Intel IOMMU bounce page dma_ops\n");
+	domain = iommu_get_domain_for_dev(dev);
+	if (device_needs_bounce(dev))
 		set_dma_ops(dev, &bounce_dma_ops);
-	}
+	else if (domain && domain->type == IOMMU_DOMAIN_DMA)
+		set_dma_ops(dev, &intel_dma_ops);
+	else
+		set_dma_ops(dev, NULL);
 
 	return 0;
 }
@@ -5499,8 +5465,7 @@ static void intel_iommu_remove_device(struct device *dev)
 
 	iommu_device_unlink(&iommu->iommu, dev);
 
-	if (device_needs_bounce(dev))
-		set_dma_ops(dev, NULL);
+	set_dma_ops(dev, NULL);
 }
 
 static void intel_iommu_get_resv_regions(struct device *device,
-- 
2.17.1

