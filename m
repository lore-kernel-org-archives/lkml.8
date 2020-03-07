Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD152C10F27
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 06:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE80B2070A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 06:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgCGGXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 01:23:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:29697 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgCGGXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 01:23:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 22:23:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,525,1574150400"; 
   d="scan'208";a="352915162"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2020 22:23:16 -0800
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
Subject: [PATCH 3/6] iommu/vt-d: Don't force 32bit devices to uses DMA domain
Date:   Sat,  7 Mar 2020 14:20:11 +0800
Message-Id: <20200307062014.3288-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200307062014.3288-1-baolu.lu@linux.intel.com>
References: <20200307062014.3288-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if a 32bit device initially uses an identity domain,
Intel IOMMU driver will convert it forcibly to a DMA one if its
address capability is not enough for the whole system memory.
The motivation was to overcome the overhead caused by possible
bounced buffer.

Unfortunately, this improvement has led to many problems. For
example, some 32bit devices are required to use an identity
domain, forcing them to use DMA domain will cause the device
not to work anymore. On the other hand, the VMD sub-devices
share a domain but each sub-device might have different address
capability. Forcing a VMD sub-device to use DMA domain blindly
will impact the operation of other sub-devices without any
notification. Further more, PCI aliased devices (PCI bridge
and all devices beneath it, VMD devices and various devices
quirked with pci_add_dma_alias()) must use the same domain.
Forcing one device to switch to DMA domain during runtime
will cause in-fligh DMAs for other devices to abort or target
to other memory which might cause undefind system behavior.

Cc: Daniel Drake <drake@endlessm.com>
Cc: Derrick Jonathan <jonathan.derrick@intel.com>
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 46 +------------------------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 33593fea0250..c58ced848206 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3582,47 +3582,13 @@ static struct dmar_domain *get_private_domain_for_dev(struct device *dev)
 /* Check if the dev needs to go through non-identity map and unmap process.*/
 static bool iommu_need_mapping(struct device *dev)
 {
-	int ret;
-
 	if (iommu_dummy(dev))
 		return false;
 
 	if (unlikely(attach_deferred(dev)))
 		do_deferred_attach(dev);
 
-	ret = identity_mapping(dev);
-	if (ret) {
-		u64 dma_mask = *dev->dma_mask;
-
-		if (dev->coherent_dma_mask && dev->coherent_dma_mask < dma_mask)
-			dma_mask = dev->coherent_dma_mask;
-
-		if (dma_mask >= dma_direct_get_required_mask(dev))
-			return false;
-
-		/*
-		 * 32 bit DMA is removed from si_domain and fall back to
-		 * non-identity mapping.
-		 */
-		dmar_remove_one_dev_info(dev);
-		ret = iommu_request_dma_domain_for_dev(dev);
-		if (ret) {
-			struct iommu_domain *domain;
-			struct dmar_domain *dmar_domain;
-
-			domain = iommu_get_domain_for_dev(dev);
-			if (domain) {
-				dmar_domain = to_dmar_domain(domain);
-				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
-			}
-			dmar_remove_one_dev_info(dev);
-			get_private_domain_for_dev(dev);
-		}
-
-		dev_info(dev, "32bit DMA uses non-identity mapping\n");
-	}
-
-	return true;
+	return !identity_mapping(dev);
 }
 
 static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
@@ -5179,16 +5145,6 @@ int __init intel_iommu_init(void)
 	}
 	up_write(&dmar_global_lock);
 
-#if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
-	/*
-	 * If the system has no untrusted device or the user has decided
-	 * to disable the bounce page mechanisms, we don't need swiotlb.
-	 * Mark this and the pre-allocated bounce pages will be released
-	 * later.
-	 */
-	if (!has_untrusted_dev() || intel_no_bounce)
-		swiotlb = 0;
-#endif
 	dma_ops = &intel_dma_ops;
 
 	init_iommu_pm_ops();
-- 
2.17.1

