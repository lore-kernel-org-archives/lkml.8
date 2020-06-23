Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ECAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5AB720780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733071AbgFWPhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:37:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:27329 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732992AbgFWPgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:36:48 -0400
IronPort-SDR: MOcAt0y2hpNj6uzRcEIwOsvi+u0nnzIP8yUUwH5cAEJpQ+62bUndwrvITxgfK51VyRjSOeuETv
 V0Dzq9VEVrFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="124367618"
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="124367618"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 08:36:47 -0700
IronPort-SDR: k2apAaKBivgIXhj59rCh2jS9rqqNdo0TAlnaXzkRyb9C2CZXZE2XkooeqFUGchm0YlK838Uvi3
 ANKMnrr8jXew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="452262645"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 08:36:47 -0700
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
Subject: [PATCH 6/7] iommu/vt-d: Warn on out-of-range invalidation address
Date:   Tue, 23 Jun 2020 08:43:15 -0700
Message-Id: <1592926996-47914-7-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For guest requested IOTLB invalidation, address and mask are provided as
part of the invalidation data. VT-d HW silently ignores any address bits
below the mask. SW shall also allow such case but give warning if
address does not align with the mask. This patch relax the fault
handling from error to warning and proceed with invalidation request
with the given mask.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5ea5732d5ec4..50fc62413a35 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5439,13 +5439,12 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 
 		switch (BIT(cache_type)) {
 		case IOMMU_CACHE_INV_TYPE_IOTLB:
+			/* HW will ignore LSB bits based on address mask */
 			if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
 			    size &&
 			    (inv_info->addr_info.addr & ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
-				pr_err_ratelimited("Address out of range, 0x%llx, size order %llu\n",
-						   inv_info->addr_info.addr, size);
-				ret = -ERANGE;
-				goto out_unlock;
+				WARN_ONCE(1, "Address out of range, 0x%llx, size order %llu\n",
+					  inv_info->addr_info.addr, size);
 			}
 
 			/*
-- 
2.7.4

