Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23D8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B921F2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgF3VBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:01:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:26203 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbgF3VBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:01:08 -0400
IronPort-SDR: tC8vddosXwi9DGvUOGoWnm+I5/aUSXuoRlZvtp9aqzKZx4IZDQauAREoUeVWb71uVrxckkBuAH
 S+S3yIlGVz9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="147935012"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="147935012"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:01:05 -0700
IronPort-SDR: gSNp/vpoqUhHOCTl0xUUaku1SNTPfKpe1zH1G0/ikblflwlvVZArln/46UIl/XcYhTgLFcIWN8
 1RPWWUNmsQ3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="425337240"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2020 14:01:05 -0700
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
Subject: [PATCH v2 5/7] iommu/vt-d: Fix devTLB flush for vSVA
Date:   Tue, 30 Jun 2020 14:07:36 -0700
Message-Id: <1593551258-39854-6-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593551258-39854-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1593551258-39854-1-git-send-email-jacob.jun.pan@linux.intel.com>
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
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 96340da57075..6a0c62c7395c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5408,7 +5408,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 	sid = PCI_DEVID(bus, devfn);
 
 	/* Size is only valid in address selective invalidation */
-	if (inv_info->granularity != IOMMU_INV_GRANU_PASID)
+	if (inv_info->granularity == IOMMU_INV_GRANU_ADDR)
 		size = to_vtd_size(inv_info->addr_info.granule_size,
 				   inv_info->addr_info.nb_granules);
 
@@ -5417,6 +5417,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 			 IOMMU_CACHE_INV_TYPE_NR) {
 		int granu = 0;
 		u64 pasid = 0;
+		u64 addr = 0;
 
 		granu = to_vtd_granularity(cache_type, inv_info->granularity);
 		if (granu == -EINVAL) {
@@ -5456,24 +5457,31 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
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
+			 * There is no PASID selective flush for device TLB, so
+			 * the equivalent of that is we set the size to be the
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

