Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E28C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01DAD20723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733018AbgFWPhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:37:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:27329 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732990AbgFWPgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:36:48 -0400
IronPort-SDR: /UUGJXYYOwiTLx7ZLbfFAEbsXy+GUi13q9Qo+XgKmq/L3T6h1hPt0ip0asYgEki48r7/vZBcfZ
 u723FEMFw+nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="124367617"
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="124367617"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 08:36:47 -0700
IronPort-SDR: F+pE8PC2bwIdrn5adWHISPAMxW06OHSTvh3F2enpnXWbVyCPLItYjIhJ6I2SmJ/jcM6F7uKk2s
 Tvz6CRnIrn2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="452262640"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 08:36:46 -0700
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
Subject: [PATCH 4/7] iommu/vt-d: Handle non-page aligned address
Date:   Tue, 23 Jun 2020 08:43:13 -0700
Message-Id: <1592926996-47914-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Yi L <yi.l.liu@intel.com>

Address information for device TLB invalidation comes from userspace
when device is directly assigned to a guest with vIOMMU support.
VT-d requires page aligned address. This patch checks and enforce
address to be page aligned, otherwise reserved bits can be set in the
invalidation descriptor. Unrecoverable fault will be reported due to
non-zero value in the reserved bits.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d9f973fa1190..53f4e5003620 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1455,9 +1455,24 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	 * Max Invs Pending (MIP) is set to 0 for now until we have DIT in
 	 * ECAP.
 	 */
-	desc.qw1 |= addr & ~mask;
-	if (size_order)
+	if (addr & ~VTD_PAGE_MASK)
+		pr_warn_ratelimited("Invalidate non-page aligned address %llx\n", addr);
+
+	if (size_order) {
+		/* Take page address */
+		desc.qw1 |= QI_DEV_EIOTLB_ADDR(addr);
+		/*
+		 * Existing 0s in address below size_order may be the least
+		 * significant bit, we must set them to 1s to avoid having
+		 * smaller size than desired.
+		 */
+		desc.qw1 |= GENMASK_ULL(size_order + VTD_PAGE_SHIFT,
+					VTD_PAGE_SHIFT);
+		/* Clear size_order bit to indicate size */
+		desc.qw1 &= ~mask;
+		/* Set the S bit to indicate flushing more than 1 page */
 		desc.qw1 |= QI_DEV_EIOTLB_SIZE;
+	}
 
 	qi_submit_sync(iommu, &desc, 1, 0);
 }
-- 
2.7.4

