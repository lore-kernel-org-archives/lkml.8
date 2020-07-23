Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D98C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C2B2071A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgGWRTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:19:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:65337 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbgGWRS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:18:56 -0400
IronPort-SDR: N+NI3k0w7FrDfyEq6dITcBLFDG/W41XJr/GR77LS5W/KBpkl27+Q6y42oENwgt5mM/aW243LoN
 MG+kPzXKMkMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="151880957"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="151880957"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 10:18:55 -0700
IronPort-SDR: IkIBm09gNlxO9YlVjnaIk0y2ORspEW+U/baLCoQTpkTeIG2j8804PkqnqflbDBL6onim/C6JZC
 vdznZjhyH8uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="462933852"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 23 Jul 2020 10:18:55 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v6 3/6] iommu/uapi: Use named union for user data
Date:   Thu, 23 Jul 2020 10:25:37 -0700
Message-Id: <1595525140-23899-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595525140-23899-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1595525140-23899-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMU UAPI data size is filled by the user space which must be validated
by the kernel. To ensure backward compatibility, user data can only be
extended by either re-purpose padding bytes or extend the variable sized
union at the end. No size change is allowed before the union. Therefore,
the minimum size is the offset of the union.

To use offsetof() on the union, we must make it named.

Link: https://lore.kernel.org/linux-iommu/20200611145518.0c2817d6@x1.home/
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel/iommu.c | 22 +++++++++++-----------
 drivers/iommu/intel/svm.c   |  2 +-
 include/uapi/linux/iommu.h  |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 92c7ad66e64c..021f62078f52 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5417,8 +5417,8 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 
 	/* Size is only valid in address selective invalidation */
 	if (inv_info->granularity == IOMMU_INV_GRANU_ADDR)
-		size = to_vtd_size(inv_info->addr_info.granule_size,
-				   inv_info->addr_info.nb_granules);
+		size = to_vtd_size(inv_info->granu.addr_info.granule_size,
+				   inv_info->granu.addr_info.nb_granules);
 
 	for_each_set_bit(cache_type,
 			 (unsigned long *)&inv_info->cache,
@@ -5439,20 +5439,20 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 		 * granularity.
 		 */
 		if (inv_info->granularity == IOMMU_INV_GRANU_PASID &&
-		    (inv_info->pasid_info.flags & IOMMU_INV_PASID_FLAGS_PASID))
-			pasid = inv_info->pasid_info.pasid;
+		    (inv_info->granu.pasid_info.flags & IOMMU_INV_PASID_FLAGS_PASID))
+			pasid = inv_info->granu.pasid_info.pasid;
 		else if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
-			 (inv_info->addr_info.flags & IOMMU_INV_ADDR_FLAGS_PASID))
-			pasid = inv_info->addr_info.pasid;
+			 (inv_info->granu.addr_info.flags & IOMMU_INV_ADDR_FLAGS_PASID))
+			pasid = inv_info->granu.addr_info.pasid;
 
 		switch (BIT(cache_type)) {
 		case IOMMU_CACHE_INV_TYPE_IOTLB:
 			/* HW will ignore LSB bits based on address mask */
 			if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
 			    size &&
-			    (inv_info->addr_info.addr & ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
+			    (inv_info->granu.addr_info.addr & ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
 				pr_err_ratelimited("User address not aligned, 0x%llx, size order %llu\n",
-					  inv_info->addr_info.addr, size);
+						inv_info->granu.addr_info.addr, size);
 			}
 
 			/*
@@ -5460,9 +5460,9 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 			 * We use npages = -1 to indicate that.
 			 */
 			qi_flush_piotlb(iommu, did, pasid,
-					mm_to_dma_pfn(inv_info->addr_info.addr),
+					mm_to_dma_pfn(inv_info->granu.addr_info.addr),
 					(granu == QI_GRAN_NONG_PASID) ? -1 : 1 << size,
-					inv_info->addr_info.flags & IOMMU_INV_ADDR_FLAGS_LEAF);
+					inv_info->granu.addr_info.flags & IOMMU_INV_ADDR_FLAGS_LEAF);
 
 			if (!info->ats_enabled)
 				break;
@@ -5485,7 +5485,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 				size = 64 - VTD_PAGE_SHIFT;
 				addr = 0;
 			} else if (inv_info->granularity == IOMMU_INV_GRANU_ADDR)
-				addr = inv_info->addr_info.addr;
+				addr = inv_info->granu.addr_info.addr;
 
 			if (info->ats_enabled)
 				qi_flush_dev_iotlb_pasid(iommu, sid,
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d386853121a2..713b3a218483 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -338,7 +338,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	spin_lock(&iommu->lock);
 	ret = intel_pasid_setup_nested(iommu, dev,
 				       (pgd_t *)(uintptr_t)data->gpgd,
-				       data->hpasid, &data->vtd, dmar_domain,
+				       data->hpasid, &data->vendor.vtd, dmar_domain,
 				       data->addr_width);
 	spin_unlock(&iommu->lock);
 	if (ret) {
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index d5e9014f690e..7c8e075c2b29 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -263,7 +263,7 @@ struct iommu_cache_invalidate_info {
 	union {
 		struct iommu_inv_pasid_info pasid_info;
 		struct iommu_inv_addr_info addr_info;
-	};
+	} granu;
 };
 
 /**
@@ -329,7 +329,7 @@ struct iommu_gpasid_bind_data {
 	/* Vendor specific data */
 	union {
 		struct iommu_gpasid_bind_data_vtd vtd;
-	};
+	} vendor;
 };
 
 #endif /* _UAPI_IOMMU_H */
-- 
2.7.4

