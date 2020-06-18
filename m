Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E055C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA3820888
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgFRXlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:41:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:39260 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgFRXlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 19:41:00 -0400
IronPort-SDR: NsmWbC7ysWqzaq5ynKjWH38Cs/3Cks4HnJysCz3bDnQu1tTObvlPF/7j53O4L71dlmw3QM0J78
 TpStX1wxgpeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="141075357"
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="141075357"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 16:41:00 -0700
IronPort-SDR: I0qU0iqtU7izjgw61vjOgd73oVqxTlEZTgba5DL+6SDxcPU/Rc4b6Mc6wMBpigTWgrWZwYsjg8
 M6qEHV9IC6Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="383673934"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jun 2020 16:40:59 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy <murphyt7@tcd.ie>
Subject: [PATCH 1/1] iommu/vt-d: Fix misuse of iommu_domain_identity_map()
Date:   Fri, 19 Jun 2020 07:36:50 +0800
Message-Id: <20200618233650.9214-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu_domain_identity_map() helper takes start/end PFN as arguments.
Fix a misuse case where the start and end addresses are passed.

Fixes: e70b081c6f376 ("iommu/vt-d: Remove IOVA handling code from the non-dma_ops path")
Cc: Tom Murphy <murphyt7@tcd.ie>
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f16bf63ea9fd..d759e7234e98 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2701,7 +2701,9 @@ static int __init si_domain_init(int hw)
 				    end >> agaw_to_width(si_domain->agaw)))
 				continue;
 
-			ret = iommu_domain_identity_map(si_domain, start, end);
+			ret = iommu_domain_identity_map(si_domain,
+					mm_to_dma_pfn(start >> PAGE_SHIFT),
+					mm_to_dma_pfn(end >> PAGE_SHIFT));
 			if (ret)
 				return ret;
 		}
-- 
2.17.1

