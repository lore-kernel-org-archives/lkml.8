Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B28FC433F7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E546D20717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732744AbgGVTT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:19:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:65004 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732493AbgGVTTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:19:47 -0400
IronPort-SDR: SlE/y+lP7ySNRPYHHiNC0Golt9ULKZrmojITV1kXtTkiqt9vssvHkBWeseLgYMdjjte4HlSSlk
 +IYnpSTqXZeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="149590058"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="149590058"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 12:19:43 -0700
IronPort-SDR: pMs43vdrwWQ0lKNOQmBvzsKqLJUnHqKaWh1xcqIzETvuBiZXFm/xi5RBzjlzFdWdEZHtJUOl8s
 aM7TKIETlOvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="362811904"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 22 Jul 2020 12:19:43 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 5/7] iommu/vt-d: Fix devTLB flush for vSVA
Date:   Wed, 22 Jul 2020 12:26:25 -0700
Message-Id: <1595445987-40095-6-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595445987-40095-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1595445987-40095-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Yi L <yi.l.liu@intel.com>

For guest SVA usage, in order to optimize for less VMEXIT, guest request
of IOTLB flush also includes device TLB.

On the host side, IOMMU driver performs IOTLB and implicit devTLB
invalidation. When PASID-selective granularity is requested by the guest
we need to derive the equivalent address range for devTLB instead of
using the address information in the UAPI data. The reason for that is, unlike
IOTLB flush, devTLB flush does not support PASID-selective granularity.
This is to say, we need to set the following in the PASID based devTLB
invalidation descriptor:
- entire 64 bit range in address ~(0x1 << 63)
- S bit = 1 (VT-d CH 6.5.2.6).

Without this fix, device TLB flush range is not set properly for PASID
selective granularity. This patch also merged devTLB flush code for both
implicit and explicit cases.

Fixes: 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index bdd1e7d81178..c6999b9b6265 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5416,7 +5416,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 	sid = PCI_DEVID(bus, devfn);
 
 	/* Size is only valid in address selective invalidation */
-	if (inv_info->granularity != IOMMU_INV_GRANU_PASID)
+	if (inv_info->granularity == IOMMU_INV_GRANU_ADDR)
 		size = to_vtd_size(inv_info->addr_info.granule_size,
 				   inv_info->addr_info.nb_granules);
 
@@ -5425,6 +5425,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 			 IOMMU_CACHE_INV_TYPE_NR) {
 		int granu = 0;
 		u64 pasid = 0;
+		u64 addr = 0;
 
 		granu = to_vtd_granularity(cache_type, inv_info->granularity);
 		if (granu == -EINVAL) {
@@ -5464,24 +5465,33 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 					(granu == QI_GRAN_NONG_PASID) ? -1 : 1 << size,
 					inv_info->addr_info.flags & IOMMU_INV_ADDR_FLAGS_LEAF);
 
+			if (!info->ats_enabled)
+				break;
 			/*
 			 * Always flush device IOTLB if ATS is enabled. vIOMMU
 			 * in the guest may assume IOTLB flush is inclusive,
 			 * which is more efficient.
 			 */
-			if (info->ats_enabled)
-				qi_flush_dev_iotlb_pasid(iommu, sid,
-						info->pfsid, pasid,
-						info->ats_qdep,
-						inv_info->addr_info.addr,
-						size);
-			break;
+			fallthrough;
 		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
+			/*
+			 * PASID based device TLB invalidation does not support
+			 * IOMMU_INV_GRANU_PASID granularity but only supports
+			 * IOMMU_INV_GRANU_ADDR.
+			 * The equivalent of that is we set the size to be the
+			 * entire range of 64 bit. User only provides PASID info
+			 * without address info. So we set addr to 0.
+			 */
+			if (inv_info->granularity == IOMMU_INV_GRANU_PASID) {
+				size = 64 - VTD_PAGE_SHIFT;
+				addr = 0;
+			} else if (inv_info->granularity == IOMMU_INV_GRANU_ADDR)
+				addr = inv_info->addr_info.addr;
+
 			if (info->ats_enabled)
 				qi_flush_dev_iotlb_pasid(iommu, sid,
 						info->pfsid, pasid,
-						info->ats_qdep,
-						inv_info->addr_info.addr,
+						info->ats_qdep, addr,
 						size);
 			else
 				pr_warn_ratelimited("Passdown device IOTLB flush w/o ATS!\n");
-- 
2.7.4

