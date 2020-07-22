Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C9BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01AD920737
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbgGVTTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:19:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:65004 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728497AbgGVTTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:19:44 -0400
IronPort-SDR: jEbXD6qCWwE6+/fdyBGjkP595UfFFGBTqo12nAsqhcf+KQGV7mP2RKte/4BkXYQTsh+raH/Nv3
 dwE6/A1CnpZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="149590051"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="149590051"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 12:19:43 -0700
IronPort-SDR: RkgAmJfU3x/374fBSFuIEayEtKhfXHZ0yNICQp16sXcLVhn+JM6pkeJvmhjju8BGQj8dcpiv8p
 eheZGEhGR5sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="362811894"
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
Subject: [PATCH v5 2/7] iommu/vt-d: Remove global page support in devTLB flush
Date:   Wed, 22 Jul 2020 12:26:22 -0700
Message-Id: <1595445987-40095-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595445987-40095-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1595445987-40095-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Global pages support is removed from VT-d spec 3.0 for dev TLB
invalidation. This patch is to remove the bits for vSVA. Similar change
already made for the native SVA. See the link below.

Link: https://lkml.org/lkml/2019/8/26/651
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  | 4 +---
 drivers/iommu/intel/iommu.c | 4 ++--
 include/linux/intel-iommu.h | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 683b812c5c47..9be08b9400ee 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1438,8 +1438,7 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 
 /* PASID-based device IOTLB Invalidate */
 void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			      u32 pasid,  u16 qdep, u64 addr,
-			      unsigned int size_order, u64 granu)
+			      u32 pasid,  u16 qdep, u64 addr, unsigned int size_order)
 {
 	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
 	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
@@ -1447,7 +1446,6 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) | QI_DEV_EIOTLB_SID(sid) |
 		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
 		QI_DEV_IOTLB_PFSID(pfsid);
-	desc.qw1 = QI_DEV_EIOTLB_GLOB(granu);
 
 	/*
 	 * If S bit is 0, we only flush a single page. If S bit is set,
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d759e7234e98..bdd1e7d81178 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5474,7 +5474,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 						info->pfsid, pasid,
 						info->ats_qdep,
 						inv_info->addr_info.addr,
-						size, granu);
+						size);
 			break;
 		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
 			if (info->ats_enabled)
@@ -5482,7 +5482,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 						info->pfsid, pasid,
 						info->ats_qdep,
 						inv_info->addr_info.addr,
-						size, granu);
+						size);
 			else
 				pr_warn_ratelimited("Passdown device IOTLB flush w/o ATS!\n");
 			break;
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 311117b50e93..c7a8aae36771 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -381,7 +381,6 @@ enum {
 
 #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
 #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
-#define QI_DEV_EIOTLB_GLOB(g)	((u64)(g) & 0x1)
 #define QI_DEV_EIOTLB_PASID(p)	((u64)((p) & 0xfffff) << 32)
 #define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
 #define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
@@ -705,7 +704,7 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 
 void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 			      u32 pasid, u16 qdep, u64 addr,
-			      unsigned int size_order, u64 granu);
+			      unsigned int size_order);
 void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
 			  int pasid);
 
-- 
2.7.4

