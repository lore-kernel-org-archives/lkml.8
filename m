Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87B4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98EA2207F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbgGAP1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:27:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:54837 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732004AbgGAP1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:27:25 -0400
IronPort-SDR: 1lKOYQEx6jjlc7iAAJFMMwz/Q99Q7cNox9+cUXWwZe6PsSgian1z0C2o6o0O60pcVGMn2dJ+io
 lUFLthEI61DQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="126699717"
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="126699717"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 08:27:22 -0700
IronPort-SDR: u9h00Dj0YFmtIgKW1YoQHXAnJsnfhOsoXn8xVha87V1+qfbpWl7YNx/mN8KRBgu0o4amTw1zLf
 ywszPxoX+Lew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="295591646"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 01 Jul 2020 08:27:22 -0700
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
Subject: [PATCH v3 3/7] iommu/vt-d: Fix PASID devTLB invalidation
Date:   Wed,  1 Jul 2020 08:33:52 -0700
Message-Id: <1593617636-79385-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593617636-79385-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1593617636-79385-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DevTLB flush can be used for both DMA request with and without PASIDs.
The former uses PASID#0 (RID2PASID), latter uses non-zero PASID for SVA
usage.

This patch adds a check for PASID value such that devTLB flush with
PASID is used for SVA case. This is more efficient in that multiple
PASIDs can be used by a single device, when tearing down a PASID entry
we shall flush only the devTLB specific to a PASID.

Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table")
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index c81f0f17c6ba..fa0154cce537 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -486,7 +486,16 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	qdep = info->ats_qdep;
 	pfsid = info->pfsid;
 
-	qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
+	/*
+	 * When PASID 0 is used, it indicates RID2PASID(DMA request w/o PASID),
+	 * devTLB flush w/o PASID should be used. For non-zero PASID under
+	 * SVA usage, device could do DMA with multiple PASIDs. It is more
+	 * efficient to flush devTLB specific to the PASID.
+	 */
+	if (pasid == PASID_RID2PASID)
+		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
+	else
+		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0, 64 - VTD_PAGE_SHIFT);
 }
 
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
-- 
2.7.4

