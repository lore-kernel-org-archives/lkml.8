Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E633CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B1D2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgF3VBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:01:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:26203 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgF3VBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:01:05 -0400
IronPort-SDR: 0r1y0kN4stkWcBgo1/9jJ5Ib2S8tq/zhiT695KK0rluOE/+b3dHZ7Koxwwm5CJQnzvtJqZW4U3
 WcSdhLf/wB0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="147935007"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="147935007"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 14:01:05 -0700
IronPort-SDR: PLfeMlB4FVyybdV/sOAZ6ts7BFZIIowAkySH/V5FngvMRDCT2Syhe4Xho1gGnMxV1Di9r/tBSV
 nUzGDUJVU8fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="425337231"
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
Subject: [PATCH v2 3/7] iommu/vt-d: Fix PASID devTLB invalidation
Date:   Tue, 30 Jun 2020 14:07:34 -0700
Message-Id: <1593551258-39854-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593551258-39854-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1593551258-39854-1-git-send-email-jacob.jun.pan@linux.intel.com>
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
index c81f0f17c6ba..70d21209dd04 100644
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
+		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0, 64 - VTD_PAGE_SHIFT);
+	else
+		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
 }
 
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
-- 
2.7.4

