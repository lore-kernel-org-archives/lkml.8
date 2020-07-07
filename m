Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10B9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB04B20656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGGAGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 20:06:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:18975 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbgGGAGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 20:06:20 -0400
IronPort-SDR: dAXuSvwy+Dncb/Hc0kORXwzox6vMmFvm6Cb6Gnc5DJ3hiMnmXf6AccZMGMRsqcBcF+zkB2XMBP
 /IW5yRWufWzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="212492293"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="212492293"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 17:06:17 -0700
IronPort-SDR: NORpXiscpzAgT3JuqHHMG4Q6991N7MfI+GqnDOm44Cw/YvAOWrfjFXnmaxwolubNBhRjAJ+RLm
 JoEVKbyNJ5Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="456913827"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 06 Jul 2020 17:06:17 -0700
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
Subject: [PATCH v4 6/7] iommu/vt-d: Warn on out-of-range invalidation address
Date:   Mon,  6 Jul 2020 17:12:53 -0700
Message-Id: <1594080774-33413-7-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594080774-33413-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1594080774-33413-1-git-send-email-jacob.jun.pan@linux.intel.com>
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

Fixes: 6ee1b77ba3ac0 ("iommu/vt-d: Add svm/sva invalidate function")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3bf03c6cd15f..c3a9a85a3c3f 100644
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
+				pr_err_ratelimited("User address not aligned, 0x%llx, size order %llu\n",
+					  inv_info->addr_info.addr, size);
 			}
 
 			/*
-- 
2.7.4

