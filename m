Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FECC433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AFFA20717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbgGVTTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:19:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:65004 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgGVTTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:19:45 -0400
IronPort-SDR: 3rJfE4CD2fy0wSAFxOe2mQ/AgW3mcKzKZbYrbomiT0xxhuCuA7CPd7m5p8JIuanPfySB78HJsh
 u/T3n8D5h1iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="149590052"
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="149590052"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 12:19:43 -0700
IronPort-SDR: XltEm9MD8yKvnszVJ4SYldkA1RzqBGrjUydJLU2rwM/ounzJBtssvxX3RiRljicM370R2Lr3lA
 APBzNbs03A3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="362811892"
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
Subject: [PATCH v5 1/7] iommu/vt-d: Enforce PASID devTLB field mask
Date:   Wed, 22 Jul 2020 12:26:21 -0700
Message-Id: <1595445987-40095-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595445987-40095-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1595445987-40095-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Yi L <yi.l.liu@intel.com>

Set proper masks to avoid invalid input spillover to reserved bits.

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/linux/intel-iommu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 3e8fa1c7a1e6..311117b50e93 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -381,8 +381,8 @@ enum {
 
 #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
 #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
-#define QI_DEV_EIOTLB_GLOB(g)	((u64)g)
-#define QI_DEV_EIOTLB_PASID(p)	(((u64)p) << 32)
+#define QI_DEV_EIOTLB_GLOB(g)	((u64)(g) & 0x1)
+#define QI_DEV_EIOTLB_PASID(p)	((u64)((p) & 0xfffff) << 32)
 #define QI_DEV_EIOTLB_SID(sid)	((u64)((sid) & 0xffff) << 16)
 #define QI_DEV_EIOTLB_QDEP(qd)	((u64)((qd) & 0x1f) << 4)
 #define QI_DEV_EIOTLB_PFSID(pfsid) (((u64)(pfsid & 0xf) << 12) | \
-- 
2.7.4

