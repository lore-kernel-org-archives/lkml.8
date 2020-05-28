Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C1AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD86E207F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405692AbgE1R5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:57:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:4416 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405660AbgE1R5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:57:36 -0400
IronPort-SDR: 5L8XbszJ/reypBy6+tnza80YLlAaQmFgq5Lg9kG9S5dG7A5kDNz7NZgJrQVJ3fIkGLbI4aF95/
 jzSDlcfA9qIQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 10:57:35 -0700
IronPort-SDR: fco9CEO8XR2JlX6tJVG1Ozrw4df4pHmH2T4kBBPWCsQnI5NNTgOL+8uhXk8uJtV/nLBTZlBW69
 hdqjD28hKRfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="256243677"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga007.jf.intel.com with ESMTP; 28 May 2020 10:57:35 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH] iommu/vt-d: Fix compile warning
Date:   Thu, 28 May 2020 11:03:51 -0700
Message-Id: <1590689031-79318-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make intel_svm_unbind_mm() a static function.

Fixes: 064a57d7ddfc ("iommu/vt-d: Replace intel SVM APIs with generic
SVA APIs")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 3c190c3b90b9..d386853121a2 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -597,7 +597,7 @@ intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
 }
 
 /* Caller must hold pasid_mutex */
-int intel_svm_unbind_mm(struct device *dev, int pasid)
+static int intel_svm_unbind_mm(struct device *dev, int pasid)
 {
 	struct intel_svm_dev *sdev;
 	struct intel_iommu *iommu;
-- 
2.7.4

