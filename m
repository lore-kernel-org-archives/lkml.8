Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBA7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 536972074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgFIGyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 02:54:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:28097 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbgFIGyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 02:54:31 -0400
IronPort-SDR: DYNqMGFBi9gDfaMwrkJlc6tKO+1SEneqALE/2Bdta1dJSpDvN29WG8rFct8eOv8lhFdMhvBJmR
 c3/OdcIkL52g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 23:54:30 -0700
IronPort-SDR: s+XGWlNsIXKwVLfLKu6THnbbqAZOLYdOox+8ELbS71den1jppMvdQiGkMERUiaYJRG+iUK1xrl
 h5JtqG24Hu7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,490,1583222400"; 
   d="scan'208";a="379655376"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jun 2020 23:54:27 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Update scalable mode paging structure coherency
Date:   Tue,  9 Jun 2020 14:50:19 +0800
Message-Id: <20200609065019.8749-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Scalable-mode Page-walk Coherency (SMPWC) field in the VT-d extended
capability register indicates the hardware coherency behavior on paging
structures accessed through the pasid table entry. This is ignored in
current code and using ECAP.C instead which is only valid in legacy mode.
Fix this so that paging structure updates could be manually flushed from
the cache line if hardware page walking is not snooped.

Fixes: 765b6a98c1de3 ("iommu/vt-d: Enumerate the scalable mode capability")
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6bdbf3332c60..cef163fd353b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -612,6 +612,12 @@ struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
 	return g_iommus[iommu_id];
 }
 
+static inline bool iommu_paging_structure_coherency(struct intel_iommu *iommu)
+{
+	return sm_supported(iommu) ?
+			ecap_smpwc(iommu->ecap) : ecap_coherent(iommu->ecap);
+}
+
 static void domain_update_iommu_coherency(struct dmar_domain *domain)
 {
 	struct dmar_drhd_unit *drhd;
@@ -623,7 +629,7 @@ static void domain_update_iommu_coherency(struct dmar_domain *domain)
 
 	for_each_domain_iommu(i, domain) {
 		found = true;
-		if (!ecap_coherent(g_iommus[i]->ecap)) {
+		if (!iommu_paging_structure_coherency(g_iommus[i])) {
 			domain->iommu_coherency = 0;
 			break;
 		}
@@ -634,7 +640,7 @@ static void domain_update_iommu_coherency(struct dmar_domain *domain)
 	/* No hardware attached; use lowest common denominator */
 	rcu_read_lock();
 	for_each_active_iommu(iommu, drhd) {
-		if (!ecap_coherent(iommu->ecap)) {
+		if (!iommu_paging_structure_coherency(iommu)) {
 			domain->iommu_coherency = 0;
 			break;
 		}
@@ -2094,7 +2100,8 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 
 	context_set_fault_enable(context);
 	context_set_present(context);
-	domain_flush_cache(domain, context, sizeof(*context));
+	if (!ecap_coherent(iommu->ecap))
+		clflush_cache_range(context, sizeof(*context));
 
 	/*
 	 * It's a non-present to present mapping. If hardware doesn't cache
-- 
2.17.1

